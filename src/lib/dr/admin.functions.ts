import { fetchAll } from "./paging";
import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { PRODUCTS } from "./config";

const productEnum = z.enum(PRODUCTS);
const baseEnum = z.enum(["official_editor_dr", "real_questions", "official_faq", "refund_risk"]);

async function assertAdmin(context: { supabase: any; userId: string }) {
  const { data, error } = await context.supabase.rpc("has_role", {
    _user_id: context.userId,
    _role: "admin",
  });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

export const listKnowledgeDocuments = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data, error } = await context.supabase
      .from("knowledge_documents")
      .select(
        "id, title, base_type, product, storage_path, source, version, status, approved, created_at",
      )
      .order("created_at", { ascending: false })
      .limit(200);
    if (error) throw new Error("Não consegui carregar os documentos.");
    return data ?? [];
  });

export const createKnowledgeDocument = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        title: z.string().trim().min(2).max(160),
        baseType: baseEnum,
        product: productEnum.nullable().optional(),
        storagePath: z.string().trim().max(400).nullable().optional(),
        source: z.string().trim().max(200).nullable().optional(),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: row, error } = await context.supabase
      .from("knowledge_documents")
      .insert({
        title: data.title,
        base_type: data.baseType,
        product: data.product ?? null,
        storage_path: data.storagePath ?? null,
        source: data.source ?? null,
      })
      .select("id")
      .single();
    if (error) throw new Error("Não consegui cadastrar o documento.");
    return row;
  });

export const setDocumentApproval = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ id: z.string().uuid(), approved: z.boolean() }).parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { error } = await context.supabase
      .from("knowledge_documents")
      .update({
        approved: data.approved,
        status: data.approved ? ("approved" as const) : ("pending" as const),
        updated_at: new Date().toISOString(),
      })
      .eq("id", data.id);
    if (error) throw new Error("Não consegui atualizar o documento.");
    const { error: chunkError } = await context.supabase
      .from("knowledge_chunks")
      .update({ approved: data.approved })
      .eq("document_id", data.id);
    if (chunkError) throw new Error("Não consegui atualizar os trechos do documento.");
    return { ok: true };
  });

export const deleteKnowledgeDocument = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ id: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { error } = await context.supabase.from("knowledge_documents").delete().eq("id", data.id);
    if (error) throw new Error("Não consegui remover o documento.");
    return { ok: true };
  });

export const getAdminStatus = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    const { data } = await context.supabase.rpc("has_role", {
      _user_id: context.userId,
      _role: "admin",
    });
    return { isAdmin: Boolean(data) };
  });

type SessionRow = {
  user_id: string;
  device_id: string;
  ip: string | null;
  started_at: string;
  last_seen_at: string;
};

function sharingLevel(devices: number, ips: number, overlaps: number) {
  if (overlaps > 0 || devices >= 4 || ips >= 6) return "provável compartilhamento" as const;
  if (devices >= 2 || ips >= 3) return "atenção" as const;
  return "baixo" as const;
}

function countOverlaps(rows: SessionRow[]) {
  let overlaps = 0;
  for (let i = 0; i < rows.length; i++) {
    for (let j = i + 1; j < rows.length; j++) {
      const a = rows[i]!;
      const b = rows[j]!;
      if (a.device_id === b.device_id) continue;
      const aStart = new Date(a.started_at).getTime();
      const aEnd = new Date(a.last_seen_at).getTime();
      const bStart = new Date(b.started_at).getTime();
      const bEnd = new Date(b.last_seen_at).getTime();
      if (aStart < bEnd && bStart < aEnd) overlaps++;
    }
  }
  return overlaps;
}

export const listStudentAccess = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        page: z.number().int().min(0).default(0),
        pageSize: z.number().int().min(10).max(200).default(50),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const from = data.page * data.pageSize;

    const { data: profiles, count } = await context.supabase
      .from("profiles")
      .select("id, name, email, created_at", { count: "exact" })
      .order("created_at", { ascending: false })
      .range(from, from + data.pageSize - 1);

    const ids = (profiles ?? []).map((p: { id: string }) => p.id);
    if (ids.length === 0) {
      return { rows: [], total: count ?? 0, page: data.page, pageSize: data.pageSize };
    }

    const [sessions, messages] = await Promise.all([
      fetchAll<SessionRow>((a, b) =>
        context.supabase
          .from("access_sessions")
          .select("user_id, device_id, ip, started_at, last_seen_at")
          .in("user_id", ids)
          .order("last_seen_at", { ascending: false })
          .range(a, b),
      ),
      fetchAll<{ user_id: string; role: string }>((a, b) =>
        context.supabase.from("messages").select("user_id, role").in("user_id", ids).eq("role", "user").order("id").range(a, b),
      ),
    ]);

    const byUser = new Map<string, SessionRow[]>();
    for (const row of (sessions ?? []) as SessionRow[]) {
      const list = byUser.get(row.user_id) ?? [];
      list.push(row);
      byUser.set(row.user_id, list);
    }

    const msgCount = new Map<string, number>();
    for (const m of messages ?? []) {
      if (m.role !== "user") continue;
      msgCount.set(m.user_id, (msgCount.get(m.user_id) ?? 0) + 1);
    }

    return {
      total: count ?? ids.length,
      page: data.page,
      pageSize: data.pageSize,
      rows: (profiles ?? []).map((p) => {
        const rows = byUser.get(p.id) ?? [];
        const devices = new Set(rows.map((r) => r.device_id)).size;
        const ips = new Set(rows.map((r) => r.ip).filter(Boolean)).size;
        const totalMinutes = Math.round(
          rows.reduce(
            (acc, r) =>
              acc +
              Math.max(0, new Date(r.last_seen_at).getTime() - new Date(r.started_at).getTime()),
            0,
          ) / 60000,
        );
        const overlaps = countOverlaps(rows);
        return {
          userId: p.id,
          name: p.name,
          email: p.email,
          createdAt: p.created_at,
          sessions: rows.length,
          firstAccess: rows.length ? rows[rows.length - 1]!.started_at : null,
          lastAccess: rows.length ? rows[0]!.last_seen_at : null,
          totalMinutes,
          devices,
          ips,
          messages: msgCount.get(p.id) ?? 0,
          sharing: sharingLevel(devices, ips, overlaps),
        };
      }),
    };
  });

export const getStudentAccessDetail = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ userId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);

    const [{ data: profile }, { data: sessions }, { data: messages }] = await Promise.all([
      context.supabase
        .from("profiles")
        .select("id, name, email, created_at")
        .eq("id", data.userId)
        .maybeSingle(),
      context.supabase
        .from("access_sessions")
        .select("id, device_id, ip, ip_city, ip_country, user_agent, started_at, last_seen_at")
        .eq("user_id", data.userId)
        .order("last_seen_at", { ascending: false })
        .limit(200),
      context.supabase
        .from("messages")
        .select("id, role, content, created_at")
        .eq("user_id", data.userId)
        .order("created_at", { ascending: true })
        .limit(500),
    ]);

    return { profile, sessions: sessions ?? [], messages: messages ?? [] };
  });
