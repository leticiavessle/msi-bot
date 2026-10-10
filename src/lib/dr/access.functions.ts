import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import {
  abrirSessao,
  ipConfiavel,
  readClientMeta,
  SESSION_GAP_MS,
  type CadastroParaSessao,
} from "./access.server";
import {
  EMAIL_RE,
  LIMITE_TENTATIVAS,
  cadastroAtivo,
  chaveTelefone,
  escolherCadastro,
  formatarTelefone,
  mascararEmail,
  nomeCompletoValido,
  normalizarCpf,
  normalizarNome,
  normalizarTelefone,
  passouDoLimite,
  proximaEtapa,
  viaMostraEmail,
  type CadastroCandidato,
  type EtapaEntrada,
  type ViaEntrada,
} from "./identificacao";
import { ENTRADA } from "../../oferta/entrada";

type Admin = Awaited<typeof import("@/integrations/supabase/client.server")>["supabaseAdmin"];

type Cadastro = CadastroParaSessao &
  CadastroCandidato & { emails_anteriores: string[] | null; telefone_busca?: string | null };

const CAMPOS_CADASTRO =
  "id, email, name, role, status, product_access, access_expires_at, last_login_at, updated_at, cpf, nome_busca, telefone_busca, emails_anteriores";

const STATUS_LABEL: Record<string, string> = {
  blocked: "bloqueado",
  refunded: "reembolsado",
  canceled: "cancelado",
};

const entradaSchema = z.object({
  etapa: z.enum(["email", "cpf", "nome", "whatsapp"]),
  deviceId: z.string().trim().min(6).max(64).nullable().optional(),
  email: z.string().trim().toLowerCase().max(255).nullable().optional(),
  cpf: z.string().trim().max(30).nullable().optional(),
  nome: z.string().trim().max(160).nullable().optional(),
  whatsapp: z.string().trim().max(30).nullable().optional(),
});

export type ResultadoEntrada =
  | {
      status: "entrou";
      tokenHash: string;
      via: ViaEntrada;
      /** E-mail da compra escondido (ma•••@gmail.com), quando ela entrou por dado de reserva ou e-mail antigo. */
      emailMascarado: string | null;
      dica: "email_diferente" | "email_atualizado" | null;
    }
  | { status: "nao_encontrado"; proxima: EtapaEntrada | null; whatsapp?: string | null }
  | { status: "invalido"; mensagem: string }
  | { status: "limite"; mensagem: string };

/** Cadastro pelo e-mail; se não houver, por um e-mail antigo (trocado pela equipe no painel). */
async function buscarPorEmail(admin: Admin, email: string): Promise<{ cadastro: Cadastro; anterior: boolean } | null> {
  const { data } = await admin.from("authorized_users").select(CAMPOS_CADASTRO).eq("email", email).maybeSingle();
  if (data) return { cadastro: data as unknown as Cadastro, anterior: false };
  const { data: antigos } = await admin
    .from("authorized_users")
    .select(CAMPOS_CADASTRO)
    .contains("emails_anteriores", [email])
    .limit(5);
  const lista = (antigos ?? []) as unknown as Cadastro[];
  const escolhido = lista.find((c) => cadastroAtivo(c)) ?? lista[0];
  return escolhido ? { cadastro: escolhido, anterior: true } : null;
}

async function buscarPor(admin: Admin, coluna: "cpf" | "nome_busca" | "telefone_busca", valor: string) {
  const { data } = await admin.from("authorized_users").select(CAMPOS_CADASTRO).eq(coluna, valor).limit(20);
  return (data ?? []) as unknown as Cadastro[];
}

const descrever = (c: Cadastro) =>
  `${c.email}${cadastroAtivo(c) ? "" : ` (${STATUS_LABEL[c.status] ?? (c.status === "active" ? "vencido" : c.status)})`}`;

/**
 * O que a equipe precisa saber quando nada encontrou a compra: cadastros que existem com esses dados,
 * mas não valeram (reembolsado, cancelado, homônimo...). Vai junto com o aviso na aba Acessos.
 */
async function observacoesParaEquipe(
  admin: Admin,
  dados: { email: string | null; cpf: string | null; nomeBusca: string | null; telefoneBusca: string | null },
) {
  const notas: string[] = [];
  if (dados.email) {
    const achado = await buscarPorEmail(admin, dados.email);
    if (achado) notas.push(`E-mail digitado: cadastro ${descrever(achado.cadastro)}`);
  }
  const porDado: [string, "cpf" | "nome_busca" | "telefone_busca", string | null][] = [
    ["CPF", "cpf", dados.cpf],
    ["Nome", "nome_busca", dados.nomeBusca],
    ["WhatsApp", "telefone_busca", dados.telefoneBusca],
  ];
  for (const [rotulo, coluna, valor] of porDado) {
    if (!valor) continue;
    const lista = await buscarPor(admin, coluna, valor);
    if (lista.length) notas.push(`${rotulo}: ${lista.map(descrever).join(", ")}`);
  }
  return notas.join(" · ") || null;
}

/**
 * Entrada no bot (MSI, 09/10/2026): e-mail › CPF › nome da compra › WhatsApp, um de cada vez.
 * Achou em qualquer etapa → entra na conta da compra. Nenhum achou → aviso na aba Acessos com tudo o que
 * ela digitou. Regras e limites em src/lib/dr/identificacao.ts; textos em src/oferta/entrada.ts.
 * A tela manda, a cada etapa, também os dados das etapas anteriores (para o desempate e o aviso final).
 */
export const iniciarEntrada = createServerFn({ method: "POST" })
  .inputValidator((data: unknown) => entradaSchema.parse(data))
  .handler(async ({ data }): Promise<ResultadoEntrada> => {
    const { supabaseAdmin: admin } = await import("@/integrations/supabase/client.server");
    const ip = ipConfiavel();
    const deviceId = data.deviceId ?? null;
    const email = data.email && EMAIL_RE.test(data.email) ? data.email : null;

    const registrar = (fields: Record<string, unknown>) =>
      admin.from("tentativas_entrada").insert({ etapa: data.etapa, device_id: deviceId, ip, ...fields } as never);

    const entrar = async (cadastro: Cadastro, via: ViaEntrada): Promise<ResultadoEntrada> => {
      const { tokenHash, accountId } = await abrirSessao(admin, cadastro);
      await registrar({ resultado: "entrou", via, user_id: accountId, authorized_user_id: cadastro.id });

      let dica: "email_diferente" | "email_atualizado" | null = via === "email_anterior" ? "email_atualizado" : null;
      const outroEmail =
        via !== "email" &&
        via !== "email_anterior" &&
        email &&
        email !== cadastro.email.toLowerCase() &&
        !(cadastro.emails_anteriores ?? []).includes(email);
      if (outroEmail) {
        // Talvez ela tenha trocado de e-mail: a equipe vê os dois e decide se troca (aba Acessos › Entrada no bot).
        await avisarEquipe(admin, {
          tipo: "email_diferente",
          chave: { authorized_user_id: cadastro.id, email_digitado: email },
          campos: { email_digitado: email, via, authorized_user_id: cadastro.id, user_id: accountId, device_id: deviceId, ip },
        });
        dica = "email_diferente";
      }
      return {
        status: "entrou",
        tokenHash,
        via,
        emailMascarado: viaMostraEmail(via) ? mascararEmail(cadastro.email) : null,
        dica,
      };
    };

    // 1. E-mail (ou e-mail antigo, trocado pela equipe).
    if (data.etapa === "email") {
      if (!email) return { status: "invalido", mensagem: ENTRADA.invalido.email };
      const achado = await buscarPorEmail(admin, email);
      if (achado && cadastroAtivo(achado.cadastro)) {
        return entrar(achado.cadastro, achado.anterior ? "email_anterior" : "email");
      }
      const motivo = !achado
        ? "não encontrado"
        : achado.cadastro.status !== "active"
          ? (STATUS_LABEL[achado.cadastro.status] ?? achado.cadastro.status)
          : "expirado";
      await admin.from("audit_logs").insert({ action: "login_denied", target_email: email, metadata: { reason: motivo } });
      await registrar({ resultado: "nao_encontrado" });
      return { status: "nao_encontrado", proxima: "cpf" };
    }

    // 2 a 4. Dados de reserva: limite de tentativas por aparelho e por rede.
    const desde = new Date(Date.now() - LIMITE_TENTATIVAS.janelaMin * 60_000).toISOString();
    const contar = async (coluna: "device_id" | "ip", valor: string | null) => {
      if (!valor) return 0;
      const { count } = await admin
        .from("tentativas_entrada")
        .select("id", { count: "exact", head: true })
        .eq(coluna, valor)
        .eq("resultado", "nao_encontrado")
        .neq("etapa", "email")
        .gte("created_at", desde);
      return count ?? 0;
    };
    const [aparelho, rede] = await Promise.all([contar("device_id", deviceId), contar("ip", ip)]);
    if (passouDoLimite({ aparelho, rede })) return { status: "limite", mensagem: ENTRADA.limite };

    const cpf = normalizarCpf(data.cpf);
    const nomeBusca = nomeCompletoValido(data.nome) ? normalizarNome(data.nome) : null;
    const telefone = normalizarTelefone(data.whatsapp);

    let candidatos: Cadastro[] = [];
    if (data.etapa === "cpf") {
      if (!cpf) return { status: "invalido", mensagem: ENTRADA.invalido.cpf };
      candidatos = await buscarPor(admin, "cpf", cpf);
    } else if (data.etapa === "nome") {
      if (!nomeBusca) return { status: "invalido", mensagem: ENTRADA.invalido.nome };
      candidatos = await buscarPor(admin, "nome_busca", nomeBusca);
    } else {
      if (!telefone) return { status: "invalido", mensagem: ENTRADA.invalido.whatsapp };
      candidatos = await buscarPor(admin, "telefone_busca", chaveTelefone(telefone));
    }

    const escolha = escolherCadastro(data.etapa, candidatos, { nomeBusca });
    if (escolha.cadastro) return entrar(escolha.cadastro, data.etapa);

    await registrar({ resultado: "nao_encontrado" });
    const proxima = proximaEtapa(data.etapa);
    if (proxima) return { status: "nao_encontrado", proxima };

    // Nenhum dado achou a compra: a equipe recebe tudo o que ela digitou (o CPF completo, para procurar a compra).
    const observacao = await observacoesParaEquipe(admin, {
      email,
      cpf,
      nomeBusca,
      telefoneBusca: telefone ? chaveTelefone(telefone) : null,
    });
    await avisarEquipe(admin, {
      tipo: "nao_encontrada",
      chave: deviceId ? { device_id: deviceId } : { whatsapp_digitado: telefone },
      campos: {
        email_digitado: data.email ?? null,
        cpf_digitado: cpf,
        nome_digitado: data.nome?.trim().slice(0, 160) || null,
        whatsapp_digitado: telefone,
        device_id: deviceId,
        ip,
        observacao,
      },
    });
    return { status: "nao_encontrado", proxima: null, whatsapp: telefone ? formatarTelefone(telefone) : null };
  });

/**
 * Grava o aviso para a aba Acessos › Entrada no bot. Se já existe um pendente igual (mesmo aparelho, ou
 * mesmo cadastro + e-mail), atualiza e soma a tentativa em vez de repetir a linha.
 */
async function avisarEquipe(
  admin: Admin,
  aviso: {
    tipo: "nao_encontrada" | "email_diferente";
    chave: Record<string, string | null>;
    campos: Record<string, unknown>;
  },
) {
  try {
    let q = admin.from("identificacao_alertas").select("id, tentativas").eq("tipo", aviso.tipo).eq("status", "pending");
    for (const [coluna, valor] of Object.entries(aviso.chave)) q = valor ? q.eq(coluna, valor) : q.is(coluna, null);
    const { data: existente } = await q.order("updated_at", { ascending: false }).limit(1).maybeSingle();
    if (existente) {
      await admin
        .from("identificacao_alertas")
        .update({ ...aviso.campos, tentativas: existente.tentativas + 1 } as never)
        .eq("id", existente.id);
    } else {
      await admin.from("identificacao_alertas").insert({ tipo: aviso.tipo, ...aviso.campos } as never);
    }
  } catch (error) {
    console.error("[entrada] aviso para a equipe falhou", error);
  }
}

/**
 * Heartbeat de presença. Também devolve `revoked: true` quando o acesso foi
 * revogado/bloqueado pelo admin — o frontend encerra a sessão nesse caso.
 */
export const touchAccessSession = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ deviceId: z.string().trim().min(6).max(64) }).parse(data),
  )
  .handler(async ({ data, context }) => {
    const meta = readClientMeta();
    const { supabase, userId } = context;

    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { data: profile } = await supabaseAdmin
      .from("profiles")
      .select("email")
      .eq("id", userId)
      .maybeSingle();

    if (profile?.email) {
      const { data: authorized } = await supabaseAdmin
        .from("authorized_users")
        .select("status, access_expires_at")
        .eq("email", profile.email.toLowerCase())
        .maybeSingle();
      const expired =
        authorized?.access_expires_at && new Date(authorized.access_expires_at) < new Date();
      if (!authorized || authorized.status !== "active" || expired) {
        return { sessionId: null, revoked: true };
      }
    }

    const { data: existing } = await supabase
      .from("access_sessions")
      .select("id, last_seen_at, revoked_at")
      .eq("user_id", userId)
      .eq("device_id", data.deviceId)
      .order("last_seen_at", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (existing?.revoked_at) return { sessionId: null, revoked: true };

    const now = new Date();
    const fresh =
      existing && now.getTime() - new Date(existing.last_seen_at).getTime() < SESSION_GAP_MS;

    if (fresh) {
      await supabase
        .from("access_sessions")
        .update({
          last_seen_at: now.toISOString(),
          ip: meta.ip,
          ip_city: meta.city,
          ip_country: meta.country,
        })
        .eq("id", existing.id);
      return { sessionId: existing.id, revoked: false };
    }

    const { data: created, error } = await supabase
      .from("access_sessions")
      .insert({
        user_id: userId,
        device_id: data.deviceId,
        user_agent: meta.userAgent,
        ip: meta.ip,
        ip_city: meta.city,
        ip_country: meta.country,
        started_at: now.toISOString(),
        last_seen_at: now.toISOString(),
      })
      .select("id")
      .single();

    if (error) return { sessionId: null, revoked: false };
    return { sessionId: created.id, revoked: false };
  });
