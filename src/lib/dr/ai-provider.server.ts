/**
 * Camada única de IA. Lê ai_settings e chama o provedor escolhido.
 * Com chave ativa no painel (salva + teste ok) → só essa chave, sem reserva.
 * Sem chave ativa no painel → reserva pelo .env (AI_PROVIDER + AI_API_KEY + AI_MODEL_CHAT),
 * o equivalente ao "gateway do Lovable" que o MGA usava antes de ter chave própria.
 * Sem nenhuma das duas → erro claro ("IA não configurada"); o chat mostra a mensagem de indisponibilidade.
 */
import type { SupabaseClient } from "@supabase/supabase-js";

export type AiUse = "chat" | "classificacao";
export type AiProvider = "openai" | "gemini";
export type AiMessage = { role: "user" | "assistant"; content: string; imageDataUrl?: string | null };

export class AiHttpError extends Error {
  constructor(
    public provider: AiProvider,
    public status: number,
    public body: string,
  ) {
    super(`${provider} ${status}: ${body.slice(0, 300)}`);
  }
}

export type AiSettingsRow = {
  provider: "openai" | "gemini" | null;
  model_chat: string | null;
  model_tasks: string | null;
  temperature: number | null;
  openai_api_key: string | null;
  gemini_api_key: string | null;
  active: boolean;
};

// eslint-disable-next-line @typescript-eslint/no-explicit-any
type Admin = SupabaseClient<any>;

// ---------- criptografia (AES-GCM, chave do servidor) ----------
async function encKey() {
  const secret = process.env["AI_SETTINGS_ENC_KEY"];
  if (!secret) throw new Error("AI_SETTINGS_ENC_KEY ausente");
  const hash = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(secret));
  return crypto.subtle.importKey("raw", hash, "AES-GCM", false, ["encrypt", "decrypt"]);
}
const b64 = (u: Uint8Array) => Buffer.from(u).toString("base64");
export async function encryptSecret(plain: string) {
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const ct = new Uint8Array(await crypto.subtle.encrypt({ name: "AES-GCM", iv }, await encKey(), new TextEncoder().encode(plain)));
  return `v1:${b64(iv)}:${b64(ct)}`;
}
export async function decryptSecret(stored: string) {
  const [v, iv, ct] = stored.split(":");
  if (v !== "v1" || !iv || !ct) throw new Error("chave salva em formato inválido");
  const out = await crypto.subtle.decrypt(
    { name: "AES-GCM", iv: Buffer.from(iv, "base64") },
    await encKey(),
    Buffer.from(ct, "base64"),
  );
  return new TextDecoder().decode(out);
}

// ---------- montagem dos pedidos (exportadas para teste) ----------
export function buildOpenAIBody(model: string, system: string, messages: AiMessage[], temperature: number | null) {
  return {
    model,
    ...(temperature !== null && temperature !== undefined ? { temperature } : {}),
    messages: [
      { role: "system", content: system },
      ...messages.map((m) =>
        m.imageDataUrl
          ? { role: m.role, content: [{ type: "text", text: m.content }, { type: "image_url", image_url: { url: m.imageDataUrl } }] }
          : { role: m.role, content: m.content },
      ),
    ],
    response_format: { type: "json_object" },
  };
}

function parseDataUrl(url: string) {
  const m = /^data:([^;,]+);base64,(.*)$/s.exec(url);
  return m ? { mimeType: m[1]!, data: m[2]! } : null;
}

export function buildGeminiBody(system: string, messages: AiMessage[], temperature: number | null) {
  return {
    systemInstruction: { parts: [{ text: system }] },
    contents: messages.map((m) => {
      const parts: Record<string, unknown>[] = [{ text: m.content || " " }];
      const img = m.imageDataUrl ? parseDataUrl(m.imageDataUrl) : null;
      if (img) parts.push({ inlineData: img });
      return { role: m.role === "assistant" ? "model" : "user", parts };
    }),
    generationConfig: {
      responseMimeType: "application/json",
      ...(temperature !== null && temperature !== undefined ? { temperature } : {}),
    },
  };
}

type Result = {
  raw: string;
  model: string;
  provider: AiProvider;
  usage: { promptTokens: number | null; completionTokens: number | null; totalTokens: number | null };
};

async function callOpenAI(key: string, model: string, system: string, messages: AiMessage[], temperature: number | null): Promise<Result> {
  const res = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: { "Content-Type": "application/json", Authorization: `Bearer ${key}` },
    body: JSON.stringify(buildOpenAIBody(model, system, messages, temperature)),
  });
  if (!res.ok) throw new AiHttpError("openai", res.status, await res.text());
  const j = (await res.json()) as {
    choices?: { message?: { content?: string } }[];
    model?: string;
    usage?: { prompt_tokens?: number; completion_tokens?: number; total_tokens?: number };
  };
  return {
    raw: j.choices?.[0]?.message?.content ?? "",
    model: j.model ?? model,
    provider: "openai",
    usage: { promptTokens: j.usage?.prompt_tokens ?? null, completionTokens: j.usage?.completion_tokens ?? null, totalTokens: j.usage?.total_tokens ?? null },
  };
}

async function callGemini(key: string, model: string, system: string, messages: AiMessage[], temperature: number | null): Promise<Result> {
  const id = model.replace(/^models\//, "");
  const res = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(id)}:generateContent`, {
    method: "POST",
    headers: { "Content-Type": "application/json", "x-goog-api-key": key },
    body: JSON.stringify(buildGeminiBody(system, messages, temperature)),
  });
  if (!res.ok) throw new AiHttpError("gemini", res.status, await res.text());
  const j = (await res.json()) as {
    candidates?: { content?: { parts?: { text?: string }[] } }[];
    modelVersion?: string;
    usageMetadata?: { promptTokenCount?: number; candidatesTokenCount?: number; totalTokenCount?: number };
  };
  const raw = (j.candidates?.[0]?.content?.parts ?? []).map((p) => p.text ?? "").join("");
  return {
    raw,
    model: j.modelVersion ?? id,
    provider: "gemini",
    usage: {
      promptTokens: j.usageMetadata?.promptTokenCount ?? null,
      completionTokens: j.usageMetadata?.candidatesTokenCount ?? null,
      totalTokens: j.usageMetadata?.totalTokenCount ?? null,
    },
  };
}

/** Reserva pelo .env, usada só enquanto não há chave ativa no painel. */
export type EnvAiConfig = { provider: AiProvider; key: string; modelChat: string; modelTasks: string };

export function readEnvAiConfig(env: Record<string, string | undefined> = process.env): EnvAiConfig | null {
  const provider = env["AI_PROVIDER"]?.trim().toLowerCase();
  const key = env["AI_API_KEY"]?.trim();
  const modelChat = env["AI_MODEL_CHAT"]?.trim();
  if ((provider !== "openai" && provider !== "gemini") || !key || !modelChat) return null;
  return { provider, key, modelChat, modelTasks: env["AI_MODEL_TASKS"]?.trim() || modelChat };
}

export class AiNotConfiguredError extends Error {
  constructor() {
    super("IA não configurada: salve e teste uma chave em Admin › Configurações › IA (ou preencha AI_PROVIDER, AI_API_KEY e AI_MODEL_CHAT no .env).");
  }
}

/**
 * Decide o caminho. Exportada para teste.
 * Chave ativa no painel sempre vence e nunca cai para o .env (mesma regra do MGA:
 * depois de ligar a chave própria, não existe reserva).
 */
export function pickRoute(
  s: Pick<AiSettingsRow, "provider" | "active"> | null,
  env: EnvAiConfig | null = null,
): { provider: AiProvider; source: "painel" | "env" } | null {
  if (s?.active && s.provider) return { provider: s.provider, source: "painel" };
  if (env) return { provider: env.provider, source: "env" };
  return null;
}

export async function callProviderDirect(
  provider: "openai" | "gemini",
  key: string,
  model: string,
  system: string,
  messages: AiMessage[],
  temperature: number | null,
) {
  return provider === "openai"
    ? callOpenAI(key, model, system, messages, temperature)
    : callGemini(key, model, system, messages, temperature);
}

async function adminClient(): Promise<Admin> {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  return supabaseAdmin as Admin;
}

export async function loadAiSettings(admin?: Admin): Promise<AiSettingsRow | null> {
  const db = admin ?? (await adminClient());
  const { data } = await db
    .from("ai_settings")
    .select("provider, model_chat, model_tasks, temperature, openai_api_key, gemini_api_key, active")
    .eq("id", true)
    .maybeSingle();
  return (data as AiSettingsRow | null) ?? null;
}

export async function logAiUsage(
  row: { provider: string; model: string | null; use: string; input: number | null; output: number | null; latency: number; error: string | null },
  admin?: Admin,
) {
  try {
    const db = admin ?? (await adminClient());
    await db.from("ai_usage_log").insert({
      provider: row.provider,
      model: row.model,
      use: row.use,
      input_tokens: row.input,
      output_tokens: row.output,
      latency_ms: row.latency,
      error: row.error ? row.error.slice(0, 1000) : null,
    });
  } catch (e) {
    console.error("[ai] falha ao registrar uso", e);
  }
}

/** Ponto único usado pelo chat e pelo classificador. */
export async function runAI(opts: { use: AiUse; system: string; messages: AiMessage[] }): Promise<Result> {
  const db = await adminClient();
  let settings: AiSettingsRow | null = null;
  try {
    settings = await loadAiSettings(db);
  } catch (e) {
    console.error("[ai] falha ao ler ai_settings", e);
  }
  const envConfig = readEnvAiConfig();
  const route = pickRoute(settings, envConfig);
  if (!route) {
    const err = new AiNotConfiguredError();
    await logAiUsage({ provider: "nenhum", model: null, use: opts.use, input: null, output: null, latency: 0, error: err.message }, db);
    throw err;
  }
  const started = Date.now();
  let model = "";
  try {
    let result: Result;
    if (route.source === "env") {
      model = opts.use === "chat" ? envConfig!.modelChat : envConfig!.modelTasks;
      result = await callProviderDirect(route.provider, envConfig!.key, model, opts.system, opts.messages, null);
    } else {
      const stored = route.provider === "openai" ? settings!.openai_api_key : settings!.gemini_api_key;
      model = (opts.use === "chat" ? settings!.model_chat : settings!.model_tasks) || settings!.model_chat || "";
      if (!stored) throw new Error(`chave ${route.provider} ausente`);
      if (!model) throw new Error("modelo não configurado");
      const key = await decryptSecret(stored);
      const temp = settings!.temperature === null ? null : Number(settings!.temperature);
      result = await callProviderDirect(route.provider, key, model, opts.system, opts.messages, temp);
    }
    await logAiUsage(
      { provider: route.provider, model: result.model, use: opts.use, input: result.usage.promptTokens, output: result.usage.completionTokens, latency: Date.now() - started, error: null },
      db,
    );
    return result;
  } catch (e) {
    await logAiUsage(
      { provider: route.provider, model, use: opts.use, input: null, output: null, latency: Date.now() - started, error: e instanceof Error ? e.message : String(e) },
      db,
    );
    throw e;
  }
}
