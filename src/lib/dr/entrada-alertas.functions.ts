/**
 * Aba Acessos › "Entrada no bot" (MSI, 09/10/2026).
 *  - nao_encontrada: nenhum dado (e-mail, CPF, nome, WhatsApp) achou a compra. O time procura e chama no WhatsApp.
 *  - email_diferente: entrou pelo CPF, nome ou WhatsApp e tinha digitado outro e-mail (talvez trocou de e-mail).
 * E a troca do e-mail de acesso (decisão c: "esse e-mail pode ser alterado").
 */
import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { assertAdmin, audit } from "./admin-guard";
import {
  cadastroAtivo,
  chaveTelefone,
  escolherCadastro,
  juntarCadastros,
  normalizarNome,
  type CadastroCandidato,
  type CadastroCompleto,
} from "./identificacao";

const VIA_LABEL: Record<string, string> = {
  email: "e-mail",
  email_anterior: "e-mail antigo",
  cpf: "CPF",
  nome: "nome",
  whatsapp: "WhatsApp",
};

type Cadastro = CadastroCandidato & { name: string | null; telefone_busca: string | null; emails_anteriores: string[] };
const CAMPOS = "id, email, name, status, access_expires_at, last_login_at, updated_at, cpf, nome_busca, telefone_busca, emails_anteriores";

export const countEntradaAlertas = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { count } = await context.supabase
      .from("identificacao_alertas")
      .select("id", { count: "exact", head: true })
      .eq("status", "pending");
    return count ?? 0;
  });

export const listEntradaAlertas = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ view: z.enum(["pending", "resolved"]) }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const sb = context.supabase;
    const { data: rows, error } = await sb
      .from("identificacao_alertas")
      .select("*")
      .eq("status", data.view)
      .order("updated_at", { ascending: false })
      .limit(300);
    if (error) throw new Error(error.message);
    const alertas = rows ?? [];

    // Cadastros ligados (email_diferente) e "encontrada depois" (nao_encontrada: a compra chegou ou o time arrumou).
    const ids = [...new Set(alertas.map((a) => a.authorized_user_id).filter(Boolean) as string[])];
    const ligados = new Map<string, Cadastro>();
    if (ids.length) {
      const { data: cads } = await sb.from("authorized_users").select(CAMPOS).in("id", ids);
      for (const c of (cads ?? []) as unknown as Cadastro[]) ligados.set(c.id, c);
    }

    const pendentes = alertas.filter((a) => a.tipo === "nao_encontrada" && a.status === "pending");
    const emails = [...new Set(pendentes.map((a) => a.email_digitado?.toLowerCase()).filter(Boolean) as string[])];
    const cpfs = [...new Set(pendentes.map((a) => a.cpf_digitado).filter(Boolean) as string[])];
    const nomes = [...new Set(pendentes.map((a) => normalizarNome(a.nome_digitado)).filter(Boolean) as string[])];
    const fones = [...new Set(pendentes.map((a) => (a.whatsapp_digitado ? chaveTelefone(a.whatsapp_digitado) : null)).filter(Boolean) as string[])];
    const candidatos: Cadastro[] = [];
    const juntar = async (q: PromiseLike<{ data: unknown }>) => {
      const { data: lista } = await q;
      candidatos.push(...((lista ?? []) as Cadastro[]));
    };
    await Promise.all([
      emails.length ? juntar(sb.from("authorized_users").select(CAMPOS).in("email", emails)) : null,
      emails.length ? juntar(sb.from("authorized_users").select(CAMPOS).overlaps("emails_anteriores", emails)) : null,
      cpfs.length ? juntar(sb.from("authorized_users").select(CAMPOS).in("cpf", cpfs)) : null,
      nomes.length ? juntar(sb.from("authorized_users").select(CAMPOS).in("nome_busca", nomes)) : null,
      fones.length ? juntar(sb.from("authorized_users").select(CAMPOS).in("telefone_busca", fones)) : null,
    ]);

    const encontradaAgora = (a: (typeof alertas)[number]) => {
      if (a.tipo !== "nao_encontrada" || a.status !== "pending") return null;
      const email = a.email_digitado?.toLowerCase();
      const porEmail = candidatos.find(
        (c) => cadastroAtivo(c) && (c.email.toLowerCase() === email || (email && c.emails_anteriores?.includes(email))),
      );
      if (porEmail) return { email: porEmail.email, via: "e-mail" };
      const tentativas: [string, Cadastro[]][] = [
        ["CPF", a.cpf_digitado ? candidatos.filter((c) => c.cpf === a.cpf_digitado) : []],
        ["nome", (() => { const n = normalizarNome(a.nome_digitado); return n ? candidatos.filter((c) => c.nome_busca === n) : []; })()],
        ["WhatsApp", a.whatsapp_digitado ? candidatos.filter((c) => c.telefone_busca === chaveTelefone(a.whatsapp_digitado!)) : []],
      ];
      for (const [via, lista] of tentativas) {
        const unicos = [...new Map(lista.map((c) => [c.id, c])).values()];
        const etapa = via === "CPF" ? "cpf" : via === "nome" ? "nome" : "whatsapp";
        const escolha = escolherCadastro(etapa, unicos, { nomeBusca: normalizarNome(a.nome_digitado) });
        if (escolha.cadastro) return { email: escolha.cadastro.email, via };
      }
      return null;
    };

    const quem = [...new Set(alertas.map((a) => a.resolved_by).filter(Boolean) as string[])];
    const nomesEquipe = new Map<string, string>();
    if (quem.length) {
      const { data: ps } = await sb.from("profiles").select("id, name, email").in("id", quem);
      for (const p of ps ?? []) nomesEquipe.set(p.id, p.name ?? p.email ?? "");
    }

    return alertas.map((a) => {
      const cad = a.authorized_user_id ? ligados.get(a.authorized_user_id) : undefined;
      return {
        id: a.id,
        tipo: a.tipo as "nao_encontrada" | "email_diferente",
        status: a.status,
        emailDigitado: a.email_digitado,
        cpf: a.cpf_digitado,
        nomeDigitado: a.nome_digitado,
        whatsapp: a.whatsapp_digitado,
        via: a.via ? (VIA_LABEL[a.via] ?? a.via) : null,
        tentativas: a.tentativas,
        observacao: a.observacao,
        criadoEm: a.created_at,
        atualizadoEm: a.updated_at,
        authorizedUserId: a.authorized_user_id,
        userId: a.user_id,
        cadastroEmail: cad?.email ?? null,
        cadastroNome: cad?.name ?? null,
        // O e-mail do cadastro já é o que ela digitou (a equipe trocou por outro caminho).
        jaTrocado: Boolean(cad && a.email_digitado && cad.email.toLowerCase() === a.email_digitado.toLowerCase()),
        encontradaAgora: encontradaAgora(a),
        resolucao: a.resolucao,
        resolvidoEm: a.resolved_at,
        resolvidoPor: a.resolved_by ? (nomesEquipe.get(a.resolved_by) ?? null) : null,
      };
    });
  });

export const resolveEntradaAlerta = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) =>
    z
      .object({
        id: z.string().uuid(),
        undo: z.boolean().default(false),
        resolucao: z.enum(["chamada", "manter_email", "email_trocado", "outro"]).optional(),
      })
      .parse(d),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    const { error } = await supabaseAdmin
      .from("identificacao_alertas")
      .update(
        data.undo
          ? { status: "pending", resolved_by: null, resolved_at: null, resolucao: null }
          : { status: "resolved", resolved_by: context.userId, resolved_at: now, resolucao: data.resolucao ?? "outro" },
      )
      .eq("id", data.id);
    if (error) throw new Error("Não consegui marcar.");
    await audit(context, data.undo ? "entrada_alerta_reaberto" : "entrada_alerta_resolvido", {
      metadata: { id: data.id, resolucao: data.resolucao ?? null },
    });
    return { ok: true };
  });

/** Histórico da aluna que acompanha a conta quando dois cadastros viram um (conversa, alertas, relatórios). */
const TABELAS_DO_HISTORICO = [
  "conversations",
  "messages",
  "access_alerts",
  "sales_alerts",
  "risk_alerts",
  "conversation_insights",
  "retention_actions",
  "material_requests",
  "usage_events",
  "tentativas_entrada",
  "identificacao_alertas",
] as const;

const CAMPOS_COMPLETOS =
  "id, email, name, role, status, product_access, access_expires_at, product_origin, metadata, cpf, telefone, emails_anteriores";

/**
 * Troca o e-mail de acesso (decisão c, 09/10): ela passa a entrar com o e-mail novo (o que a equipe trocou ou para
 * onde reenviou o acesso) e a conversa antiga vem junto. Muda o cadastro, a conta do bot e a ficha; o e-mail antigo
 * vai para emails_anteriores, então login, webhooks (reembolso!) e planilha continuam achando a pessoa por ele.
 *
 * Se o e-mail novo já tem outro cadastro (ex.: comprou de novo com ele), devolve `precisaJuntar` para o painel
 * confirmar; com `juntar: true`, os dois viram um só: produtos somam e a conversa dos dois fica na mesma conta.
 */
export const changeAuthorizedEmail = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) =>
    z
      .object({
        authorizedUserId: z.string().uuid().nullable().optional(),
        /** Alternativa ao id: o e-mail atual da aluna (aba Acessos › Área de membros). */
        emailAtual: z.string().trim().toLowerCase().email().max(255).nullable().optional(),
        novoEmail: z.string().trim().toLowerCase().email().max(255),
        alertaId: z.string().uuid().nullable().optional(),
        juntar: z.boolean().default(false),
      })
      .refine((v) => v.authorizedUserId || v.emailAtual, "Informe o cadastro.")
      .parse(d),
  )
  .handler(
    async ({
      data,
      context,
    }): Promise<
      | { ok: true; email: string; juntou: boolean }
      | { ok: false; precisaJuntar: true; outro: { email: string; name: string | null; status: string } }
    > => {
      await assertAdmin(context);
      const { supabaseAdmin: admin } = await import("@/integrations/supabase/client.server");
      const novo = data.novoEmail;

      const buscar = async (coluna: "id" | "email", valor: string) => {
        const { data: c } = await admin.from("authorized_users").select(CAMPOS_COMPLETOS).eq(coluna, valor).maybeSingle();
        return (c as unknown as CadastroCompleto | null) ?? null;
      };
      const cad = data.authorizedUserId ? await buscar("id", data.authorizedUserId) : await buscar("email", data.emailAtual!);
      if (!cad) throw new Error("Cadastro não encontrado.");
      const antigo = cad.email.toLowerCase();
      let juntou = false;

      if (antigo !== novo) {
        // O e-mail novo já é de outro cadastro (ou já foi)?
        let outro = await buscar("email", novo);
        if (!outro) {
          const { data: lista } = await admin
            .from("authorized_users")
            .select(CAMPOS_COMPLETOS)
            .contains("emails_anteriores", [novo])
            .neq("id", cad.id)
            .limit(1);
          outro = ((lista ?? [])[0] as unknown as CadastroCompleto | undefined) ?? null;
        }
        if (outro && outro.id === cad.id) outro = null;
        if (outro && !data.juntar) {
          return { ok: false, precisaJuntar: true, outro: { email: outro.email, name: outro.name, status: outro.status } };
        }

        // Contas do bot: fica a do cadastro atual (a conversa antiga); a do outro e-mail, se existir, entrega o
        // histórico e é apagada.
        const emailsDasContas = [...new Set([antigo, novo, ...(outro ? [outro.email.toLowerCase()] : [])])];
        const { data: perfis } = await admin.from("profiles").select("id, email").in("email", emailsDasContas);
        const contaAtual = (perfis ?? []).find((p) => p.email?.toLowerCase() === antigo) ?? null;
        const contaOutra = (perfis ?? []).find((p) => p.email?.toLowerCase() !== antigo) ?? null;
        const fica = contaAtual ?? contaOutra;
        const sai = contaAtual && contaOutra ? contaOutra : null;

        if (sai && fica) {
          for (const tabela of TABELAS_DO_HISTORICO) {
            const { error } = await admin.from(tabela).update({ user_id: fica.id } as never).eq("user_id", sai.id);
            if (error) {
              console.error("[entrada] mover histórico falhou", tabela, error.message);
              throw new Error("Não consegui juntar as conversas. Nada foi apagado; tente de novo.");
            }
          }
          const { error } = await admin.auth.admin.deleteUser(sai.id);
          if (error) console.error("[entrada] apagar a conta repetida falhou", error.message);
        }
        if (fica && fica.email?.toLowerCase() !== novo) {
          const { error } = await admin.auth.admin.updateUserById(fica.id, { email: novo, email_confirm: true });
          if (error) {
            console.error("[entrada] troca de e-mail na conta falhou", error.message);
            throw new Error("Já existe uma conta no bot com esse e-mail. Não troquei nada.");
          }
        }
        if (fica) await admin.from("profiles").update({ email: novo }).eq("id", fica.id);

        // Cadastro: o outro (se houver) entra neste e sai da lista; o e-mail antigo vira "anterior".
        const anteriores = [
          ...new Set([...(cad.emails_anteriores ?? []), ...(outro?.emails_anteriores ?? []), antigo, ...(outro ? [outro.email] : [])]),
        ]
          .map((e) => e.toLowerCase())
          .filter((e) => e !== novo);
        const campos = outro ? juntarCadastros(cad, outro) : {};
        if (outro) {
          await admin.from("tentativas_entrada").update({ authorized_user_id: cad.id }).eq("authorized_user_id", outro.id);
          await admin.from("identificacao_alertas").update({ authorized_user_id: cad.id }).eq("authorized_user_id", outro.id);
          const { error } = await admin.from("authorized_users").delete().eq("id", outro.id);
          if (error) throw new Error("Não consegui juntar os cadastros.");
          juntou = true;
        }
        const { error } = await admin
          .from("authorized_users")
          .update({ ...campos, email: novo, emails_anteriores: anteriores } as never)
          .eq("id", cad.id);
        if (error) {
          console.error("[entrada] troca de e-mail no cadastro falhou", error.message);
          throw new Error("Não consegui trocar o e-mail do cadastro.");
        }

        // Produtos e papel da conta que ficou (soma dos dois cadastros).
        if (fica && outro) {
          const { syncAuthorizedAccount } = await import("./access.server");
          const final = { ...cad, ...campos } as CadastroCompleto;
          await syncAuthorizedAccount(admin, fica.id, final.role, final.product_access as never).catch((e) =>
            console.error("[entrada] sincronizar produtos falhou", e),
          );
        }

        await audit(context, juntou ? "cadastros_juntados" : "email_de_acesso_trocado", {
          targetUserId: fica?.id ?? null,
          targetEmail: novo,
          metadata: { de: antigo, para: novo, ...(outro ? { juntou_com: outro.email } : {}) },
        });
      }

      if (data.alertaId) {
        await admin
          .from("identificacao_alertas")
          .update({
            status: "resolved",
            resolved_by: context.userId,
            resolved_at: new Date().toISOString(),
            resolucao: "email_trocado",
          })
          .eq("id", data.alertaId);
      }
      return { ok: true, email: novo, juntou };
    },
  );
