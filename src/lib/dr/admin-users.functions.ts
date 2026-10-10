import { fetchAll } from "./paging";
import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { assertAdmin, audit, ONLINE_WINDOW_MS } from "./admin-guard";
import { PRODUCTS, PRODUTO_PADRAO } from "./config";
import { dadosDeReserva, juntarDadosDeReserva, normalizarCpf } from "./identificacao";

const productEnum = z.enum(PRODUCTS);
const statusEnum = z.enum(["active", "blocked", "refunded", "canceled"]);
const roleEnum = z.enum(["admin", "student"]);

const upsertSchema = z.object({
  id: z.string().uuid().nullable().optional(),
  email: z.string().trim().toLowerCase().email().max(255),
  name: z.string().trim().max(120).nullable().optional(),
  role: roleEnum.default("student"),
  status: statusEnum.default("active"),
  products: z.array(productEnum).max(PRODUCTS.length).default([PRODUTO_PADRAO]),
  accessExpiresAt: z.string().datetime().nullable().optional(),
});

const listSchema = z.object({
  page: z.number().int().min(0).default(0),
  pageSize: z.number().int().min(10).max(200).default(50),
  search: z.string().trim().max(120).optional(),
  paytProvisional: z.boolean().optional(),
  product: z.enum(PRODUCTS as unknown as [string, ...string[]]).optional(),
  productOrigin: z.enum(["confirmado", "padrao", "incerto"]).optional(),
  source: z.enum(["webhook", "cademi", "payt", "lastlink", "import", "manual", "seed"]).optional(),
});

/** Quantos alunos ativos estão com a etiqueta "payt provisório". */
export const countPaytProvisional = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { count } = await context.supabase
      .from("authorized_users")
      .select("id", { count: "exact", head: true })
      .contains("metadata", { payt_provisional: true })
      .eq("status", "active");
    return { count: count ?? 0 };
  });

/** Desativa de uma vez todo o grupo "payt provisório" (sem apagar cadastro). */
export const revokeAllPaytProvisional = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const now = new Date().toISOString();
    let revoked = 0;
    for (let guard = 0; guard < 200; guard++) {
      const { data: rows, error } = await supabaseAdmin
        .from("authorized_users")
        .select("id, email, role, status, metadata")
        .contains("metadata", { payt_provisional: true })
        .eq("status", "active")
        .neq("role", "admin")
        .limit(500);
      if (error) throw new Error("Não consegui ler o grupo Payt provisório.");
      if (!rows || rows.length === 0) break;
      for (const r of rows) {
        const meta = { ...((r.metadata as Record<string, unknown> | null) ?? {}) };
        const history = Array.isArray(meta["access_history"])
          ? [...(meta["access_history"] as unknown[])]
          : [];
        history.push({
          action: "revoked_payt_provisional",
          reason: "Revogar todos (Payt provisório)",
          at: now,
          by: context.userId,
          previous_status: r.status,
        });
        meta["access_history"] = history;
        meta["payt_provisional_revoked_at"] = now;
        await supabaseAdmin
          .from("authorized_users")
          .update({ status: "blocked", metadata: meta as never })
          .eq("id", r.id);
      }
      const emails = rows.map((r) => r.email.toLowerCase());
      const { data: profiles } = await supabaseAdmin.from("profiles").select("id").in("email", emails);
      const ids = (profiles ?? []).map((p) => p.id);
      if (ids.length) {
        await supabaseAdmin.from("user_products").update({ active: false }).in("user_id", ids);
        await supabaseAdmin
          .from("access_sessions")
          .update({ revoked_at: now })
          .in("user_id", ids)
          .is("revoked_at", null);
      }
      revoked += rows.length;
    }
    await audit(context, "payt_provisional_revoked_all", { metadata: { revoked } });
    return { revoked };
  });

/** Lista paginada de alunos autorizados com métricas de uso e presença. */
export const listAuthorizedUsers = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => listSchema.parse(data ?? {}))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabase } = context;
    const from = data.page * data.pageSize;
    const to = from + data.pageSize - 1;

    let query = supabase
      .from("authorized_users")
      .select(
        "id, email, name, role, status, product_access, access_source, product_origin, access_expires_at, last_login_at, created_at",
        { count: "exact" },
      )
      .order("created_at", { ascending: false })
      .range(from, to);

    const search = data.search?.trim();
    if (search) {
      const term = search.replace(/[%,()]/g, " ").trim();
      // Número (8+ dígitos) também procura no WhatsApp da compra; e-mail também nos e-mails antigos.
      const digitos = term.replace(/\D+/g, "");
      const cpf = normalizarCpf(term);
      const extra = [
        ...(cpf ? [`cpf.eq.${cpf}`] : []),
        ...(digitos.length >= 8 && digitos.length === term.replace(/[\s()+-]/g, "").length ? [`telefone.ilike.%${digitos.slice(-8)}%`] : []),
        ...(term.includes("@") ? [`emails_anteriores.cs.{${term.toLowerCase()}}`] : []),
      ];
      query = query.or([`email.ilike.%${term}%`, `name.ilike.%${term}%`, ...extra].join(","));
    }
    if (data.paytProvisional) {
      query = query.contains("metadata", { payt_provisional: true }).eq("status", "active");
    }
    if (data.product) query = query.contains("product_access", [data.product as never]);
    if (data.productOrigin) query = query.eq("product_origin", data.productOrigin);
    if (data.source) query = query.eq("access_source", data.source as never);

    const { data: authorized, count } = await query;
    const rows = authorized ?? [];
    const emails = rows.map((r) => r.email.toLowerCase());

    if (emails.length === 0) {
      return { rows: [], total: count ?? 0, page: data.page, pageSize: data.pageSize };
    }

    const { data: profiles } = await supabase
      .from("profiles")
      .select("id, email, name")
      .in("email", emails);

    const profileByEmail = new Map(
      (profiles ?? []).map((p) => [String(p.email ?? "").toLowerCase(), p]),
    );
    const userIds = (profiles ?? []).map((p) => p.id);

    const [sessions, messages, alerts] =
      userIds.length > 0
        ? await Promise.all([
            fetchAll<{ user_id: string; last_seen_at: string; revoked_at: string | null }>((a, b) =>
              supabase.from("access_sessions").select("user_id, last_seen_at, revoked_at").in("user_id", userIds).order("id").range(a, b),
            ),
            fetchAll<{ user_id: string; role: string }>((a, b) =>
              supabase.from("messages").select("user_id, role").in("user_id", userIds).eq("role", "user").order("id").range(a, b),
            ),
            fetchAll<{ user_id: string; risk_level: string; status: string }>((a, b) =>
              supabase.from("risk_alerts").select("user_id, risk_level, status").in("user_id", userIds).order("id").range(a, b),
            ),
          ])
        : [[], [], []];

    const lastSeen = new Map<string, string>();
    for (const s of sessions ?? []) {
      if (s.revoked_at) continue;
      const current = lastSeen.get(s.user_id);
      if (!current || s.last_seen_at > current) lastSeen.set(s.user_id, s.last_seen_at);
    }

    const msgCount = new Map<string, number>();
    for (const m of messages ?? []) {
      if (m.role !== "user") continue;
      msgCount.set(m.user_id, (msgCount.get(m.user_id) ?? 0) + 1);
    }

    const order = { low: 0, medium: 1, high: 2, critical: 3 } as const;
    const risk = new Map<string, keyof typeof order>();
    for (const a of alerts ?? []) {
      if (a.status !== "pending") continue;
      const level = a.risk_level as keyof typeof order;
      const current = risk.get(a.user_id);
      if (!current || order[level] > order[current]) risk.set(a.user_id, level);
    }

    const now = Date.now();
    return {
      total: count ?? rows.length,
      page: data.page,
      pageSize: data.pageSize,
      rows: rows.map((row) => {
        const profile = profileByEmail.get(row.email.toLowerCase());
        const userId = profile?.id ?? null;
        const seen = userId ? (lastSeen.get(userId) ?? null) : null;
        return {
          ...row,
          userId,
          displayName: row.name ?? profile?.name ?? null,
          lastSeenAt: seen,
          online: Boolean(seen && now - new Date(seen).getTime() < ONLINE_WINDOW_MS),
          messages: userId ? (msgCount.get(userId) ?? 0) : 0,
          risk: userId ? (risk.get(userId) ?? "low") : "low",
        };
      }),
    };
  });

/** Últimas tentativas de login recusadas (audit_logs action = login_denied). */
export const listLoginDenied = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ search: z.string().trim().max(120).optional() }).parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    let query = context.supabase
      .from("audit_logs")
      .select("id, target_email, metadata, created_at")
      .eq("action", "login_denied")
      .order("created_at", { ascending: false })
      .limit(100);
    const search = data.search?.trim();
    if (search) query = query.ilike("target_email", `%${search.replace(/[%,()]/g, " ").trim()}%`);
    const { data: rows } = await query;
    return (rows ?? []).map((r) => ({
      id: r.id,
      email: r.target_email,
      reason: String((r.metadata as Record<string, unknown> | null)?.["reason"] ?? "desconhecido"),
      createdAt: r.created_at,
    }));
  });

/** Eventos de webhook (paginado, com filtro de erro). */
export const listWebhookEvents = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        page: z.number().int().min(0).default(0),
        pageSize: z.number().int().min(10).max(200).default(50),
        onlyErrors: z.boolean().default(false),
        provider: z.string().max(40).optional(),
      })
      .parse(data ?? {}),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const from = data.page * data.pageSize;
    let query = context.supabase
      .from("webhook_events")
      .select(
        "id, provider, event_type, external_event_id, payload, processed, processing_error, created_at",
        { count: "exact" },
      )
      .order("created_at", { ascending: false })
      .range(from, from + data.pageSize - 1);
    if (data.onlyErrors) query = query.not("processing_error", "is", null);
    if (data.provider) query = query.eq("provider", data.provider);

    const { data: rows, count } = await query;
    const { ADAPTERS } = await import("./webhooks.server");

    return {
      total: count ?? 0,
      page: data.page,
      pageSize: data.pageSize,
      rows: (rows ?? []).map((row) => {
        const payload = (row.payload ?? {}) as Record<string, unknown>;
        const adapter = ADAPTERS[row.provider];
        const normalized = adapter ? adapter.parse(payload) : null;
        return {
          id: row.id,
          provider: row.provider,
          eventType: row.event_type,
          email: normalized?.email ?? null,
          product: normalized?.product ?? null,
          processed: row.processed,
          error: row.processing_error,
          createdAt: row.created_at,
          payload: JSON.stringify(payload, null, 2),
        };
      }),
    };
  });

/** Reprocessa um evento de webhook já gravado (usa os adapters atuais). */
export const reprocessWebhookEvent = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ id: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { processWebhookEvent } = await import("./webhooks.server");

    const { data: row } = await supabaseAdmin
      .from("webhook_events")
      .select("id, provider, payload")
      .eq("id", data.id)
      .maybeSingle();
    if (!row) return { ok: false, reason: "evento não encontrado" };

    const result = await processWebhookEvent(
      supabaseAdmin,
      row.provider,
      (row.payload ?? {}) as Record<string, unknown>,
      row.id,
    );
    await audit(context, "webhook_reprocessed", {
      targetEmail: "email" in result ? (result.email ?? null) : null,
      metadata: { provider: row.provider },
    });
    return { ok: result.ok, reason: result.reason ?? null };
  });

/** Nomes de produto externos que chegaram por webhook (tela de mapeamento). */
export const listProductNames = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data } = await context.supabase
      .from("webhook_product_names")
      .select("id, provider, name, mapped_to, last_email, pending_count, updated_at")
      .order("updated_at", { ascending: false })
      .limit(500);
    return data ?? [];
  });

/** Define o mapeamento e reprocessa os eventos pendentes daquele nome. */
export const mapProductName = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        id: z.string().uuid(),
        mappedTo: z.union([productEnum, z.literal("ignore")]),
        reprocess: z.boolean().default(true),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { processWebhookEvent } = await import("./webhooks.server");
    const { data: row } = await supabaseAdmin
      .from("webhook_product_names")
      .update({ mapped_to: data.mappedTo, updated_at: new Date().toISOString() })
      .eq("id", data.id)
      .select("provider, name")
      .single();
    if (!row) return { ok: false, reprocessed: 0, granted: 0 };
    await audit(context, "webhook_product_mapped", {
      metadata: { provider: row.provider, name: row.name, mapped_to: data.mappedTo },
    });
    if (!data.reprocess) return { ok: true, reprocessed: 0, granted: 0 };

    const { data: pending } = await supabaseAdmin
      .from("webhook_events")
      .select("id, payload")
      .eq("provider", row.provider)
      .eq("processing_error", "produto não mapeado")
      .order("created_at", { ascending: true })
      .limit(500);
    let reprocessed = 0;
    let granted = 0;
    const { ADAPTERS } = await import("./webhooks.server");
    for (const ev of pending ?? []) {
      const payload = (ev.payload ?? {}) as Record<string, unknown>;
      const parsed = ADAPTERS[row.provider]?.parse(payload);
      if (parsed?.unmappedProductName !== row.name) continue;
      const result = await processWebhookEvent(supabaseAdmin, row.provider, payload, ev.id);
      reprocessed++;
      if (result.ok) granted++;
    }
    await supabaseAdmin
      .from("webhook_product_names")
      .update({ pending_count: 0 })
      .eq("id", data.id);
    return { ok: true, reprocessed, granted };
  });

export const upsertAuthorizedUser = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => upsertSchema.parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { data: antigo } = await context.supabase
      .from("authorized_users")
      .select("email")
      .contains("emails_anteriores", [data.email])
      .limit(1);
    if (antigo?.length && antigo[0]!.email !== data.email) {
      throw new Error(`Esse e-mail foi trocado para ${antigo[0]!.email}. Edite aquele cadastro.`);
    }
    const payload = {
      email: data.email,
      name: data.name ?? null,
      role: data.role,
      status: data.status,
      product_access: data.products,
      access_expires_at: data.accessExpiresAt ?? null,
    };

    const { error } = await context.supabase
      .from("authorized_users")
      .upsert(payload as never, { onConflict: "email" });
    if (error) throw new Error("Não consegui salvar o aluno.");

    await syncExistingAccount(context, data.email, data.role, data.products, data.status);
    await audit(context, data.id ? "user_updated" : "user_created", {
      targetEmail: data.email,
      metadata: { role: data.role, status: data.status, products: data.products },
    });
    return { ok: true };
  });

export const importAuthorizedUsers = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        source: z.enum(["hubla", "simples", "cademi", "planilha"]).default("simples"),
        /** completar = só preenche CPF, WhatsApp e nome de quem já tem cadastro (não libera acesso). */
        modo: z.enum(["liberar", "completar"]).default("liberar"),
        rows: z
          .array(
            z.object({
              email: z
                .string()
                .trim()
                .toLowerCase()
                .max(255)
                .regex(/^[^\s@]+@[^\s@]+\.[^\s@]+$/),
              name: z.string().trim().max(120).optional().nullable(),
              products: z.array(productEnum).max(PRODUCTS.length).optional(),
              status: statusEnum.optional(),
              enteredAt: z.string().trim().max(40).optional().nullable(),
              cpf: z.string().regex(/^\d{11}$/).optional().nullable(),
              telefone: z.string().regex(/^\d{10,15}$/).optional().nullable(),
            }),
          )
          .min(1)
          .max(500),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);

    const emails = data.rows.map((r) => r.email);
    const campos = "email, name, role, status, product_access, metadata, product_origin, cpf, telefone, emails_anteriores";
    const [{ data: existing, error: exErr }, { data: antigos }, { data: grants }] = await Promise.all([
      context.supabase.from("authorized_users").select(campos).in("email", emails),
      // E-mail trocado pela equipe: a linha da planilha com o e-mail antigo atualiza o cadastro atual.
      context.supabase.from("authorized_users").select(campos).overlaps("emails_anteriores", emails),
      context.supabase.from("product_access_grants").select("email, hubla_status").in("email", emails),
    ]);
    if (exErr) throw new Error("Não consegui ler os alunos existentes.");
    const byEmail = new Map((existing ?? []).map((e) => [e.email.toLowerCase(), e]));
    for (const atual of antigos ?? []) {
      for (const antigo of atual.emails_anteriores ?? []) {
        if (!byEmail.has(antigo.toLowerCase())) byEmail.set(antigo.toLowerCase(), atual);
      }
    }
    const hublaRevoked = new Set(
      (grants ?? [])
        .filter((g) => /refund|reembols|chargeback|estorn|cancel/i.test(g.hubla_status ?? ""))
        .map((g) => g.email.toLowerCase()),
    );

    const refused: { email: string; reason: string }[] = [];
    const ignored: { email: string; reason: string }[] = [];
    const inserts: Record<string, unknown>[] = [];
    const updates: Record<string, unknown>[] = [];

    const destinos = new Set<string>();
    for (const r of data.rows) {
      const cur = byEmail.get(r.email);
      // O e-mail antigo e o novo da mesma pessoa no mesmo lote: um só cadastro.
      const destino = (cur?.email ?? r.email).toLowerCase();
      if (destinos.has(destino)) {
        ignored.push({ email: r.email, reason: "mesmo cadastro já está na lista (e-mail trocado)" });
        continue;
      }
      destinos.add(destino);
      const curProducts = (cur?.product_access ?? []) as string[];
      const meta = { ...((cur?.metadata as Record<string, unknown> | null) ?? {}) };
      // CPF e WhatsApp: a planilha só preenche o que falta (o webhook, mais novo, vence).
      const reserva = juntarDadosDeReserva(cur, dadosDeReserva(r.cpf, r.telefone), { telefoneNovoVence: false });
      const reservaMudou = reserva.cpf !== (cur?.cpf ?? null) || reserva.telefone !== (cur?.telefone ?? null);

      if (data.modo === "completar") {
        const needsName = !cur?.name && !!r.name;
        if (!cur) ignored.push({ email: r.email, reason: "sem cadastro (só completar dados)" });
        else if (!reservaMudou && !needsName) ignored.push({ email: r.email, reason: "nada novo para completar" });
        else
          updates.push({
            email: cur.email,
            name: cur.name ?? r.name ?? null,
            role: cur.role,
            status: cur.status,
            product_access: curProducts,
            metadata: meta,
            product_origin: cur.product_origin,
            ...reserva,
          });
        continue;
      }
      if (data.source === "cademi" && r.enteredAt && !meta["cademi_entered_at"]) {
        meta["cademi_entered_at"] = r.enteredAt;
      }

      if (data.source === "cademi") {
        if (cur?.status === "refunded" || hublaRevoked.has(r.email)) {
          refused.push({ email: r.email, reason: "reembolso/chargeback registrado" });
          continue;
        }
        if (cur?.status === "blocked") {
          refused.push({ email: r.email, reason: "bloqueado manualmente" });
          continue;
        }
        if (!cur) {
          inserts.push({
            email: r.email,
            name: r.name ?? null,
            role: "student",
            status: "active",
            product_access: [PRODUTO_PADRAO],
            access_source: "cademi",
            product_origin: "padrao",
            metadata: meta,
            ...reserva,
          });
          continue;
        }
        const needsAccess = curProducts.length === 0 || cur.status !== "active";
        const needsMeta = meta["cademi_entered_at"] !== (cur.metadata as Record<string, unknown> | null)?.["cademi_entered_at"];
        const needsName = !cur.name && !!r.name;
        if (!needsAccess && !needsMeta && !needsName && !reservaMudou) {
          ignored.push({ email: r.email, reason: "já tinha acesso" });
          continue;
        }
        updates.push({
          email: cur.email,
          name: cur.name ?? r.name ?? null,
          role: cur.role,
          status: "active",
          product_access: curProducts.length ? curProducts : [PRODUTO_PADRAO],
          metadata: meta,
          product_origin: cur.product_origin,
          ...reserva,
        });
        continue;
      }

      // Planilha nunca reativa reembolso/chargeback nem bloqueio manual.
      if (cur && (cur.status === "refunded" || hublaRevoked.has(r.email))) {
        refused.push({ email: r.email, reason: "reembolso/chargeback registrado" });
        continue;
      }
      if (cur?.status === "blocked") {
        refused.push({ email: r.email, reason: "bloqueado (só reativa pelo painel)" });
        continue;
      }
      if (!cur && hublaRevoked.has(r.email)) {
        refused.push({ email: r.email, reason: "reembolso/chargeback registrado" });
        continue;
      }
      // Hubla / simples: nunca remove produtos já existentes.
      const merged = [...new Set([...curProducts, ...(r.products?.length ? r.products : [PRODUTO_PADRAO])])];
      // Hubla (coluna de produto) e planilha com produtos preenchidos confirmam o produto.
      const origin =
        cur?.product_origin === "confirmado" || r.products?.length ? "confirmado" : (cur?.product_origin ?? "padrao");
      const row = {
        product_origin: origin,
        email: cur?.email ?? r.email,
        name: r.name ?? cur?.name ?? null,
        role: (cur?.role ?? "student") as "admin" | "student",
        status: r.status ?? ("active" as const),
        product_access: merged,
        metadata: meta,
        ...reserva,
      };
      if (cur) updates.push(row);
      else inserts.push({ ...row, access_source: "import" });
    }

    if (inserts.length) {
      const { error } = await context.supabase
        .from("authorized_users")
        .upsert(inserts as never, { onConflict: "email" });
      if (error) throw new Error("Não consegui importar a lista.");
    }
    if (updates.length) {
      const { error } = await context.supabase
        .from("authorized_users")
        .upsert(updates as never, { onConflict: "email" });
      if (error) throw new Error("Não consegui atualizar a lista.");
    }

    for (const row of [...inserts, ...updates]) {
      if (row["status"] !== "active") await revokeByEmail(String(row["email"]));
    }

    await audit(context, "users_imported", {
      metadata: {
        source: data.source,
        count: data.rows.length,
        created: inserts.length,
        updated: updates.length,
        ignored: ignored.length,
        refused: refused.length,
      },
    });
    return {
      imported: inserts.length + updates.length,
      created: inserts.length,
      updated: updates.length,
      ignored,
      refused,
    };
  });

/** Desativa acessos em lote (CSV email,motivo). Não apaga: status "blocked" + histórico. */
export const revokeAuthorizedUsersCsv = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({
        rows: z
          .array(
            z.object({
              email: z.string().trim().toLowerCase().max(255),
              reason: z.string().trim().max(300).default(""),
            }),
          )
          .min(1)
          .max(500),
      })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const emails = [...new Set(data.rows.map((r) => r.email))];
    const { data: existing, error } = await context.supabase
      .from("authorized_users")
      .select("email, name, role, status, product_access, metadata")
      .in("email", emails);
    if (error) throw new Error("Não consegui ler os alunos.");
    const byEmail = new Map((existing ?? []).map((e) => [e.email.toLowerCase(), e]));
    const now = new Date().toISOString();
    const notFound: string[] = [];
    const alreadyInactive: string[] = [];
    const updates: Record<string, unknown>[] = [];
    const seen = new Set<string>();

    for (const r of data.rows) {
      if (seen.has(r.email)) continue;
      seen.add(r.email);
      const cur = byEmail.get(r.email);
      if (!cur) {
        notFound.push(r.email);
        continue;
      }
      if (cur.status !== "active") {
        alreadyInactive.push(r.email);
        continue;
      }
      if (cur.role === "admin") {
        alreadyInactive.push(r.email);
        continue;
      }
      const meta = { ...((cur.metadata as Record<string, unknown> | null) ?? {}) };
      const history = Array.isArray(meta["access_history"]) ? [...(meta["access_history"] as unknown[])] : [];
      history.push({
        action: "revoked_csv",
        reason: r.reason || "sem motivo",
        at: now,
        by: context.userId,
        previous_status: cur.status,
      });
      meta["access_history"] = history;
      updates.push({
        email: cur.email,
        name: cur.name,
        role: cur.role,
        status: "blocked",
        product_access: cur.product_access,
        metadata: meta,
      });
    }

    if (updates.length) {
      const { error: upErr } = await context.supabase
        .from("authorized_users")
        .upsert(updates as never, { onConflict: "email" });
      if (upErr) throw new Error("Não consegui desativar os acessos.");
      const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
      const { data: profiles } = await supabaseAdmin
        .from("profiles")
        .select("id")
        .in("email", updates.map((u) => String(u["email"])));
      const ids = (profiles ?? []).map((p) => p.id);
      if (ids.length) {
        await supabaseAdmin
          .from("access_sessions")
          .update({ revoked_at: now })
          .in("user_id", ids)
          .is("revoked_at", null);
      }
    }

    await audit(context, "users_revoked_csv", {
      metadata: {
        count: data.rows.length,
        revoked: updates.length,
        not_found: notFound.length,
        already_inactive: alreadyInactive.length,
      },
    });
    return { revoked: updates.length, notFound, alreadyInactive };
  });

export const deleteAuthorizedUser = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z.object({ email: z.string().trim().toLowerCase().email() }).parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { error } = await context.supabase
      .from("authorized_users")
      .delete()
      .eq("email", data.email);
    if (error) throw new Error("Não consegui remover o acesso.");
    await revokeByEmail(data.email);
    await audit(context, "access_revoked", { targetEmail: data.email });
    return { ok: true };
  });

export const revokeUserSessions = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) =>
    z
      .object({ userId: z.string().uuid(), sessionId: z.string().uuid().nullable().optional() })
      .parse(data),
  )
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    let query = supabaseAdmin
      .from("access_sessions")
      .update({ revoked_at: new Date().toISOString() })
      .eq("user_id", data.userId)
      .is("revoked_at", null);
    if (data.sessionId) query = query.eq("id", data.sessionId);
    const { error } = await query;
    if (error) throw new Error("Não consegui revogar a sessão.");
    await audit(context, "session_revoked", {
      targetUserId: data.userId,
      metadata: { sessionId: data.sessionId ?? "all" },
    });
    return { ok: true };
  });

/** Perfil completo do aluno para o painel. */
export const getStudentProfile = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ userId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    const { supabase } = context;
    const userId = data.userId;

    const [
      { data: profile },
      { data: products },
      { data: sessions },
      { data: memory },
      { data: facts },
      { data: alerts },
      { data: conversations },
    ] = await Promise.all([
      supabase
        .from("profiles")
        .select("id, name, email, created_at")
        .eq("id", userId)
        .maybeSingle(),
      supabase.from("user_products").select("product, active").eq("user_id", userId),
      supabase
        .from("access_sessions")
        .select(
          "id, device_id, ip, ip_city, ip_country, user_agent, started_at, last_seen_at, revoked_at",
        )
        .eq("user_id", userId)
        .order("last_seen_at", { ascending: false })
        .limit(100),
      supabase.from("student_memory").select("*").eq("user_id", userId).maybeSingle(),
      supabase
        .from("student_memory_facts")
        .select("key, value, category, confidence, updated_at")
        .eq("user_id", userId),
      supabase
        .from("risk_alerts")
        .select("id, risk_level, reason, trigger_text, status, created_at, resolved_at")
        .eq("user_id", userId)
        .order("created_at", { ascending: false })
        .limit(50),
      supabase
        .from("conversations")
        .select("id, title, status, created_at, updated_at, last_message_at")
        .eq("user_id", userId)
        .order("updated_at", { ascending: false })
        .limit(50),
    ]);

    // Identificação (entrada no bot): o cadastro, os e-mails antigos e por onde ela entrou.
    const { data: cadastro } = profile?.email
      ? await supabase
          .from("authorized_users")
          .select("id, email, cpf, telefone, emails_anteriores")
          .eq("email", profile.email.toLowerCase())
          .maybeSingle()
      : { data: null };
    const { data: entradas } = await supabase
      .from("tentativas_entrada")
      .select("via, device_id, created_at")
      .eq("user_id", userId)
      .eq("resultado", "entrou")
      .order("created_at", { ascending: false })
      .limit(10);

    // Compras ficam no e-mail da compra: inclui os e-mails antigos (trocados pela equipe).
    const emailsDaCompra = profile?.email
      ? [profile.email.toLowerCase(), ...((cadastro?.emails_anteriores ?? []) as string[])]
      : [];
    const { data: grants } = emailsDaCompra.length
      ? await supabase
          .from("product_access_grants")
          .select("product, source, granted_at, hubla_status, hubla_status_at")
          .in("email", emailsDaCompra)
      : { data: [] };

    return {
      profile,
      identificacao: {
        authorizedUserId: cadastro?.id ?? null,
        email: cadastro?.email ?? profile?.email ?? null,
        emailsAnteriores: (cadastro?.emails_anteriores ?? []) as string[],
        cpf: cadastro?.cpf ?? null,
        telefone: cadastro?.telefone ?? null,
        entradas: (entradas ?? []).map((e) => ({ via: e.via, aparelho: e.device_id, em: e.created_at })),
      },
      grants: grants ?? [],
      products: products ?? [],
      sessions: sessions ?? [],
      memory,
      facts: facts ?? [],
      alerts: alerts ?? [],
      conversations: conversations ?? [],
    };
  });

export const getConversationMessages = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => z.object({ conversationId: z.string().uuid() }).parse(data))
  .handler(async ({ data, context }) => {
    await assertAdmin(context);
    type Msg = {
      id: string;
      role: string;
      content: string;
      created_at: string;
      detected_intent: string | null;
    };
    const all: Msg[] = [];
    for (let offset = 0; ; offset += 1000) {
      const { data: messages } = await context.supabase
        .from("messages")
        .select("id, role, content, created_at, detected_intent")
        .eq("conversation_id", data.conversationId)
        .order("created_at", { ascending: true })
        .order("id", { ascending: true })
        .range(offset, offset + 999);
      const page = (messages ?? []) as Msg[];
      all.push(...page);
      if (page.length < 1000) break;
    }
    return all;
  });

export const listAuditLogs = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { data } = await context.supabase
      .from("audit_logs")
      .select("id, action, target_email, target_user_id, metadata, created_at")
      .order("created_at", { ascending: false })
      .limit(200);
    return data ?? [];
  });

/* ---------------- helpers ---------------- */

async function revokeByEmail(email: string) {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  const { revokeSessionsByEmail } = await import("./webhooks.server");
  await revokeSessionsByEmail(supabaseAdmin, email);
}

/** Se o aluno já tem conta, aplica papel/produtos/bloqueio imediatamente. */
async function syncExistingAccount(
  context: { supabase: any; userId: string },
  email: string,
  role: "admin" | "student",
  products: string[],
  status: string,
) {
  const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
  const { data: profile } = await supabaseAdmin
    .from("profiles")
    .select("id")
    .eq("email", email)
    .maybeSingle();
  if (!profile) return;

  if (role === "admin") {
    await supabaseAdmin
      .from("user_roles")
      .upsert({ user_id: profile.id, role: "admin" }, { onConflict: "user_id,role" });
  } else {
    await supabaseAdmin.from("user_roles").delete().eq("user_id", profile.id).eq("role", "admin");
  }

  const { data: current } = await supabaseAdmin
    .from("user_products")
    .select("product")
    .eq("user_id", profile.id);
  const existing = new Set((current ?? []).map((p) => p.product as string));

  for (const product of products) {
    if (existing.has(product)) {
      await supabaseAdmin
        .from("user_products")
        .update({ active: true })
        .eq("user_id", profile.id)
        .eq("product", product as never);
    } else {
      await supabaseAdmin
        .from("user_products")
        .insert({ user_id: profile.id, product: product as never, active: true });
    }
  }
  for (const product of existing) {
    if (!products.includes(product)) {
      await supabaseAdmin
        .from("user_products")
        .update({ active: false })
        .eq("user_id", profile.id)
        .eq("product", product as never);
    }
  }

  if (status !== "active") {
    await supabaseAdmin
      .from("access_sessions")
      .update({ revoked_at: new Date().toISOString() })
      .eq("user_id", profile.id)
      .is("revoked_at", null);
  }
}

/**
 * Cademí: prévia de quem mudaria de produto (só leitura, não altera nada).
 * Lê os eventos da Cademí que já chegaram com produto e compara com o que a
 * pessoa tem hoje. Também conta os avisos "evento sem produto".
 */
export const previewCademiProducts = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    await assertAdmin(context);
    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");
    const { ADAPTERS } = await import("./webhooks.server");
    const since = new Date(Date.now() - 7 * 86400_000).toISOString();
    const [events, missing, pendingIds] = await Promise.all([
      fetchAll<{ payload: unknown; created_at: string }>((a, b) =>
        supabaseAdmin.from("webhook_events").select("payload, created_at").eq("provider", "cademi").order("created_at").range(a, b),
      ),
      supabaseAdmin
        .from("audit_logs")
        .select("created_at", { count: "exact" })
        .eq("action", "cademi_sem_produto")
        .gte("created_at", since)
        .order("created_at", { ascending: false })
        .limit(1),
      supabaseAdmin.from("webhook_product_names").select("name, pending_count, last_email").eq("provider", "cademi").is("mapped_to", null),
    ]);
    const wanted = new Map<string, Set<string>>();
    let withProduct = 0;
    let lastWithProduct: string | null = null;
    for (const ev of events) {
      const n = ADAPTERS["cademi"]?.parse(ev.payload as Record<string, unknown>);
      if (!n?.email || !n.productConfirmed || !n.products?.length) continue;
      withProduct++;
      lastWithProduct = ev.created_at;
      const set = wanted.get(n.email) ?? new Set<string>();
      n.products.forEach((p) => set.add(p));
      wanted.set(n.email, set);
    }
    const emails = [...wanted.keys()];
    const current: { email: string; product_access: string[]; status: string }[] = [];
    for (let i = 0; i < emails.length; i += 200) {
      const { data } = await supabaseAdmin
        .from("authorized_users")
        .select("email, product_access, status")
        .in("email", emails.slice(i, i + 200));
      current.push(...((data ?? []) as never[]));
    }
    const gains: Record<string, number> = {};
    let wouldRemove = 0;
    let people = 0;
    for (const c of current) {
      if (c.status === "refunded") continue;
      const want = wanted.get(c.email)!;
      const add = [...want].filter((p) => !c.product_access.includes(p));
      if (c.product_access.some((p) => !want.has(p))) wouldRemove++;
      if (add.length === 0) continue;
      people++;
      for (const p of add) gains[p] = (gains[p] ?? 0) + 1;
    }
    return {
      eventsWithProduct: withProduct,
      lastWithProduct,
      missingLast7d: missing.count ?? 0,
      lastMissing: missing.data?.[0]?.created_at ?? null,
      pendingIds: pendingIds.data ?? [],
      peopleWouldGain: people,
      gains,
      peopleWithOtherProducts: wouldRemove,
    };
  });
