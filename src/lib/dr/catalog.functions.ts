import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { PRODUCTS, PRODUTO_PADRAO, type Product } from "./config";

type AdminContext = { supabase: { rpc: RpcFn }; userId: string };
type RpcFn = (
  fn: "has_role",
  args: { _user_id: string; _role: "admin" },
) => PromiseLike<{ data: unknown; error: unknown }>;

async function assertAdmin(context: AdminContext) {
  const { data, error } = await context.supabase.rpc("has_role", {
    _user_id: context.userId,
    _role: "admin",
  });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

/** Números do catálogo importado (blocos, ferramentas, materiais e versão do pacote). */
export const getCatalogStats = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");

    const [chunks, approvedChunks, levels, materials, approvedMaterials, stored, config] =
      await Promise.all([
        supabaseAdmin.from("course_chunks").select("id", { count: "exact", head: true }),
        supabaseAdmin
          .from("course_chunks")
          .select("id", { count: "exact", head: true })
          .eq("status", "approved"),
        supabaseAdmin.from("course_chunks").select("level"),
        supabaseAdmin.from("support_materials").select("id", { count: "exact", head: true }),
        supabaseAdmin
          .from("support_materials")
          .select("id", { count: "exact", head: true })
          .eq("status", "approved")
          .eq("distribution_authorized", true),
        supabaseAdmin
          .from("support_materials")
          .select("id", { count: "exact", head: true })
          .not("storage_path", "is", null),
        supabaseAdmin
          .from("assistant_config")
          .select("key, value")
          .eq("key", "retrieval")
          .maybeSingle(),
      ]);

    const retrieval = (config.data?.value ?? {}) as Record<string, unknown>;
    const levelSet = new Set(
      ((levels.data ?? []) as { level: number | null }[])
        .map((r) => r.level)
        .filter((l): l is number => typeof l === "number"),
    );
    return {
      chunks: chunks.count ?? 0,
      approvedChunks: approvedChunks.count ?? 0,
      vitrines: levelSet.size,
      materials: materials.count ?? 0,
      approvedMaterials: approvedMaterials.count ?? 0,
      storedFiles: stored.count ?? 0,
      bundleVersion: (retrieval["bundle_version"] as string | undefined) ?? "—",
      model: (retrieval["model"] as string | undefined) ?? "—",
    };
  });

/** Teste de recuperação: mostra o que o assistente encontraria para uma pergunta. */
export const testRetrieval = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        question: z.string().trim().min(2).max(500),
        products: z.array(z.enum(PRODUCTS)).optional(),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const retrieval = await import("./retrieval.server");
    const products = (data.products?.length ? data.products : [PRODUTO_PADRAO]) as Product[];

    const [chunks, materials] = await Promise.all([
      retrieval.searchCourseChunks(supabaseAdmin, products, data.question),
      retrieval.searchMaterials(supabaseAdmin, products, data.question),
    ]);

    return {
      intents: retrieval.classifyIntents(data.question),
      chunks: chunks.map((c) => ({
        id: c.id,
        title: c.title,
        module: c.module,
        level: c.level,
        lesson: c.lesson,
      })),
      materials: materials.map((m) => ({
        id: m.id,
        title: m.title,
        resourceType: m.resource_type,
        delivery: m.storage_path
          ? "download"
          : (m.download_url ?? m.source_url)
            ? "link"
            : m.contact_value
              ? "contato"
              : "suporte",
        contact: m.contact_value,
        commercial: m.commercial_offer,
      })),
      tools: [] as { name: string; url: string | null; status: string }[],
    };
  });

/* ------------------------------------------------------------------ */
/* Verificação de links externos                                       */
/* ------------------------------------------------------------------ */

/** Domínios que nunca podem ser julgados por robô (login, anti-bot, convite). */
const MANUAL_REVIEW = [
  /whatsapp\.com/i,
  /wa\.me/i,
  /checkout/i,
  /pay\./i,
  /hotmart/i,
  /hubla/i,
  /kiwify/i,
];

type LinkCheck = {
  id: string;
  slug: string | null;
  title: string;
  url: string | null;
  status: "available" | "unavailable" | "unknown" | "not_applicable";
  detail: string;
};

async function probe(url: string): Promise<{ status: LinkCheck["status"]; detail: string }> {
  if (MANUAL_REVIEW.some((re) => re.test(url))) {
    return { status: "unknown", detail: "revisão manual obrigatória (convite/checkout)" };
  }
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 12_000);
  try {
    const res = await fetch(url, { redirect: "follow", signal: controller.signal });
    if (res.ok) return { status: "available", detail: `HTTP ${res.status}` };
    if ([401, 403, 405, 429].includes(res.status))
      return { status: "unknown", detail: `HTTP ${res.status} — bloqueio/bot/login` };
    if (res.status >= 500)
      return { status: "unknown", detail: `HTTP ${res.status} — servidor instável` };
    return { status: "unavailable", detail: `HTTP ${res.status}` };
  } catch (error) {
    return {
      status: "unknown",
      detail: error instanceof Error ? error.message.slice(0, 80) : "falha de rede",
    };
  } finally {
    clearTimeout(timer);
  }
}

/**
 * Verificação manual (painel) dos links públicos do catálogo.
 * A rotina semanal automática só será ligada quando houver agendamento habilitado.
 */
export const checkCatalogLinks = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ limit: z.number().min(1).max(80).optional() }).parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");

    const { data: rows } = await supabaseAdmin
      .from("support_materials")
      .select("id, slug, title, source_url, download_url, storage_path, contact_value")
      .order("last_checked_at", { ascending: true, nullsFirst: true })
      .limit(data.limit ?? 60);

    const results: LinkCheck[] = [];
    for (const row of rows ?? []) {
      const url = (row.download_url ?? row.source_url) as string | null;
      let status: LinkCheck["status"];
      let detail: string;
      if (!url) {
        status = "not_applicable";
        detail = row.storage_path
          ? "arquivo privado no storage"
          : row.contact_value
            ? "contato direto"
            : "sem link";
      } else {
        const probed = await probe(url);
        status = probed.status;
        detail = probed.detail;
      }
      await supabaseAdmin
        .from("support_materials")
        .update({ availability_status: status, last_checked_at: new Date().toISOString() })
        .eq("id", row.id);
      results.push({ id: row.id, slug: row.slug, title: row.title, url, status, detail });
    }

    return {
      checked: results.length,
      available: results.filter((r) => r.status === "available").length,
      unavailable: results.filter((r) => r.status === "unavailable").length,
      unknown: results.filter((r) => r.status === "unknown").length,
      results,
    };
  });
