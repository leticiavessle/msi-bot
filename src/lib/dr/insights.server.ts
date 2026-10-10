import { fetchAll } from "./paging";
import { AiHttpError, AiNotConfiguredError, runAI } from "./ai-provider.server";
/**
 * Parte A — classificação de conversas SÓ para relatório. Não toca no chat:
 * lê messages/risk_alerts e grava em conversation_insights.
 */
import type { SupabaseClient } from "@supabase/supabase-js";
import { NOME_DO_CURSO_NO_RELATORIO, REFUND_REASONS, STAGES, TOPICS } from "../../oferta/relatorios";
import { ATIVACAO_ALERTA_PREFIXO, NOME_ATIVACAO } from "./refund-protocol";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type Admin = SupabaseClient<any>;

const TZ = "America/Sao_Paulo";

/** Categorias da classificação: src/oferta/relatorios.ts. */
export { REFUND_REASONS, STAGES, TOPICS };
const SENTIMENTS = ["positivo", "neutro", "negativo"] as const;

/** Data (YYYY-MM-DD) no fuso de São Paulo. */
export function spDay(d: Date | string): string {
  return new Intl.DateTimeFormat("en-CA", { timeZone: TZ, year: "numeric", month: "2-digit", day: "2-digit" }).format(new Date(d));
}
/** Início do dia SP (UTC-3 fixo; o Brasil não tem horário de verão). */
export function spDayStart(day: string): Date {
  return new Date(`${day}T00:00:00-03:00`);
}

export class AiBlockedError extends Error {
  constructor(public status: number, msg: string) { super(msg); }
}

type Msg = { role: string; content: string; created_at: string; detected_intent: string | null; metadata: unknown };

const SYSTEM = `Você classifica UMA conversa de suporte (${NOME_DO_CURSO_NO_RELATORIO}) para um relatório interno. Responda só JSON com as chaves:
topic (${TOPICS.join("|")}), refund_requested (bool), refund_reason (${REFUND_REASONS.join("|")}|null),
refund_retained (bool: desistiu do reembolso ou aceitou a ${NOME_ATIVACAO} 7D), sentiment (${SENTIMENTS.join("|")}),
resolved_by_bot (bool: dúvida resolvida sem humano), needed_human (bool), repeated_question (bool: a aluna repetiu a mesma pergunta),
abandoned (bool: parou de responder no meio de dúvida não resolvida), onboarding_stage (${STAGES.join("|")}|null, pelo que a aluna diz),
stuck (bool: diz que travou nessa etapa), summary (português, até 200 caracteres, sem e-mail/telefone).
Use as dicas de "sinais existentes" (intenção detectada e alertas de risco) sem contradizê-las.`;

function pickEnum<T extends readonly string[]>(list: T, v: unknown, fallback: T[number] | null): T[number] | null {
  return typeof v === "string" && (list as readonly string[]).includes(v) ? (v as T[number]) : fallback;
}

async function callClassifier(transcript: string) {
  try {
    const out = await runAI({ use: "classificacao", system: SYSTEM, messages: [{ role: "user", content: transcript }] });
    return JSON.parse(out.raw || "{}") as Record<string, unknown>;
  } catch (e) {
    if (e instanceof AiHttpError && (e.status === 402 || e.status === 403)) throw new AiBlockedError(e.status, e.body.slice(0, 300));
    if (e instanceof AiHttpError) throw new Error(`AI ${e.status}: ${e.body.slice(0, 200)}`);
    throw e;
  }
}

/** Classifica uma conversa num dia (SP) e grava/atualiza o insight. */
export async function classifyConversationDay(admin: Admin, conversationId: string, userId: string, day: string) {
  const start = spDayStart(day);
  const end = new Date(start.getTime() + 86_400_000);
  const { data: msgs } = await admin
    .from("messages")
    .select("role, content, created_at, detected_intent, metadata")
    .eq("conversation_id", conversationId)
    .gte("created_at", start.toISOString())
    .lt("created_at", end.toISOString())
    .order("created_at", { ascending: true })
    .limit(200);
  const list = (msgs ?? []) as Msg[];
  if (!list.length) return null;

  const { data: alerts } = await admin
    .from("risk_alerts")
    .select("reason, risk_level")
    .eq("conversation_id", conversationId)
    .gte("created_at", start.toISOString())
    .lt("created_at", end.toISOString());
  const intents = [...new Set(list.map((m) => m.detected_intent).filter(Boolean))];
  const alertReasons = (alerts ?? []).map((a) => `${a.risk_level}: ${String(a.reason).slice(0, 120)}`);
  const accepted7d = alertReasons.some((r) => r.toLowerCase().includes(ATIVACAO_ALERTA_PREFIXO.toLowerCase()));
  const humanMsgs = list.some((m) => (m.metadata as Record<string, unknown> | null)?.["human"]);

  const transcript = [
    `Sinais existentes — intenção detectada: ${intents.join(", ") || "nenhuma"}; alertas de risco: ${alertReasons.join(" | ") || "nenhum"}; atendimento humano: ${humanMsgs ? "sim" : "não"}.`,
    "Conversa:",
    ...list.map((m) => `[${m.created_at.slice(11, 16)}] ${(m.metadata as Record<string, unknown> | null)?.["human"] ? "equipe" : m.role}: ${m.content.slice(0, 1200)}`),
  ].join("\n").slice(0, 24_000);

  const r = await callClassifier(transcript);
  const refundRequested = Boolean(r["refund_requested"]);
  const row = {
    conversation_id: conversationId,
    user_id: userId,
    day,
    topic: pickEnum(TOPICS, r["topic"], "outros")!,
    refund_requested: refundRequested,
    refund_reason: refundRequested ? pickEnum(REFUND_REASONS, r["refund_reason"], "outro") : null,
    refund_retained: accepted7d || Boolean(r["refund_retained"]),
    sentiment: pickEnum(SENTIMENTS, r["sentiment"], "neutro")!,
    resolved_by_bot: !humanMsgs && Boolean(r["resolved_by_bot"]),
    needed_human: humanMsgs || Boolean(r["needed_human"]),
    repeated_question: Boolean(r["repeated_question"]),
    abandoned: Boolean(r["abandoned"]),
    onboarding_stage: pickEnum(STAGES, r["onboarding_stage"], null),
    stuck: Boolean(r["stuck"]),
    summary: typeof r["summary"] === "string" ? r["summary"].slice(0, 200) : null,
    last_message_at: list[list.length - 1]!.created_at,
    classified_at: new Date().toISOString(),
  };
  await admin.from("conversation_insights").upsert(row, { onConflict: "conversation_id,day" });
  return row;
}

/**
 * Classifica as conversas com mensagens novas em [from, to) que ainda não têm
 * insight atualizado. Limitado a `max` por execução.
 */
export async function classifyPending(admin: Admin, from: Date, to: Date, max = 40) {
  const msgs = await fetchAll<{ conversation_id: string; user_id: string; created_at: string }>((a, b) =>
    admin
      .from("messages")
      .select("conversation_id, user_id, created_at")
      .gte("created_at", from.toISOString())
      .lt("created_at", to.toISOString())
      .order("created_at", { ascending: false })
      .range(a, b),
  );
  // última mensagem por (conversa, dia)
  const latest = new Map<string, { conversationId: string; userId: string; day: string; lastAt: string }>();
  for (const m of msgs ?? []) {
    const day = spDay(m.created_at);
    const key = `${m.conversation_id}|${day}`;
    if (!latest.has(key)) latest.set(key, { conversationId: m.conversation_id, userId: m.user_id, day, lastAt: m.created_at });
  }
  if (!latest.size) return { classified: 0, pending: 0, errors: 0 };

  const ids = [...new Set([...latest.values()].map((v) => v.conversationId))];
  const done = new Map<string, string | null>();
  for (let i = 0; i < ids.length; i += 200) {
    const { data } = await admin
      .from("conversation_insights")
      .select("conversation_id, day, last_message_at")
      .in("conversation_id", ids.slice(i, i + 200));
    for (const d of data ?? []) done.set(`${d.conversation_id}|${d.day}`, d.last_message_at);
  }
  const todo = [...latest.entries()].filter(([k, v]) => {
    const last = done.get(k);
    return last === undefined || last === null || new Date(last) < new Date(v.lastAt);
  });

  let classified = 0;
  let errors = 0;
  for (const [, v] of todo.slice(0, max)) {
    try {
      await classifyConversationDay(admin, v.conversationId, v.userId, v.day);
      classified++;
    } catch (e) {
      if (e instanceof AiBlockedError || e instanceof AiNotConfiguredError) throw e;
      errors++;
      console.error("[insights] falha", v.conversationId, e instanceof Error ? e.message : e);
    }
  }
  return { classified, pending: Math.max(0, todo.length - classified), errors };
}
