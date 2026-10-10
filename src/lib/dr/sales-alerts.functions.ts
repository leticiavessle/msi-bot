import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { groupSalesAlerts, type SalesAlertRow } from "./sales-alert";
import { PRODUCT_LABELS } from "./config";

async function assertAdmin(context: { supabase: any; userId: string }) {
  const { data, error } = await context.supabase.rpc("has_role", { _user_id: context.userId, _role: "admin" });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

const PRODUCT_LABEL: Record<string, string> = PRODUCT_LABELS;

async function loadRows(sb: any): Promise<SalesAlertRow[]> {
  const out: SalesAlertRow[] = [];
  for (let from = 0; ; from += 1000) {
    const { data, error } = await sb.from("sales_alerts").select("*").order("created_at", { ascending: false }).range(from, from + 999);
    if (error) throw new Error(error.message);
    out.push(...(data ?? []));
    if (!data || data.length < 1000) break;
  }
  return out;
}

export const countSalesAlerts = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    return groupSalesAlerts(await loadRows(context.supabase), "pending").length;
  });

export const listSalesAlerts = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ view: z.enum(["pending", "resolved"]) }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const sb = context.supabase;
    const people = groupSalesAlerts(await loadRows(sb), data.view);
    const ids = [...new Set([...people.map((p) => p.userId), ...people.map((p) => p.resolvedBy).filter(Boolean) as string[]])];
    const profiles = new Map<string, { name: string | null; email: string | null }>();
    for (let i = 0; i < ids.length; i += 300) {
      const { data: ps } = await sb.from("profiles").select("id, name, email").in("id", ids.slice(i, i + 300));
      for (const p of ps ?? []) profiles.set(p.id, { name: p.name, email: p.email });
    }
    const owned = new Map<string, string[]>();
    const userIds = people.map((p) => p.userId);
    for (let i = 0; i < userIds.length; i += 300) {
      const { data: ups } = await sb.from("user_products").select("user_id, product").eq("active", true).in("user_id", userIds.slice(i, i + 300));
      for (const u of ups ?? []) owned.set(u.user_id, [...(owned.get(u.user_id) ?? []), u.product]);
    }
    return people.map((p) => {
      const prof = profiles.get(p.userId);
      return {
        ...p,
        name: prof?.name ?? null,
        email: prof?.email ?? null,
        asked: p.askedProducts.map((x) => PRODUCT_LABEL[x] ?? x),
        owned: (owned.get(p.userId) ?? []).map((x) => PRODUCT_LABEL[x] ?? x),
        resolvedByName: p.resolvedBy ? profiles.get(p.resolvedBy)?.name ?? profiles.get(p.resolvedBy)?.email ?? null : null,
      };
    });
  });

export const setSalesAlertHandled = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((d: unknown) => z.object({ userId: z.string().uuid(), undo: z.boolean() }).parse(d))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    if (!data.undo) {
      const { error } = await supabaseAdmin.from("sales_alerts")
        .update({ status: "resolved", resolved_by: context.userId, resolved_at: now })
        .eq("user_id", data.userId).eq("status", "pending");
      if (error) throw new Error("Não consegui marcar.");
    } else {
      const { data: last } = await supabaseAdmin.from("sales_alerts").select("resolved_at")
        .eq("user_id", data.userId).eq("status", "resolved").order("resolved_at", { ascending: false }).limit(1).maybeSingle();
      if (!last?.resolved_at) throw new Error("Nada para desfazer.");
      const { error } = await supabaseAdmin.from("sales_alerts")
        .update({ status: "pending", resolved_by: null, resolved_at: null })
        .eq("user_id", data.userId).eq("resolved_at", last.resolved_at);
      if (error) throw new Error("Não consegui desfazer.");
    }
    await supabaseAdmin.from("audit_logs").insert({
      admin_user_id: context.userId,
      action: data.undo ? "venda_contato_desfeito" : "venda_contato_feito",
      target_user_id: data.userId,
      metadata: { at: now },
    });
    return { ok: true };
  });
