import { createFileRoute } from "@tanstack/react-router";
import { runClassification } from "@/lib/dr/report-routes.server";

/** Job de hora em hora (pg_cron): classifica conversas com mensagens novas (últimas 48h). */
export const Route = createFileRoute("/api/public/insights/classify")({
  server: {
    handlers: {
      POST: async ({ request }) => {
        const token = /^Bearer\s+(\S+)$/.exec(request.headers.get("authorization") ?? "")?.[1];
        if (!token) return new Response("Unauthorized", { status: 401 });
        const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
        const { data } = await supabaseAdmin.from("job_tokens").select("token").eq("name", "insights_classify").maybeSingle();
        const { createHash, timingSafeEqual } = await import("node:crypto");
        const h = (v: string) => createHash("sha256").update(v).digest();
        if (!data?.token || !timingSafeEqual(h(token), h(data.token))) {
          return new Response("Unauthorized", { status: 401 });
        }
        const now = new Date();
        const result = await runClassification(new Date(now.getTime() - 48 * 3_600_000), now, 40);
        return Response.json(result);
      },
    },
  },
});
