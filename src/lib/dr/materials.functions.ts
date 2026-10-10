import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { PRODUCTS, type Product } from "./config";
import type { MaterialRow } from "./retrieval.server";
import { MARCA } from "./config";

/**
 * Gera acesso ao material.
 * A autorização é decidida no servidor: produto ativo + aprovado + distribuição autorizada.
 * Ordem de entrega: arquivo privado (link assinado) → download → site oficial → contato.
 */
export const getMaterialDownloadUrl = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ materialId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    const { supabase, userId } = context;

    const { data: productRows } = await supabase
      .from("user_products")
      .select("product")
      .eq("user_id", userId)
      .eq("active", true);
    const products = (productRows ?? [])
      .map((r) => r.product as Product)
      .filter((p) => (PRODUCTS as readonly string[]).includes(p));

    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { materialAllowed, resolveMaterialTarget, priceStatus, MATERIAL_FIELDS } =
      await import("./retrieval.server");

    const { data: row } = await supabaseAdmin
      .from("support_materials")
      .select(MATERIAL_FIELDS)
      .eq("id", data.materialId)
      .maybeSingle();

    const material = row as unknown as MaterialRow | null;
    if (!material || !materialAllowed(material, products)) {
      throw new Error("Material não disponível para o seu acesso.");
    }

    const target = resolveMaterialTarget(material);
    let url: string | null = null;
    let kind: "download" | "link" | "contact" = "download";
    let contact: { type: string | null; value: string } | null = null;

    if (target.kind === "file") {
      const fileName = material.file_name ?? `${material.slug ?? "material"}`;
      const { data: signed, error } = await supabaseAdmin.storage
        .from("knowledge")
        .createSignedUrl(target.value!, 300, { download: fileName });
      if (error || !signed?.signedUrl) throw new Error("Não consegui gerar o link de download.");
      url = signed.signedUrl;
    } else if (target.kind === "download" || target.kind === "link") {
      url = target.value;
      kind = "link";
    } else if (target.kind === "contact") {
      kind = "contact";
      contact = { type: material.contact_type, value: target.value! };
    }

    if (!url && !contact) {
      throw new Error(
        `Esse material ainda não tem link ou contato cadastrado. Use o atendimento humano da ${MARCA.nomeProduto}.`,
      );
    }

    await supabaseAdmin.from("usage_events").insert({
      user_id: userId,
      event_name: "material_downloaded",
      metadata: { material_id: material.id, slug: material.slug, kind },
    });

    const price = priceStatus(material);

    return {
      url,
      kind,
      contact,
      fileName: material.file_name ?? material.title,
      riskNotice: material.risk_notice,
      commercialOffer: material.commercial_offer,
      priceState: price.state,
      priceVerifiedAt: price.verifiedAt,
      availabilityStatus: material.availability_status,
    };
  });

/** Materiais liberados para o aluno (usado para listar/procurar na interface). */
export const listMyMaterials = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    const { data } = await context.supabase
      .from("support_materials")
      .select(
        "id, title, description, lesson_ref, lesson_title, resource_type, file_name, file_size, risk_notice, commercial_offer",
      )
      .eq("status", "approved")
      .eq("distribution_authorized", true)
      .order("created_at", { ascending: false })
      .limit(200);
    return data ?? [];
  });
