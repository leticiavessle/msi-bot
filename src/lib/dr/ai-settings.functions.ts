import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { assertAdmin, audit } from "./admin-guard";

const Provider = z.enum(["openai", "gemini"]);

async function db() {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  return supabaseAdmin;
}

async function who(context: { supabase: any; userId: string }) {
  const { data } = await context.supabase.from("profiles").select("name, email").eq("id", context.userId).maybeSingle();
  return (data?.name as string | null) || (data?.email as string | null) || "Equipe";
}

function mask(provider: "openai" | "gemini", hint: string | null) {
  if (!hint) return null;
  return `${provider === "openai" ? "sk-" : "AIza"}...${hint}`;
}

type AiRow = { provider: string | null; model_chat: string | null; model_tasks: string | null; temperature: number | null; openai_key_hint: string | null; gemini_key_hint: string | null; active: boolean; last_test_at: string | null; last_test_error: string | null; updated_by_name: string | null; updated_at: string | null; openai_api_key: string | null; gemini_api_key: string | null };
async function readRow() {
  const { data } = await (await db()).from("ai_settings").select("*").eq("id", true).maybeSingle();
  return data as AiRow | null;
}

/** Status para a tela. Nunca devolve a chave, só a máscara. */
export const getAiSettings = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const r = await readRow();
    const active = Boolean(r?.active && r?.provider);
    return {
      inUse: active ? (r!.provider as "openai" | "gemini") : ("env" as const),
      provider: (r?.provider as "openai" | "gemini" | null) ?? null,
      modelChat: (r?.model_chat as string | null) ?? null,
      modelTasks: (r?.model_tasks as string | null) ?? null,
      temperature: r?.temperature === null || r?.temperature === undefined ? null : Number(r.temperature),
      openaiMasked: mask("openai", r?.openai_key_hint ?? null),
      geminiMasked: mask("gemini", r?.gemini_key_hint ?? null),
      active,
      lastTestAt: (r?.last_test_at as string | null) ?? null,
      lastTestError: (r?.last_test_error as string | null) ?? null,
      updatedByName: (r?.updated_by_name as string | null) ?? null,
      updatedAt: (r?.updated_at as string | null) ?? null,
    };
  });

/** Provedor/modelos/temperatura. Mudar provedor ou modelo desarma até novo teste. */
export const saveAiConfig = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) =>
    z
      .object({
        provider: Provider,
        modelChat: z.string().trim().max(120).nullable(),
        modelTasks: z.string().trim().max(120).nullable(),
        temperature: z.number().min(0).max(2).nullable(),
      })
      .parse(d),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const r = await readRow();
    const changed = r?.provider !== data.provider || r?.model_chat !== (data.modelChat || null) || r?.model_tasks !== (data.modelTasks || null);
    await (await db())
      .from("ai_settings")
      .update({
        provider: data.provider,
        model_chat: data.modelChat || null,
        model_tasks: data.modelTasks || null,
        temperature: data.temperature,
        ...(changed ? { active: false } : {}),
        updated_by: context.userId,
        updated_by_name: await who(context),
        updated_at: new Date().toISOString(),
      })
      .eq("id", true);
    await audit(context, "ai_settings_config", { metadata: { provider: data.provider, modelChat: data.modelChat, modelTasks: data.modelTasks } });
    return { ok: true, deactivated: changed && Boolean(r?.active) };
  });

export const saveAiKey = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ provider: Provider, key: z.string().trim().min(10).max(500) }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { encryptSecret } = await import("./ai-provider.server");
    const enc = await encryptSecret(data.key);
    const r = await readRow();
    await (await db())
      .from("ai_settings")
      .update({
        [`${data.provider}_api_key`]: enc,
        [`${data.provider}_key_hint`]: data.key.slice(-4),
        ...(r?.provider === data.provider ? { active: false } : {}),
        updated_by: context.userId,
        updated_by_name: await who(context),
        updated_at: new Date().toISOString(),
      })
      .eq("id", true);
    await audit(context, "ai_settings_key_saved", { metadata: { provider: data.provider } });
    return { ok: true };
  });

export const removeAiKey = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ provider: Provider }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const r = await readRow();
    await (await db())
      .from("ai_settings")
      .update({
        [`${data.provider}_api_key`]: null,
        [`${data.provider}_key_hint`]: null,
        ...(r?.provider === data.provider ? { active: false } : {}),
        updated_by: context.userId,
        updated_by_name: await who(context),
        updated_at: new Date().toISOString(),
      })
      .eq("id", true);
    await audit(context, "ai_settings_key_removed", { metadata: { provider: data.provider } });
    return { ok: true };
  });

async function keyFor(provider: "openai" | "gemini") {
  const r = await readRow();
  const stored = provider === "openai" ? r?.openai_api_key : r?.gemini_api_key;
  if (!stored) throw new Error("Nenhuma chave salva para esse provedor.");
  const { decryptSecret } = await import("./ai-provider.server");
  return decryptSecret(stored);
}

export const listProviderModels = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ provider: Provider }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const key = await keyFor(data.provider);
    if (data.provider === "openai") {
      const res = await fetch("https://api.openai.com/v1/models", { headers: { Authorization: `Bearer ${key}` } });
      if (!res.ok) throw new Error(`OpenAI ${res.status}: ${(await res.text()).slice(0, 300)}`);
      const j = (await res.json()) as { data?: { id: string }[] };
      return { models: (j.data ?? []).map((m) => m.id).sort() };
    }
    const res = await fetch("https://generativelanguage.googleapis.com/v1beta/models?pageSize=1000", { headers: { "x-goog-api-key": key } });
    if (!res.ok) throw new Error(`Gemini ${res.status}: ${(await res.text()).slice(0, 300)}`);
    const j = (await res.json()) as { models?: { name: string; supportedGenerationMethods?: string[] }[] };
    return {
      models: (j.models ?? [])
        .filter((m) => m.supportedGenerationMethods?.includes("generateContent"))
        .map((m) => m.name.replace(/^models\//, ""))
        .sort(),
    };
  });

/** Testa o provedor escolhido com a chave e o modelo de chat salvos. Só liga se passar. */
export const testAiConnection = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const r = await readRow();
    const provider = r?.provider as "openai" | "gemini" | null;
    const now = new Date().toISOString();
    const fail = async (msg: string) => {
      await (await db()).from("ai_settings").update({ active: false, last_test_at: now, last_test_error: msg.slice(0, 1000) }).eq("id", true);
      return { ok: false as const, error: msg };
    };
    if (!provider) return fail("Escolha o provedor e salve antes de testar.");
    const model = (r?.model_chat as string | null) || "";
    if (!model) return fail("Escolha o modelo de chat e salve antes de testar.");
    const { callProviderDirect, logAiUsage } = await import("./ai-provider.server");
    const started = Date.now();
    try {
      const key = await keyFor(provider);
      const out = await callProviderDirect(
        provider,
        key,
        model,
        'Responda apenas com o JSON {"ok": true}.',
        [{ role: "user", content: "teste de conexão" }],
        r?.temperature === null || r?.temperature === undefined ? null : Number(r.temperature),
      );
      await logAiUsage({ provider, model: out.model, use: "teste", input: out.usage.promptTokens, output: out.usage.completionTokens, latency: Date.now() - started, error: null });
      await (await db()).from("ai_settings").update({ active: true, last_test_at: now, last_test_error: null }).eq("id", true);
      await audit(context, "ai_settings_test_ok", { metadata: { provider, model } });
      return { ok: true as const, error: null };
    } catch (e) {
      const msg = e instanceof Error ? e.message : String(e);
      await logAiUsage({ provider, model, use: "teste", input: null, output: null, latency: Date.now() - started, error: msg });
      return fail(msg);
    }
  });

export const getAiUsage = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const client = await db();
    const { data: summary, error } = await client.rpc("ai_usage_summary");
    if (error) throw new Error(error.message);
    const { data: errors } = await client
      .from("ai_usage_log")
      .select("created_at, provider, model, use, error")
      .not("error", "is", null)
      .order("created_at", { ascending: false })
      .limit(20);
    return {
      summary: (summary ?? []) as { period: string; use: string; calls: number; errors: number; input: number; output: number }[],
      errors: (errors ?? []) as { created_at: string; provider: string; model: string | null; use: string; error: string }[],
    };
  });
