import { z } from "zod";
import { AiBlockedError, classifyPending } from "./insights.server";
import { AiNotConfiguredError } from "./ai-provider.server";
import { buildReportData, checkReportToken, sendWhatsappReport } from "./reports.server";

const PAUSE_KEY = "insights_paused";

async function admin() {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  return supabaseAdmin;
}

async function isPaused(db: Awaited<ReturnType<typeof admin>>) {
  const { data } = await db.from("assistant_config").select("value").eq("key", PAUSE_KEY).maybeSingle();
  return Boolean(data?.value && (data.value as Record<string, unknown>)["paused"]);
}

/** Roda a classificação respeitando a pausa por falta de créditos (402/403). */
export async function runClassification(from: Date, to: Date, max: number) {
  const db = await admin();
  if (await isPaused(db)) return { paused: true, classified: 0 };
  try {
    return { paused: false, ...(await classifyPending(db, from, to, max)) };
  } catch (e) {
    // IA ainda não configurada: não classifica e não pausa (volta sozinho quando a chave existir).
    if (e instanceof AiNotConfiguredError) return { paused: true, classified: 0, reason: e.message };
    if (e instanceof AiBlockedError) {
      await db.from("assistant_config").upsert({
        key: PAUSE_KEY,
        value: { paused: true, status: e.status, reason: e.message, at: new Date().toISOString() },
      });
      return { paused: true, classified: 0 };
    }
    throw e;
  }
}

const iso = z.string().min(10).max(40).refine((v) => !Number.isNaN(Date.parse(v)), "data inválida");

export async function handleDados(request: Request) {
  const denied = await checkReportToken(request);
  if (denied) return denied;
  const url = new URL(request.url);
  const parsed = z.object({ inicio: iso, fim: iso }).safeParse({
    inicio: url.searchParams.get("inicio"),
    fim: url.searchParams.get("fim"),
  });
  if (!parsed.success) return Response.json({ error: "inicio e fim são obrigatórios (ISO com fuso)" }, { status: 400 });
  const start = new Date(parsed.data.inicio);
  const end = new Date(parsed.data.fim);
  if (end <= start || end.getTime() - start.getTime() > 3 * 86_400_000) {
    return Response.json({ error: "janela inválida (máx. 3 dias)" }, { status: 400 });
  }
  const classificacao = await runClassification(start, end, 80);
  const data = await buildReportData(await admin(), start, end);
  return Response.json({ ...data, classificacao });
}

const publishSchema = z.object({
  dia: z.string().regex(/^\d{4}-\d{2}-\d{2}$/),
  edicao: z.enum(["08h", "17h"]),
  html: z.string().min(1).max(2_000_000),
  whatsapp: z.object({ params: z.array(z.string().max(1000)).length(8) }).passthrough(),
  dados: z.unknown().optional(),
});

export async function handlePublicar(request: Request) {
  const denied = await checkReportToken(request);
  if (denied) return denied;
  let body: unknown;
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "JSON inválido" }, { status: 400 });
  }
  const parsed = publishSchema.safeParse(body);
  if (!parsed.success) return Response.json({ error: parsed.error.issues[0]?.message ?? "inválido" }, { status: 400 });
  const { dia, edicao, html, whatsapp, dados } = parsed.data;
  const params = whatsapp.params.map((p) => p.replace(/[\r\n\t]+/g, " ").replace(/ {4,}/g, "   ").trim() || "-");

  const db = await admin();
  const saved = await db
    .from("daily_reports")
    .upsert(
      { dia, edicao, html, whatsapp: whatsapp as never, dados: (dados ?? null) as never, whatsapp_status: "pendente", whatsapp_error: null },
      { onConflict: "dia,edicao" },
    )
    .select("id")
    .single();
  if (saved.error) return Response.json({ error: "falha ao salvar" }, { status: 500 });

  const sent = await sendWhatsappReport(params);
  await db
    .from("daily_reports")
    .update({
      whatsapp_status: sent.status,
      whatsapp_error: sent.error,
      whatsapp_sent_at: sent.status === "enviado" ? new Date().toISOString() : null,
    })
    .eq("id", saved.data.id);
  return Response.json({ ok: true, id: saved.data.id, whatsapp: { status: sent.status, erro: sent.error } });
}
