/**
 * Identificação da aluna na entrada do bot (MSI, 09/10/2026): e-mail › CPF › nome da compra › WhatsApp.
 * Módulo puro (sem banco) para ser testável; o servidor fica em access.functions.ts.
 *
 * Regras (docs/plano-identificacao-e-membrium.md, decisões de 09/10):
 *  a) CPF guardado com os 11 números: a equipe vê completo no painel; a aluna nunca vê.
 *  b) Nome só vale quando encontra UMA pessoa (homônimo → pede o WhatsApp).
 *  c) Quem entra por dado de reserva vê o e-mail da compra escondido (ma•••@gmail.com). O e-mail pode ser
 *     trocado pela equipe: ela passa a entrar com o novo e a conversa antiga continua.
 *  d) Quem entra pelo nome ou pelo WhatsApp não recebe link de acesso direto: a equipe confere antes.
 *
 * O banco repete duas destas regras em colunas calculadas (migração 20261009010000_identificacao.sql):
 * normalizarNome = public.normalizar_nome (coluna nome_busca) e chaveTelefone = coluna telefone_busca.
 * Se mudar uma, mude a outra (o teste compara a tabela de acentos com a da migração).
 */

export type EtapaEntrada = "email" | "cpf" | "nome" | "whatsapp";
export const ETAPAS_ENTRADA: readonly EtapaEntrada[] = ["email", "cpf", "nome", "whatsapp"];

/** Como a pessoa entrou. "email_anterior" = um e-mail antigo que a equipe já trocou no painel. */
export type ViaEntrada = "email" | "email_anterior" | "cpf" | "nome" | "whatsapp";

export function proximaEtapa(etapa: EtapaEntrada): EtapaEntrada | null {
  const i = ETAPAS_ENTRADA.indexOf(etapa);
  return ETAPAS_ENTRADA[i + 1] ?? null;
}

/** Decisão d: link de acesso direto só para quem entrou pelo e-mail ou pelo CPF. */
export function viaPrecisaConferir(via: string | null | undefined): boolean {
  return via === "nome" || via === "whatsapp";
}

/** Entrou por dado de reserva (ou e-mail antigo): mostra o e-mail da compra escondido. */
export function viaMostraEmail(via: ViaEntrada): boolean {
  return via !== "email";
}

export const soDigitos = (valor: string | null | undefined) => (valor ?? "").replace(/\D+/g, "");

/* ------------------------------------------------------------------ */
/* CPF                                                                 */
/* ------------------------------------------------------------------ */

/** Confere os dois dígitos verificadores (e recusa 000.000.000-00, 111.111.111-11...). */
export function cpfValido(cpf: string): boolean {
  if (!/^\d{11}$/.test(cpf) || /^(\d)\1{10}$/.test(cpf)) return false;
  const digito = (ate: number) => {
    let soma = 0;
    for (let i = 0; i < ate; i++) soma += Number(cpf[i]) * (ate + 1 - i);
    const resto = (soma * 10) % 11;
    return resto === 10 ? 0 : resto;
  };
  return digito(9) === Number(cpf[9]) && digito(10) === Number(cpf[10]);
}

/**
 * CPF só com números, ou null se não for um CPF válido. CNPJ (14 números) não vale.
 * completarZeros: planilhas costumam perder o zero do começo (Excel trata como número).
 */
export function normalizarCpf(valor: string | null | undefined, opts: { completarZeros?: boolean } = {}): string | null {
  let d = soDigitos(valor);
  if (opts.completarZeros && d.length >= 9 && d.length < 11) d = d.padStart(11, "0");
  return cpfValido(d) ? d : null;
}

/** 52998224725 → 529.982.247-25 (painel da equipe). */
export function formatarCpf(cpf: string): string {
  return /^\d{11}$/.test(cpf) ? cpf.replace(/^(\d{3})(\d{3})(\d{3})(\d{2})$/, "$1.$2.$3-$4") : cpf;
}

/* ------------------------------------------------------------------ */
/* Telefone / WhatsApp                                                 */
/* ------------------------------------------------------------------ */

/**
 * Telefone só com números e com o código do país (Brasil = 55), ou null.
 * Aceita "(31) 98888-7777", "+55 31 98888-7777", "031 98888-7777", "5531988887777".
 */
export function normalizarTelefone(valor: string | null | undefined): string | null {
  let d = soDigitos(valor);
  if (d.startsWith("00")) d = d.slice(2);
  if ((d.length === 11 || d.length === 12) && d.startsWith("0")) d = d.slice(1);
  if ((d.length === 10 || d.length === 11) && !d.startsWith("0")) d = `55${d}`;
  if (d.startsWith("55") && (d.length === 12 || d.length === 13)) {
    const numero = d.slice(4);
    const dddOk = /^[1-9][0-9]$/.test(d.slice(2, 4));
    const numeroOk = numero.length === 8 || (numero.length === 9 && numero.startsWith("9"));
    return dddOk && numeroOk ? d : null;
  }
  if (d.startsWith("55")) return null;
  return d.length >= 10 && d.length <= 15 ? d : null;
}

/**
 * Chave de busca do telefone: no Brasil, DDD + os 8 últimos números (aceita com e sem o 9 e com e sem 55).
 * Igual à coluna calculada authorized_users.telefone_busca.
 */
export function chaveTelefone(normalizado: string): string {
  return /^55\d{10,11}$/.test(normalizado) ? normalizado.slice(2, 4) + normalizado.slice(-8) : normalizado;
}

/** "(31) 98888-7777" para mostrar à própria pessoa o número que ela digitou. */
export function formatarTelefone(normalizado: string): string {
  const m = /^55(\d{2})(\d{4,5})(\d{4})$/.exec(normalizado);
  return m ? `(${m[1]}) ${m[2]}-${m[3]}` : `+${normalizado}`;
}

/* ------------------------------------------------------------------ */
/* Nome                                                                */
/* ------------------------------------------------------------------ */

/** Letras com acento que o banco troca (public.normalizar_nome). O teste confere com a migração. */
export const ACENTOS_DE = "áàâãäåāăąçćĉċčďéèêëēĕėęěĝğġģĥíìîïĩīĭįĵķĺļľñńņňóòôõöōŏőŕŗřśŝşšţťúùûüũūŭůűųŵýÿŷźżž";
export const ACENTOS_PARA = "aaaaaaaaacccccdeeeeeeeeegggghiiiiiiiijklllnnnnoooooooorrrssssttuuuuuuuuuuwyyyzzz";

/** Palavras que não contam na comparação ("Maria da Silva" = "Maria Silva"). */
export const PARTICULAS_NOME = ["de", "da", "do", "das", "dos", "e", "d"] as const;
const PARTICULAS = new Set<string>(PARTICULAS_NOME);

/** Nome para comparar: sem acento, minúsculo, só letras, sem "de/da/do/dos/das/e". Igual a nome_busca. */
export function normalizarNome(valor: string | null | undefined): string | null {
  const base = (valor ?? "")
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/[^a-z]+/g, " ");
  const palavras = base.split(" ").filter((p) => p && !PARTICULAS.has(p));
  return palavras.length ? palavras.join(" ") : null;
}

/** Nome completo = pelo menos duas palavras (só o primeiro nome é fácil demais de adivinhar). */
export function nomeCompletoValido(valor: string | null | undefined): boolean {
  return (normalizarNome(valor)?.split(" ").length ?? 0) >= 2;
}

/* ------------------------------------------------------------------ */
/* E-mail                                                              */
/* ------------------------------------------------------------------ */

export const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

/** "ma•••@gmail.com": o suficiente para ela reconhecer, sem entregar o e-mail para quem chutou um nome. */
export function mascararEmail(email: string): string {
  const [local = "", dominio = ""] = email.trim().toLowerCase().split("@");
  const visivel = local.length <= 2 ? local.slice(0, 1) : local.slice(0, 2);
  return `${visivel}•••@${dominio}`;
}

/* ------------------------------------------------------------------ */
/* Qual cadastro vale                                                  */
/* ------------------------------------------------------------------ */

export type CadastroCandidato = {
  id: string;
  email: string;
  status: string;
  access_expires_at: string | null;
  cpf?: string | null;
  nome_busca?: string | null;
  last_login_at?: string | null;
  updated_at?: string | null;
};

/** Ativo e dentro do prazo. Cadastro reembolsado, cancelado, bloqueado ou vencido nunca entra por reserva. */
export function cadastroAtivo(c: CadastroCandidato, agora = new Date()): boolean {
  return c.status === "active" && !(c.access_expires_at && new Date(c.access_expires_at) < agora);
}

/** Quando a mesma pessoa tem dois cadastros (ex.: comprou com dois e-mails): o mais usado/recente. */
function maisRecente<T extends CadastroCandidato>(lista: T[]): T {
  const chave = (c: CadastroCandidato) => `${c.last_login_at ?? ""}|${c.updated_at ?? ""}`;
  return [...lista].sort((a, b) => chave(b).localeCompare(chave(a)))[0]!;
}

/** Todos os cadastros têm o mesmo CPF (preenchido): é a mesma pessoa. */
function mesmaPessoa(lista: CadastroCandidato[]): boolean {
  const cpf = lista[0]?.cpf;
  return Boolean(cpf) && lista.every((c) => c.cpf === cpf);
}

export type Escolha<T> = { cadastro: T; motivo: null } | { cadastro: null; motivo: "nenhum" | "homonimo" | "varios" };

/**
 * Decide qual cadastro a etapa encontrou.
 *  - CPF: o CPF é da pessoa; com dois cadastros (dois e-mails), vale o mais recente.
 *  - Nome: só com UMA pessoa (decisão b). Homônimos → pede o WhatsApp.
 *  - WhatsApp: uma pessoa; com vários cadastros no mesmo número, desempata pelo nome digitado antes.
 */
export function escolherCadastro<T extends CadastroCandidato>(
  etapa: Exclude<EtapaEntrada, "email">,
  candidatos: T[],
  opts: { nomeBusca?: string | null; agora?: Date } = {},
): Escolha<T> {
  const ativos = candidatos.filter((c) => cadastroAtivo(c, opts.agora));
  if (ativos.length === 0) return { cadastro: null, motivo: "nenhum" };
  if (ativos.length === 1) return { cadastro: ativos[0]!, motivo: null };
  if (etapa === "cpf" || mesmaPessoa(ativos)) return { cadastro: maisRecente(ativos), motivo: null };
  if (etapa === "nome") return { cadastro: null, motivo: "homonimo" };
  const peloNome = opts.nomeBusca ? ativos.filter((c) => c.nome_busca === opts.nomeBusca) : [];
  if (peloNome.length === 1) return { cadastro: peloNome[0]!, motivo: null };
  if (peloNome.length > 1 && mesmaPessoa(peloNome)) return { cadastro: maisRecente(peloNome), motivo: null };
  return { cadastro: null, motivo: "varios" };
}

/* ------------------------------------------------------------------ */
/* Limite de tentativas                                                */
/* ------------------------------------------------------------------ */

/** Tentativas que não encontraram nada (CPF, nome, WhatsApp) em 15 minutos. */
export const LIMITE_TENTATIVAS = { janelaMin: 15, porAparelho: 6, porRede: 20 } as const;

export function passouDoLimite(falhas: { aparelho: number; rede: number }): boolean {
  return falhas.aparelho >= LIMITE_TENTATIVAS.porAparelho || falhas.rede >= LIMITE_TENTATIVAS.porRede;
}

/* ------------------------------------------------------------------ */
/* Dados de reserva vindos da compra (webhook e planilha)              */
/* ------------------------------------------------------------------ */

export type DadosDeReserva = { cpf: string | null; telefone: string | null };

/** CPF e telefone de uma compra, prontos para authorized_users. CNPJ ou inválido vira null. */
export function dadosDeReserva(
  documento: string | null | undefined,
  telefone: string | null | undefined,
  opts: { completarZeros?: boolean } = {},
): DadosDeReserva {
  return { cpf: normalizarCpf(documento, opts), telefone: normalizarTelefone(telefone) };
}

/**
 * Junta com o que o cadastro já tem: o CPF só entra se ainda não havia um (a compra é da mesma pessoa);
 * o telefone mais novo vence quando `telefoneNovoVence` (webhook), senão só preenche o que falta (planilha antiga).
 */
export function juntarDadosDeReserva(
  atual: Partial<DadosDeReserva> | null | undefined,
  novo: DadosDeReserva,
  opts: { telefoneNovoVence: boolean },
): DadosDeReserva {
  return {
    cpf: atual?.cpf ?? novo.cpf,
    telefone: opts.telefoneNovoVence ? (novo.telefone ?? atual?.telefone ?? null) : (atual?.telefone ?? novo.telefone),
  };
}

/* ------------------------------------------------------------------ */
/* Dois cadastros da mesma pessoa (troca de e-mail no painel)          */
/* ------------------------------------------------------------------ */

export type CadastroCompleto = {
  id: string;
  email: string;
  name: string | null;
  role: "admin" | "student";
  status: "active" | "blocked" | "refunded" | "canceled";
  product_access: string[];
  access_expires_at: string | null;
  product_origin: string | null;
  metadata: Record<string, unknown> | null;
  cpf: string | null;
  telefone: string | null;
  emails_anteriores: string[] | null;
};

/** Dois cadastros da mesma pessoa viram um: produtos somam, ativo vence, dados que faltam são preenchidos. */
export function juntarCadastros(fica: CadastroCompleto, sai: CadastroCompleto) {
  const historico = (c: CadastroCompleto) =>
    Array.isArray(c.metadata?.["access_history"]) ? (c.metadata!["access_history"] as unknown[]) : [];
  const vencimentos = [fica.access_expires_at, sai.access_expires_at];
  return {
    name: fica.name ?? sai.name,
    role: fica.role === "admin" || sai.role === "admin" ? ("admin" as const) : ("student" as const),
    status: fica.status === "active" || sai.status === "active" ? ("active" as const) : fica.status,
    product_access: [...new Set([...fica.product_access, ...sai.product_access])],
    access_expires_at: vencimentos.includes(null) ? null : [...vencimentos].sort().at(-1)!,
    product_origin:
      fica.product_origin === "confirmado" || sai.product_origin === "confirmado" ? "confirmado" : fica.product_origin,
    cpf: fica.cpf ?? sai.cpf,
    telefone: fica.telefone ?? sai.telefone,
    metadata: {
      ...(sai.metadata ?? {}),
      ...(fica.metadata ?? {}),
      access_history: [...historico(sai), ...historico(fica)],
    },
  };
}
