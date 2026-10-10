import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { PRODUCTS } from "./config";

async function assertAdmin(context: { supabase: { rpc: Function }; userId: string }) {
  const { data, error } = await (
    context.supabase.rpc as (
      fn: string,
      args: Record<string, unknown>,
    ) => Promise<{ data: unknown; error: unknown }>
  )("has_role", {
    _user_id: context.userId,
    _role: "admin",
  });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

export const listMaterials = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data, error } = await context.supabase
      .from("support_materials")
      .select(
        "id, title, description, keywords, product, lesson_ref, file_name, file_size, storage_path, active, created_at, updated_at, updated_by",
      )
      .order("created_at", { ascending: false })
      .limit(300);
    if (error) throw new Error("Não consegui carregar os materiais.");
    return data ?? [];
  });

export const createMaterial = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        title: z.string().trim().min(2).max(160),
        description: z.string().trim().max(500).nullable().optional(),
        keywords: z.array(z.string().trim().min(2).max(40)).max(20).default([]),
        product: z.enum(PRODUCTS).nullable().optional(),
        lessonRef: z.string().trim().max(120).nullable().optional(),
        storagePath: z.string().trim().min(3).max(400),
        fileName: z.string().trim().min(1).max(200),
        fileSize: z.number().int().nonnegative().nullable().optional(),
        mimeType: z.string().trim().max(120).nullable().optional(),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: row, error } = await context.supabase
      .from("support_materials")
      .insert({
        title: data.title,
        description: data.description ?? null,
        keywords: data.keywords,
        product: data.product ?? null,
        lesson_ref: data.lessonRef ?? null,
        storage_path: data.storagePath,
        file_name: data.fileName,
        file_size: data.fileSize ?? null,
        mime_type: data.mimeType ?? null,
        created_by: context.userId,
      })
      .select("id")
      .single();
    if (error) throw new Error("Não consegui cadastrar o material.");
    return row;
  });

export const setMaterialActive = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ id: z.string().uuid(), active: z.boolean() }).parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { error } = await context.supabase
      .from("support_materials")
      .update({ active: data.active })
      .eq("id", data.id);
    if (error) throw new Error("Não consegui atualizar o material.");
    return { ok: true };
  });

export const deleteMaterial = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ id: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: material } = await context.supabase
      .from("support_materials")
      .select("storage_path")
      .eq("id", data.id)
      .maybeSingle();

    const { error } = await context.supabase.from("support_materials").delete().eq("id", data.id);
    if (error) throw new Error("Não consegui remover o material.");

    if (material?.storage_path) {
      const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
      await supabaseAdmin.storage.from("knowledge").remove([material.storage_path]);
    }
    return { ok: true };
  });

export const listMaterialRequests = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data } = await context.supabase
      .from("material_requests")
      .select("id, query_text, terms, created_at, user_id")
      .order("created_at", { ascending: false })
      .limit(100);
    return data ?? [];
  });

export const updateMaterial = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        id: z.string().uuid(),
        title: z.string().trim().min(2).max(160),
        description: z.string().trim().max(500).nullable().optional(),
        keywords: z.array(z.string().trim().min(2).max(40)).max(40).default([]),
        file: z
          .object({
            storagePath: z.string().trim().min(3).max(400),
            fileName: z.string().trim().min(1).max(200),
            fileSize: z.number().int().nonnegative().nullable().optional(),
            mimeType: z.string().trim().max(120).nullable().optional(),
          })
          .nullable()
          .optional(),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: current } = await context.supabase
      .from("support_materials")
      .select("storage_path, title, keywords, description, file_name")
      .eq("id", data.id)
      .maybeSingle();
    if (!current) throw new Error("Material não encontrado.");

    const patch: Record<string, unknown> = {
      title: data.title,
      description: data.description ?? null,
      keywords: data.keywords,
      updated_by: context.userId,
    };
    if (data.file) {
      patch["storage_path"] = data.file.storagePath;
      patch["file_name"] = data.file.fileName;
      patch["file_size"] = data.file.fileSize ?? null;
      patch["mime_type"] = data.file.mimeType ?? null;
    }
    const { error } = await context.supabase
      .from("support_materials")
      .update(patch as never)
      .eq("id", data.id);
    if (error) throw new Error("Não consegui salvar a edição.");

    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    if (data.file && current.storage_path && current.storage_path !== data.file.storagePath) {
      await supabaseAdmin.storage.from("knowledge").remove([current.storage_path]);
    }
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: "material_updated",
      metadata: {
        material_id: data.id,
        before: { title: current.title, description: current.description, keywords: current.keywords, file_name: current.file_name },
        after: { title: data.title, description: data.description ?? null, keywords: data.keywords, file_name: data.file?.fileName ?? current.file_name },
      },
    });
    return { ok: true };
  });
