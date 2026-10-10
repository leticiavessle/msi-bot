import { fetchAll } from "./paging";
import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { assertAdmin, audit } from "./admin-guard";
import { PRODUCTS } from "./config";

const subscriptionSchema = z.object({
  endpoint: z.string().url().max(600),
  p256dh: z.string().min(10).max(300),
  auth: z.string().min(4).max(300),
  device: z.string().max(200).optional(),
});

/** Salva (ou reativa) a inscrição de notificação do aluno logado. */
export const savePushSubscription = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => subscriptionSchema.parse(data))
  .handler(async ({ data, context }) => {
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    await supabaseAdmin.from("push_subscriptions").upsert(
      {
        user_id: context.userId,
        endpoint: data.endpoint,
        p256dh: data.p256dh,
        auth: data.auth,
        device: data.device ?? null,
        active: true,
      },
      { onConflict: "endpoint" },
    );
    return { ok: true };
  });

/** Desativa uma inscrição (aluno desligou as notificações neste aparelho). */
export const disablePushSubscription = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ endpoint: z.string().max(600) }).parse(data))
  .handler(async ({ data, context }) => {
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    await supabaseAdmin
      .from("push_subscriptions")
      .update({ active: false })
      .eq("endpoint", data.endpoint)
      .eq("user_id", context.userId);
    return { ok: true };
  });

const audienceSchema = z.object({
  audience: z.enum(["all", "product", "email"]).default("all"),
  product: z.enum(PRODUCTS).optional(),
  email: z.string().trim().toLowerCase().max(255).optional(),
});

/* eslint-disable-next-line @typescript-eslint/no-explicit-any */
type AnyAdmin = any;

async function resolveTargets(
  admin: AnyAdmin,
  data: z.infer<typeof audienceSchema>,
): Promise<{ id: string; endpoint: string; p256dh: string; auth: string }[]> {
  let userIds: string[] | null = null;

  if (data.audience === "product" && data.product) {
    const rows = await fetchAll<{ user_id: string }>((a, b) =>
      admin.from("user_products").select("user_id").eq("product", data.product).eq("active", true).order("id").range(a, b),
    );
    userIds = rows.map((r) => r.user_id);
  }

  if (data.audience === "email" && data.email) {
    const { data: rows } = await admin
      .from("profiles")
      .select("id")
      .ilike("email", data.email)
      .limit(5);
    userIds = (rows ?? []).map((r: { id: string }) => r.id);
  }

  if (userIds && userIds.length === 0) return [];
  const subs = await fetchAll<{ id: string; user_id: string; endpoint: string; p256dh: string; auth: string }>((a, b) =>
    admin.from("push_subscriptions").select("id, user_id, endpoint, p256dh, auth").eq("active", true).order("id").range(a, b),
  );
  const allow = userIds ? new Set(userIds) : null;
  return subs
    .filter((s) => !allow || allow.has(s.user_id))
    .map(({ id, endpoint, p256dh, auth }) => ({ id, endpoint, p256dh, auth }));
}

/** Quantos aparelhos receberiam o envio com o público escolhido. */
export const countPushTargets = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => audienceSchema.parse(data ?? {}))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const rows = await resolveTargets(supabaseAdmin, data);
    return { devices: rows.length };
  });

const sendSchema = audienceSchema.extend({
  title: z.string().trim().min(2).max(80),
  body: z.string().trim().min(2).max(300),
  url: z.string().trim().max(500).optional(),
});

/** Envia a notificação para o público escolhido e guarda o histórico. */
export const sendPushBroadcast = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => sendSchema.parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { sendPushToRows } = await import("./push.server");

    const rows = await resolveTargets(supabaseAdmin, data);
    const result = await sendPushToRows(supabaseAdmin, rows, {
      title: data.title,
      body: data.body,
      url: data.url && data.url.length > 0 ? data.url : "/chat",
      tag: "msi-broadcast",
    });

    await supabaseAdmin.from("push_broadcasts").insert({
      created_by: context.userId,
      title: data.title,
      body: data.body,
      url: data.url ?? null,
      audience: data.audience,
      audience_value: data.audience === "product" ? (data.product ?? null) : (data.email ?? null),
      devices_targeted: rows.length,
      devices_sent: result.sent,
      devices_failed: result.failed,
    });

    await audit(context, "push_broadcast", {
      metadata: { audience: data.audience, ...result, targeted: rows.length },
    });

    return { targeted: rows.length, ...result };
  });

/** Histórico dos últimos envios. */
export const listPushBroadcasts = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data } = await context.supabase
      .from("push_broadcasts")
      .select(
        "id, title, body, url, audience, audience_value, devices_targeted, devices_sent, devices_failed, created_at",
      )
      .order("created_at", { ascending: false })
      .limit(50);
    return { rows: data ?? [] };
  });
