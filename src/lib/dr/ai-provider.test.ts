import { test, expect } from "bun:test";
import { buildGeminiBody, buildOpenAIBody, decryptSecret, encryptSecret, pickRoute, readEnvAiConfig } from "./ai-provider.server";

const IMG = "data:image/png;base64,AAAA";

const ENV = { provider: "gemini" as const, key: "k", modelChat: "m", modelTasks: "m" };

test("sem chave ativa no painel usa a reserva do .env; sem as duas, não há IA", () => {
  expect(pickRoute(null, ENV)).toEqual({ provider: "gemini", source: "env" });
  expect(pickRoute({ provider: "openai", active: false }, ENV)).toEqual({ provider: "gemini", source: "env" });
  expect(pickRoute(null, null)).toBeNull();
});

test("com chave ativa no painel nunca volta para o .env", () => {
  expect(pickRoute({ provider: "openai", active: true }, ENV)).toEqual({ provider: "openai", source: "painel" });
  expect(pickRoute({ provider: "gemini", active: true }, null)).toEqual({ provider: "gemini", source: "painel" });
});

test("reserva do .env só vale completa", () => {
  expect(readEnvAiConfig({ AI_PROVIDER: "openai", AI_API_KEY: "sk", AI_MODEL_CHAT: "gpt" })).toEqual({ provider: "openai", key: "sk", modelChat: "gpt", modelTasks: "gpt" });
  expect(readEnvAiConfig({ AI_PROVIDER: "openai", AI_API_KEY: "sk" })).toBeNull();
  expect(readEnvAiConfig({ AI_PROVIDER: "outra", AI_API_KEY: "sk", AI_MODEL_CHAT: "x" })).toBeNull();
});

test("OpenAI: JSON e imagem", () => {
  const b = buildOpenAIBody("gpt-x", "sys", [{ role: "user", content: "oi", imageDataUrl: IMG }], 0.3) as any;
  expect(b.response_format.type).toBe("json_object");
  expect(b.temperature).toBe(0.3);
  expect(b.messages[0]).toEqual({ role: "system", content: "sys" });
  expect(b.messages[1].content[1].image_url.url).toBe(IMG);
});

test("Gemini: system, papéis, JSON e imagem", () => {
  const b = buildGeminiBody("sys", [
    { role: "assistant", content: "olá" },
    { role: "user", content: "print", imageDataUrl: IMG },
  ], null) as any;
  expect(b.systemInstruction.parts[0].text).toBe("sys");
  expect(b.contents[0].role).toBe("model");
  expect(b.contents[1].parts[1].inlineData).toEqual({ mimeType: "image/png", data: "AAAA" });
  expect(b.generationConfig.responseMimeType).toBe("application/json");
  expect(b.generationConfig.temperature).toBeUndefined();
});

test("criptografia da chave ida e volta", async () => {
  process.env["AI_SETTINGS_ENC_KEY"] ??= "teste-local-123";
  const enc = await encryptSecret("sk-abcdef1234");
  expect(enc).not.toContain("abcdef");
  expect(await decryptSecret(enc)).toBe("sk-abcdef1234");
});
