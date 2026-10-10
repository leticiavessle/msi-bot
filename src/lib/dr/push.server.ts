import { buildPushPayload } from "@block65/webcrypto-web-push";
import type { SupabaseClient } from "@supabase/supabase-js";
import { EMAIL_SUPORTE } from "../../oferta/links";

/** Chave pública das notificações (par gerado para ESTE app; a privada fica só no servidor). */
export const VAPID_PUBLIC_KEY = import.meta.env["VITE_VAPID_PUBLIC_KEY"] ?? "";

/* eslint-disable-next-line @typescript-eslint/no-explicit-any */
type AnyClient = SupabaseClient<any, any, any>;

export type PushRow = { id: string; endpoint: string; p256dh: string; auth: string };
export type PushMessageInput = { title: string; body: string; url?: string | null; tag?: string };

/** Envia uma notificação para uma inscrição; desativa a inscrição expirada (404/410). */
async function sendOne(admin: AnyClient, row: PushRow, message: PushMessageInput) {
  const privateKey = process.env["VAPID_PRIVATE_KEY"];
  const subject = process.env["VAPID_SUBJECT"] ?? `mailto:${EMAIL_SUPORTE}`;
  if (!privateKey || !VAPID_PUBLIC_KEY) throw new Error("Notificações não configuradas.");

  const subscription = {
    endpoint: row.endpoint,
    expirationTime: null,
    keys: { p256dh: row.p256dh, auth: row.auth },
  };

  const payload = await buildPushPayload(
    {
      data: {
        title: message.title,
        body: message.body,
        url: message.url ?? "/chat",
        tag: message.tag ?? "app",
      },
      options: { ttl: 60 * 60 * 24, urgency: "normal" },
    },
    subscription,
    { subject, publicKey: VAPID_PUBLIC_KEY, privateKey },
  );

  const response = await fetch(row.endpoint, {
    method: payload.method,
    headers: payload.headers,
    body: payload.body as BodyInit,
  });

  if (response.status === 404 || response.status === 410) {
    await admin.from("push_subscriptions").update({ active: false }).eq("id", row.id);
    return false;
  }
  if (!response.ok) return false;
  await admin
    .from("push_subscriptions")
    .update({ last_used_at: new Date().toISOString() })
    .eq("id", row.id);
  return true;
}

/** Envia para uma lista de inscrições e devolve o resultado agregado. */
export async function sendPushToRows(
  admin: AnyClient,
  rows: PushRow[],
  message: PushMessageInput,
): Promise<{ sent: number; failed: number }> {
  let sent = 0;
  let failed = 0;
  for (const row of rows) {
    try {
      const ok = await sendOne(admin, row, message);
      if (ok) sent += 1;
      else failed += 1;
    } catch {
      failed += 1;
    }
  }
  return { sent, failed };
}

/** Inscrições ativas dos usuários informados. */
export async function activeSubscriptions(admin: AnyClient, userIds: string[]) {
  if (userIds.length === 0) return [] as PushRow[];
  const { data } = await admin
    .from("push_subscriptions")
    .select("id, endpoint, p256dh, auth")
    .eq("active", true)
    .in("user_id", userIds);
  return (data ?? []) as PushRow[];
}

/** Envia para uma lista de usuários (ignora quem não tem notificação ativa). */
export async function sendPushToUsers(
  admin: AnyClient,
  userIds: string[],
  message: PushMessageInput,
) {
  const rows = await activeSubscriptions(admin, userIds);
  return sendPushToRows(admin, rows, message);
}

/** Ids dos administradores. */
export async function adminUserIds(admin: AnyClient) {
  const { data } = await admin.from("user_roles").select("user_id").eq("role", "admin");
  return (data ?? []).map((r: { user_id: string }) => r.user_id);
}
