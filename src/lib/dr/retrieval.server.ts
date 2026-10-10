import { fetchAll } from "./paging";
import { INTENT_RULES, SYNONYMS, type Intent } from "../../oferta/vocabulario";
import type { supabaseAdmin as AdminType } from "@/integrations/supabase/client.server";
import { PRODUTO_PADRAO, type Product } from "./config";

type AdminClient = typeof AdminType;

/* ------------------------------------------------------------------ */
/* Normalização e similaridade (tolerante a erro de digitação)          */
/* ------------------------------------------------------------------ */

export function normalize(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

const STOPWORDS = new Set([
  "para",
  "como",
  "onde",
  "qual",
  "quais",
  "isso",
  "esse",
  "essa",
  "aula",
  "aulas",
  "voce",
  "vc",
  "manda",
  "mandar",
  "envia",
  "enviar",
  "quero",
  "preciso",
  "pode",
  "poderia",
  "favor",
  "sobre",
  "tenho",
  "estou",
  "fazer",
  "meu",
  "minha",
  "dos",
  "das",
  "com",
  "sem",
  "que",
  "uma",
  "uns",
  "the",
  "and",
  "por",
  "pelo",
  "pela",
  "nao",
  "sim",
  "mais",
  "tem",
  "tudo",
  "aqui",
  "ali",
  "ele",
  "ela",
]);

export function terms(text: string) {
  return normalize(text)
    .split(" ")
    .filter((w) => w.length >= 3 && !STOPWORDS.has(w));
}

function bigrams(value: string) {
  const clean = normalize(value).replace(/ /g, "");
  const out: string[] = [];
  for (let i = 0; i < clean.length - 1; i++) out.push(clean.slice(i, i + 2));
  return out;
}

/** Coeficiente de Dice: 1 = idêntico. Boa tolerância a "Hicksfield"/"Higgsfield". */
export function similarity(a: string, b: string) {
  const A = bigrams(a);
  const B = bigrams(b);
  if (A.length === 0 || B.length === 0) return a === b ? 1 : 0;
  const pool = [...B];
  let hits = 0;
  for (const g of A) {
    const idx = pool.indexOf(g);
    if (idx >= 0) {
      hits++;
      pool.splice(idx, 1);
    }
  }
  return (2 * hits) / (A.length + B.length);
}

/** Melhor pontuação entre um texto livre e uma lista de nomes/apelidos. */
export function bestNameScore(query: string, candidates: string[]) {
  const q = normalize(query);
  const words = q.split(" ").filter(Boolean);
  let best = 0;
  for (const raw of candidates) {
    const cand = normalize(raw);
    if (!cand) continue;
    if (q.includes(cand) || cand.includes(q)) return 1;
    for (const w of words) {
      if (w.length < 4) continue;
      const score = similarity(w, cand);
      if (score > best) best = score;
    }
    const whole = similarity(q, cand);
    if (whole > best) best = whole;
  }
  return best;
}

/* ------------------------------------------------------------------ */
/* Classificação de intenção                                           */
/* ------------------------------------------------------------------ */

/** Lista de intenções e regras de detecção: src/oferta/vocabulario.ts. */
export { INTENTS, type Intent } from "../../oferta/vocabulario";

/** Pedido de ajuda sem assunto: nunca vira etapa, só abre uma pergunta de contexto. */
const HELP_RE =
  /^(oi|ola|opa|eae|e ai)?[\s,.!]*(me ajuda|preciso de ajuda|pode me ajudar|ajuda|estou perdido|to perdido|nao sei (o que fazer|por onde)|nao consegui|nao entendi|socorro)[\s.!?]*$/;

export function classifyIntents(text: string): Intent[] {
  // Comparação sempre sem acento: "Não consigo" precisa casar com /nao consigo/.
  const flat = normalize(text);
  const found = INTENT_RULES.filter((r) => r.re.test(flat)).map((r) => r.intent);

  // Mensagem vaga de socorro: prioridade máxima, sem assumir assunto.
  if (HELP_RE.test(flat.trim())) return ["preciso_ajuda"];

  if (found.length === 0) found.push("outro");
  return [...new Set(found)].slice(0, 6);
}

/** Compatibilidade com o restante do código que ainda usa nomes antigos. */
export function wantsMaterialIntent(intents: Intent[]) {
  return intents.includes("material_aula");
}

/* ------------------------------------------------------------------ */
/* Catálogo de ferramentas                                             */
/* ------------------------------------------------------------------ */

export type ToolLink = {
  id: string;
  name: string;
  aliases: string[];
  category: string | null;
  official_url: string | null;
  status: string;
  modules: number[];
  course_use: string | null;
  verified_at: string | null;
};

/** Só ferramentas verificadas podem ser citadas. "disabled_*" nunca aparece. */
function toolCitable(t: ToolLink) {
  return t.status.startsWith("verified");
}

export async function searchToolLinks(admin: AdminClient, question: string, limit = 4) {
  const { data } = await admin
    .from("tool_links")
    .select("id, name, aliases, category, official_url, status, modules, course_use, verified_at")
    .limit(300);

  const rows = ((data ?? []) as ToolLink[]).filter(toolCitable);

  // 1) Correspondência por nome/apelido (tolerante a erro de digitação).
  const byName = rows
    .map((t) => ({ tool: t, score: bestNameScore(question, [t.name, ...(t.aliases ?? [])]) }))
    .filter((r) => r.score >= 0.58)
    .sort((a, b) => b.score - a.score);
  if (byName.length > 0) return byName.slice(0, limit).map((s) => s.tool);

  // 2) Sem nome citado ("quais ferramentas para portfólio?"): casa por categoria e uso no curso.
  const qTerms = expandedTerms(question);
  if (qTerms.length === 0) return [];
  const byTopic = rows
    .map((t) => {
      let score = 0;
      const category = normalize(t.category ?? "").replace(/_/g, " ");
      const use = normalize(t.course_use ?? "");
      for (const term of qTerms) {
        if (category.includes(term)) score += 4;
        if (use.includes(term)) score += 2;
      }
      return { tool: t, score };
    })
    .filter((r) => r.score >= 4)
    .sort((a, b) => b.score - a.score);

  return byTopic.slice(0, limit).map((s) => s.tool);
}

/* ------------------------------------------------------------------ */
/* Materiais de apoio                                                  */
/* ------------------------------------------------------------------ */

export type MaterialRow = {
  id: string;
  slug: string | null;
  title: string;
  description: string | null;
  aliases: string[];
  keywords: string[];
  lesson_ref: string | null;
  lesson_title: string | null;
  level: number | null;
  module: number | null;
  resource_type: string;
  source_url: string | null;
  download_url: string | null;
  storage_path: string | null;
  file_name: string | null;
  file_size: number | null;
  product: string | null;
  access_scope: string[];
  status: string;
  distribution_authorized: boolean;
  risk_notice: string | null;
  availability_status: string | null;
  verified_at: string | null;
  commercial_offer: boolean;
  price_display: string | null;
  price_verified_at: string | null;
  send_policy: string | null;
  contact_type: string | null;
  contact_value: string | null;
  notes: string | null;
  last_checked_at: string | null;
  temporary_link: boolean | null;
  active: boolean;
};

export const MATERIAL_FIELDS =
  "id, slug, title, description, aliases, keywords, lesson_ref, lesson_title, level, module, resource_type, source_url, download_url, storage_path, file_name, file_size, product, access_scope, status, distribution_authorized, risk_notice, availability_status, verified_at, commercial_offer, price_display, price_verified_at, send_policy, contact_type, contact_value, notes, last_checked_at, temporary_link, active";

/** Validade de preço: 7 dias a partir da verificação real. */
export const PRICE_VALIDITY_DAYS = 7;

export function priceStatus(m: {
  commercial_offer: boolean;
  price_display: string | null;
  price_verified_at: string | null;
}): { state: "none" | "fresh" | "stale"; verifiedAt: string | null } {
  if (!m.commercial_offer || !m.price_display) return { state: "none", verifiedAt: null };
  if (!m.price_verified_at) return { state: "stale", verifiedAt: null };
  const verified = new Date(`${m.price_verified_at}T00:00:00Z`).getTime();
  if (Number.isNaN(verified)) return { state: "stale", verifiedAt: m.price_verified_at };
  const days = (Date.now() - verified) / 86_400_000;
  return {
    state: days <= PRICE_VALIDITY_DAYS ? "fresh" : "stale",
    verifiedAt: m.price_verified_at,
  };
}

/**
 * Destino do material, na ordem: arquivo privado (link assinado) → download →
 * site oficial → contato (telefone/e-mail). Contato sem URL é entrega válida.
 */
export function resolveMaterialTarget(
  m: Pick<
    MaterialRow,
    "storage_path" | "download_url" | "source_url" | "contact_type" | "contact_value"
  >,
): { kind: "file" | "download" | "link" | "contact" | "none"; value: string | null } {
  if (m.storage_path) return { kind: "file", value: m.storage_path };
  if (m.download_url) return { kind: "download", value: m.download_url };
  if (m.source_url) return { kind: "link", value: m.source_url };
  if (m.contact_value) return { kind: "contact", value: m.contact_value };
  return { kind: "none", value: null };
}

/** Acesso é decidido SEMPRE no servidor, nunca pelo frontend. */
export function materialAllowed(m: MaterialRow, products: Product[]) {
  if (!m.active || m.status !== "approved" || !m.distribution_authorized) return false;
  const scope = m.access_scope ?? [];
  if (scope.includes("all")) return true;
  if (scope.length > 0) return scope.some((s) => (products as string[]).includes(s));
  if (m.product) return (products as string[]).includes(m.product);
  return true;
}

export async function loadEntitledMaterials(admin: AdminClient, products: Product[]) {
  const { data } = await admin.from("support_materials").select(MATERIAL_FIELDS).limit(1000);
  return ((data ?? []) as unknown as MaterialRow[]).filter((m) => materialAllowed(m, products));
}

/** Sinônimos usados pelos alunos → termos do catálogo: src/oferta/vocabulario.ts. */

function expandedTerms(question: string) {
  const base = terms(question);
  const out = new Set(base);
  for (const t of base) for (const syn of SYNONYMS[t] ?? []) out.add(normalize(syn));
  return [...out];
}

export function scoreMaterials(rows: MaterialRow[], question: string, limit = 6) {
  const q = normalize(question);
  const qTerms = expandedTerms(question);

  const scored = rows.map((m) => {
    let score = 0;
    const aliasScore = bestNameScore(question, [
      m.title,
      ...(m.aliases ?? []),
      ...(m.lesson_title ? [m.lesson_title] : []),
      ...(m.slug ? [m.slug.replace(/-/g, " ")] : []),
    ]);
    if (aliasScore >= 0.95) score += 12;
    else if (aliasScore >= 0.6) score += aliasScore * 6;

    const slugText = normalize((m.slug ?? "").replace(/-/g, " "));
    for (const t of qTerms) {
      if (normalize(m.title).includes(t)) score += 4;
      if ((m.keywords ?? []).some((k) => normalize(k).includes(t))) score += 3;
      if ((m.aliases ?? []).some((a) => normalize(a).includes(t))) score += 3;
      if (slugText.includes(t)) score += 3;
      if (m.lesson_ref && normalize(m.lesson_ref).includes(t)) score += 2;
      if (m.lesson_title && normalize(m.lesson_title).includes(t)) score += 2;
      if (m.description && normalize(m.description).includes(t)) score += 1;
      if (m.notes && normalize(m.notes).includes(t)) score += 1;
      if (m.send_policy && normalize(m.send_policy).includes(t)) score += 1;
      if (m.contact_value && normalize(m.contact_value).includes(t)) score += 2;
      if (m.contact_type && normalize(m.contact_type).includes(t)) score += 1;
    }

    const moduleMatch = q.match(/\bmodulo (\d{1,2})\b/);
    if (moduleMatch && m.module === Number(moduleMatch[1])) score += 3;

    return { m, score };
  });

  return scored
    .filter((s) => s.score > 0)
    .sort((a, b) => b.score - a.score)
    .slice(0, limit)
    .map((s) => s.m);
}

export async function searchMaterials(
  admin: AdminClient,
  products: Product[],
  question: string,
  limit = 6,
) {
  const rows = await loadEntitledMaterials(admin, products);
  return scoreMaterials(rows, question, limit);
}

/* ------------------------------------------------------------------ */
/* Blocos do curso                                                     */
/* ------------------------------------------------------------------ */

export type CourseChunk = {
  id: string;
  product: string;
  level: number | null;
  module: number | null;
  lesson: string | null;
  topic: string | null;
  title: string;
  content: string;
  keywords: string[];
};

export async function searchCourseChunks(
  admin: AdminClient,
  products: Product[],
  question: string,
  { min = 4, max = 8 }: { min?: number; max?: number } = {},
) {
  const allowed = products.length > 0 ? products : [PRODUTO_PADRAO];
  // Lê TODOS os trechos aprovados em páginas (o banco devolve no máximo 1.000
  // por consulta; antes, ~207 trechos ficavam de fora). Ordem estável por id.
  const rows = await fetchAll<CourseChunk>((from, to) =>
    admin
      .from("course_chunks")
      .select("id, product, level, module, lesson, topic, title, content, keywords")
      .eq("status", "approved")
      .in("product", [...allowed, "all"])
      .order("id")
      .range(from, to) as never,
  );
  const qTerms = expandedTerms(question);
  if (rows.length === 0) return [];

  const nq = normalize(question);
  const moduleMatch = nq.match(/\bmodulo (\d{1,2})\b/);
  const wantedModule = moduleMatch ? Number(moduleMatch[1]) : null;
  const levelMatch = nq.match(/\bvitrine (\d{1,2})\b/);
  const wantedLevel = levelMatch ? Number(levelMatch[1]) : null;

  // Pergunta sobre um módulo/vitrine inteiro: trazer aulas variadas daquele escopo.
  if (wantedModule || wantedLevel) {
    const scope = rows.filter(
      (c) =>
        (wantedModule === null || c.module === wantedModule) &&
        (wantedLevel === null || c.level === wantedLevel),
    );
    if (scope.length) {
      const byLesson = new Map<string, CourseChunk>();
      for (const c of scope) {
        const key = `${c.level ?? "?"}-${c.module ?? "?"}-${c.lesson ?? c.title}`;
        if (!byLesson.has(key)) byLesson.set(key, c);
      }
      const picked = [...byLesson.values()].slice(0, 12);
      if (picked.length >= 2) return picked;
    }
  }

  const scored = rows.map((c) => {
    let score = 0;
    const title = normalize(c.title);
    const topic = normalize(c.topic ?? "");
    const content = normalize(c.content);
    for (const t of qTerms) {
      if (title.includes(t)) score += 5;
      if ((c.keywords ?? []).some((k) => normalize(k).includes(t))) score += 4;
      if (topic.includes(t)) score += 3;
      if (content.includes(t)) score += 1;
    }
    if (wantedModule && c.module === wantedModule) score += 4;
    return { c, score };
  });

  const hits = scored.filter((s) => s.score > 0).sort((a, b) => b.score - a.score);
  if (hits.length === 0) return [];
  return hits.slice(0, Math.max(min, Math.min(max, hits.length))).map((s) => s.c);
}

/* ------------------------------------------------------------------ */
/* Configuração do assistente                                          */
/* ------------------------------------------------------------------ */

export async function loadAssistantConfig(admin: AdminClient) {
  const { data } = await admin.from("assistant_config").select("key, value");
  const map = new Map((data ?? []).map((r) => [r.key, r.value as Record<string, unknown>]));
  const text = (key: string) => {
    const value = map.get(key);
    const content = value?.["content"];
    return typeof content === "string" ? content : null;
  };
  const retrieval = (map.get("retrieval") ?? {}) as Record<string, unknown>;
  return {
    systemPrompt: text("system_prompt"),
    voiceGuide: text("voice_guide"),
    minChunks:
      typeof retrieval["min_chunks"] === "number" ? (retrieval["min_chunks"] as number) : 4,
    maxChunks:
      typeof retrieval["max_chunks"] === "number" ? (retrieval["max_chunks"] as number) : 8,
  };
}
