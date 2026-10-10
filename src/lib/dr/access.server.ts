import { getRequest } from "@tanstack/react-start/server";
import type { SupabaseClient } from "@supabase/supabase-js";
import { PRODUCTS, type Product } from "./config";
import type { ViaEntrada } from "./identificacao";

export const SESSION_GAP_MS = 30 * 60 * 1000;

export function readClientMeta() {
  const request = getRequest();
  const headers = request?.headers;
  const forwarded = headers?.get("x-forwarded-for") ?? "";
  const ip =
    forwarded.split(",")[0]?.trim() ||
    headers?.get("cf-connecting-ip") ||
    headers?.get("x-real-ip") ||
    null;

  return {
    ip,
    userAgent: headers?.get("user-agent")?.slice(0, 400) ?? null,
    city: headers?.get("cf-ipcity") ?? null,
    country: headers?.get("cf-ipcountry") ?? null,
  };
}

/**
 * IP para o limite de tentativas. Na Cloudflare, cf-connecting-ip é o endereço real; o primeiro item do
 * x-forwarded-for pode ser inventado por quem faz a chamada.
 */
export function ipConfiavel(): string | null {
  const headers = getRequest()?.headers;
  return headers?.get("cf-connecting-ip") || headers?.get("x-real-ip") || readClientMeta().ip;
}

type Admin = SupabaseClient<any, any, any>;

export type CadastroParaSessao = {
  id: string;
  email: string;
  name: string | null;
  role: "admin" | "student";
  product_access: string[];
};

const FALHA_SESSAO = "Não consegui liberar seu acesso agora. Tente novamente.";

/**
 * Abre a sessão na conta da compra (sem código no e-mail): cria a conta se ainda não existe, gera o token
 * de entrada, garante a ficha e sincroniza papel e produtos. O mesmo caminho para e-mail, CPF, nome e WhatsApp.
 */
export async function abrirSessao(admin: Admin, cadastro: CadastroParaSessao) {
  const email = cadastro.email.toLowerCase();
  const nome = cadastro.name ?? email.split("@")[0] ?? "";

  const { error: createError } = await admin.auth.admin.createUser({
    email,
    email_confirm: true,
    user_metadata: { name: nome },
  });
  if (createError) {
    const message = createError.message.toLowerCase();
    const alreadyExists =
      message.includes("already") || message.includes("registered") || message.includes("exists");
    if (!alreadyExists) {
      console.error("[access] createUser failed", createError.message);
      throw new Error(FALHA_SESSAO);
    }
  }

  const { data: link, error: linkError } = await admin.auth.admin.generateLink({ type: "magiclink", email });
  const tokenHash = link?.properties?.hashed_token;
  if (linkError || !tokenHash) {
    console.error("[access] generateLink failed", linkError?.message);
    throw new Error(FALHA_SESSAO);
  }
  const accountId = link.user?.id;
  if (!accountId) {
    console.error("[access] generated link without user identity");
    throw new Error(FALHA_SESSAO);
  }

  // Garante a ficha do aluno (o painel de Acessos depende dela).
  await admin.from("profiles").upsert({ id: accountId, email, name: cadastro.name ?? nome }, { onConflict: "id" });

  try {
    await syncAuthorizedAccount(
      admin,
      accountId,
      cadastro.role,
      cadastro.product_access.filter((p): p is Product => (PRODUCTS as readonly string[]).includes(p)),
    );
  } catch (error) {
    console.error("[access] account sync failed", error);
    throw new Error(FALHA_SESSAO);
  }

  await admin.from("authorized_users").update({ last_login_at: new Date().toISOString() }).eq("id", cadastro.id);
  return { tokenHash, accountId };
}

/**
 * Por onde a pessoa entrou da última vez (neste aparelho, se souber qual; senão, em qualquer um).
 * Usado na "dupla checagem": quem entrou pelo nome ou WhatsApp não recebe link de acesso direto.
 */
export async function ultimaEntrada(admin: Admin, userId: string, deviceId?: string | null): Promise<ViaEntrada | null> {
  const buscar = async (porAparelho: boolean) => {
    let q = admin
      .from("tentativas_entrada")
      .select("via")
      .eq("user_id", userId)
      .eq("resultado", "entrou")
      .order("created_at", { ascending: false })
      .limit(1);
    if (porAparelho) q = q.eq("device_id", deviceId);
    const { data } = await q.maybeSingle();
    return (data?.via as ViaEntrada | undefined) ?? null;
  };
  if (deviceId) {
    const noAparelho = await buscar(true);
    if (noAparelho) return noAparelho;
  }
  return buscar(false);
}

export async function syncAuthorizedAccount(
  admin: SupabaseClient<any, any, any>,
  userId: string,
  role: "admin" | "student",
  products: Product[],
) {
  const roleQuery =
    role === "admin"
      ? admin
          .from("user_roles")
          .upsert({ user_id: userId, role: "admin" }, { onConflict: "user_id,role" })
      : admin.from("user_roles").delete().eq("user_id", userId).eq("role", "admin");

  const { error: roleError } = await roleQuery;
  if (roleError) throw roleError;

  const { data: currentProducts, error: productsError } = await admin
    .from("user_products")
    .select("product")
    .eq("user_id", userId);
  if (productsError) throw productsError;

  const current = new Set(
    (currentProducts ?? []).map((entry: { product: string }) => entry.product),
  );

  for (const product of products) {
    const query = current.has(product)
      ? admin
          .from("user_products")
          .update({ active: true })
          .eq("user_id", userId)
          .eq("product", product)
      : admin.from("user_products").insert({ user_id: userId, product, active: true });
    const { error } = await query;
    if (error) throw error;
  }

  let deactivateQuery = admin.from("user_products").update({ active: false }).eq("user_id", userId);
  if (products.length > 0) {
    deactivateQuery = deactivateQuery.not("product", "in", `(${products.join(",")})`);
  }
  const { error: deactivateError } = await deactivateQuery;
  if (deactivateError) throw deactivateError;
}
