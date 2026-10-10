/**
 * Protocolo 7D · MOTOR do fluxo FECHADO de retenção de reembolso/cancelamento.
 *
 * Os TEXTOS ficam em src/oferta/protocolo-7d.ts (scripts oficiais do board, verbatim).
 * Substituições permitidas: [nome] → primeiro nome e as marcas de gênero {feminino|masculino} (genero.ts).
 * A decisão de qual script enviar é feita aqui, no servidor — o modelo de IA não participa.
 */
import { fillGenero, tratamento } from "./genero";
import type { OfficialLinkKey } from "./official-links";
import { RED_MATCH, type Condicao, type RefundTarget, type RouteDef, type RouteId } from "./refund-types";
import { EMAIL_SUPORTE } from "../../oferta/links";
import { ASSINATURA_RE } from "../../oferta/produtos";
import {
  ASSINATURA_ENCERRAMENTO,
  ATIVACAO_ENCAMINHADA,
  ATIVACAO_NOTA,
  ATIVACAO_OPCOES,
  CLASSIFIERS,
  CONDICAO_PADRAO,
  D1_GOLPE_INSISTIDO,
  D3_FINALIZACAO,
  D3_REATIVACAO,
  D3_REATIVACAO_OPCOES,
  DIAGNOSTICO_SINAIS,
  ESCALACAO_RISCO,
  HIPOTETICA_PONTE,
  HIPOTETICA_PROPOSTA,
  HIPOTETICA_REPETIDA,
  INSISTENCIA_REENQUADRAMENTO,
  N002_ACOLHIMENTO,
  N004_DIAGNOSTICO,
  N134_DIAGNOSTICO,
  N135_OFERTA,
  N136_JUSTIFICATIVA,
  N137_PERSONALIZADO,
  N138_SETE_DIAS,
  N139_BONUS,
  N140_COMPROMISSO,
  N143_CONFIRMACAO,
  N145_PS,
  N154_REEMBOLSO,
  N155_FECHAMENTO,
  NAO_CONTA_TEXTO,
  NOME_ATIVACAO,
  NO_EMOJI_ROUTES,
  PROPOSAL_ROUTE_IDS,
  ROUTES,
  ROUTE_PROPOSAL_NODE,
  ROUTE_REASON,
  ROTA_MUDOU_DE_IDEIA,
  WHATSAPP_7D_MENSAGEM,
} from "../../oferta/protocolo-7d";

export * from "../../oferta/protocolo-7d";
export type { RefundOption, RefundTarget, RouteDef, RouteId } from "./refund-types";

/** Início do motivo do alerta quando a pessoa aceita o acompanhamento (painel, relatórios e fila usam). */
export const ATIVACAO_ALERTA_PREFIXO = `${NOME_ATIVACAO} aceita`;

/** Rótulos dos botões de aceite do 7D (só o clique exato conta como aceite na fila do painel). */
export function acceptLabels(): string[] {
  const labels = new Set<string>([ATIVACAO_OPCOES[0]!]);
  if (CONDICAO_PADRAO) labels.add(CONDICAO_PADRAO.aceite);
  for (const route of Object.values(ROUTES)) {
    for (const option of route.options) {
      if (option.target.kind === "activation" || option.target.kind === "accept") labels.add(option.label);
    }
    if (route.condicao) labels.add(route.condicao.aceite);
  }
  return [...labels];
}

const normLabel = (t: string) => stripEmoji(t).trim().toLowerCase();

/** Rótulos dos botões de recusa (rotas e condições). Clicar num deles é recusa explícita. */
let redLabels: Set<string> | null = null;
function redLabelSet() {
  if (redLabels) return redLabels;
  const set = new Set<string>();
  if (CONDICAO_PADRAO) set.add(normLabel(CONDICAO_PADRAO.recusa));
  for (const route of Object.values(ROUTES)) {
    for (const option of route.options) if (option.target.kind === "red") set.add(normLabel(option.label));
    if (route.condicao) set.add(normLabel(route.condicao.recusa));
  }
  redLabels = set;
  return set;
}

export function isRedLabel(text: string) {
  return redLabelSet().has(normLabel(text));
}

/** Recusa dentro do fluxo: palavras de reembolso/cancelamento ou clique num botão de recusa. */
function isRedChoice(text: string) {
  return RED_MATCH.test(text) || isRedLabel(text);
}

/** Botões da proposta em aberto: os da condição (MSI) ou os três do bloco N135–N140 (MGA). */
function opcoesDaProposta(state: RefundFlowState): string[] {
  const condicao = condicaoDa(state);
  const opcoes = condicao ? [condicao.aceite, condicao.recusa] : ATIVACAO_OPCOES;
  return opcoes.map((o) => dress(o, state).trim());
}

/** Clique (ou texto igual) no botão de aceite da proposta em aberto. */
function isAcceptClick(state: RefundFlowState, text: string) {
  const condicao = condicaoDa(state);
  const labels = [ATIVACAO_OPCOES[0]!, ...(condicao ? [condicao.aceite] : [])];
  return labels.some((l) => normLabel(l) === normLabel(text));
}

/** Condição oferecida na rota atual (ou a padrão da oferta; null = bloco N135–N140 do MGA). */
function condicaoDa(state: RefundFlowState): Condicao | null {
  const route = state.route ? ROUTES[state.route] : null;
  return route?.condicao ?? CONDICAO_PADRAO ?? null;
}

function escapeRe(text: string) {
  return text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
const EMAIL_RE_SRC = escapeRe(EMAIL_SUPORTE);

export type RefundFlowState = {
  active: boolean;
  route: RouteId | null;
  /** etapas do fluxo, incluindo o bloco central da acompanhamento de 7 dias (N133–N147) */
  stage:
    | "aguardando_motivo"
    | "aguardando_resposta_rota"
    /** "Espera responder" do board: a rota fez uma pergunta e espera a resposta, sem botões. */
    | "aguardando_resposta_pergunta"
    | "ativacao_proposta"
    | "ativacao_aceita_diagnostico"
    | "ativacao_encaminhada"
    | "ativacao_whatsapp"
    | "waiting_reactivation"
    | "encerrado";
  endpoint: boolean;
  activation: boolean;
  waitingSince: string | null;
  reactivationShown: boolean;
  softCount: number;
  /** Resumo curto do motivo trazido pela pessoa (usado no N137). */
  reason: string | null;
  /** O diagnóstico (N134) já foi respondido nesta conversa. */
  diagnosisDone: boolean;
  /** Alerta criado no painel quando o acompanhamento de 7 dias é aceito. */
  alertId: string | null;
  /** Momento da última atualização do estado (ISO). Estados antigos reiniciam. */
  updatedAt: string | null;
  /** Pedidos inequívocos de reembolso depois de uma tentativa de retenção. */
  insistencia_reembolso: number;
  /** Alerta do painel que acompanha o contador de insistência. */
  insistAlertId: string | null;
  /** Depois do aceite (WhatsApp): respostas do diagnóstico no chat já foram agradecidas. */
  whatsappThanked?: boolean;
  /** Assunto do pedido: reembolso ou cancelamento (mesma régua de 4). */
  topic?: "reembolso" | "cancelamento" | null;
  /** Cancelamento de assinatura recorrente (Mentoria) x compra avulsa. */
  cancelKind?: "compra" | "assinatura" | null;
};

export const EMPTY_FLOW: RefundFlowState = {
  active: false,
  route: null,
  stage: "encerrado",
  endpoint: false,
  activation: false,
  waitingSince: null,
  reactivationShown: false,
  softCount: 0,
  reason: null,
  diagnosisDone: false,
  alertId: null,
  updatedAt: null,
  insistencia_reembolso: 0,
  insistAlertId: null,
  topic: null,
  cancelKind: null,
};

/** As perguntas do N134, texto idêntico (sem a abertura e sem o fechamento). */
export function n134Perguntas() {
  return N134_DIAGNOSTICO.split("\n").filter((l) => l.startsWith("• ")).join("\n");
}

/** Mensagem do WhatsApp do 7D: depois do Dia 1 e antes do P.S. O link vai como cartão. */
export function whatsappMessage(name: string) {
  return fillName(WHATSAPP_7D_MENSAGEM.replace("[perguntas]", n134Perguntas()), name).replace(
    /^(\p{Ll})/u,
    (c) => c.toUpperCase(),
  );
}

/** Pedido do link do WhatsApp de novo, depois do aceite. */
export const WHATSAPP_LINK_AGAIN = /\b(link|whats(?:app)?|zap|wpp)\b/i;
export function asksWhatsappLinkAgain(text: string) {
  return WHATSAPP_LINK_AGAIN.test(text) &&
    /(de novo|novamente|manda|mande|envia|cad[eê]|qual|n[aã]o (achei|abriu|abre|chegou|apareceu|consegui)|perdi|onde)/i.test(text);
}

/** Resposta da listinha digitada no chat (em vez de ir ao WhatsApp). */
export function looksLikeDiagnosisAnswer(text: string) {
  const t = text.toLowerCase();
  const hits = DIAGNOSTICO_SINAIS.filter((r) => r.test(t)).length;
  return hits >= 3 || (hits >= 2 && text.split("\n").filter((l) => l.trim()).length >= 3);
}

const EMOJI_RE = /[\u{1F000}-\u{1FAFF}\u{2190}-\u{21FF}\u{2300}-\u{27BF}\u{2B00}-\u{2BFF}]/gu;
const VARIATION_RE = /[\u{FE0F}\u{FE0E}]/gu;

export function stripEmoji(text: string) {
  return text
    .replace(EMOJI_RE, "")
    .replace(VARIATION_RE, "")
    .replace(/[ \t]{2,}/g, " ")
    .replace(/[ \t]+$/gm, "")
    // Linha que começava com emoji ("✅ **...**") não fica com espaço sobrando no começo.
    .replace(/^[ \t]+/gm, "");
}

/** Resumo curto (até 15 palavras) do diagnóstico, único trecho preenchido. */
export function summarizeDiagnosis(text: string) {
  const clean = stripEmoji(text)
    .replace(/\s+/g, " ")
    .replace(/[*_#`]/g, "")
    .trim();
  const words = clean.split(" ").filter(Boolean).slice(0, 15);
  return words.join(" ").replace(/[.,;:!?]+$/, "") || "o processo travado no meio do caminho";
}

/** Ameaça jurídica (Procon, processo, advogado, Reclame Aqui): sem emoji, sem cartão. */
const LEGAL_RE =
  /\b(procon|reclame\s*aqui|advogad[oa]|processo\s+judicial|vou\s+(te\s+)?processar|processar\s+voc[êe]s?|a[çc][ãa]o\s+judicial|juizado|justi[çc]a|notifica[çc][ãa]o\s+extrajudicial|c[óo]digo\s+de\s+defesa\s+do\s+consumidor)\b/i;

export function hasLegalThreat(text: string) {
  return LEGAL_RE.test(text);
}

const RISK_RE =
  /(me matar|tirar minha vida|suic[íi]d|n[ãa]o quero mais viver|n[ãa]o aguento mais viver|desistir de viver|sumir do mundo|quero sumir|quero desaparecer|acabar com tudo|n[ãa]o vejo sa[íi]da|me machucar)/i;


export function hasLifeRisk(text: string) {
  return RISK_RE.test(text);
}

/** Classifica o motivo da desistência em uma das 17 rotas. Null = motivo não identificado. */
export function classifyRoute(text: string): RouteId | null {
  for (const c of CLASSIFIERS) if (c.re.test(text)) return c.route;
  return null;
}

const SOFT_RE = /(deixa eu ver|depois eu te falo|vou pensar|pensar melhor|talvez|mais tarde)/i;
export function isSoftAnswer(text: string) {
  return SOFT_RE.test(text);
}

/** Aluno já decidido pelo reembolso antes de entrar em rota → Rota 3 (sticky N005). */
const DECIDED_RE =
  /(prefiro seguir com o reembolso|s[óo] quero o reembolso|j[áa] decidi|mantenho o reembolso|quero (s[óo] )?(o )?reembolso|quero meu dinheiro de volta)/i;

export function firstName(fullName?: string | null) {
  const n = (fullName ?? "").trim().split(/\s+/)[0];
  if (!n || n.length < 2) return "";
  return n.charAt(0).toUpperCase() + n.slice(1);
}

/**
 * Substitui [nome] pelo primeiro nome; sem nome, remove o vocativo sem quebrar a frase.
 * Também resolve as marcas {feminino|masculino} pelo nome (src/lib/dr/genero.ts).
 */
export function fillName(text: string, name: string) {
  text = fillGenero(text, tratamento(name));
  if (name) return text.replaceAll("[nome]", name);
  return text
    .replaceAll("[nome], ", "")
    .replaceAll(", [nome]", "")
    .replaceAll(" [nome]", "")
    .replaceAll("[nome]", "");
}

export function renderScript(messages: string[], name: string) {
  return messages.map((m) => fillName(m, name)).join("\n\n");
}

/** Resolve a resposta do aluno dentro da rota atual (botão clicado ou texto digitado). */
export function resolveAnswer(route: RouteDef, text: string): RefundTarget | null {
  const clean = text.trim().toLowerCase();
  for (const opt of route.options) {
    if (clean === opt.label.trim().toLowerCase()) return opt.target;
  }
  if (RED_MATCH.test(text)) {
    const red = route.options.find((o) => o.target.kind === "red");
    if (red) return red.target;
  }
  for (const opt of route.options) {
    if (opt.match.test(text)) return opt.target;
  }
  return null;
}

/**
 * Uma proposta nunca pode chegar ao chat sem os dois caminhos essenciais.
 * Esta validação central protege todas as saídas, inclusive repetições de rota.
 */
export function proposalReplies(route: RouteDef) {
  const labels = route.options.map((option) => option.label);
  const hasAccept = route.options.some((option) => option.target.kind === "activation");
  const hasRefusal = route.options.some(
    (option) => option.target.kind === "red" || option.target.kind === "route",
  );
  if (labels.length < 2 || !hasAccept || !hasRefusal) {
    throw new Error(`Rota ${route.id} possui proposta sem opções completas.`);
  }
  return labels;
}

function repliesForRoute(route: RouteDef) {
  return (PROPOSAL_ROUTE_IDS as readonly RouteId[]).includes(route.id)
    ? proposalReplies(route)
    : route.options.map((option) => option.label);
}

export type FlowOutcome = {
  content: string;
  /** Segunda mensagem enviada imediatamente depois, antes dos botões. */
  followUpContent?: string;
  /** Mensagens seguintes, em ordem, cada uma inteira (com cartões de link próprios). */
  extras?: { content: string; links?: OfficialLinkKey[] }[];
  state: RefundFlowState;
  /** Respostas da rota, exibidas como botões clicáveis. */
  replies: string[];
  /** Cartão de atendimento humano, quando o endpoint exige. */
  support: { note: string | null } | null;
  /** Sinais para o servidor (alerta do time), nunca mostrados ao aluno. */
  events?: {
    activationAccepted?: boolean;
    diagnosis?: string;
    insistence?: number;
    accept?: { origin: "botão" | "digitado"; text: string; node: string | null };
    whatsappSent?: boolean;
  };
};

const REFUND_TRIGGER_RE =
  /(reembolso|estorno|dinheiro de volta|meu dinheiro|quero (?:sair|desistir|cancelar|encerrar)|me estorn|desistir do curso|golpe|fraude)/i;

/**
 * Pedido de cancelamento/desistência (decisão 30/09): tratado exatamente como
 * pedido de reembolso. "cancelada/cancelado" (status de pagamento) não conta.
 */
const CANCEL_TRIGGER_RE =
  /(\bcancel(?:ar|a|o|e|amento|amentos)\b|\b(?:quero|vou|decidi|pensando em|preciso|gostaria de)\s+desistir\b|\bdesisto\b|\bdesist[êe]ncia\b|desistir (?:d[ao]s?|dess[ea]) (?:curso|compra|mentoria|produto|m[ée]todo)|n[ãa]o quero mais|quero sair|quero encerrar|encerrar (?:a |minha )?(?:compra|assinatura|inscri[çc][ãa]o|matr[íi]cula)|desfazer a compra)/i;

export function isCancelRequest(text: string) {
  return CANCEL_TRIGGER_RE.test(text);
}

export function isRefundTrigger(text: string) {
  return REFUND_TRIGGER_RE.test(text) || isCancelRequest(text) || isHypotheticalRefund(text);
}

/** Assunto e tipo do pedido de cancelamento (assinatura só se a pessoa tiver produto recorrente). */
export function cancelContext(text: string, hasRecurring: boolean) {
  if (!isCancelRequest(text)) return null;
  const subscription = hasRecurring && ASSINATURA_RE.test(text);
  return { topic: "cancelamento" as const, cancelKind: subscription ? ("assinatura" as const) : ("compra" as const) };
}

/* ------------------------------------------------------------------ */
/* Cobrança de prazo: a aluna diz que JÁ enviou o pedido (decisão 30/09) */
/* ------------------------------------------------------------------ */

const DEADLINE_FOLLOWUP_RE =
  /((j[áa]|eu)\s+(pedi|solicitei|enviei|mandei|fiz|abri)\b[^.?!]{0,40}(cancel|reembols|estorn|pedido|e-?mail|solicita)|\b(pedi|solicitei|enviei|mandei)\s+(o|a|meu|minha)?\s*(pedido\s+de\s+)?(cancelamento|reembolso|estorno|e-?mail)|(estou|t[ôo]|to|fico)\s+aguardando[^.?!]{0,40}(cancel|reembols|estorn|retorno|resposta|devolu)|aguardando\s+(o|a)\s+(cancelamento|reembolso|estorno)|n[ãa]o\s+(tive|obtive|recebi)\s+(nenhum\s+|nenhuma\s+)?(retorno|resposta)[^.?!]{0,40}(cancel|reembols|estorn|pedido|e-?mail))/i;

/** A própria aluna afirma que já enviou o pedido de cancelamento/reembolso. */
export function isDeadlineFollowUp(text: string) {
  return DEADLINE_FOLLOWUP_RE.test(text);
}

/* ------------------------------------------------------------------ */
/* Aceite digitado da proposta (decisão 30/09)                          */
/* ------------------------------------------------------------------ */

const ACCEPT_CORE =
  /^(sim|sim bora|sim vamos|bora|bora la|bora comecar|bora comecar o dia 1|vamos|vamos la|vamos nessa|vamos sim|vamos tentar|aceito|aceito sim|quero|quero sim|sim quero|quero muito|topo|topo sim|to dentro|estou dentro|pode fazer|pode fazer a proposta|pode montar|pode mandar|pode sim|combinado|fechado|fechou|manda o dia 1|manda|quero o acompanhamento|com certeza|claro|claro que sim|sim senhor|sim senhora|ok vamos|ok bora|perfeito pode mandar)$/;
const ACCEPT_FILLER = /^(ok|okay|perfeito|beleza|blz|show|otimo|certo|isso|entao)$/;
const HEDGE_RE =
  /(\bacho\b|\btalvez\b|pensar|deixa eu ver|depois|\bver se\b|n[ãa]o sei|\be se\b|\bmas\b|por[ée]m|s[óo] que|ser[áa]|\bn[ãa]o\b|d[úu]vida|mais ou menos|\bse\b|\bcaso\b|\?)/i;

function normAccept(text: string) {
  return stripEmoji(text)
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/(\p{L})\1{2,}/gu, "$1")
    .trim();
}

/**
 * Aceite digitado, por sentido: todas as partes da frase precisam ser aceite
 * (ou "ok/perfeito" junto de um aceite). Qualquer ressalva invalida. Na dúvida, não é aceite.
 */
export function isTypedAccept(text: string) {
  if (!text || text.length > 80) return false;
  if (HEDGE_RE.test(text)) return false;
  const clauses = normAccept(text)
    .split(/[,.!;:\n]+|\s+e\s+/)
    .map((c) => c.replace(/[^a-z0-9 ]/g, " ").replace(/\s+/g, " ").trim())
    .filter(Boolean);
  if (!clauses.length) return false;
  let strong = false;
  for (const c of clauses) {
    if (ACCEPT_CORE.test(c)) strong = true;
    else if (!ACCEPT_FILLER.test(c)) return false;
  }
  return strong;
}

/** Parece aceite, mas tem ressalva ("acho que sim", "sim, mas..."): vai para Possíveis retenções. */
export function isHedgedAccept(text: string) {
  if (isTypedAccept(text)) return false;
  return HEDGE_RE.test(text) && /\b(sim|bora|vamos|topo|quero|aceito|pode|combinado)\b/i.test(normAccept(text));
}

/** A última mensagem do bot foi uma proposta (rota com pergunta de proposta ou N135–N143)? */
export function isProposalContext(state: RefundFlowState | null | undefined) {
  if (!state || !state.active) return false;
  if (state.stage === "ativacao_proposta") return true;
  return (
    state.stage === "aguardando_resposta_rota" &&
    Boolean(state.route && ROUTE_PROPOSAL_NODE[state.route])
  );
}

export function proposalNode(state: RefundFlowState | null | undefined) {
  if (!state) return null;
  if (state.stage === "ativacao_proposta") {
    return CONDICAO_PADRAO ? `condição · rota ${state.route ?? "?"}` : "N135–N143";
  }
  return state.route ? (ROUTE_PROPOSAL_NODE[state.route] ?? null) : null;
}

/* ------------------------------------------------------------------ */
/* Pergunta hipotética x pedido efetivo (decisão 25/09)                 */
/* ------------------------------------------------------------------ */

const REFUND_TOPIC_RE =
  /(reembols|desist|estorn|dinheiro de volta|garantia|prazo (de |da |do |pra )?(garantia|reembols|devolu|desist|cancel|decidir)|tempo (eu tenho )?(pra|para) decidir|devolu[çc][ãa]o do dinheiro|\bcancel|quanto tempo (eu )?tenho|quantos dias (eu )?tenho|e se eu n[ãa]o (?:tiver resultado|conseguir|gostar)|se n[ãa]o der certo)/i;
const HYPOTHETICAL_RE =
  /(\bse\b|\bcaso\b|e se|posso(?:\s+pedir)?|consigo(?:\s+pedir)?|tem como|d[áa] pra|como funciona|tem garantia|qual (é )?a garantia|quanto tempo|quantos dias|at[ée] quando|prazo)/i;
const EFFECTIVE_RE =
  /(quero (o |meu |o meu )?(reembolso|dinheiro|estorno|cancelar|cancelamento)|n[ãa]o quero mais|me estorna|me devolve|quero desistir|quero cancelar|j[áa] (falei|disse|decidi)|mesmo assim|prefiro seguir com o reembolso|n[ãa]o quero|preciso do valor de volta|devolve meu)/i;

/** Pergunta hipotética/condicional sobre reembolso, garantia ou prazo. Na dúvida, é hipotética. */
export function isHypotheticalRefund(text: string) {
  if (!REFUND_TOPIC_RE.test(text)) return false;
  // Condicional/pergunta sempre vence palavras soltas de intenção. Isso cobre
  // frases como “se eu quiser o reembolso depois, posso pedir?”.
  if (HYPOTHETICAL_RE.test(text) || text.includes("?")) return true;
  // Um rótulo isolado como “Reembolso” abre o acolhimento e diagnóstico.
  // Só uma marca real de pergunta/condição transforma a mensagem em objeção.
  return false;
}

const INSIST_LIMIT = 4;

/** Recusa explícita, no presente, reafirmando que quer o dinheiro de volta. Na dúvida, não conta. */
const EXPLICIT_REFUSAL_RE =
  /(prefiro seguir com o reembolso|quero (o |meu |o meu )?(reembolso|dinheiro( de volta)?|estorno)|quero cancelar|me estorna|devolve meu dinheiro|n[ãa]o quero (os 7 dias|a ativa|a proposta|continuar)|j[áa] (falei|disse|decidi)|mesmo assim|mantenho o reembolso|quero (o |fazer o )?cancelamento|\bcancela\b|cancelar (a |minha |essa )?(compra|assinatura|inscri[çc][ãa]o|curso|mentoria)|prefiro cancelar|mantenho o cancelamento|n[ãa]o quero mais|quero sair|quero encerrar|quero desistir|desisto)/i;
const NOT_REFUSAL_RE =
  /(\bse\b|\bcaso\b|e se|como funciona|prazo|garantia|quanto tempo|quantos dias|pensando|vou pensar|talvez|acho que|ser[áa] que|n[ãa]o sei)/i;

export function isExplicitRefusal(text: string) {
  if (isRedLabel(text)) return true;
  if (text.includes("?")) return false;
  if (NOT_REFUSAL_RE.test(text)) return false;
  return EXPLICIT_REFUSAL_RE.test(text);
}

/**
 * Trava de saída: o e-mail de reembolso (N152) só é liberado pelo servidor,
 * dentro do fluxo 7D. Qualquer texto gerado pela IA passa por aqui e perde
 * as frases com o endereço ou com o pedido de e-mail de reembolso.
 */
export function stripRefundEmail(text: string) {
  const blocked = new RegExp(`${EMAIL_RE_SRC}|assunto\\s*\\**\\s*[“"]?reembolso`, "i");
  if (!blocked.test(text)) return text;
  const kept = text
    .split(/\n+/)
    .map((para) =>
      para
        .split(/(?<=[.!?])\s+/)
        .filter((sentence) => !blocked.test(sentence))
        .join(" "),
    )
    .filter((para) => para.trim().length > 0)
    .join("\n\n");
  return kept.trim() || "Me conta com calma o que tá acontecendo que eu te ajudo por aqui.";
}

/** Identifica o texto específico do Endpoint Vermelho antes de persistir a resposta. */
export function containsRefundEndpoint(text: string) {
  const n154 = N154_REEMBOLSO.replace(/\[nome\][,!]?\s*/g, "").slice(0, 60).trim();
  return (
    containsCancelEndpoint(text) ||
    (n154.length > 20 && text.includes(n154)) ||
    new RegExp(
      `formalizar seu pedido de reembolso|${EMAIL_RE_SRC}[\\s\\S]{0,180}(?:reembols|assunto)|(?:reembols|assunto)[\\s\\S]{0,180}${EMAIL_RE_SRC}|assunto\\s*\\**\\s*[“"]?reembolso|time financeiro processa`,
      "i",
    ).test(text)
  );
}

/** Passo a passo/endereço de cancelamento (mesma trava do e-mail de reembolso). */
export function containsCancelEndpoint(text: string) {
  return new RegExp(
    `${EMAIL_RE_SRC}[\\s\\S]{0,180}cancel|cancel[\\s\\S]{0,180}${EMAIL_RE_SRC}|assunto\\s*\\**\\s*[“"]?cancelamento|fluxo oficial de cancelamento|(?:formalizar|solicitar|pedir|fazer|concluir)\\s+(?:o\\s+|seu\\s+)?(?:pedido\\s+de\\s+)?cancelamento\\s+(?:[ée] assim|pelo|por e-?mail|envi)|(?:pra|para)\\s+cancelar[\\s\\S]{0,60}(?:envi|mand)[ae]\\s+(?:um\\s+)?e-?mail|passo a passo (?:do|de|para o|pro) cancelamento`,
    "i",
  ).test(text);
}

export type RefundOutputGuard = {
  content: string;
  followUpContent?: string;
  state: RefundFlowState;
  replies: string[];
  support: { note: string | null } | null;
  audit: {
    rule: "refund_endpoint_v1" | "cancel_endpoint_v1";
    decision: "allowed" | "blocked" | "not_present";
    reason: string;
    insistence: number;
    explicitCurrentRequest: boolean;
  };
};

/**
 * Última trava de saída, independente de rota ou gerador do texto.
 * Se detectar o Endpoint Vermelho sem as duas condições atuais, substitui tudo pela Rota 5.
 */
export function guardRefundOutput(args: {
  content: string;
  state?: RefundFlowState | null;
  currentUserText: string;
  name: string;
}): RefundOutputGuard {
  const state = args.state ?? EMPTY_FLOW;
  const insistence = state.insistencia_reembolso ?? 0;
  const explicitCurrentRequest = isExplicitRefusal(args.currentUserText);
  const hasEndpoint = containsRefundEndpoint(args.content);
  const rule = containsCancelEndpoint(args.content) ? ("cancel_endpoint_v1" as const) : ("refund_endpoint_v1" as const);
  const allowed = hasEndpoint && insistence >= INSIST_LIMIT && explicitCurrentRequest;

  if (hasEndpoint && !allowed) {
    const fallback = hypotheticalOutcome(args.name, { ...state, endpoint: false });
    return {
      content: fallback.content,
      ...(fallback.followUpContent ? { followUpContent: fallback.followUpContent } : {}),
      state: fallback.state,
      replies: fallback.replies,
      support: null,
      audit: {
        rule,
        decision: "blocked",
        reason: `Endpoint bloqueado: insistência ${Math.min(insistence, INSIST_LIMIT)}/${INSIST_LIMIT}; pedido explícito atual=${explicitCurrentRequest ? "sim" : "não"}`,
        insistence,
        explicitCurrentRequest,
      },
    };
  }

  return {
    content: args.content,
    state,
    replies: [],
    support: null,
    audit: {
      rule,
      decision: allowed ? "allowed" : "not_present",
      reason: allowed
        ? `Endpoint liberado: insistência ${insistence}/${INSIST_LIMIT} e pedido explícito atual`
        : "Endpoint não apareceu na resposta",
      insistence,
      explicitCurrentRequest,
    },
  };
}

/**
 * Pedido de reembolso depois de uma retenção: soma insistência.
 * Endpoint Vermelho só a partir de 4; antes disso, reenquadramento diferente.
 */
function insistOutcome(name: string, state: RefundFlowState, text: string): FlowOutcome {
  if (isHypotheticalRefund(text)) return hypotheticalOutcome(name, state);
  if (!isExplicitRefusal(text)) {
    return {
      content: dress(fillName(NAO_CONTA_TEXTO, name), state),
      state: { ...state, active: true, endpoint: false, stage: "ativacao_proposta" },
      replies: opcoesDaProposta(state),
      support: null,
    };
  }
  const count = (state.insistencia_reembolso ?? 0) + 1;
  const next = { ...state, insistencia_reembolso: count };
  if (count >= INSIST_LIMIT) {
    const out = endpointOutcome({ kind: "red" }, name, next)!;
    return { ...out, events: { insistence: count } };
  }
  const item = INSISTENCIA_REENQUADRAMENTO[count - 1] ?? INSISTENCIA_REENQUADRAMENTO[0]!;
  // MSI: um reenquadramento pode ser uma rota inteira do board (ex.: argumento da Soffia).
  if (typeof item !== "string") {
    return { ...enterRoute(item.rota, name, next), events: { insistence: count } };
  }
  return {
    content: dress(fillName(item, name), next),
    state: { ...next, active: true, stage: "ativacao_proposta" },
    replies: opcoesDaProposta(next),
    support: null,
    events: { insistence: count },
  };
}

/** Rota 5 (N038–N042): garantia curta e honesta + proposta dos 7 dias. */
function hypotheticalOutcome(name: string, base: RefundFlowState): FlowOutcome {
  const route = ROUTES["5"];
  const repeated = base.route === "5" && base.stage === "aguardando_resposta_rota";
  const content = repeated
    ? fillGenero(HIPOTETICA_REPETIDA, tratamento(name)).replaceAll("[nome]", name || "você")
    : [fillName(route.messages[0] ?? "", name), HIPOTETICA_PONTE].filter((t) => t.trim()).join("\n\n");
  // Sem texto próprio da oferta, a 2ª mensagem é o resto da Rota 5 (MSI: board #128 e #129).
  const followUpContent = HIPOTETICA_PROPOSTA.trim()
    ? fillName(HIPOTETICA_PROPOSTA, name)
    : renderScript(route.messages.slice(1), name);
  return {
    content,
    followUpContent,
    state: {
      ...base,
      endpoint: false,
      active: true,
      route: "5",
      reason: base.reason ?? ROUTE_REASON["5"],
      stage: "aguardando_resposta_rota",
    },
    replies: repliesForRoute(route),
    support: null,
  };
}

/** Bloco central sem emoji quando a rota de origem é a 3 ou a D1 (seção 6). */
function dress(text: string, state: RefundFlowState) {
  return state.route && NO_EMOJI_ROUTES.includes(state.route) ? stripEmoji(text) : text;
}

function enterRoute(routeId: RouteId, name: string, base: RefundFlowState): FlowOutcome {
  const route = ROUTES[routeId];
  const espera = Boolean(route.continuacao?.length);
  return {
    content: renderScript(route.messages, name),
    state: {
      ...base,
      active: true,
      route: routeId,
      reason: ROUTE_REASON[routeId],
      stage: espera ? "aguardando_resposta_pergunta" : "aguardando_resposta_rota",
    },
    replies: espera ? [] : repliesForRoute(route),
    support: null,
  };
}

function endpointOutcome(
  target: RefundTarget,
  name: string,
  base: RefundFlowState,
): FlowOutcome | null {
  switch (target.kind) {
    case "route":
      return enterRoute(target.route, name, base);
    case "red":
      if (base.cancelKind === "assinatura") {
        return {
          content: fillName(ASSINATURA_ENCERRAMENTO, name),
          state: { ...base, active: false, stage: "encerrado", endpoint: true },
          replies: [],
          support: { note: "Cancelamento de assinatura (Mentoria), veio do bot" },
        };
      }
      return {
        content: `${fillName(N154_REEMBOLSO, name)}\n\n${fillName(N155_FECHAMENTO, name)}`,
        state: { ...base, active: false, stage: "encerrado", endpoint: true },
        replies: [],
        support: null,
      };
    case "activation":
      // Resposta positiva da rota → condição da rota (no MGA: N135 a N140). Nada de humano aqui.
      return proposalOutcome(name, base);
    case "accept":
      return acceptOutcome(name, base, { origin: "botão", text: "", node: proposalNode(base) });
    case "scam_end":
      return {
        content: fillName(D1_GOLPE_INSISTIDO, name),
        state: { ...base, active: false, stage: "encerrado" },
        replies: [],
        support: null,
      };
    case "finalize":
      return {
        content: fillName(D3_FINALIZACAO, name),
        state: {
          ...base,
          active: true,
          stage: "waiting_reactivation",
          waitingSince: new Date().toISOString(),
          reactivationShown: false,
        },
        replies: [],
        support: null,
      };
    case "escalate":
      // Risco de vida: acolhimento + CVV, sem cartão de atendimento.
      return {
        content: fillName(ESCALACAO_RISCO, name),
        state: { ...base, active: false, stage: "encerrado" },
        replies: [],
        support: null,
      };
    default:
      return null;
  }
}

/**
 * Aceite (clique ou digitado, mesmo caminho): N143 → [N144 é montado pelo time]
 * → listinha + WhatsApp → N145. A fila "Aceitaram" e o aviso seguem como antes.
 */
function acceptOutcome(
  name: string,
  state: RefundFlowState,
  accept: { origin: "botão" | "digitado"; text: string; node: string | null },
): FlowOutcome {
  return {
    content: dress(fillName(N143_CONFIRMACAO, name), state),
    extras: [
      { content: dress(whatsappMessage(name), state), links: ["whatsapp_7d"] },
      // MSI: o board não tem P.S. depois do link (N145 vazio).
      ...(N145_PS.trim() ? [{ content: dress(fillName(N145_PS, name), state) }] : []),
    ],
    state: { ...state, active: false, activation: true, stage: "ativacao_whatsapp", whatsappThanked: false },
    replies: [],
    support: null,
    events: { activationAccepted: true, accept, whatsappSent: true },
  };
}

/**
 * Proposta do acompanhamento de 7 dias. Com condição na rota (ou CONDICAO_PADRAO da oferta):
 * as mensagens da condição + botões de aceite e recusa. Sem condição: N135 a N140 (modelo MGA).
 */
function proposalOutcome(name: string, base: RefundFlowState): FlowOutcome {
  const condicao = condicaoDa(base);
  if (condicao) {
    const msgs = condicao.messages.map((m) => dress(fillName(m, name), base));
    return {
      content: msgs.slice(0, Math.max(1, msgs.length - 1)).join("\n\n"),
      ...(msgs.length > 1 ? { followUpContent: msgs[msgs.length - 1] } : {}),
      state: { ...base, active: true, stage: "ativacao_proposta" },
      replies: [condicao.aceite, condicao.recusa].map((o) => dress(o, base).trim()),
      support: null,
    };
  }
  const resumo = base.reason ?? "o processo travado no meio do caminho";
  const reenquadramento = [
    N135_OFERTA,
    N136_JUSTIFICATIVA,
    N137_PERSONALIZADO,
  ]
    .map((m) => fillName(m, name).replaceAll("[diagnostico]", fillGenero(resumo, tratamento(name))))
    .join("\n\n");
  const proposta = [
    N138_SETE_DIAS,
    N139_BONUS,
    N140_COMPROMISSO,
  ]
    .map((m) => fillName(m, name).replaceAll("[diagnostico]", fillGenero(resumo, tratamento(name))))
    .join("\n\n");
  return {
    content: dress(reenquadramento, base),
    followUpContent: dress(proposta, base),
    state: { ...base, active: true, stage: "ativacao_proposta" },
    replies: ATIVACAO_OPCOES.map((o) => dress(o, base).trim()),
    support: null,
  };
}

/** Primeira mensagem do fluxo: N002 sempre; rota classificada ou N004. */
export function startFlow(
  text: string,
  name: string,
  ctx?: Pick<RefundFlowState, "topic" | "cancelKind"> | null,
): FlowOutcome {
  const base: RefundFlowState = { ...EMPTY_FLOW, ...(ctx ?? {}), active: true, reason: summarizeDiagnosis(text) };
  if (hasLifeRisk(text)) return endpointOutcome({ kind: "escalate" }, name, base)!;
  // Pergunta hipotética ("posso pedir reembolso depois?") não é motivo: o N137 usa o motivo da Rota 5,
  // e não o começo da mensagem da aluna (no MGA saía "O que tá pesando pra você é posso pedir...").
  if (isHypotheticalRefund(text)) return hypotheticalOutcome(name, { ...base, reason: null });

  const routeId =
    ROTA_MUDOU_DE_IDEIA && ROTA_MUDOU_DE_IDEIA.re.test(text) ? ROTA_MUDOU_DE_IDEIA.route : classifyRoute(text);
  const acolhimento = fillName(N002_ACOLHIMENTO, name);

  if (!routeId) {
    return {
      content: `${acolhimento}\n\n${fillName(N004_DIAGNOSTICO, name)}`,
      state: { ...base, stage: "aguardando_motivo" },
      replies: [],
      support: null,
    };
  }

  const routed = enterRoute(routeId, name, base);
  if (ROUTES[routeId].semAcolhimento) return routed;
  return { ...routed, content: `${acolhimento}\n\n${routed.content}` };
}

/** Passo seguinte do fluxo já ativo. */
export function advanceFlow(state: RefundFlowState, text: string, name: string): FlowOutcome {
  if (hasLifeRisk(text)) return endpointOutcome({ kind: "escalate" }, name, state)!;
  // A classificação vale mais que o estado: pergunta nunca abre o Endpoint Vermelho.
  if (isHypotheticalRefund(text)) return hypotheticalOutcome(name, { ...state, endpoint: false });
  // "Mudei de ideia, quero continuar" vence a palavra "reembolso" da mesma frase.
  if (ROTA_MUDOU_DE_IDEIA && ROTA_MUDOU_DE_IDEIA.re.test(text)) return enterRoute(ROTA_MUDOU_DE_IDEIA.route, name, state);

  // "Espera responder": qualquer resposta que não seja recusa recebe a continuação + botões.
  if (state.stage === "aguardando_resposta_pergunta") {
    const route = state.route ? ROUTES[state.route] : null;
    if (isRedChoice(text) || !route?.continuacao) return insistOutcome(name, state, text);
    return {
      content: renderScript(route.continuacao, name),
      state: { ...state, active: true, stage: "aguardando_resposta_rota" },
      replies: repliesForRoute(route),
      support: null,
      events: { diagnosis: text.slice(0, 1500) },
    };
  }

  if (state.stage === "waiting_reactivation") {
    if (isRedChoice(text)) return insistOutcome(name, state, text);
    if (/manh[ãa]|almo[çc]o|noite|sim|bora|vamos/i.test(text)) {
      return endpointOutcome({ kind: "activation" }, name, state)!;
    }
    const due =
      !state.reactivationShown &&
      Boolean(state.waitingSince) &&
      Date.now() - new Date(state.waitingSince as string).getTime() >= 60 * 60 * 1000;
    if (due) {
      return {
        content: fillName(D3_REATIVACAO, name),
        state: { ...state, reactivationShown: true },
        replies: D3_REATIVACAO_OPCOES,
        support: null,
      };
    }
    return {
      content: fillName(D3_FINALIZACAO, name),
      state,
      replies: [],
      support: null,
    };
  }

  // Proposta enviada (N135–N140): SIM → N143 (+N134 se faltar); "deixa eu ver" → D3; reembolso → Endpoint Vermelho.
  if (state.stage === "ativacao_proposta") {
    if (isRedChoice(text)) return insistOutcome(name, state, text);
    const clicked = isAcceptClick(state, text);
    const typed = !clicked && isTypedAccept(text);
    if (!clicked && !typed) {
      if (isSoftAnswer(text) || isHedgedAccept(text) || /deixa eu ver|depois/i.test(text)) {
        return enterRoute("D3", name, { ...state, softCount: state.softCount + 1 });
      }
      // Fora do botão e sem aceite claro: na dúvida, NÃO é aceite (decisão 30/09).
      return {
        content: dress(fillName(NAO_CONTA_TEXTO, name), state),
        state: { ...state, active: true, endpoint: false, stage: "ativacao_proposta" },
        replies: opcoesDaProposta(state),
        support: null,
      };
    }
    const accept = { origin: clicked ? ("botão" as const) : ("digitado" as const), text: text.slice(0, 300), node: proposalNode(state) };

    return acceptOutcome(name, state, accept);
  }

  // Diagnóstico respondido depois do SIM → encaminhamento para o time, com cartão.
  if (state.stage === "ativacao_aceita_diagnostico") {
    if (isRedChoice(text)) return insistOutcome(name, state, text);
    return {
      content: dress(fillName(ATIVACAO_ENCAMINHADA, name), state),
      state: {
        ...state,
        active: false,
        diagnosisDone: true,
        stage: "ativacao_encaminhada",
      },
      replies: [],
      support: { note: ATIVACAO_NOTA },
      events: { diagnosis: text.slice(0, 1500) },
    };
  }

  if (state.stage === "aguardando_motivo") {
    // Sticky N005: já chegou decidido → direto para a Rota 3.
    const routeId = DECIDED_RE.test(text) ? "3" : (classifyRoute(text) ?? "1");
    return enterRoute(routeId, name, { ...state, reason: summarizeDiagnosis(text) });
  }

  const route = state.route ? ROUTES[state.route] : null;
  if (!route) return startFlow(text, name);

  // Proposta da rota: aceite digitado segue o mesmo caminho do clique; ressalva é resposta suave.
  if (isProposalContext(state)) {
    const exact = route.options.some((o) => o.label.trim().toLowerCase() === text.trim().toLowerCase());
    if (!exact && !RED_MATCH.test(text)) {
      if (isTypedAccept(text)) {
        const yes = route.options.find((o) => o.target.kind === "activation");
        if (yes) return endpointOutcome(yes.target, name, state)!;
      } else if (isHedgedAccept(text)) {
        const softCount = state.softCount + 1;
        if (softCount >= 2 || state.route === "D3") {
          return endpointOutcome({ kind: "finalize" }, name, { ...state, softCount })!;
        }
        return enterRoute("D3", name, { ...state, softCount });
      }
    }
  }

  const answer = resolveAnswer(route, text);
  if (answer?.kind === "red") return insistOutcome(name, state, text);
  if (answer) {
    const outcome = endpointOutcome(answer, name, state);
    if (outcome) return outcome;
  }

  if (isSoftAnswer(text)) {
    const softCount = state.softCount + 1;
    if (softCount >= 2 || state.route === "D3") {
      return endpointOutcome({ kind: "finalize" }, name, { ...state, softCount })!;
    }
    return enterRoute("D3", name, { ...state, softCount });
  }

  const reclassified = classifyRoute(text);
  if (reclassified && reclassified !== state.route) return enterRoute(reclassified, name, state);

  // Resposta fora do roteiro: repete a pergunta da rota, sem inventar texto.
  const last = route.messages[route.messages.length - 1] ?? "";
  return {
    content: fillName(last, name),
    state,
    replies: repliesForRoute(route),
    support: null,
  };
}

/* ------------------------------------------------------------------ */
/* Reinício do fluxo: estado antigo/encerrado não sequestra o pedido    */
/* ------------------------------------------------------------------ */

const FLOW_MAX_AGE_MS = 24 * 60 * 60 * 1000;

/** Estado velho (>24h) ou já encerrado não deve continuar um fluxo. */
export function isFlowStale(state: RefundFlowState) {
  if (!state.active) return true;
  if (state.stage === "encerrado" || state.endpoint) return true;
  if (!state.updatedAt) return false;
  const ts = new Date(state.updatedAt).getTime();
  if (!Number.isFinite(ts)) return false;
  return Date.now() - ts > FLOW_MAX_AGE_MS;
}

/**
 * Pedido de reembolso NOVO dentro de uma rota: a pessoa não respondeu a
 * pergunta da rota, trouxe outro motivo. Nesse caso o fluxo recomeça pela
 * entrada (N002) em vez de cair no Endpoint Vermelho.
 */
export function isNewRefundRequest(state: RefundFlowState, text: string) {
  if (isFlowStale(state)) return isRefundTrigger(text);
  if (state.stage !== "aguardando_resposta_rota") return false;
  const route = state.route ? ROUTES[state.route] : null;
  if (route) {
    const clean = text.trim().toLowerCase();
    if (route.options.some((o) => clean === o.label.trim().toLowerCase())) return false;
  }
  if (!isRefundTrigger(text)) return false;
  const rid = classifyRoute(text);
  return Boolean(rid && rid !== state.route);
}

const STAGE_LABEL: Record<RefundFlowState["stage"], string> = {
  aguardando_motivo: "aguardando motivo",
  aguardando_resposta_rota: "aguardando resposta da rota",
  aguardando_resposta_pergunta: "aguardando a resposta da pergunta da rota",
  ativacao_proposta: "ativação · proposta enviada",
  ativacao_aceita_diagnostico: "ativação · aceita, aguardando diagnóstico",
  ativacao_encaminhada: "ativação · aceita, encaminhada",
  ativacao_whatsapp: "ativação · aceita, enviada ao WhatsApp",
  waiting_reactivation: "aguardando reativação",
  encerrado: "encerrado",
};

/** Resumo legível do 7D para auditoria no painel. */
export function describeFlow(state: RefundFlowState | null | undefined) {
  if (!state || (!state.active && !state.endpoint && !state.activation && !state.route))
    return null;
  const parts: string[] = [];
  if (state.insistencia_reembolso > 0 || state.endpoint)
    parts.push(
      state.topic === "cancelamento"
        ? `cancelamento · insistência ${Math.min(state.insistencia_reembolso ?? 0, 4)}/4`
        : `7D - reembolso - insistência ${Math.min(state.insistencia_reembolso ?? 0, 4)}/4`,
    );
  parts.push(state.route ? `Rota ${state.route}` : "Entrada");
  parts.push(STAGE_LABEL[state.stage] ?? state.stage);
  if (state.endpoint) parts.push("endpoint vermelho");
  if (state.activation) parts.push("ativação aceita");
  return parts.join(" · ");
}
