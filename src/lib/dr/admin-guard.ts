import type { SupabaseClient } from "@supabase/supabase-js";

export type AdminContext = { supabase: SupabaseClient<any, any, any>; userId: string };

/** Revalida o papel de administrador no servidor a cada chamada. */
export async function assertAdmin(context: AdminContext) {
  const { data, error } = await context.supabase.rpc("has_role", {
    _user_id: context.userId,
    _role: "admin",
  });
  if (error || !data) throw new Error("Acesso restrito a administradores.");
}

/** Registra a ação administrativa na auditoria. */
export async function audit(
  context: AdminContext,
  action: string,
  args: {
    targetUserId?: string | null;
    targetEmail?: string | null;
    metadata?: Record<string, unknown>;
  },
) {
  await context.supabase.from("audit_logs").insert({
    admin_user_id: context.userId,
    action,
    target_user_id: args.targetUserId ?? null,
    target_email: args.targetEmail ?? null,
    metadata: (args.metadata ?? {}) as never,
  });
}

export const ONLINE_WINDOW_MS = 2 * 60 * 1000;
