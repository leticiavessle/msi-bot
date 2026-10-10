/** Parte C — dados dos relatórios (somente leitura) e envio no WhatsApp. */
import type { SupabaseClient } from "@supabase/supabase-js";
import { REFUND_REASONS, STAGES, TOPICS, spDay } from "./insights.server";
import { WHATSAPP_TEMPLATE_RELATORIO } from "../../oferta/relatorios";
import { ATIVACAO_ALERTA_PREFIXO } from "./refund-protocol";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type Admin = SupabaseClient<any>;

const DAY = 86_400_000;

/** Compara o Bearer com REPORT_API_TOKEN em tempo constante. */
export async function checkReportToken(request: Request): Promise<Response | null> {
  const secret = process.env["REPORT_API_TOKEN"];
  if (!secret) return new Response("Not configured", { status: 503 });
  const token = /^Bearer\s+(\S+)$/.exec(request.headers.get("authorization") ?? "")?.[1];
  if (!token) return new Response("Unauthorized", { status: 401 });
  const { createHash, timingSafeEqual } = await import("node:crypto");
  const h = (v: string) => createHash("sha256").update(v).digest();
  if (!timingSafeEqual(h(token), h(secret))) return new Response("Unauthorized", { status: 401 });
  return null;
}

export function maskPii(text: string): string {
  return text
    .replace(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/gi, "***")
    .replace(/(\+?\d[\d\s().-]{7,}\d)/g, "***");
}
const firstName = (n: string | null | undefined) => (n ?? "").trim().split(/\s+/)[0] || "Aluna";

async function paged<T>(fn: (from: number, to: number) => PromiseLike<{ data: T[] | null }>) {
  const out: T[] = [];
  for (let i = 0; i < 50; i++) {
    const { data } = await fn(i * 1000, i * 1000 + 999);
    out.push(...(data ?? []));
    if (!data || data.length < 1000) break;
  }
  return out;
}

const countBy = (vals: (string | null)[], keys: readonly string[]) => {
  const o: Record<string, number> = Object.fromEntries(keys.map((k) => [k, 0]));
  for (const v of vals) if (v) o[v] = (o[v] ?? 0) + 1;
  return o;
};

type Insight = {
  conversation_id: string; user_id: string; day: string; topic: string; refund_requested: boolean; refund_reason: string | null;
  refund_retained: boolean; sentiment: string; resolved_by_bot: boolean; needed_human: boolean; repeated_question: boolean;
  abandoned: boolean; onboarding_stage: string | null; stuck: boolean; summary: string | null; last_message_at: string | null;
};

/** Totais + agregados de insights para uma janela. */
export async function windowNumbers(admin: Admin, start: Date, end: Date) {
  const s = start.toISOString();
  const e = end.toISOString();
  const msgs = await paged<{ conversation_id: string; user_id: string; role: string }>((a, b) =>
    admin.from("messages").select("conversation_id, user_id, role").gte("created_at", s).lt("created_at", e).range(a, b),
  );
  const events = await paged<{ provider: string; event_type: string }>((a, b) =>
    admin.from("webhook_events").select("provider, event_type").in("provider", ["hubla", "payt"]).gte("created_at", s).lt("created_at", e).range(a, b),
  );
  const { count: firstAccess } = await admin.from("profiles").select("id", { count: "exact", head: true }).gte("created_at", s).lt("created_at", e);
  const acc = await paged<{ user_id: string }>((a, b) => admin.from("access_alerts").select("user_id").gte("created_at", s).lt("created_at", e).order("id").range(a, b));
  const act = await paged<{ user_id: string }>((a, b) => admin.from("risk_alerts").select("user_id").like("reason", `${ATIVACAO_ALERTA_PREFIXO}%`).gte("created_at", s).lt("created_at", e).order("id").range(a, b));

  const insights = await paged<Insight>((a, b) =>
    admin.from("conversation_insights").select("*").gte("day", spDay(start)).lte("day", spDay(new Date(end.getTime() - 1))).gte("last_message_at", s).range(a, b),
  );
  const bool = (k: keyof Insight) => insights.filter((i) => i[k] === true).length;

  return {
    totais: {
      conversas: new Set(msgs.map((m) => m.conversation_id)).size,
      mensagens: msgs.length,
      alunas_ativas: new Set(msgs.filter((m) => m.role === "user").map((m) => m.user_id)).size,
      novas_compras: events.filter((x) => x.event_type === "purchase_approved").length,
      reembolsos_reais: events.filter((x) => x.event_type === "refund" || x.event_type === "chargeback").length,
      primeiro_acesso: firstAccess ?? 0,
      alunas_dificuldade_acesso: new Set((acc ?? []).map((r) => r.user_id)).size,
      alunas_ativacao: new Set((act ?? []).map((r) => r.user_id)).size,
    },
    insights: {
      total_classificadas: insights.length,
      topic: countBy(insights.map((i) => i.topic), TOPICS),
      refund_reason: countBy(insights.map((i) => i.refund_reason), REFUND_REASONS),
      onboarding_stage: countBy(insights.map((i) => i.onboarding_stage), STAGES),
      sentiment: countBy(insights.map((i) => i.sentiment), ["positivo", "neutro", "negativo"]),
      refund_requested: bool("refund_requested"),
      refund_retained: bool("refund_retained"),
      resolved_by_bot: bool("resolved_by_bot"),
      needed_human: bool("needed_human"),
      repeated_question: bool("repeated_question"),
      abandoned: bool("abandoned"),
      stuck: bool("stuck"),
    },
  };
}

type Nums = Awaited<ReturnType<typeof windowNumbers>>;

/** Média numérica profunda de vários objetos de mesma forma. */
function average(list: Nums[]): Nums {
  const avg = (vals: unknown[]): unknown => {
    const f = vals[0];
    if (typeof f === "number") return Math.round(((vals as number[]).reduce((a, b) => a + b, 0) / vals.length) * 10) / 10;
    if (f && typeof f === "object") {
      return Object.fromEntries(Object.keys(f).map((k) => [k, avg(vals.map((v) => (v as Record<string, unknown>)[k] ?? 0))]));
    }
    return f;
  };
  return avg(list) as Nums;
}

export async function buildReportData(admin: Admin, start: Date, end: Date) {
  const atual = await windowNumbers(admin, start, end);
  const prev = await windowNumbers(admin, new Date(start.getTime() - DAY), new Date(end.getTime() - DAY));
  const week: Nums[] = [];
  for (let d = 1; d <= 7; d++) week.push(await windowNumbers(admin, new Date(start.getTime() - d * DAY), new Date(end.getTime() - d * DAY)));

  // Compradoras dos últimos 30 dias (grants liberados) e quem já acessou.
  const since30 = new Date(end.getTime() - 30 * DAY).toISOString();
  const grants = await paged<{ email: string; granted_at: string; hubla_status: string | null }>((a, b) =>
    admin.from("product_access_grants").select("email, granted_at, hubla_status").gte("granted_at", since30).lt("granted_at", end.toISOString()).range(a, b),
  );
  const buyers = new Map<string, Date>();
  for (const g of grants) {
    if (g.hubla_status && /reembols|refund|chargeback|cancel/i.test(g.hubla_status)) continue;
    const email = g.email.toLowerCase();
    const at = new Date(g.granted_at);
    if (!buyers.has(email) || buyers.get(email)! > at) buyers.set(email, at);
  }
  const emails = [...buyers.keys()];
  const profiles: { id: string; email: string | null; name: string | null }[] = [];
  const auth: { email: string; name: string | null }[] = [];
  for (let i = 0; i < emails.length; i += 200) {
    const chunk = emails.slice(i, i + 200);
    const { data: p } = await admin.from("profiles").select("id, email, name").in("email", chunk);
    profiles.push(...(p ?? []));
    const { data: au } = await admin.from("authorized_users").select("email, name").in("email", chunk);
    auth.push(...(au ?? []));
  }
  const profileByEmail = new Map(profiles.map((p) => [(p.email ?? "").toLowerCase(), p]));
  const authName = new Map(auth.map((a) => [a.email.toLowerCase(), a.name]));
  const userIds = profiles.map((p) => p.id);
  const latestInsight = new Map<string, Insight>();
  const latestStage = new Map<string, string>();
  for (let i = 0; i < userIds.length; i += 200) {
    const { data } = await admin
      .from("conversation_insights").select("*").in("user_id", userIds.slice(i, i + 200))
      .order("last_message_at", { ascending: false, nullsFirst: false }).limit(5000);
    for (const r of (data ?? []) as Insight[]) {
      if (!latestInsight.has(r.user_id)) latestInsight.set(r.user_id, r);
      if (r.onboarding_stage && !latestStage.has(r.user_id)) latestStage.set(r.user_id, r.onboarding_stage);
    }
  }
  const stageCount: Record<string, number> = Object.fromEntries([...STAGES, "sem_etapa"].map((k) => [k, 0]));
  let accessed = 0;
  const emRisco: Record<string, unknown>[] = [];
  for (const [email, at] of buyers) {
    const p = profileByEmail.get(email);
    if (p) accessed++;
    const stage = p ? latestStage.get(p.id) ?? null : null;
    stageCount[stage ?? "sem_etapa"]!++;
    const days = Math.floor((end.getTime() - at.getTime()) / DAY);
    if (days > 7) continue;
    const ins = p ? latestInsight.get(p.id) : undefined;
    const reasons: string[] = [];
    if (!p) reasons.push("nao_acessou");
    if (ins?.stuck) reasons.push("travada");
    if (ins?.sentiment === "negativo") reasons.push("sentimento_negativo");
    if (ins?.refund_requested && !ins.refund_retained) reasons.push("reembolso_sem_resolver");
    if (!reasons.length) continue;
    emRisco.push({
      primeiro_nome: firstName(p?.name ?? authName.get(email)),
      dias_desde_compra: days,
      etapa: stage,
      ultimo_tema: ins?.topic ?? null,
      ultimo_resumo: ins?.summary ? maskPii(ins.summary) : null,
      motivos: reasons,
    });
  }

  // Conversas da janela com mensagens e insight.
  const msgs = await paged<{ conversation_id: string; user_id: string; role: string; content: string; created_at: string; metadata: unknown }>((a, b) =>
    admin.from("messages").select("conversation_id, user_id, role, content, created_at, metadata")
      .gte("created_at", start.toISOString()).lt("created_at", end.toISOString()).order("created_at", { ascending: true }).range(a, b),
  );
  const convIds = [...new Set(msgs.map((m) => m.conversation_id))];
  const convUsers = [...new Set(msgs.map((m) => m.user_id))];
  const names = new Map<string, string | null>();
  for (let i = 0; i < convUsers.length; i += 200) {
    const { data } = await admin.from("profiles").select("id, name").in("id", convUsers.slice(i, i + 200));
    for (const p of data ?? []) names.set(p.id, p.name);
  }
  const insightByConv = new Map<string, Insight>();
  for (let i = 0; i < convIds.length; i += 200) {
    const { data } = await admin.from("conversation_insights").select("*").in("conversation_id", convIds.slice(i, i + 200))
      .gte("day", spDay(start)).order("day", { ascending: true });
    for (const r of (data ?? []) as Insight[]) insightByConv.set(r.conversation_id, r);
  }
  const conversas = convIds.map((id) => {
    const list = msgs.filter((m) => m.conversation_id === id);
    const ins = insightByConv.get(id);
    return {
      conversation_id: id,
      primeiro_nome: firstName(names.get(list[0]!.user_id)),
      mensagens: list.map((m) => ({
        papel: (m.metadata as Record<string, unknown> | null)?.["human"] ? "equipe" : m.role,
        texto: maskPii(m.content),
        horario: m.created_at,
      })),
      insight: ins ? { ...ins, user_id: undefined, summary: ins.summary ? maskPii(ins.summary) : null } : null,
    };
  });

  return {
    periodo: { inicio: start.toISOString(), fim: end.toISOString() },
    ...atual,
    comparacao: { mesma_janela_24h_antes: prev, media_mesma_janela_7_dias: average(week) },
    compradoras_30d: { total: buyers.size, ja_acessaram: accessed, por_etapa: stageCount },
    em_risco: emRisco,
    conversas,
  };
}

/** Envia o template aprovado (src/oferta/relatorios.ts) pela WhatsApp Cloud API. */
export async function sendWhatsappReport(params: string[]): Promise<{ status: "enviado" | "erro"; error: string | null }> {
  const token = process.env["WHATSAPP_TOKEN"];
  const phoneId = process.env["WHATSAPP_PHONE_NUMBER_ID"];
  const to = process.env["REPORT_WHATSAPP_TO"];
  if (!token || !phoneId || !to) return { status: "erro", error: "Segredos do WhatsApp não configurados" };
  try {
    const res = await fetch(`https://graph.facebook.com/v21.0/${phoneId}/messages`, {
      method: "POST",
      headers: { Authorization: `Bearer ${token}`, "Content-Type": "application/json" },
      body: JSON.stringify({
        messaging_product: "whatsapp",
        to,
        type: "template",
        template: {
          name: WHATSAPP_TEMPLATE_RELATORIO,
          language: { code: "pt_BR" },
          components: [{ type: "body", parameters: params.map((text) => ({ type: "text", text })) }],
        },
      }),
    });
    if (res.ok) return { status: "enviado", error: null };
    const body = (await res.json().catch(() => null)) as { error?: { message?: string; code?: number } } | null;
    return { status: "erro", error: `${res.status}: ${body?.error?.message ?? "erro desconhecido"}`.slice(0, 500) };
  } catch (e) {
    return { status: "erro", error: e instanceof Error ? e.message.slice(0, 500) : "falha de rede" };
  }
}
