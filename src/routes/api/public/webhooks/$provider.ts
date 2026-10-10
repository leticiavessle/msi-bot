import { createFileRoute } from "@tanstack/react-router";
import {
  ADAPTERS,
  parseFormBody,
  processWebhookEvent,
  verifySignature,
  verifyToken,
} from "@/lib/dr/webhooks.server";

export const Route = createFileRoute("/api/public/webhooks/$provider")({
  server: {
    handlers: {
      POST: async ({ request, params }) => {
        const adapter = ADAPTERS[params.provider];
        if (!adapter) return new Response("Unknown provider", { status: 404 });

        const rawBody = await request.text();
        if (rawBody.length > 200_000) return new Response("Payload too large", { status: 413 });

        // Assinatura é OBRIGATÓRIA. Sem segredo configurado, o provedor fica desativado
        // (nunca aceitamos evento não assinado em produção).
        const secret = adapter.secretEnv ? process.env[adapter.secretEnv] : undefined;
        if (!secret) {
          return new Response("Provider not configured", { status: 503 });
        }
        // Hubla envia um token fixo no header; outros provedores usam HMAC do corpo.
        const queryToken = adapter.tokenQueryParam
          ? new URL(request.url).searchParams.get(adapter.tokenQueryParam)
          : null;
        const token = adapter.tokenHeader ? request.headers.get(adapter.tokenHeader) : null;
        const signature = request.headers.get(adapter.signatureHeader ?? "x-webhook-signature");
        const authorized = adapter.tokenQueryParam
          ? verifyToken(secret, queryToken)
          : token
            ? verifyToken(secret, token)
            : verifySignature(secret, rawBody, signature);
        if (!authorized) {
          return new Response("Invalid signature", { status: 401 });
        }

        let payload: Record<string, unknown>;
        try {
          payload = JSON.parse(rawBody) as Record<string, unknown>;
        } catch {
          // Payt (postback V1) pode mandar form-urlencoded.
          const isForm = (request.headers.get("content-type") ?? "").includes("form");
          if (!isForm && !rawBody.includes("=")) {
            return new Response("Invalid JSON", { status: 400 });
          }
          payload = parseFormBody(rawBody);
        }

        const normalized = adapter.parse(payload);
        const { supabaseAdmin } = await import("@/integrations/supabase/client.server");

        // Idempotência: o índice único (provider, external_event_id) bloqueia repetições.
        const insert = await supabaseAdmin
          .from("webhook_events")
          .insert({
            provider: adapter.provider,
            event_type: normalized?.eventType ?? "unknown",
            external_event_id: normalized?.externalEventId ?? null,
            payload: payload as never,
          })
          .select("id")
          .single();

        if (insert.error) {
          if (insert.error.code === "23505") {
            return Response.json({ ok: true, duplicated: true });
          }
          console.error("[webhook] insert failed", insert.error.message);
          return new Response("Storage error", { status: 500 });
        }

        try {
          const result = await processWebhookEvent(
            supabaseAdmin,
            adapter.provider,
            payload,
            insert.data.id,
          );
          return Response.json({ ok: true, processed: result.ok, reason: result.reason ?? null });
        } catch (error) {
          console.error("[webhook] processing failed", error);
          await supabaseAdmin
            .from("webhook_events")
            .update({
              processing_error: error instanceof Error ? error.message.slice(0, 300) : "erro",
              processed_at: new Date().toISOString(),
            })
            .eq("id", insert.data.id);
          return new Response("Processing error", { status: 500 });
        }
      },
    },
  },
});
