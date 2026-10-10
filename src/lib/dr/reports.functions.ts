import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";

/** Lista de relatórios (sem o html) — RLS restringe a administradoras. */
export const listDailyReports = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    const { data } = await context.supabase
      .from("daily_reports")
      .select("id, dia, edicao, whatsapp_status, whatsapp_error, whatsapp_sent_at, updated_at")
      .order("dia", { ascending: false })
      .order("edicao", { ascending: false })
      .limit(400);
    return data ?? [];
  });

export const getDailyReport = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ id: z.string().uuid() }).parse(d))
  .handler(async ({ data, context }) => {
    const { data: row } = await context.supabase
      .from("daily_reports")
      .select("id, dia, edicao, html, whatsapp_status, whatsapp_error, whatsapp_sent_at, updated_at")
      .eq("id", data.id)
      .maybeSingle();
    return row ?? null;
  });
