import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { assertAdmin, audit, ONLINE_WINDOW_MS } from "./admin-guard";
import { fetchAll, spDayKey } from "./paging";
import { describeFlow, type RefundFlowState } from "./refund-protocol";

/** Remove campos indefinidos (argumentos opcionais do RPC). */
function clean<T extends Record<string, unknown>>(o: T) {
  return Object.fromEntries(Object.entries(o).filter(([, v]) => v !== undefined)) as {
    [K in keyof T]: Exclude<T[K], undefined>;
  };
}

const DAY_MS = 24 * 60 * 60 * 1000;

/** Visão geral do painel: presença, atividade, mensagens e risco. Tudo contado no banco, fuso de Brasília. */
export const getAdminOverview = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data, error } = await context.supabase.rpc("admin_overview_metrics" as never);
    if (error) throw new Error("Não consegui calcular a visão geral.");
    const m = data as unknown as Record<string, number | string | null>;
    const n = (k: string) => Number(m[k] ?? 0);
    return {
      onlineNow: n("onlineNow"),
      activeToday: n("activeToday"),
      active7d: n("active7d"),
      active30d: n("active30d"),
      totalUsers: n("totalUsers"),
      activeUsers: n("activeUsers"),
      messagesToday: n("messagesTodayUser"),
      messagesTodayUser: n("messagesTodayUser"),
      messagesTodayBot: n("messagesTodayBot"),
      conversationsToday: n("conversationsToday"),
      peopleToday: n("peopleToday"),
      lastUserMessageAt: (m["lastUserMessageAt"] as string | null) ?? null,
      avgMessagesPerUser: n("avgMessagesPerUser"),
      newUsers7d: n("newUsers7d"),
      atRisk: n("atRisk"),
      criticalAlerts: n("criticalAlerts"),
      // Contador do menu: PESSOAS com alerta pendente, não alertas soltos.
      pendingAlerts: n("atRisk"),
      pendingAlertItems: n("pendingAlertItems"),
      returnRate: n("returnRate"),
    };
  });

/** Séries de uso (dia, hora, temas, eventos). Agregado no banco, fuso de Brasília. */
export const getAdminAnalytics = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data, error } = await context.supabase.rpc("admin_usage_series" as never);
    if (error) throw new Error("Não consegui calcular as séries de uso.");
    const s = data as unknown as {
      daily: { day: string; messages: number; botMessages: number; users: number }[];
      hourly: { hour: number; count: number }[];
      topics: { intent: string; count: number }[];
      events: { name: string; count: number }[];
      nextActions: { name: string; count: number }[];
    };
    return {
      daily: s.daily ?? [],
      hourly: s.hourly ?? [],
      topics: s.topics ?? [],
      events: s.events ?? [],
      journey: { nextActions: s.nextActions ?? [] },
    };
  });

export const listRiskAlerts = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        level: z.enum(["all", "medium", "high", "critical"]).default("all"),
        status: z.enum(["all", "pending", "resolved"]).default("pending"),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    let query = context.supabase
      .from("risk_alerts")
      .select(
        "id, user_id, conversation_id, risk_level, reason, trigger_text, status, created_at, resolved_at",
      )
      .order("created_at", { ascending: false })
      .limit(300);
    if (data.level !== "all") query = query.eq("risk_level", data.level);
    if (data.status !== "all") query = query.eq("status", data.status);

    const { data: alerts } = await query;
    const ids = [...new Set((alerts ?? []).map((a) => a.user_id))];
    const { data: profiles } = ids.length
      ? await context.supabase.from("profiles").select("id, name, email").in("id", ids)
      : { data: [] as { id: string; name: string | null; email: string | null }[] };
    const byId = new Map((profiles ?? []).map((p) => [p.id, p]));

    return (alerts ?? []).map((a) => ({
      ...a,
      name: byId.get(a.user_id)?.name ?? null,
      email: byId.get(a.user_id)?.email ?? null,
    }));
  });

export const resolveRiskAlert = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({ id: z.string().uuid(), status: z.enum(["pending", "resolved", "ignored"]) })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { error } = await context.supabase
      .from("risk_alerts")
      .update({
        status: data.status,
        reviewed_by: context.userId,
        resolved_at: data.status === "pending" ? null : new Date().toISOString(),
      })
      .eq("id", data.id);
    if (error) throw new Error("Não consegui atualizar o alerta.");
    await audit(context, "alert_resolved", { metadata: { alertId: data.id, status: data.status } });
    return { ok: true };
  });

const LEVEL_RANK: Record<string, number> = { low: 0, medium: 1, high: 2, critical: 3 };

/** Alertas agrupados por pessoa: uma linha por aluna, com todos os alertas dela. */
export const listRiskAlertsByPerson = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        level: z.enum(["all", "medium", "high", "critical"]).default("all"),
        status: z.enum(["all", "pending", "resolved"]).default("pending"),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    type A = {
      id: string;
      user_id: string;
      conversation_id: string | null;
      risk_level: string;
      reason: string | null;
      trigger_text: string | null;
      status: string;
      created_at: string;
      resolved_at: string | null;
    };
    const all: A[] = [];
    for (let offset = 0; offset < 20000; offset += 1000) {
      let q = context.supabase
        .from("risk_alerts")
        .select("id, user_id, conversation_id, risk_level, reason, trigger_text, status, created_at, resolved_at")
        .order("created_at", { ascending: false })
        .range(offset, offset + 999);
      if (data.level !== "all") q = q.eq("risk_level", data.level);
      if (data.status !== "all") q = q.eq("status", data.status);
      const { data: page } = await q;
      all.push(...((page ?? []) as A[]));
      if ((page ?? []).length < 1000) break;
    }
    const groups = new Map<string, A[]>();
    for (const a of all) groups.set(a.user_id, [...(groups.get(a.user_id) ?? []), a]);
    const ids = [...groups.keys()];
    const profiles: { id: string; name: string | null; email: string | null }[] = [];
    for (let i = 0; i < ids.length; i += 300) {
      const { data: p } = await context.supabase
        .from("profiles")
        .select("id, name, email")
        .in("id", ids.slice(i, i + 300));
      profiles.push(...(p ?? []));
    }
    const byId = new Map(profiles.map((p) => [p.id, p]));
    return [...groups.entries()]
      .map(([userId, alerts]) => ({
        userId,
        name: byId.get(userId)?.name ?? null,
        email: byId.get(userId)?.email ?? null,
        count: alerts.length,
        pendingCount: alerts.filter((a) => a.status === "pending").length,
        topLevel: alerts.reduce(
          (top, a) => ((LEVEL_RANK[a.risk_level] ?? 0) > (LEVEL_RANK[top] ?? 0) ? a.risk_level : top),
          "low",
        ),
        latestAt: alerts[0]!.created_at,
        alerts,
      }))
      .sort((a, b) => b.latestAt.localeCompare(a.latestAt));
  });

/** Resolve todos os alertas pendentes de uma pessoa de uma vez. */
export const resolveRiskAlertsForPerson = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ userId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: rows, error } = await context.supabase
      .from("risk_alerts")
      .update({ status: "resolved", reviewed_by: context.userId, resolved_at: new Date().toISOString() })
      .eq("user_id", data.userId)
      .eq("status", "pending")
      .select("id");
    if (error) throw new Error("Não consegui resolver os alertas.");
    await audit(context, "alerts_resolved_person", {
      targetUserId: data.userId,
      metadata: { count: rows?.length ?? 0 },
    });
    return { resolved: rows?.length ?? 0 };
  });

/** Conversas com busca por nome/e-mail e filtro por data. */
type ConvRpcRow = {
  id: string;
  user_id: string;
  title: string | null;
  status: string;
  created_at: string;
  updated_at: string;
  message_count: number;
  name: string | null;
  email: string | null;
  has_profile: boolean;
  refund_state: unknown;
  total_count: number;
};

function flowLabel(state: unknown) {
  return state && typeof state === "object" ? describeFlow(state as RefundFlowState) : null;
}

export const searchConversations = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        term: z.string().trim().max(120).optional().nullable(),
        from: z.string().date().optional().nullable(),
        to: z.string().date().optional().nullable(),
        includeEmpty: z.boolean().optional().nullable(),
        userId: z.string().uuid().optional().nullable(),
        limit: z.number().int().min(1).max(200).optional().nullable(),
        offset: z.number().int().min(0).optional().nullable(),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: rows, error } = await context.supabase.rpc("admin_list_conversations", clean({
      _term: data.term || undefined,
      _from: data.from || undefined,
      _to: data.to || undefined,
      _include_empty: Boolean(data.includeEmpty),
      _user_id: data.userId || undefined,
      _limit: data.limit ?? 50,
      _offset: data.offset ?? 0,
    }));
    if (error) throw new Error("Não consegui carregar as conversas.");
    const list = (rows ?? []) as ConvRpcRow[];
    const { takeoverMap } = await import("./takeover.functions");
    const taken = new Map(
      (await takeoverMap(context.supabase, { conversationIds: list.map((c) => c.id) })).map((t) => [t.id, t]),
    );
    return {
      total: Number(list[0]?.total_count ?? 0),
      items: list.map((c) => ({
        id: c.id,
        user_id: c.user_id,
        title: c.title,
        status: c.status,
        created_at: c.created_at,
        updated_at: c.updated_at,
        messageCount: Number(c.message_count),
        name: c.name,
        email: c.email,
        hasProfile: c.has_profile,
        refundFlow: flowLabel(c.refund_state),
        takeover: taken.has(c.id)
          ? { name: taken.get(c.id)!.human_takeover_name ?? "Equipe", since: taken.get(c.id)!.human_takeover_at }
          : null,
      })),
    };
  });

/** Uma linha por pessoa, ordenada pela atividade mais recente. */
export const listConversationPeople = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        term: z.string().trim().max(120).optional().nullable(),
        limit: z.number().int().min(1).max(200).optional().nullable(),
        offset: z.number().int().min(0).optional().nullable(),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: rows, error } = await context.supabase.rpc("admin_list_conversation_people", clean({
      _term: data.term || undefined,
      _limit: data.limit ?? 50,
      _offset: data.offset ?? 0,
    }));
    if (error) throw new Error("Não consegui carregar as pessoas.");
    const list = rows ?? [];
    const { takeoverMap } = await import("./takeover.functions");
    const takenByUser = new Map(
      (await takeoverMap(context.supabase, { userIds: list.map((p) => p.user_id) })).map((t) => [t.user_id, t]),
    );
    return {
      total: Number(list[0]?.total_count ?? 0),
      items: list.map((p) => ({
        takeover: takenByUser.has(p.user_id)
          ? { name: takenByUser.get(p.user_id)!.human_takeover_name ?? "Equipe", since: takenByUser.get(p.user_id)!.human_takeover_at }
          : null,
        userId: p.user_id,
        name: p.name,
        email: p.email,
        hasProfile: p.has_profile,
        products: p.products ?? [],
        conversationCount: Number(p.conversation_count),
        firstAt: p.first_at,
        lastAt: p.last_at,
      })),
    };
  });

/** Relatório de custo de IA: por dia, por aluno e totais dos períodos. */
export const getAiCostReport = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { supabase } = context;
    const since = new Date(Date.now() - 60 * DAY_MS).toISOString();

    const [rows, { data: config }] = await Promise.all([
      fetchAll<{ user_id: string; created_at: string; cost_usd: number | null; total_tokens: number | null }>((a, b) =>
        supabase
          .from("messages")
          .select("user_id, created_at, cost_usd, total_tokens")
          .eq("role", "assistant")
          .not("cost_usd", "is", null)
          .gte("created_at", since)
          .order("created_at", { ascending: true })
          .range(a, b),
      ),
      supabase
        .from("assistant_config")
        .select("key, value")
        .in("key", ["ai_price_input_per_mtok", "ai_price_output_per_mtok"]),
    ]);

    const priceOf = (key: string) => {
      const row = (config ?? []).find((c) => c.key === key);
      const n = typeof row?.value === "number" ? row.value : Number(row?.value);
      return Number.isFinite(n) ? n : 0;
    };

    const data = rows ?? [];
    const now = new Date();
    const todayKey = spDayKey(now);
    const monthKey = todayKey.slice(0, 7);
    const since7Key = spDayKey(new Date(Date.now() - 6 * DAY_MS));

    const byDay = new Map<string, { cost: number; messages: number; tokens: number }>();
    const byUser = new Map<string, { cost: number; messages: number }>();
    let costToday = 0;
    let cost7d = 0;
    let costMonth = 0;
    let totalCost = 0;
    let totalTokens = 0;

    for (const r of data) {
      const cost = Number(r.cost_usd ?? 0);
      const day = spDayKey(r.created_at);
      const entry = byDay.get(day) ?? { cost: 0, messages: 0, tokens: 0 };
      entry.cost += cost;
      entry.messages += 1;
      entry.tokens += r.total_tokens ?? 0;
      byDay.set(day, entry);

      const u = byUser.get(r.user_id) ?? { cost: 0, messages: 0 };
      u.cost += cost;
      u.messages += 1;
      byUser.set(r.user_id, u);

      totalCost += cost;
      totalTokens += r.total_tokens ?? 0;
      if (day === todayKey) costToday += cost;
      if (day >= since7Key) cost7d += cost;
      if (day.startsWith(monthKey)) costMonth += cost;
    }

    const dayOfMonth = Number(todayKey.slice(8, 10));
    const [yy, mm] = todayKey.split("-").map(Number) as [number, number];
    const daysInMonth = new Date(Date.UTC(yy, mm, 0)).getUTCDate();
    const topIds = [...byUser.entries()].sort((a, b) => b[1].cost - a[1].cost).slice(0, 10).map(([id]) => id);
    const { data: profiles } = topIds.length
      ? await supabase.from("profiles").select("id, name, email").in("id", topIds)
      : { data: [] as { id: string; name: string | null; email: string | null }[] };
    const byId = new Map((profiles ?? []).map((p) => [p.id, p]));

    return {
      prices: {
        input: priceOf("ai_price_input_per_mtok"),
        output: priceOf("ai_price_output_per_mtok"),
      },
      costToday,
      cost7d,
      costMonth,
      projectedMonth: dayOfMonth > 0 ? (costMonth / dayOfMonth) * daysInMonth : 0,
      messages: data.length,
      totalTokens,
      avgPerMessage: data.length ? totalCost / data.length : 0,
      avgPerUser: byUser.size ? totalCost / byUser.size : 0,
      users: byUser.size,
      daily: [...byDay.entries()]
        .sort(([a], [b]) => a.localeCompare(b))
        .slice(-30)
        .map(([day, v]) => ({ day, cost: v.cost, messages: v.messages, tokens: v.tokens })),
      topUsers: [...byUser.entries()]
        .sort((a, b) => b[1].cost - a[1].cost)
        .slice(0, 10)
        .map(([id, v]) => ({
          userId: id,
          name: byId.get(id)?.name ?? null,
          email: byId.get(id)?.email ?? null,
          cost: v.cost,
          messages: v.messages,
        })),
    };
  });

/** Atualiza o preço por milhão de tokens usado no cálculo de custo. */
export const setAiPrices = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({ input: z.number().min(0).max(1000), output: z.number().min(0).max(1000) })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    await supabaseAdmin.from("assistant_config").upsert(
      [
        { key: "ai_price_input_per_mtok", value: data.input },
        { key: "ai_price_output_per_mtok", value: data.output },
      ],
      { onConflict: "key" },
    );
    await audit(context, "ai_prices_updated", { metadata: { ...data } });
    return { ok: true };
  });

/** Exporta conversas (uma linha por mensagem) para planilha. */
export const exportConversations = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        conversationId: z.string().uuid().optional().nullable(),
        userId: z.string().uuid().optional().nullable(),
        term: z.string().trim().max(120).optional().nullable(),
        from: z.string().date().optional().nullable(),
        to: z.string().date().optional().nullable(),
        byPeople: z.boolean().optional().nullable(),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabase } = context;

    // Lista ordenada de conversas (sem teto): mais recente primeiro.
    type Conv = { id: string; title: string | null; name: string | null; email: string | null };
    const list: Conv[] = [];
    if (data.conversationId) {
      const { data: c } = await supabase
        .from("conversations")
        .select("id, user_id, title")
        .eq("id", data.conversationId)
        .maybeSingle();
      if (c) {
        const { data: p } = await supabase
          .from("profiles")
          .select("name, email")
          .eq("id", c.user_id)
          .maybeSingle();
        list.push({ id: c.id, title: c.title, name: p?.name ?? null, email: p?.email ?? null });
      }
    } else if (data.byPeople) {
      for (let offset = 0; ; offset += 200) {
        const { data: people, error } = await supabase.rpc("admin_list_conversation_people", clean({
          _term: data.term || undefined,
          _limit: 200,
          _offset: offset,
        }));
        if (error) throw new Error("Falha ao listar pessoas.");
        const page = people ?? [];
        for (const person of page) {
          for (let o = 0; ; o += 200) {
            const { data: convs } = await supabase.rpc("admin_list_conversations", clean({
              _user_id: person.user_id,
              _limit: 200,
              _offset: o,
            }));
            const cs = (convs ?? []) as ConvRpcRow[];
            for (const c of cs) list.push({ id: c.id, title: c.title, name: c.name, email: c.email });
            if (cs.length < 200) break;
          }
        }
        if (page.length < 200) break;
      }
    } else {
      for (let offset = 0; ; offset += 200) {
        const { data: convs, error } = await supabase.rpc("admin_list_conversations", clean({
          _term: data.term || undefined,
          _from: data.from || undefined,
          _to: data.to || undefined,
          _user_id: data.userId || undefined,
          _limit: 200,
          _offset: offset,
        }));
        if (error) throw new Error("Falha ao listar conversas.");
        const cs = (convs ?? []) as ConvRpcRow[];
        for (const c of cs) list.push({ id: c.id, title: c.title, name: c.name, email: c.email });
        if (cs.length < 200) break;
      }
    }
    if (list.length === 0) return { rows: [], conversations: 0 };

    const byConversation = new Map(list.map((c) => [c.id, c]));
    const order = new Map(list.map((c, i) => [c.id, i]));
    const ids = list.map((c) => c.id);
    const rows: {
      name: string | null;
      email: string | null;
      title: string | null;
      conversationId: string;
      createdAt: string;
      role: string;
      content: string;
      intent: string | null;
    }[] = [];

    for (let i = 0; i < ids.length; i += 40) {
      const batch = ids.slice(i, i + 40);
      for (let offset = 0; ; offset += 1000) {
        const { data: messages } = await supabase
          .from("messages")
          .select("conversation_id, role, content, created_at, detected_intent")
          .in("conversation_id", batch)
          .order("created_at", { ascending: true })
          .order("id", { ascending: true })
          .range(offset, offset + 999);
        const page = messages ?? [];
        for (const m of page) {
          const conv = byConversation.get(m.conversation_id);
          rows.push({
            name: conv?.name ?? null,
            email: conv?.email ?? null,
            title: conv?.title ?? null,
            conversationId: m.conversation_id,
            createdAt: m.created_at,
            role: m.role,
            content: m.content,
            intent: m.detected_intent ?? null,
          });
        }
        if (page.length < 1000) break;
      }
    }

    // Conversas na ordem da lista (recente → antiga); mensagens em ordem cronológica.
    rows.sort((a, b) =>
      a.conversationId === b.conversationId
        ? a.createdAt.localeCompare(b.createdAt)
        : (order.get(a.conversationId) ?? 0) - (order.get(b.conversationId) ?? 0),
    );
    const withMessages = new Set(rows.map((r) => r.conversationId)).size;

    await audit(context, "export_conversations", {
      targetUserId: data.userId ?? null,
      metadata: {
        conversationId: data.conversationId ?? null,
        term: data.term ?? null,
        from: data.from ?? null,
        to: data.to ?? null,
        byPeople: Boolean(data.byPeople),
        conversations: withMessages,
        messages: rows.length,
      },
    });

    return { rows, conversations: withMessages };
  });

/** Apaga uma conversa e suas mensagens (só admin). Não mexe no aluno nem no acesso. */
export const deleteConversation = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ conversationId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const id = data.conversationId;
    const { data: conv } = await supabaseAdmin
      .from("conversations")
      .select("id, user_id")
      .eq("id", id)
      .maybeSingle();
    if (!conv) throw new Error("Conversa não encontrada.");
    const { data: profile } = await supabaseAdmin
      .from("profiles")
      .select("email")
      .eq("id", conv.user_id)
      .maybeSingle();
    const { count } = await supabaseAdmin
      .from("messages")
      .select("id", { count: "exact", head: true })
      .eq("conversation_id", id);
    await supabaseAdmin
      .from("risk_alerts")
      .update({ conversation_id: null })
      .eq("conversation_id", id);
    await supabaseAdmin
      .from("material_requests")
      .update({ conversation_id: null })
      .eq("conversation_id", id);
    await supabaseAdmin
      .from("student_memory_facts")
      .update({ source_conversation_id: null })
      .eq("source_conversation_id", id);
    const m = await supabaseAdmin.from("messages").delete().eq("conversation_id", id);
    if (m.error) throw new Error("Não consegui apagar as mensagens.");
    const c = await supabaseAdmin.from("conversations").delete().eq("id", id);
    if (c.error) throw new Error("Não consegui apagar a conversa.");
    await audit(context, "conversation_deleted", {
      targetUserId: conv.user_id,
      targetEmail: profile?.email ?? null,
      metadata: { conversationId: id, messages: count ?? 0 },
    });
    return { ok: true };
  });
