import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";

export const USAGE_EVENTS = [
  "login",
  "chat_opened",
  "message_sent",
  "conversation_started",
  "quick_button_clicked",
  "video_review_started",
  "support_clicked",
  "aula_clicked",
  "link_clicked",
  "session_started",
  "session_ended",
] as const;

export type UsageEvent = (typeof USAGE_EVENTS)[number];

const schema = z.object({
  eventName: z.enum(USAGE_EVENTS),
  sessionId: z.string().uuid().nullable().optional(),
  metadata: z.record(z.string(), z.unknown()).nullable().optional(),
});

/** Registra um evento de uso do próprio aluno (RLS garante o isolamento). */
export const logUsageEvent = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => schema.parse(data))
  .handler(async ({ data, context }) => {
    const { error } = await context.supabase.from("usage_events").insert({
      user_id: context.userId,
      event_name: data.eventName,
      session_id: data.sessionId ?? null,
      metadata: JSON.parse(JSON.stringify(data.metadata ?? {})),
    });
    if (error) return { ok: false };
    return { ok: true };
  });
