import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { groupAccessAlerts, type AccessAlertRow } from "./access-alert";
import { PRODUCT_LABELS } from "./config";

async function assertAdmin(context: { supabase: any; userId: string }) {
  const { data, error } = await context.supabase.rpc("has_role", { _user_id: context.userId, _role: "admin" });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

const PRODUCT_LABEL: Record<string, string> = PRODUCT_LABELS;
const SOURCE_LABEL: Record<string, string> = {
  webhook: "Hubla", cademi: "Cademí", payt: "Payt", lastlink: "LastLink", import: "planilha", manual: "manual", seed: "manual",
};

async function loadRows(sb: any): Promise<AccessAlertRow[]> {
  const out: AccessAlertRow[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await sb.from("access_alerts").select("*").order("created_at", { ascending: false }).range(from, from + 999);
    if (error) throw new Error(error.message);
    out.push(...(data ?? []));
    if (!data || data.length < 1000) break;
  }
  return out;
}

export const countAccessAlerts = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    // Inclui os avisos da entrada no bot (mesma aba Acessos).
    const { count } = await context.supabase
      .from("identificacao_alertas")
      .select("id", { count: "exact", head: true })
      .eq("status", "pending");
    return groupAccessAlerts(await loadRows(context.supabase), "pending").length + (count ?? 0);
  });

export const listAccessAlerts = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ view: z.enum(["pending", "resolved"]) }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const sb = context.supabase;
    const people = groupAccessAlerts(await loadRows(sb), data.view);
    const ids = [...new Set([...people.map((p) => p.userId), ...people.map((p) => p.resolvedBy).filter(Boolean) as string[]])];
    const profiles = new Map<string, { name: string | null; email: string | null }>();
    for (let i = 0; i < ids.length; i += 300) {
      const { data: ps } = await sb.from("profiles").select("id, name, email").in("id", ids.slice(i, i + 300));
      for (const p of ps ?? []) profiles.set(p.id, { name: p.name, email: p.email });
    }
    const emails = [...new Set(people.map((p) => profiles.get(p.userId)?.email?.toLowerCase()).filter(Boolean) as string[])];
    const auth = new Map<string, any>();
    for (let i = 0; i < emails.length; i += 300) {
      const { data: au } = await sb.from("authorized_users")
        .select("email, status, product_access, access_source, metadata").in("email", emails.slice(i, i + 300));
      for (const a of au ?? []) auth.set(String(a.email).toLowerCase(), a);
    }
    return people.map((p) => {
      const prof = profiles.get(p.userId);
      const a = prof?.email ? auth.get(prof.email.toLowerCase()) : null;
      const meta = (a?.metadata ?? {}) as Record<string, unknown>;
      const first = (meta["cademi_first_access_at"] ?? meta["primeiro_acesso_em"] ?? null) as string | null;
      return {
        ...p,
        name: prof?.name ?? null,
        email: prof?.email ?? null,
        authorized: Boolean(a),
        authStatus: (a?.status as string | undefined) ?? null,
        products: ((a?.product_access ?? []) as string[]).map((x) => PRODUCT_LABEL[x] ?? x),
        source: a ? SOURCE_LABEL[a.access_source] ?? a.access_source : null,
        cademiFirstAccess: first,
        resolvedByName: p.resolvedBy ? profiles.get(p.resolvedBy)?.name ?? profiles.get(p.resolvedBy)?.email ?? null : null,
      };
    });
  });

export const setAccessResent = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ userId: z.string().uuid(), undo: z.boolean() }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    if (!data.undo) {
      const { error } = await supabaseAdmin.from("access_alerts")
        .update({ status: "resolved", resolved_by: context.userId, resolved_at: now })
        .eq("user_id", data.userId).eq("status", "pending");
      if (error) throw new Error("Não consegui marcar.");
    } else {
      const { data: last } = await supabaseAdmin.from("access_alerts").select("resolved_at")
        .eq("user_id", data.userId).eq("status", "resolved").order("resolved_at", { ascending: false }).limit(1).maybeSingle();
      if (!last?.resolved_at) throw new Error("Nada para desfazer.");
      const { error } = await supabaseAdmin.from("access_alerts")
        .update({ status: "pending", resolved_by: null, resolved_at: null })
        .eq("user_id", data.userId).eq("resolved_at", last.resolved_at);
      if (error) throw new Error("Não consegui desfazer.");
    }
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: data.undo ? "acesso_reenviado_desfeito" : "acesso_reenviado",
      target_user_id: data.userId,
      metadata: { at: now },
    });
    return { ok: true };
  });
