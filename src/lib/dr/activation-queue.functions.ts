import { fetchAll } from "./paging";
import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { ATIVACAO_ALERTA_PREFIXO, acceptLabels, isDeadlineFollowUp, isHedgedAccept } from "./refund-protocol";
import { WHATSAPP_7D_URL_PART } from "../../oferta/links";

async function assertAdmin(context: { supabase: any; userId: string }) {
  const { data, error } = await context.supabase.rpc("has_role", {
    _user_id: context.userId,
    _role: "admin",
  });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

const ACTIVATION_PREFIX = ATIVACAO_ALERTA_PREFIXO;

/** Rótulos literais dos botões de aceite do 7D (tirados das rotas em src/oferta/protocolo-7d.ts). Só o clique exato conta. */
const ACCEPT_LABELS = acceptLabels();
const norm = (t: string) => t.normalize("NFC").replace(/\s+/g, " ").trim().toLowerCase();
const ACCEPT_SET = new Set(ACCEPT_LABELS.map(norm));
export function isAcceptClick(text: string | null | undefined) {
  return Boolean(text && ACCEPT_SET.has(norm(text)));
}

type ActivationAlert = {
  id: string;
  user_id: string;
  conversation_id: string | null;
  reason: string | null;
  created_at: string;
  accept_origin: string | null;
  accept_text: string | null;
  accept_node: string | null;
  accept_reclassified: boolean;
  from_retention: boolean;
  whatsapp_sent_at: string | null;
};

/** Separa alertas de Ativação em "com clique de aceite" e "sem clique" (olhando a mensagem que gerou o alerta). */
async function splitActivation(supabase: any) {
  const alerts = await fetchAll<ActivationAlert>((a, b) =>
    supabase
      .from("risk_alerts")
      .select("id, user_id, conversation_id, reason, created_at, accept_origin, accept_text, accept_node, accept_reclassified, from_retention, whatsapp_sent_at")
      .eq("status", "pending")
      .like("reason", `${ACTIVATION_PREFIX}%`)
      .order("created_at", { ascending: true })
      .range(a, b),
  );
  const rows = (alerts ?? []) as ActivationAlert[];
  const checked = await Promise.all(
    rows.map(async (r) => {
      // Aceite registrado com origem (botão ou digitado em contexto de proposta) já conta.
      if (r.accept_origin || r.from_retention) return { r, clicked: true, trigger: r.accept_text };
      if (!r.conversation_id) return { r, clicked: false, trigger: null as string | null };
      const until = new Date(new Date(r.created_at).getTime() + 5000).toISOString();
      const { data: m } = await supabase
        .from("messages")
        .select("content")
        .eq("conversation_id", r.conversation_id)
        .eq("role", "user")
        .lte("created_at", until)
        .order("created_at", { ascending: false })
        .limit(1)
        .maybeSingle();
      const trigger = (m?.content as string | undefined) ?? null;
      return { r, clicked: isAcceptClick(trigger), trigger };
    }),
  );
  return checked;
}

async function profilesFor(supabase: any, ids: string[]) {
  const out = new Map<string, { name: string | null; email: string | null }>();
  for (let i = 0; i < ids.length; i += 300) {
    const { data } = await supabase.from("profiles").select("id, name, email").in("id", ids.slice(i, i + 300));
    for (const p of data ?? []) out.set(p.id, { name: p.name, email: p.email });
  }
  return out;
}

/** Aba "Aceitaram": SOMENTE quem clicou no botão de aceite e ainda não foi atendido. */
export const listActivationQueue = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const checked = (await splitActivation(context.supabase)).filter((c) => c.clicked);
    const userIds = [...new Set(checked.map((c) => c.r.user_id))];
    const byId = await profilesFor(context.supabase, userIds);
    // Clique no cartão do WhatsApp (mesmo registro dos links de aula).
    const clicks = new Map<string, string>();
    for (let i = 0; i < userIds.length; i += 300) {
      const rows = await fetchAll<any>((a, b) =>
        context.supabase.from("usage_events").select("user_id, created_at, metadata")
          .eq("event_name", "link_clicked").in("user_id", userIds.slice(i, i + 300))
          .like("metadata->>url", `%${WHATSAPP_7D_URL_PART}%`).order("created_at", { ascending: true }).range(a, b));
      for (const e of rows ?? []) if (!clicks.has(e.user_id)) clicks.set(e.user_id, e.created_at);
    }
    return checked.map(({ r }) => {
      const p = byId.get(r.user_id);
      const route = r.reason?.match(/rota\s+([^\s·]+)/i)?.[1] ?? "?";
      const products = r.reason?.match(/produtos:\s*(.+)$/i)?.[1]?.trim() ?? "-";
      return {
        id: r.id,
        conversationId: r.conversation_id,
        name: p?.name ?? null,
        email: p?.email ?? null,
        product: products,
        route,
        acceptedAt: r.created_at,
        origin: (r.accept_origin as "botão" | "digitado" | null) ?? "botão",
        acceptText: r.accept_text ?? null,
        node: r.accept_node ?? null,
        reclassified: r.accept_reclassified,
        fromRetention: r.from_retention,
        whatsappSentAt: r.whatsapp_sent_at,
        whatsappClickedAt: r.whatsapp_sent_at && (clicks.get(r.user_id) ?? "") >= r.whatsapp_sent_at.slice(0, 19)
          ? clicks.get(r.user_id)!
          : null,
      };
    });
  });

const FRUSTRATION =
  /n[ãa]o respondeu|pode responder o que (eu )?perguntei|voc[êe] [ée] (um )?rob[ôo]|j[áa] falei (isso)?|n[ãa]o (me )?entendeu|responde (a|o que) (minha pergunta|perguntei)|que (bot|rob[ôo]) (burro|ruim)/i;
const MAYBE_LATER = /deixa eu ver|depois eu te falo|vou pensar|vou ver depois/i;
const OPEN_STAGES = new Set(["aguardando_motivo", "aguardando_resposta_rota", "aguardando_resposta_pergunta", "ativacao_proposta", "waiting_reactivation"]);

/** Aba "Possíveis retenções": sinais sem aceite, com o motivo de cada linha (últimos 14 dias). */
export const listPossibleRetentions = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const sb = context.supabase;
    const since = new Date(Date.now() - 14 * 24 * 3600 * 1000).toISOString();
    type Entry = { conversationId: string; userId: string; reasons: Set<string>; lastAt: string; sample: string | null };
    const map = new Map<string, Entry>();
    const add = (conversationId: string | null, userId: string, reason: string, at: string, sample: string | null) => {
      if (!conversationId) return;
      const e = map.get(conversationId) ?? { conversationId, userId, reasons: new Set<string>(), lastAt: at, sample: null };
      e.reasons.add(reason);
      if (at >= e.lastAt) {
        e.lastAt = at;
        if (sample) e.sample = sample;
      } else if (!e.sample && sample) e.sample = sample;
      map.set(conversationId, e);
    };

    const split = await splitActivation(sb);
    const acceptedUsers = new Set(split.filter((c) => c.clicked).map((c) => c.r.user_id));
    for (const c of split.filter((c) => !c.clicked)) {
      add(c.r.conversation_id, c.r.user_id, "Estava na fila da Ativação sem clique de aceite registrado", c.r.created_at, c.trigger);
    }

    const [userMsgs, unknownAnswers, flowMsgs] = await Promise.all([
      fetchAll<any>((a, b) => sb.from("messages").select("conversation_id, user_id, content, created_at").eq("role", "user")
        .gte("created_at", since).order("created_at", { ascending: false }).range(a, b)),
      fetchAll<any>((a, b) => sb.from("messages").select("conversation_id, user_id, created_at").eq("role", "assistant")
        .gte("created_at", since).or("content.ilike.%não é ensinad%,content.ilike.%nao e ensinad%,content.ilike.%não é abordad%")
        .order("created_at", { ascending: false }).range(a, b)),
      fetchAll<any>((a, b) => sb.from("messages").select("conversation_id, user_id, created_at, metadata").eq("role", "assistant")
        .gte("created_at", since).not("metadata->refund_state", "is", null)
        .order("created_at", { ascending: false }).range(a, b)),
    ]);

    const flowConvs = new Set((flowMsgs ?? []).map((m: any) => m.conversation_id));
    const lastUserAt = new Map<string, string>();
    for (const m of userMsgs ?? []) {
      if ((lastUserAt.get(m.conversation_id) ?? "") < m.created_at) lastUserAt.set(m.conversation_id, m.created_at);
    }
    for (const m of userMsgs ?? []) {
      if (isDeadlineFollowUp(m.content)) add(m.conversation_id, m.user_id, "cobrança de prazo", m.created_at, m.content);
      if (isAcceptClick(m.content)) continue;
      if (flowConvs.has(m.conversation_id) && isHedgedAccept(m.content)) {
        add(m.conversation_id, m.user_id, "Respondeu a proposta com ressalva (não conta como aceite)", m.created_at, m.content);
      }
      if (MAYBE_LATER.test(m.content)) add(m.conversation_id, m.user_id, "Recebeu a proposta e respondeu \"deixa eu ver\"", m.created_at, m.content);
      if (FRUSTRATION.test(m.content)) add(m.conversation_id, m.user_id, "Demonstrou frustração com o bot", m.created_at, m.content);
    }
    for (const m of unknownAnswers ?? []) {
      add(m.conversation_id, m.user_id, "Fez uma pergunta que o bot não soube responder", m.created_at, null);
    }
    const seenConv = new Set<string>();
    for (const m of flowMsgs ?? []) {
      if (seenConv.has(m.conversation_id)) continue;
      seenConv.add(m.conversation_id);
      const st = (m.metadata as any)?.refund_state;
      if (st && st.active && OPEN_STAGES.has(st.stage) && !st.endpoint) {
        add(m.conversation_id, m.user_id, `Entrou no 7D (rota ${st.route ?? "?"}) e não decidiu`, m.created_at, null);
      }
    }

    const actions = await latestActions(sb);
    const returned = new Set<string>();
    const list = [...map.values()].filter((e) => {
      const act = actions.get(e.conversationId);
      if (act) {
        if ((lastUserAt.get(e.conversationId) ?? "") <= act.acted_at) return false;
        returned.add(e.conversationId);
      }
      return !acceptedUsers.has(e.userId);
    });
    const byId = await profilesFor(sb, [...new Set(list.map((e) => e.userId))]);
    return list
      .sort((a, b) => b.lastAt.localeCompare(a.lastAt))
      .map((e) => ({
        conversationId: e.conversationId,
        userId: e.userId,
        name: byId.get(e.userId)?.name ?? null,
        email: byId.get(e.userId)?.email ?? null,
        reasons: [...e.reasons],
        lastAt: e.lastAt,
        sample: e.sample?.slice(0, 300) ?? null,
        returned: returned.has(e.conversationId),
      }));
  });

type RetentionAction = {
  id: string; conversation_id: string; user_id: string; action: string; reason: string | null;
  reason_text: string | null; destination: string | null; reasons_snapshot: string[]; acted_by: string; acted_at: string;
};

/** Última ação (não desfeita) por conversa. */
async function latestActions(sb: any) {
  const out = new Map<string, RetentionAction>();
  for (let from = 0; ; from += 1000) {
    const { data, error } = await sb.from("retention_actions").select("*").is("undone_at", null)
      .order("acted_at", { ascending: false }).range(from, from + 999);
    if (error) throw new Error(error.message);
    for (const a of data ?? []) if (!out.has(a.conversation_id)) out.set(a.conversation_id, a);
    if (!data || data.length < 1000) break;
  }
  return out;
}

export const RETENTION_REASONS = {
  resolvida_chat: "Resolvida no chat",
  retida: "Retida",
  nao_era_retencao: "Não era retenção",
  sem_resposta: "Sem resposta da aluna",
  outro: "Outro",
} as const;

/** Aba "Fechados": fechamentos vigentes (a aluna não voltou a escrever depois). */
export const listClosedRetentions = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const sb = context.supabase;
    const actions = [...(await latestActions(sb)).values()].filter((a) => a.action === "fechado");
    const out = [];
    const byId = await profilesFor(sb, [...new Set(actions.flatMap((a) => [a.user_id, a.acted_by]))]);
    for (const a of actions) {
      const { data: later } = await sb.from("messages").select("id").eq("conversation_id", a.conversation_id)
        .eq("role", "user").gt("created_at", a.acted_at).limit(1);
      if (later && later.length) continue; // voltou a escrever → está na lista aberta
      const who = byId.get(a.acted_by);
      out.push({
        actionId: a.id,
        conversationId: a.conversation_id,
        userId: a.user_id,
        name: byId.get(a.user_id)?.name ?? null,
        email: byId.get(a.user_id)?.email ?? null,
        reason: a.reason as keyof typeof RETENTION_REASONS | null,
        reasonText: a.reason_text,
        reasons: a.reasons_snapshot,
        closedAt: a.acted_at,
        closedBy: who?.name ?? who?.email ?? null,
      });
    }
    return out;
  });

const actionBase = z.object({
  conversationId: z.string().uuid(),
  userId: z.string().uuid(),
  reasons: z.array(z.string().max(200)).max(20).default([]),
});

export const closeRetention = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) =>
    actionBase.extend({
      reason: z.enum(["resolvida_chat", "retida", "nao_era_retencao", "sem_resposta", "outro"]),
      reasonText: z.string().trim().max(300).optional(),
    }).refine((v) => v.reason !== "outro" || (v.reasonText ?? "").length > 0, "Escreva o motivo.").parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { error } = await supabaseAdmin.from("retention_actions").insert({
      conversation_id: data.conversationId, user_id: data.userId, action: "fechado",
      reason: data.reason, reason_text: data.reasonText || null, reasons_snapshot: data.reasons, acted_by: context.userId,
    });
    if (error) throw new Error("Não consegui fechar.");
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId, action: "retencao_fechada", target_user_id: data.userId,
      metadata: { conversation_id: data.conversationId, reason: data.reason, reason_text: data.reasonText ?? null },
    });
    return { ok: true };
  });

export const undoRetentionClose = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ actionId: z.string().uuid() }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { data: row, error } = await supabaseAdmin.from("retention_actions")
      .update({ undone_at: new Date().toISOString(), undone_by: context.userId })
      .eq("id", data.actionId).eq("action", "fechado").is("undone_at", null)
      .select("user_id, conversation_id").maybeSingle();
    if (error || !row) throw new Error("Nada para desfazer.");
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId, action: "retencao_fechamento_desfeito", target_user_id: row.user_id,
      metadata: { conversation_id: row.conversation_id, action_id: data.actionId },
    });
    return { ok: true };
  });

/** Encaminha para Aceitaram, Acessos ou Atendimento humano. Nada é apagado e nada é enviado à aluna. */
export const redirectRetention = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => actionBase.extend({ destination: z.enum(["ativacao", "acessos", "humano"]) }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const mark = "Redirecionado de Possíveis retenções";
    if (data.destination === "ativacao") {
      const { data: prods } = await supabaseAdmin.from("user_products").select("product")
        .eq("user_id", data.userId).eq("active", true);
      const { error } = await supabaseAdmin.from("risk_alerts").insert({
        user_id: data.userId, conversation_id: data.conversationId, risk_level: "medium", status: "pending",
        reason: `${ACTIVATION_PREFIX} — rota ? · produtos: ${(prods ?? []).map((p) => p.product).join(", ") || "-"}`,
        trigger_text: mark, from_retention: true,
      });
      if (error) throw new Error("Não consegui encaminhar para a Ativação.");
    } else if (data.destination === "acessos") {
      const { error } = await supabaseAdmin.from("access_alerts").insert({
        user_id: data.userId, conversation_id: data.conversationId, trigger_text: mark,
        status: "pending", reopened: false, from_retention: true,
      });
      if (error) throw new Error("Não consegui encaminhar para Acessos.");
    } else {
      const { data: me } = await supabaseAdmin.from("profiles").select("name, email").eq("id", context.userId).maybeSingle();
      const { error } = await supabaseAdmin.from("conversations").update({
        human_takeover_by: context.userId,
        human_takeover_name: me?.name ?? me?.email ?? "Equipe",
        human_takeover_at: new Date().toISOString(),
      }).eq("id", data.conversationId);
      if (error) throw new Error("Não consegui passar para atendimento humano.");
    }
    const { error } = await supabaseAdmin.from("retention_actions").insert({
      conversation_id: data.conversationId, user_id: data.userId, action: "redirecionado",
      destination: data.destination, reasons_snapshot: data.reasons, acted_by: context.userId,
    });
    if (error) throw new Error("Encaminhado, mas não consegui registrar a ação.");
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId, action: "retencao_redirecionada", target_user_id: data.userId,
      metadata: { conversation_id: data.conversationId, destination: data.destination },
    });
    return { ok: true };
  });

export const markActivationAttended = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ alertId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    const { data: row, error } = await supabaseAdmin
      .from("risk_alerts")
      .update({ status: "resolved", reviewed_by: context.userId, resolved_at: now })
      .eq("id", data.alertId)
      .like("reason", `${ACTIVATION_PREFIX}%`)
      .select("id, user_id")
      .maybeSingle();
    if (error || !row) throw new Error("Não consegui marcar como atendida.");
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: "ativacao_atendida",
      target_user_id: row.user_id,
      metadata: { alert_id: row.id, attended_at: now },
    });
    return { ok: true };
  });
