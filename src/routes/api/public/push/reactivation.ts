import { createFileRoute } from "@tanstack/react-router";
import { D3_REATIVACAO, fillName, firstName } from "@/lib/dr/refund-protocol";
import { IDENTITY } from "@/lib/dr/config";

/**
 * Reativação da Rota D3: uma hora depois do "deixa eu ver", quem tiver notificação
 * ativa recebe o mesmo texto por push — uma única vez. Quem não tiver continua
 * vendo a mensagem ao voltar ao chat.
 */
export const Route = createFileRoute("/api/public/push/reactivation")({
  server: {
    handlers: {
      POST: async ({ request }) => {
        // Senha da tarefa: "Authorization: Bearer <token>" igual ao de job_tokens (push_reactivation).
        // (Compatível com o MGA: também aceita ?token= igual a PUSH_CRON_TOKEN, se essa variável existir.)
        const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
        const bearer = /^Bearer\s+(\S+)$/.exec(request.headers.get("authorization") ?? "")?.[1] ?? null;
        const legacy = process.env["PUSH_CRON_TOKEN"];
        const queryToken = new URL(request.url).searchParams.get("token");
        const { data: job } = await supabaseAdmin.from("job_tokens").select("token").eq("name", "push_reactivation").maybeSingle();
        const { createHash, timingSafeEqual } = await import("node:crypto");
        const h = (v: string) => createHash("sha256").update(v).digest();
        const okBearer = Boolean(bearer && job?.token && timingSafeEqual(h(bearer), h(job.token)));
        const okLegacy = Boolean(legacy && queryToken && timingSafeEqual(h(queryToken), h(legacy)));
        if (!okBearer && !okLegacy) return new Response("Unauthorized", { status: 401 });
        const { sendPushToUsers } = await import("@/lib/dr/push.server");

        const since = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString();
        const { data: rows } = await supabaseAdmin
          .from("messages")
          .select("id, user_id, conversation_id, metadata, created_at")
          .eq("role", "assistant")
          .gte("created_at", since)
          .order("created_at", { ascending: false })
          .limit(500);

        let pushed = 0;
        const seen = new Set<string>();

        for (const row of rows ?? []) {
          if (seen.has(row.conversation_id)) continue;
          seen.add(row.conversation_id);

          const metadata = (row.metadata ?? {}) as Record<string, unknown>;
          const state = metadata["refund_state"] as Record<string, unknown> | undefined;
          if (!state || state["stage"] !== "waiting_reactivation") continue;
          if (state["reactivationShown"] === true || state["reactivationPushed"] === true) continue;

          const waitingSince = state["waitingSince"];
          if (typeof waitingSince !== "string") continue;
          if (Date.now() - new Date(waitingSince).getTime() < 60 * 60 * 1000) continue;

          const profile = await supabaseAdmin
            .from("profiles")
            .select("name")
            .eq("id", row.user_id)
            .maybeSingle();

          const text = fillName(D3_REATIVACAO, firstName(profile.data?.name ?? null));
          const result = await sendPushToUsers(supabaseAdmin, [row.user_id], {
            title: IDENTITY.name,
            body: text.replace(/\s+/g, " ").slice(0, 220),
            url: "/chat",
            tag: "reativacao-7d",
          });
          if (result.sent === 0) continue;

          await supabaseAdmin
            .from("messages")
            .update({
              metadata: {
                ...metadata,
                refund_state: { ...state, reactivationPushed: true, reactivationShown: true },
              },
            })
            .eq("id", row.id);
          pushed += 1;
        }

        return Response.json({ ok: true, pushed });
      },
    },
  },
});
