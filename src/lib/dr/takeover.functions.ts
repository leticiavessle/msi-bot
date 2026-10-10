import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { assertAdmin } from "./admin-guard";
import { parseAttachments, type ChatAttachment } from "./attachments";
import { MARCA } from "./config";

const MAX_FILE_BYTES = 10 * 1024 * 1024;

async function staffName(context: { supabase: any; userId: string }) {
  const { data } = await context.supabase
    .from("profiles")
    .select("name, email")
    .eq("id", context.userId)
    .maybeSingle();
  return (data?.name as string | null) || (data?.email as string | null) || "Equipe";
}

/** Conversa aberta no painel: estado do atendimento humano + mensagens com anexos assinados. */
export const getConversationLive = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ conversationId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { data: conv } = await supabaseAdmin
      .from("conversations")
      .select("id, user_id, human_takeover_by, human_takeover_name, human_takeover_at")
      .eq("id", data.conversationId)
      .maybeSingle();
    if (!conv) throw new Error("Conversa não encontrada.");
    type Msg = { id: string; role: string; content: string; created_at: string; metadata: unknown };
    const all: Msg[] = [];
    for (let offset = 0; ; offset += 1000) {
      const { data: page } = await supabaseAdmin
        .from("messages")
        .select("id, role, content, created_at, metadata")
        .eq("conversation_id", data.conversationId)
        .order("created_at", { ascending: true })
        .order("id", { ascending: true })
        .range(offset, offset + 999);
      all.push(...((page ?? []) as Msg[]));
      if ((page ?? []).length < 1000) break;
    }
    const messages = await Promise.all(
      all.map(async (m) => {
        const meta = (m.metadata ?? {}) as Record<string, any>;
        const files = await Promise.all(
          parseAttachments(m.metadata)
            .filter((a): a is Extract<ChatAttachment, { kind: "image" | "file" }> =>
              a.kind === "image" || a.kind === "file",
            )
            .map(async (a) => {
              const { data: s } = await supabaseAdmin.storage
                .from("uploads")
                .createSignedUrl(a.path, 3600);
              return { kind: a.kind, name: a.name, url: s?.signedUrl ?? null };
            }),
        );
        return {
          id: m.id,
          role: m.role,
          content: m.content,
          created_at: m.created_at,
          human: meta["human"] ? { name: String(meta["human"]["name"] ?? "Equipe") } : null,
          files,
        };
      }),
    );
    return {
      takeover: conv.human_takeover_at
        ? { name: conv.human_takeover_name ?? "Equipe", since: conv.human_takeover_at }
        : null,
      messages,
    };
  });

export const takeOverConversation = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ conversationId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const name = await staffName(context);
    const now = new Date().toISOString();
    const { data: conv, error } = await supabaseAdmin
      .from("conversations")
      .update({ human_takeover_by: context.userId, human_takeover_name: name, human_takeover_at: now })
      .eq("id", data.conversationId)
      .select("user_id")
      .maybeSingle();
    if (error || !conv) throw new Error("Não consegui assumir a conversa.");
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: "conversa_assumida",
      target_user_id: conv.user_id,
      metadata: { conversation_id: data.conversationId, by: name, at: now },
    });
    return { ok: true };
  });

export const releaseConversation = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ conversationId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    const { data: before } = await supabaseAdmin
      .from("conversations")
      .select("user_id, human_takeover_name, human_takeover_at")
      .eq("id", data.conversationId)
      .maybeSingle();
    if (!before) throw new Error("Conversa não encontrada.");
    await supabaseAdmin
      .from("conversations")
      .update({ human_takeover_by: null, human_takeover_name: null, human_takeover_at: null })
      .eq("id", data.conversationId);
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: "conversa_devolvida_ao_bot",
      target_user_id: before.user_id,
      metadata: {
        conversation_id: data.conversationId,
        taken_by: before.human_takeover_name,
        taken_at: before.human_takeover_at,
        released_at: now,
        released_by: await staffName(context),
      },
    });
    return { ok: true };
  });

/** Mensagem livre da equipe: nunca passa pelo 7D nem pelas travas de reembolso. */
export const sendStaffMessage = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        conversationId: z.string().uuid(),
        content: z.string().max(8000).default(""),
        file: z
          .object({
            name: z.string().min(1).max(200),
            mimeType: z.string().min(1).max(120),
            base64: z.string().min(1),
          })
          .nullable()
          .optional(),
      })
      .refine((d) => d.content.trim().length > 0 || d.file, "Mensagem vazia.")
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { data: conv } = await supabaseAdmin
      .from("conversations")
      .select("id, user_id, human_takeover_at")
      .eq("id", data.conversationId)
      .maybeSingle();
    if (!conv) throw new Error("Conversa não encontrada.");
    if (!conv.human_takeover_at) throw new Error("Assuma a conversa antes de responder.");
    const name = await staffName(context);

    const attachments: ChatAttachment[] = [];
    if (data.file) {
      const bytes = Buffer.from(data.file.base64, "base64");
      if (bytes.byteLength > MAX_FILE_BYTES) throw new Error("Arquivo maior que 10 MB.");
      const ext = (data.file.name.split(".").pop() ?? "bin").toLowerCase().replace(/[^a-z0-9]/g, "").slice(0, 6) || "bin";
      const path = `${conv.user_id}/equipe/${crypto.randomUUID()}.${ext}`;
      const up = await supabaseAdmin.storage
        .from("uploads")
        .upload(path, bytes, { contentType: data.file.mimeType, upsert: false });
      if (up.error) throw new Error("Não consegui subir o arquivo.");
      const isImage = /^image\/(jpeg|png|webp|gif|heic|heif)$/i.test(data.file.mimeType);
      attachments.push(
        isImage
          ? { kind: "image", path, name: data.file.name, size: bytes.byteLength }
          : { kind: "file", path, name: data.file.name, size: bytes.byteLength },
      );
    }

    const now = new Date().toISOString();
    const { data: msg, error } = await supabaseAdmin
      .from("messages")
      .insert({
        conversation_id: conv.id,
        user_id: conv.user_id,
        role: "assistant",
        content: data.content.trim(),
        created_at: now,
        model: "human",
        metadata: {
          human: { by: context.userId, name },
          ...(attachments.length ? { attachments } : {}),
        },
      })
      .select("id")
      .single();
    if (error || !msg) throw new Error("Não consegui enviar a mensagem.");
    await supabaseAdmin
      .from("conversations")
      .update({ updated_at: now, last_message_at: now })
      .eq("id", conv.id);
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: "mensagem_humana_enviada",
      target_user_id: conv.user_id,
      metadata: {
        conversation_id: conv.id,
        message_id: msg.id,
        by: name,
        content: data.content.trim().slice(0, 4000),
        attachments: attachments.map((a) => ("name" in a ? a.name : "")),
      },
    });
    try {
      const { sendPushToUsers } = await import("./push.server");
      await sendPushToUsers(supabaseAdmin, [conv.user_id], {
        title: MARCA.nomeEquipe,
        body: data.content.trim().slice(0, 120) || "Enviamos um arquivo para você.",
        url: "/chat",
        tag: "atendimento-humano",
      });
    } catch {
      // push é complementar
    }
    return { ok: true };
  });

/** Estado de atendimento humano de uma lista de conversas/pessoas (para as listas do painel). */
export async function takeoverMap(admin: any, filter: { conversationIds?: string[]; userIds?: string[] }) {
  let q = admin
    .from("conversations")
    .select("id, user_id, human_takeover_name, human_takeover_at")
    .not("human_takeover_at", "is", null);
  if (filter.conversationIds) q = q.in("id", filter.conversationIds.length ? filter.conversationIds : ["00000000-0000-0000-0000-000000000000"]);
  if (filter.userIds) q = q.in("user_id", filter.userIds.length ? filter.userIds : ["00000000-0000-0000-0000-000000000000"]);
  const { data } = await q;
  return (data ?? []) as { id: string; user_id: string; human_takeover_name: string | null; human_takeover_at: string }[];
}
