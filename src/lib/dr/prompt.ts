import { PRODUCTS, PRODUCT_LABELS, type Product } from "./config";
import { IDENTITY, MARCA, POLITICAS } from "../../oferta/marca";
import { NOME_ATIVACAO } from "../../oferta/protocolo-7d";
import { OFFICIAL_LINKS, type OfficialLinkDef } from "../../oferta/links";
import { ATENDIMENTO_HUMANO, COMUNIDADE } from "../../oferta/produtos";
import { PRIMEIRAS_AULAS, ROTULO_NIVEL } from "../../oferta/aulas";
import { humanCardCases } from "./human-cases";
import { tratamento } from "./genero";

export type MemoryRow = {
  current_stage: string | null;
  main_difficulties: string | null;
  last_guidance: string | null;
  recommended_action: string | null;
  action_result: string | null;
  risk_level: string;
  next_action: string | null;
  current_difficulty: string | null;
  stuck_reason: string | null;
  last_evolution: string | null;
};

export const REFUND_SIGNALS: { pattern: RegExp; weight: "medium" | "high" | "critical" }[] = [
  {
    pattern: /\b(quero|pedir|solicitar)\s+(o\s+)?(reembolso|estorno|dinheiro de volta)\b/i,
    weight: "critical",
  },
  {
    pattern: /\b(cancelar|cancela)\s+(minha\s+)?(assinatura|compra|curso)?\b/i,
    weight: "critical",
  },
  { pattern: /\b(golpe|fraude|chargeback)\b/i, weight: "high" },
  {
    pattern: /\b(n[aã]o vejo valor|arrependid[oa]|dinheiro jogado|n[aã]o era o que eu esperava)\b/i,
    weight: "high",
  },
  { pattern: /\b(reembolso|estorno|garantia|direito de arrependimento)\b/i, weight: "medium" },
];

export function detectRefundRisk(text: string) {
  const matched = REFUND_SIGNALS.filter((s) => s.pattern.test(text));
  if (!matched.length) return null;
  const order = { medium: 1, high: 2, critical: 3 } as const;
  const level = matched.reduce(
    (a, s) => (order[s.weight] > order[a] ? s.weight : a),
    "medium" as "medium" | "high" | "critical",
  );
  return { level, signals: matched.map((s) => s.pattern.source) };
}

export type RefundState = {
  active?: boolean;
  route?: string | null;
  stage?: string | null;
  endpoint?: boolean;
  activation?: boolean;
  waitingSince?: string | null;
  reactivationShown?: boolean;
};

/* ------------------------------------------------------------------ */
/* Blocos de texto do prompt (src/oferta/prompt/*.md)                   */
/* ------------------------------------------------------------------ */

/** Os 4 blocos editáveis, na ordem em que entram no prompt. */
export type PromptBlocks = {
  /** 01 · identidade, missão, público e voz (o system prompt da oferta). */
  identidade: string;
  /** 02 · restrições herdadas do MGA (sempre entram, acima de tudo). */
  restricoes: string;
  /** 03 · regras específicas da oferta (primeiros passos, ordem de cadastro, temas delicados). */
  regrasOferta: string;
  /** 04 · regras técnicas de resposta (o servidor depende delas). */
  regrasTecnicas: string;
};

/** Tira os comentários de edição (<!-- ... -->), que nunca vão para a IA. */
export function stripEditorNotes(markdown: string) {
  return markdown.replace(/<!--[\s\S]*?-->/g, "").replace(/\n{3,}/g, "\n\n").trim();
}

function linksTable() {
  const rows = (Object.values(OFFICIAL_LINKS) as OfficialLinkDef[]).map(
    (l) => `| ${l.label} | ${l.soServidor ? "(botão enviado pelo servidor)" : l.url} | ${l.quando} |`,
  );
  rows.push(
    `| ${ATENDIMENTO_HUMANO.rotulo} | (cartão) | Nunca escreva: o servidor mostra o cartão só nos casos oficiais |`,
  );
  return ["| Para quê | Link | Quando mandar |", "|---|---|---|", ...rows].join("\n");
}

/** Valores das {{chaves}} usadas nos blocos. */
export function promptVariables(): Record<string, string> {
  return {
    nome_assistente: MARCA.nomeAssistente,
    nome_produto: MARCA.nomeProduto,
    nome_expert: MARCA.nomeExpert,
    resposta_sou_humano: IDENTITY.humanCheck,
    frase_nao_encontrei: POLITICAS.fraseNaoEncontrei,
    resposta_preco: POLITICAS.respostaPreco,
    garantia_dias: String(POLITICAS.garantiaDias),
    nome_ativacao: NOME_ATIVACAO,
    nome_comunidade: COMUNIDADE.nome,
    rotulo_nivel: ROTULO_NIVEL,
    rotulo_nivel_minusculo: ROTULO_NIVEL.toLowerCase(),
    primeiras_aulas: PRIMEIRAS_AULAS.join(", "),
    casos_atendimento_humano: humanCardCases(NOME_ATIVACAO).join("; "),
    tabela_links: linksTable(),
  };
}

/** Troca {{chave}} pelo valor. Chave desconhecida fica como está (o teste acusa). */
export function fillPlaceholders(text: string, vars: Record<string, string> = promptVariables()) {
  return text.replace(/\{\{(\w+)\}\}/g, (match, key: string) => vars[key] ?? match);
}

/* ------------------------------------------------------------------ */
/* Montagem (mesma ordem do prompt em produção no MGA)                  */
/* ------------------------------------------------------------------ */

export function buildSystemPrompt(
  params: {
    products: Product[];
    studentName?: string | null;
    memory: MemoryRow | null;
    intent?: string | null;
    intents?: string[];
    knowledge?: string[];
    basePrompt?: string | null;
    voiceGuide?: string | null;
    refundState?: RefundState | null;
    /** MSI: o servidor gravou agora um alerta de venda para o time (a IA pode dizer que avisou o time). */
    salesAlerted?: boolean;
  },
  blocks: PromptBlocks,
) {
  const {
    products,
    studentName,
    memory,
    intent,
    intents = [],
    knowledge = [],
    basePrompt,
    voiceGuide,
    refundState,
    salesAlerted = false,
  } = params;
  const vars = promptVariables();
  const block = (md: string) => fillPlaceholders(stripEditorNotes(md), vars);

  const memoryLines = memory
    ? [
        `etapa/assunto atual: ${memory.current_stage ?? "não registrado"}`,
        `dificuldade: ${memory.current_difficulty ?? memory.main_difficulties ?? "não registrada"}`,
        `última orientação: ${memory.last_guidance ?? "nenhuma"}`,
        `próxima ação: ${memory.next_action ?? memory.recommended_action ?? "não registrada"}`,
        `resultado: ${memory.action_result ?? "não registrado"}`,
      ].join("\n- ")
    : "sem memória registrada";
  const productNames = products.map((p) => `${p} (${PRODUCT_LABELS[p] ?? p})`).join(", ");

  return [
    block(blocks.identidade),

    `Prioridade: as RESTRIÇÕES OFICIAIS abaixo valem acima de tudo, inclusive da identidade e da voz acima.
Exceção única: as REGRAS TÉCNICAS DE RESPOSTA, no fim deste prompt, prevalecem sobre qualquer trecho que mande direcionar para atendimento humano ou enviar link sem a pessoa pedir.`,

    block(blocks.restricoes),

    block(blocks.regrasOferta),

    `## PROTOCOLO 7D (REEMBOLSO) — NÃO É COM VOCÊ
- Reembolso, estorno, cancelamento, desistência, acusação de golpe e risco de vida são tratados pelo servidor, com os scripts oficiais, antes de você ser chamado.
- Nunca escreva texto próprio sobre reembolso, retenção, ${NOME_ATIVACAO}, Protocolo 7D, garantia ou prazo por iniciativa própria.
- Garantia de ${POLITICAS.garantiaDias} dias somente se perguntarem diretamente.`,

    `## CONTEXTO SEGURO DO SERVIDOR
- Nome: ${studentName ?? "não informado"}. Tratamento: ${tratamento(studentName) === "masculino" ? "masculino (o primeiro nome indica homem)" : "feminino"}.
- Produtos ativos: ${productNames || "nenhum"}.
- Estado do protocolo 7D: ${JSON.stringify(refundState ?? {})}.
- Memória simples: ${memoryLines}.
- Intenção do botão: ${intent ?? "nenhuma"}.
- Intenções detectadas: ${intents.join(", ") || "outra"}.
- Interesse de compra avisado ao time agora: ${salesAlerted ? "sim" : "não"}.`,

    `## TRECHOS RECUPERADOS DAS AULAS
${knowledge.length ? knowledge.join("\n---\n") : "Nenhum trecho oficial aprovado cobre a pergunta."}`,

    [
      block(blocks.regrasTecnicas),
      basePrompt ? `- Configuração complementar, subordinada às regras oficiais: ${basePrompt}` : "",
      voiceGuide ? `- Guia de voz complementar: ${voiceGuide}` : "",
    ]
      .filter(Boolean)
      .join("\n"),

    `Responda SOMENTE com JSON válido:
{"reply":"texto","lesson_refs":[{"id":"V1.M01.A01","minute":"1:20"}],"diagnosis":"interno curto","recommended_action":"próxima ação curta ou null","memory_updates":{"current_stage":null,"main_difficulties":null,"next_action":null,"current_difficulty":null,"stuck_reason":null,"last_evolution":null,"action_result":null},"handoff":false,"handoff_product":"${PRODUCTS.join("|")}|null","handoff_note":null,"community_link":false,"refund_state":{"active":false,"route":null,"stage":null,"endpoint":false,"activation":false,"waitingSince":null,"reactivationShown":false}}
Preserve no refund_state os valores anteriores que continuam válidos. Nunca revele diagnosis, alertas ou refund_state ao aluno.`,
  ].join("\n\n");
}
