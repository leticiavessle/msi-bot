/**
 * Camada genérica de webhooks (server-only).
 *
 * Providers reais (Hubla, Kiwify) ainda não estão integrados: existe apenas o
 * adapter, que normaliza o payload. Basta preencher o parse e o segredo de
 * assinatura quando as credenciais existirem.
 */
import { createHmac, timingSafeEqual } from "crypto";
import { productFromName, resolveProductName } from "./csv";
import { PRODUCTS, PRODUCT_LABELS, PRODUTO_PADRAO, type Product } from "./config";
import { MAPA_NOMES_PAYT } from "../../oferta/produtos";
import { dadosDeReserva, juntarDadosDeReserva } from "./identificacao";

export const WEBHOOK_EVENTS = [
  "purchase_approved",
  "refund",
  "chargeback",
  "subscription_canceled",
  "access_revoked",
] as const;

export type WebhookEventType = (typeof WEBHOOK_EVENTS)[number];

export type NormalizedWebhook = {
  eventType: WebhookEventType;
  externalEventId: string | null;
  email: string | null;
  name: string | null;
  /** CPF/CNPJ e telefone da compra, como vieram (entrada no bot por CPF e WhatsApp; só CPF válido é guardado). */
  document?: string | null;
  phone?: string | null;
  product: Product | null;
  /** Vários produtos liberados no mesmo evento (Cademí pode mandar lista). */
  products?: Product[] | undefined;
  /** Origem gravada em authorized_users.access_source. */
  accessSource?: "webhook" | "cademi" | "payt" | "lastlink";
  /** Nome bruto do produto quando não foi possível mapear (Payt). */
  unmappedProductName?: string | null;
  /** Liberação/revogação Payt provisória (sem produto mapeado). */
  paytProvisional?: boolean;
  /** Payload cru e id do evento, guardados no histórico do aluno (Payt). */
  rawPayload?: Record<string, unknown>;
  eventRowId?: string;
  /** Produto conhecido que não concede acesso (no MGA: Consultoria Hydra Scale). */
  noAccessProduct?: string | null | undefined;
  /** true = produto veio da origem; false = produto padrão (sem dado). */
  productConfirmed?: boolean;
  /** Cademí: ids/códigos de produto que ainda precisam de mapeamento. */
  cademiProductIds?: string[];
  /** Cademí: evento chegou sem nenhum dado de produto. */
  cademiMissingProduct?: boolean;
};

export type WebhookAdapter = {
  provider: string;
  /** Nome da variável de ambiente com o segredo de assinatura (opcional). */
  secretEnv?: string;
  /** Header onde a assinatura chega (opcional). */
  signatureHeader?: string;
  /** Header com token fixo compartilhado (Hubla usa esse modelo, não HMAC). */
  tokenHeader?: string;
  /** Token fixo enviado na query string (Cademí não manda headers). */
  tokenQueryParam?: string;
  parse: (payload: Record<string, unknown>) => NormalizedWebhook | null;
  /** Status bruto do evento (para registrar eventos que não mudam acesso). */
  label?: (payload: Record<string, unknown>) => string | null;
};

function str(value: unknown): string | null {
  return typeof value === "string" && value.trim() ? value.trim() : null;
}

/** Primeiro valor preenchido (texto ou número), para CPF e telefone que às vezes chegam como número. */
function primeiro(...values: unknown[]): string | null {
  for (const value of values) {
    const v = typeof value === "number" ? String(value) : str(value);
    if (v) return v;
  }
  return null;
}

function mapProduct(value: unknown): NormalizedWebhook["product"] {
  const raw = str(value);
  return raw ? productFromName(raw) : null;
}

function mapEvent(value: unknown): WebhookEventType | null {
  const raw = str(value)?.toLowerCase() ?? "";
  if (!raw) return null;
  if (raw.includes("refund") || raw.includes("reembol")) return "refund";
  if (raw.includes("chargeback")) return "chargeback";
  if (raw.includes("cancel")) return "subscription_canceled";
  if (raw.includes("revoke")) return "access_revoked";
  if (raw.includes("approved") || raw.includes("purchase") || raw.includes("paid"))
    return "purchase_approved";
  return null;
}

/** Adapter padrão: aceita o formato normalizado direto (usado em testes e integrações simples). */
const genericAdapter: WebhookAdapter = {
  provider: "generic",
  secretEnv: "WEBHOOK_SECRET_GENERIC",
  signatureHeader: "x-webhook-signature",
  parse: (payload) => {
    const eventType = mapEvent(payload["event_type"] ?? payload["event"] ?? payload["type"]);
    if (!eventType) return null;
    const data = (payload["data"] as Record<string, unknown> | undefined) ?? payload;
    return {
      eventType,
      externalEventId: str(payload["id"] ?? payload["event_id"] ?? payload["external_event_id"]),
      email: str(data["email"] ?? data["customer_email"])?.toLowerCase() ?? null,
      name: str(data["name"] ?? data["customer_name"]),
      document: primeiro(data["document"], data["cpf"], data["customer_document"]),
      phone: primeiro(data["phone"], data["customer_phone"]),
      product: mapProduct(data["product"] ?? data["offer"] ?? data["plan"]),
    };
  },
};

function obj(value: unknown): Record<string, unknown> {
  return value && typeof value === "object" && !Array.isArray(value)
    ? (value as Record<string, unknown>)
    : {};
}

/** Eventos da Hubla (v1 e v2) → evento normalizado. */
function mapHublaEvent(type: string | null): WebhookEventType | null {
  const raw = (type ?? "").toLowerCase();
  if (!raw) return null;
  if (raw.includes("refund") || raw.includes("chargeback") || raw.includes("dispute"))
    return "refund";
  if (raw.includes("canceled") || raw.includes("cancelled") || raw.includes("member_removed"))
    return "subscription_canceled";
  if (raw.includes("expired")) return "access_revoked";
  if (
    raw === "newsale" ||
    raw.includes("payment_succeeded") ||
    raw.includes("payment.succeeded") ||
    raw.includes("invoice.paid") ||
    raw.includes("member_added") ||
    raw.includes("subscription.activated")
  )
    return "purchase_approved";
  if (raw.includes("status_updated")) return null; // depende do status da fatura
  return null;
}

/**
 * Adapter real da Hubla.
 * Payload v2: { type, event: { id, invoice, user, product(s), groupName, offer } }
 * Payload v1: { type: "NewSale", event: { userEmail, userName, groupName, ... } }
 */
const hublaAdapter: WebhookAdapter = {
  provider: "hubla",
  secretEnv: "WEBHOOK_SECRET_HUBLA",
  tokenHeader: "x-hubla-token",
  signatureHeader: "x-hubla-signature",
  parse: (payload) => {
    const type = str(payload["type"] ?? payload["event_type"] ?? payload["event"]);
    const event = obj(payload["event"] ?? payload["data"] ?? payload);
    const invoice = obj(event["invoice"]);
    const user = obj(event["user"] ?? event["buyer"] ?? event["customer"] ?? invoice["user"]);

    let eventType = mapHublaEvent(type);
    if (!eventType) {
      // invoice.status_updated e similares: decidir pelo status da fatura.
      const status = (str(invoice["status"] ?? event["status"]) ?? "").toLowerCase();
      if (status.includes("refund")) eventType = "refund";
      else if (status.includes("chargeback")) eventType = "refund";
      else if (status.includes("cancel")) eventType = "subscription_canceled";
      else if (status.includes("expired")) eventType = "access_revoked";
      else if (status === "paid" || status.includes("paid") || status.includes("approved"))
        eventType = "purchase_approved";
    }
    if (!eventType) return null;

    const email =
      str(user["email"]) ??
      str(event["userEmail"]) ??
      str(event["customer_email"]) ??
      str(invoice["userEmail"]);
    if (!email) return null;

    const firstName = str(user["firstName"]);
    const lastName = str(user["lastName"]);
    const name =
      str(user["name"]) ??
      str(event["userName"]) ??
      str(event["customer_name"]) ??
      (firstName ? [firstName, lastName].filter(Boolean).join(" ") : null);

    const productList = Array.isArray(event["products"]) ? (event["products"] as unknown[]) : [];
    const firstProduct = obj(productList[0]);
    const productName =
      str(obj(event["product"])["name"]) ??
      str(firstProduct["name"]) ??
      str(event["groupName"]) ??
      str(obj(event["offer"])["name"]) ??
      str(event["offer"]) ??
      str(obj(invoice["product"])["name"]);

    const resolved = productName ? resolveProductName(productName) : null;
    const payer = obj(invoice["payer"]);
    return {
      eventType,
      externalEventId:
        str(event["id"]) ?? str(invoice["id"]) ?? str(payload["id"]) ?? str(event["invoiceId"]),
      email: email.toLowerCase(),
      name,
      document: primeiro(
        user["document"],
        user["documentNumber"],
        user["cpf"],
        user["doc"],
        event["userDocument"],
        event["userCpf"],
        payer["document"],
      ),
      phone: primeiro(user["phone"], user["phoneNumber"], user["cellphone"], event["userPhone"], payer["phone"]),
      product: resolved ? (resolved.products[0] ?? null) : null,
      products: resolved && resolved.products.length > 1 ? resolved.products : undefined,
      noAccessProduct: resolved && resolved.products.length === 0 ? productName : null,
      productConfirmed: resolved ? resolved.known : false,
    };
  },
};

const kiwifyAdapter: WebhookAdapter = {
  ...genericAdapter,
  provider: "kiwify",
  secretEnv: "WEBHOOK_SECRET_KIWIFY",
};

/** Eventos da Cademí que nunca liberam acesso (pt e en, v1 e v2). */
const CADEMI_IGNORED = [
  "certificado",
  "certificate",
  "prova",
  "exam",
  "quiz",
  "termo",
  "term.",
  "term_",
  "termo.assinado",
  "progresso",
  "progress",
  "gratis.criado",
  "free.created",
];

/** Tipos (v1 pt e v2 en) que significam liberação de acesso. */
const CADEMI_GRANT = [
  "usuario.criado",
  "user.created",
  "user.access.granted",
  "access.granted",
  "enrollment.created",
  "entrega.adicionada",
  "delivery.added",
  "aluno",
];

function firstObj(...values: unknown[]): Record<string, unknown> {
  for (const value of values) {
    const o = obj(value);
    if (Object.keys(o).length > 0) return o;
  }
  return {};
}

/**
 * Lê o produto da Cademí em qualquer formato: texto, número, lista, ou objeto
 * com nome/name/titulo/title e/ou id/codigo/code/sku. Devolve nomes e ids.
 */
export function cademiProductRefs(value: unknown): { names: string[]; ids: string[] } {
  const names: string[] = [];
  const ids: string[] = [];
  const visit = (item: unknown, depth: number) => {
    if (item == null || depth > 3) return;
    if (Array.isArray(item)) return item.forEach((i) => visit(i, depth + 1));
    if (typeof item === "number") return void ids.push(String(item));
    if (typeof item === "string") {
      const t = item.trim();
      if (!t) return;
      if (t.includes(",") && !/\s/.test(t)) return t.split(",").forEach((x) => visit(x, depth + 1));
      if (/^\d+$/.test(t) || /^[0-9a-f]{8}-[0-9a-f-]{27,}$/i.test(t)) ids.push(t);
      else names.push(t);
      return;
    }
    if (typeof item === "object") {
      const o = item as Record<string, unknown>;
      const name = str(o["nome"] ?? o["name"] ?? o["titulo"] ?? o["title"] ?? o["produto_nome"]);
      const id = o["id"] ?? o["codigo"] ?? o["code"] ?? o["sku"] ?? o["uuid"] ?? o["produto_id"];
      if (name) names.push(name);
      else if (typeof id === "string" || typeof id === "number") ids.push(String(id).trim());
      else if (o["produto"] ?? o["product"]) visit(o["produto"] ?? o["product"], depth + 1);
    }
  };
  visit(value, 0);
  return { names: [...new Set(names)], ids: [...new Set(ids.filter(Boolean))] };
}

/**
 * Adapter da Cademí (área de membros). Só libera acesso; nunca revoga.
 * Suporta o formato v1 (pt) e o v2 ({ event: "user.created", payload: { user } }).
 * Autenticação por token na query string (?token=...), pois a Cademí não envia headers.
 */
const cademiAdapter: WebhookAdapter = {
  provider: "cademi",
  secretEnv: "WEBHOOK_SECRET_CADEMI",
  tokenQueryParam: "token",
  parse: (payload) => {
    const rawType = (
      str(payload["event_type"]) ??
      str(payload["type"]) ??
      str(payload["evento"]) ??
      str(payload["event"]) ??
      ""
    ).toLowerCase();
    if (!rawType) return null;
    if (CADEMI_IGNORED.some((ignored) => rawType.includes(ignored))) return null;

    const isCreated =
      CADEMI_GRANT.some((grant) => rawType.includes(grant)) || rawType.includes("criado");
    if (!isCreated) return null;

    // v2: { event: "user.created", payload: { user: {...} } } · v1: { event: {...} }
    const body = firstObj(payload["payload"], payload["event"], payload["data"], payload);
    const event = body;
    const user = firstObj(
      body["user"],
      body["usuario"],
      obj(payload["data"])["usuario"],
      payload["usuario"],
      payload["user"],
    );
    const email = str(user["email"] ?? event["email"] ?? payload["email"])?.toLowerCase() ?? null;
    if (!email) return null;

    const produtoRaw =
      body["produto"] ??
      body["produtos"] ??
      body["product"] ??
      body["products"] ??
      obj(body["delivery"])["product"] ??
      obj(body["entrega"])["produto"] ??
      body["entregas"] ??
      obj(payload["data"])["produto"] ??
      payload["produto"] ??
      payload["product"];
    const vitrine = firstObj(body["vitrine"], payload["vitrine"], obj(body["entrega"])["vitrine"]);

    const refs = cademiProductRefs(produtoRaw);
    if (refs.names.length === 0 && refs.ids.length === 0) {
      const vitrineName = str(vitrine["nome"] ?? vitrine["name"]);
      if (vitrineName) refs.names.push(vitrineName);
    }

    const resolved = refs.names.map((name) => resolveProductName(name));
    const products = Array.from(new Set(resolved.flatMap((r) => r.products)));
    const confirmed = resolved.some((r) => r.known);
    const noAccessOnly = resolved.length > 0 && resolved.every((r) => r.products.length === 0);
    const productId = refs.ids[0] ?? "";

    return {
      eventType: "purchase_approved",
      externalEventId:
        str(payload["event_id"] ?? event["id"] ?? payload["id"] ?? payload["event_id"]) ??
        `cademi:${rawType}:${email}:${productId}`,
      email,
      name: str(user["nome"] ?? user["name"] ?? event["nome"]),
      document: primeiro(user["doc"], user["cpf"], user["documento"], user["document"]),
      phone: primeiro(user["celular"], user["telefone"], user["phone"], user["cellphone"]),
      product: noAccessOnly ? null : (products[0] ?? PRODUTO_PADRAO),
      products: noAccessOnly ? [] : products.length > 0 ? products : [PRODUTO_PADRAO],
      accessSource: "cademi",
      productConfirmed: confirmed,
      noAccessProduct: noAccessOnly ? refs.names[0] : null,
      cademiProductIds: refs.ids,
      cademiMissingProduct: refs.names.length === 0 && refs.ids.length === 0,
    };
  },
};

function norm(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
}

function pick(payload: Record<string, unknown>, paths: string[]): string | null {
  for (const path of paths) {
    let cur: unknown = payload;
    for (const key of path.split(".")) cur = obj(cur)[key];
    const value = typeof cur === "number" ? String(cur) : str(cur);
    if (value) return value;
  }
  return null;
}

const PAYT_STATUS = ["status", "transaction_status", "payment_status", "transaction.status"];

function paytStatus(payload: Record<string, unknown>) {
  return pick(payload, PAYT_STATUS);
}

export function mapPaytStatus(raw: string | null): WebhookEventType | null {
  const s = norm(raw ?? "");
  if (!s) return null;
  if (s.includes("reembols") || s.includes("refund")) return "refund";
  if (s.includes("chargeback")) return "chargeback";
  if (s.includes("cancel")) return "subscription_canceled";
  if (
    s.includes("aguardando") ||
    s.includes("abandon") ||
    s.includes("faturad") ||
    s.includes("entrega") ||
    s.includes("waiting") ||
    s.includes("pending")
  )
    return null;
  if (
    s.includes("aprovad") ||
    s.includes("completed") ||
    s === "paga" ||
    s === "pago" ||
    s.includes("paid") ||
    s.includes("approved")
  )
    return "purchase_approved";
  return null;
}

/** Heurística da Payt: só mapeia quando o nome é inequívoco. */
export function paytProductFromName(name: string): Product | null {
  const n = norm(name);
  return MAPA_NOMES_PAYT.find((r) => r.re.test(n))?.product ?? null;
}

/**
 * Adapter da Payt (postback V1). Um postback por status; token na URL.
 * Leitura tolerante: JSON ou form-urlencoded (convertido em objeto pela rota).
 */
const paytAdapter: WebhookAdapter = {
  provider: "payt",
  secretEnv: "WEBHOOK_SECRET_PAYT",
  tokenQueryParam: "token",
  label: paytStatus,
  parse: (payload) => {
    const eventType = mapPaytStatus(paytStatus(payload));
    if (!eventType) return null;
    const email =
      pick(payload, [
        "customer.email",
        "cliente.email",
        "email",
        "buyer_email",
        "buyer.email",
      ])?.toLowerCase() ?? null;
    if (!email) return null;
    const productName = pick(payload, [
      "product.name",
      "produto.nome",
      "offer.name",
      "oferta.nome",
      "product_name",
      "produto",
      "product",
    ]);
    // Produto de outro expert (mesma conta da Payt) ou sem acesso ao bot: registra e ignora,
    // sem cair no "Payt provisório" (que liberaria o produto padrão).
    const semAcesso = productName && resolveProductName(productName).products.length === 0 ? productName : null;
    const product = productName && !semAcesso ? paytProductFromName(productName) : null;
    const txId = pick(payload, ["transaction_id", "transaction.id", "id", "code"]);
    return {
      eventType,
      externalEventId: txId ? `${txId}:${eventType}` : null,
      email,
      name: pick(payload, ["customer.name", "cliente.nome", "cliente.name", "name", "buyer_name"]),
      document: pick(payload, [
        "customer.doc",
        "customer.document",
        "customer.cpf",
        "cliente.doc",
        "cliente.cpf",
        "cliente.documento",
        "buyer.document",
        "doc",
        "document",
        "cpf",
      ]),
      phone: pick(payload, [
        "customer.phone",
        "customer.cellphone",
        "customer.phone_number",
        "cliente.telefone",
        "cliente.celular",
        "buyer.phone",
        "phone",
        "telefone",
        "celular",
      ]),
      product,
      accessSource: "payt",
      noAccessProduct: semAcesso,
      unmappedProductName: product || semAcesso ? null : (productName ?? "(sem nome de produto)"),
    };
  },
};

/** Converte form-urlencoded (com chaves tipo customer[email]) em objeto aninhado. */
export function parseFormBody(raw: string): Record<string, unknown> {
  const out: Record<string, unknown> = {};
  for (const [key, value] of new URLSearchParams(raw)) {
    const parts = key.replace(/\]/g, "").split("[");
    let cur = out;
    parts.forEach((part, i) => {
      if (i === parts.length - 1) cur[part] = value;
      else {
        if (!cur[part] || typeof cur[part] !== "object") cur[part] = {};
        cur = cur[part] as Record<string, unknown>;
      }
    });
  }
  return out;
}

/**
 * Adapter da LastLink (MSI, 09/10/2026). Documentação oficial:
 * https://support.lastlink.com/pt-BR/articles/12587805-documentacao-de-webhook-da-lastlink
 * Formato: { Id, IsTest, Event, CreatedAt, Data: { Products: [{ Id, Name }], Buyer: { Email, Name, ... }, ... } }.
 * A LastLink não assina o envio: a senha vai no endereço (?token=), como na Payt e na Cademí.
 * Os nomes de produto passam pelas mesmas regras da Hubla (src/oferta/produtos.ts › MAPA_NOMES_DE_PRODUTO).
 */
const LASTLINK_EVENTS: Record<string, WebhookEventType> = {
  Purchase_Order_Confirmed: "purchase_approved",
  Product_Access_Started: "purchase_approved",
  Recurrent_Payment: "purchase_approved",
  Payment_Refund: "refund",
  Payment_Chargeback: "chargeback",
  Subscription_Canceled: "subscription_canceled",
  Subscription_Expired: "access_revoked",
  Product_Access_Ended: "access_revoked",
};

function lastlinkEvent(payload: Record<string, unknown>): string | null {
  return str(payload["Event"] ?? payload["event"]);
}

const lastlinkAdapter: WebhookAdapter = {
  provider: "lastlink",
  secretEnv: "WEBHOOK_SECRET_LASTLINK",
  tokenQueryParam: "token",
  label: lastlinkEvent,
  parse: (payload) => {
    const ev = lastlinkEvent(payload) ?? "";
    const data = obj(payload["Data"] ?? payload["data"]);
    let eventType: WebhookEventType | null =
      LASTLINK_EVENTS[ev] ??
      LASTLINK_EVENTS[Object.keys(LASTLINK_EVENTS).find((k) => k.toLowerCase() === ev.toLowerCase()) ?? ""] ??
      null;
    if (!eventType && ev.toLowerCase() === "subscription_product_access") {
      const action = (str(data["Action"] ?? data["action"]) ?? "").toLowerCase();
      eventType = action === "add" ? "purchase_approved" : action === "remove" ? "access_revoked" : null;
    }
    if (!eventType) return null;
    const buyer = obj(data["Buyer"] ?? data["buyer"]);
    const email = str(buyer["Email"] ?? buyer["email"])?.toLowerCase() ?? null;
    if (!email) return null;
    const lista = Array.isArray(data["Products"]) ? (data["Products"] as unknown[]) : [];
    const nomes = lista.map((p) => str(obj(p)["Name"] ?? obj(p)["name"])).filter((n): n is string => Boolean(n));
    const resolvidos = nomes.map((n) => resolveProductName(n));
    const products = [...new Set(resolvidos.flatMap((r) => r.products))];
    const semAcesso = resolvidos.length > 0 && products.length === 0;
    return {
      eventType,
      externalEventId: str(payload["Id"] ?? payload["id"]),
      email,
      name: str(buyer["Name"] ?? buyer["name"]),
      document: primeiro(buyer["Document"], buyer["document"], buyer["Cpf"], buyer["cpf"]),
      phone: primeiro(buyer["PhoneNumber"], buyer["phoneNumber"], buyer["Phone"], buyer["phone"]),
      product: products[0] ?? null,
      products: products.length > 1 ? products : undefined,
      accessSource: "lastlink",
      noAccessProduct: semAcesso ? nomes.join(", ") : null,
      productConfirmed: resolvidos.length > 0 && resolvidos.every((r) => r.known),
    };
  },
};

export const ADAPTERS: Record<string, WebhookAdapter> = {
  generic: genericAdapter,
  hubla: hublaAdapter,
  kiwify: kiwifyAdapter,
  cademi: cademiAdapter,
  payt: paytAdapter,
  lastlink: lastlinkAdapter,
};

export function verifySignature(secret: string, rawBody: string, signature: string | null) {
  if (!signature) return false;
  const expected = createHmac("sha256", secret).update(rawBody).digest("hex");
  const a = Buffer.from(signature.replace(/^sha256=/, ""));
  const b = Buffer.from(expected);
  return a.length === b.length && timingSafeEqual(a, b);
}

/** Token fixo compartilhado (modelo usado pela Hubla), comparado em tempo constante. */
export function verifyToken(secret: string, token: string | null) {
  if (!token) return false;
  const a = Buffer.from(token.trim());
  const b = Buffer.from(secret.trim());
  return a.length === b.length && timingSafeEqual(a, b);
}

type Admin = Awaited<typeof import("@/integrations/supabase/client.server")>["supabaseAdmin"];

/** Aplica o efeito do evento sobre o acesso do aluno. Idempotente por natureza. */
export async function applyWebhookEffect(
  admin: Admin,
  event: NormalizedWebhook,
  provider = "webhook",
): Promise<{ ok: boolean; reason?: string }> {
  if (!event.email) return { ok: false, reason: "payload sem e-mail" };
  const email = event.email.toLowerCase();
  const product = event.product ?? PRODUTO_PADRAO;
  let granted = event.products?.length ? event.products : [product];
  const source = event.accessSource ?? "webhook";
  const isHubla = provider === "hubla";

  // Precedência: a Hubla manda. Reembolso/chargeback/cancelamento na Hubla
  // impede Payt/Cademí de reativar o produto até uma nova compra na Hubla.
  if (event.eventType === "purchase_approved" && !isHubla) {
    const { data: grants } = await admin
      .from("product_access_grants")
      .select("product, hubla_status")
      .eq("email", email)
      .in("product", granted as never);
    const blocked = new Set(
      (grants ?? [])
        .filter((g) => BLOCKING_HUBLA.includes(g.hubla_status ?? ""))
        .map((g) => g.product as string),
    );
    if (blocked.size > 0) {
      const statuses = (grants ?? [])
        .filter((g) => blocked.has(g.product))
        .map((g) => HUBLA_LABEL[g.hubla_status ?? ""] ?? g.hubla_status);
      granted = granted.filter((p) => !blocked.has(p));
      await logAccessChange(admin, "webhook_blocked_by_hubla", email, {
        provider,
        products: Array.from(blocked),
        external_event_id: event.externalEventId,
      });
      if (granted.length === 0) {
        return { ok: false, reason: `bloqueado: ${statuses[0] ?? "reembolso"} na Hubla` };
      }
    }
  }

  const existing = await cadastroPorEmail(admin, email);
  // Conta no bot: o e-mail do cadastro (pode ter sido trocado pela equipe; o da compra fica nos anteriores).
  const contaEmail = existing?.email?.toLowerCase() ?? email;
  const productOrigin =
    event.productConfirmed || existing?.product_origin === "confirmado"
      ? "confirmado"
      : existing?.product_origin && existing.product_origin !== "padrao"
        ? existing.product_origin
        : "padrao";

  const now = new Date().toISOString();
  const meta = { ...((existing?.metadata as Record<string, unknown> | null) ?? {}) };
  const history = Array.isArray(meta["access_history"])
    ? [...(meta["access_history"] as unknown[])]
    : [];
  const isProvisional = meta["payt_provisional"] === true;
  const alreadyActive =
    existing?.status === "active" && (existing.product_access ?? []).length > 0;
  if (provider === "payt") {
    history.push({
      action: `payt_${event.eventType}`,
      at: now,
      provisional: Boolean(event.paytProvisional),
      webhook_event_id: event.eventRowId ?? null,
      payload: event.rawPayload ?? null,
    });
    meta["access_history"] = history;
  }

  if (event.eventType === "purchase_approved") {
    // Payt provisória não mexe em quem já tem acesso por outra origem.
    if (event.paytProvisional && existing && alreadyActive && !isProvisional) {
      await admin.from("authorized_users").update({ metadata: meta as never }).eq("id", existing.id);
      return { ok: true, reason: "já tinha acesso; Payt provisória não alterou" };
    }
    if (event.paytProvisional) {
      meta["payt_provisional"] = true;
      meta["payt_provisional_at"] = now;
    } else if (isProvisional) {
      // Compra confirmada por outro caminho: sai da etiqueta provisória.
      delete meta["payt_provisional"];
      delete meta["payt_provisional_at"];
    }
    const products = Array.from(new Set([...(existing?.product_access ?? []), ...granted]));
    // CPF e telefone para a entrada no bot por reserva; o telefone mais novo vence.
    const reserva = juntarDadosDeReserva(existing, dadosDeReserva(event.document, event.phone), {
      telefoneNovoVence: true,
    });
    if (existing) {
      await admin
        .from("authorized_users")
        .update({
          status: "active",
          product_access: products,
          access_source: source,
          product_origin: productOrigin,
          metadata: meta as never,
          ...reserva,
          ...(!existing.name && event.name ? { name: event.name } : {}),
        })
        .eq("id", existing.id);
    } else {
      await admin.from("authorized_users").insert({
        email,
        name: event.name,
        status: "active",
        product_access: products,
        access_source: source,
        product_origin: productOrigin,
        metadata: meta as never,
        ...reserva,
      });
    }
    await syncUserProducts(admin, contaEmail, products, true);
    await admin.from("product_access_grants").upsert(
      granted.map((p) => ({
        email,
        product: p as never,
        source: provider,
        granted_at: now,
        updated_at: now,
        ...(isHubla ? { hubla_status: "approved", hubla_status_at: now } : {}),
      })),
      { onConflict: "email,product" },
    );
    await logAccessChange(admin, "webhook_access_granted", email, {
      product: granted.join(","),
      event: event.eventType,
      external_event_id: event.externalEventId,
      ...(event.paytProvisional ? { tag: "payt provisório" } : {}),
    });
    return { ok: true };
  }

  // Revogação continua atingindo só o produto principal (como antes): reembolso do
  // Super Acesso não tira a Evolution comprada antes, e o time revisa caso a caso.
  const revokedProducts: Product[] = [product];
  if (isHubla) {
    await admin.from("product_access_grants").upsert(
      revokedProducts.map((p) => ({
        email,
        product: p as never,
        hubla_status: event.eventType,
        hubla_status_at: now,
        updated_at: now,
      })),
      { onConflict: "email,product" },
    );
  }

  if (!existing) return { ok: true };

  // Revogação Payt sem produto mapeado só atinge quem entrou pela etiqueta provisória.
  if (event.paytProvisional && !isProvisional) {
    await admin.from("authorized_users").update({ metadata: meta as never }).eq("id", existing.id);
    return { ok: true, reason: "sem produto mapeado; aluno não é Payt provisório" };
  }

  const remaining = (existing.product_access ?? []).filter(
    (p) => !revokedProducts.includes(p as Product),
  );
  const status =
    event.eventType === "refund" || event.eventType === "chargeback"
      ? "refunded"
      : event.eventType === "subscription_canceled"
        ? "canceled"
        : "blocked";

  await admin
    .from("authorized_users")
    .update({
      product_access: remaining,
      status: remaining.length > 0 ? "active" : status,
      ...(provider === "payt" ? { metadata: meta as never } : {}),
    })
    .eq("id", existing.id);

  await syncUserProducts(admin, contaEmail, revokedProducts, false);
  await logAccessChange(admin, "webhook_access_revoked", email, {
    product: revokedProducts.join(","),
    event: event.eventType,
    external_event_id: event.externalEventId,
  });
  if (remaining.length === 0) await revokeSessionsByEmail(admin, contaEmail);
  return { ok: true };
}

/**
 * Cadastro pelo e-mail da compra; se a equipe trocou o e-mail no painel, acha pelo e-mail antigo
 * (authorized_users.emails_anteriores). Assim reembolso e nova compra continuam chegando na pessoa certa.
 */
async function cadastroPorEmail(admin: Admin, email: string) {
  const campos = "id, email, name, product_access, status, metadata, product_origin, cpf, telefone";
  const { data } = await admin.from("authorized_users").select(campos).eq("email", email).maybeSingle();
  if (data) return data;
  const { data: antigos } = await admin
    .from("authorized_users")
    .select(campos)
    .contains("emails_anteriores", [email])
    .order("updated_at", { ascending: false })
    .limit(1);
  return antigos?.[0] ?? null;
}

const BLOCKING_HUBLA = ["refund", "chargeback", "subscription_canceled", "access_revoked"];
const HUBLA_LABEL: Record<string, string> = {
  refund: "reembolso",
  chargeback: "chargeback",
  subscription_canceled: "cancelamento",
  access_revoked: "acesso revogado",
};

async function syncUserProducts(admin: Admin, email: string, products: string[], active: boolean) {
  const { data: profile } = await admin
    .from("profiles")
    .select("id")
    .eq("email", email)
    .maybeSingle();
  if (!profile) return;
  for (const product of products) {
    if (active) {
      await admin
        .from("user_products")
        .upsert(
          { user_id: profile.id, product: product as never, active: true },
          { onConflict: "user_id,product" },
        );
    } else {
      await admin
        .from("user_products")
        .update({ active: false })
        .eq("user_id", profile.id)
        .eq("product", product as never);
    }
  }
}

export async function revokeSessionsByEmail(admin: Admin, email: string) {
  const { data: profile } = await admin
    .from("profiles")
    .select("id")
    .eq("email", email)
    .maybeSingle();
  if (!profile) return;
  await admin
    .from("access_sessions")
    .update({ revoked_at: new Date().toISOString() })
    .eq("user_id", profile.id)
    .is("revoked_at", null);
}

/** Log de concessão/revogação de acesso vindo de webhook. */
async function logAccessChange(
  admin: Admin,
  action: string,
  email: string,
  metadata: Record<string, unknown>,
) {
  await admin.from("audit_logs").insert({
    action,
    target_email: email,
    metadata: metadata as never,
  });
}

/**
 * Mapeamento de produto externo → produto interno.
 * Configurável em assistant_config (chave "webhook_product_map"), ex.:
 * { "OFERTA-123": "mentoria" }. Enquanto o proprietário não fornecer os
 * identificadores reais da Hubla, vale o mapeamento heurístico por nome.
 */
export async function mapExternalProduct(admin: Admin, external: string | null) {
  if (!external) return null;
  const { data } = await admin
    .from("assistant_config")
    .select("value")
    .eq("key", "webhook_product_map")
    .maybeSingle();
  const map = (data?.value ?? {}) as Record<string, string>;
  const hit = map[external] ?? map[external.toLowerCase()];
  return PRODUCTS.includes(hit as Product) ? (hit as Product) : null;
}

/**
 * Ids/códigos de produto da Cademí → produto interno. O mapeamento fica em
 * webhook_product_names (provider "cademi", name "id:<código>"); ids novos
 * entram como pendentes para mapear no painel.
 */
async function mapCademiIds(admin: Admin, ids: string[], email: string | null) {
  const out = new Set<Product>();
  for (const id of ids) {
    const name = `id:${id}`;
    const { data: map } = await admin
      .from("webhook_product_names")
      .select("id, mapped_to, pending_count")
      .eq("provider", "cademi")
      .eq("name", name)
      .maybeSingle();
    if (map?.mapped_to && PRODUCTS.includes(map.mapped_to as Product)) {
      out.add(map.mapped_to as Product);
    } else if (map) {
      await admin
        .from("webhook_product_names")
        .update({ last_email: email, pending_count: map.pending_count + 1, updated_at: new Date().toISOString() })
        .eq("id", map.id);
    } else {
      await admin
        .from("webhook_product_names")
        .insert({ provider: "cademi", name, last_email: email, pending_count: 1 });
    }
  }
  return [...out];
}

/**
 * Processa um evento já gravado em webhook_events (rota, reprocessar e
 * mapeamento de produtos usam o mesmo caminho).
 */
export async function processWebhookEvent(
  admin: Admin,
  provider: string,
  payload: Record<string, unknown>,
  rowId: string,
) {
  const adapter = ADAPTERS[provider];
  const now = new Date().toISOString();
  const finish = (fields: Record<string, unknown>) =>
    admin
      .from("webhook_events")
      .update({ processed_at: now, ...fields } as never)
      .eq("id", rowId);

  const normalized = adapter ? adapter.parse(payload) : null;
  if (!normalized) {
    const status = adapter?.label?.(payload);
    if (provider === "payt" && status) {
      await finish({
        processed: true,
        processing_error: null,
        event_type: `registrado: ${status}`,
      });
      return { ok: true, recorded: true };
    }
    await finish({ processing_error: "evento não reconhecido" });
    return { ok: false, reason: "evento não reconhecido" };
  }

  if (provider === "payt") {
    normalized.rawPayload = payload;
    normalized.eventRowId = rowId;
  }

  if (!normalized.product && normalized.unmappedProductName) {
    const name = normalized.unmappedProductName;
    const { data: map } = await admin
      .from("webhook_product_names")
      .select("id, mapped_to, pending_count")
      .eq("provider", provider)
      .eq("name", name)
      .maybeSingle();
    if (map?.mapped_to === "ignore") {
      await finish({
        processed: true,
        processing_error: "ignorado: produto marcado para ignorar",
        event_type: normalized.eventType,
      });
      return { ok: true, ignored: true };
    }
    if (map?.mapped_to && PRODUCTS.includes(map.mapped_to as Product)) {
      normalized.product = map.mapped_to as Product;
      normalized.unmappedProductName = null;
    } else {
      if (map) {
        await admin
          .from("webhook_product_names")
          .update({
            last_email: normalized.email,
            pending_count: map.pending_count + 1,
            updated_at: now,
          })
          .eq("id", map.id);
      } else {
        await admin.from("webhook_product_names").insert({
          provider,
          name,
          last_email: normalized.email,
          pending_count: 1,
        });
        await logAccessChange(admin, "webhook_product_unmapped", normalized.email ?? "", {
          provider,
          product_name: name,
          alert: "Produto da Payt não mapeado",
        });
      }
      // PROVISÓRIO (decisão 26/09 no MGA): Payt sem produto mapeado libera o produto padrão com
      // etiqueta "payt provisório"; reembolso/chargeback/cancelamento sem produto
      // só revogam quem está nessa etiqueta. Reversível em "Revogar todos".
      if (provider === "payt") {
        normalized.product = PRODUTO_PADRAO;
        normalized.paytProvisional = true;
        await logAccessChange(
          admin,
          normalized.eventType === "purchase_approved"
            ? "payt_provisional_grant"
            : "payt_provisional_revoke",
          normalized.email ?? "",
          {
            provider,
            product_name: name,
            event: normalized.eventType,
            webhook_event_id: rowId,
            alert: "Payt provisório: acesso liberado sem produto mapeado",
          },
        );
      } else {
        await finish({
          processed: false,
          processing_error: "produto não mapeado",
          event_type: normalized.eventType,
          external_event_id: normalized.externalEventId,
        });
        return { ok: false, reason: "produto não mapeado" };
      }
    }
  }

  // Produto conhecido que não concede acesso (no MGA: Consultoria Hydra Scale): registra e para.
  if (normalized.noAccessProduct) {
    await logAccessChange(admin, "webhook_product_no_access", normalized.email ?? "", {
      provider,
      product_name: normalized.noAccessProduct,
      event: normalized.eventType,
      webhook_event_id: rowId,
    });
    await finish({
      processed: true,
      processing_error: `ignorado: ${normalized.noAccessProduct} não libera o bot (outra oferta ou produto sem acesso)`,
      event_type: normalized.eventType,
    });
    return { ok: true, ignored: true, email: normalized.email };
  }

  if (provider === "cademi") {
    if (normalized.cademiMissingProduct) {
      // Aviso interno: mostra se a configuração do produto na Cademí já pegou.
      await logAccessChange(admin, "cademi_sem_produto", normalized.email ?? "", {
        provider,
        webhook_event_id: rowId,
        alert: `Evento da Cademí chegou sem produto (${PRODUCT_LABELS[PRODUTO_PADRAO]} por padrão)`,
      });
    } else if (!normalized.productConfirmed && normalized.cademiProductIds?.length) {
      const mapped = await mapCademiIds(admin, normalized.cademiProductIds, normalized.email);
      if (mapped.length) {
        normalized.products = mapped;
        normalized.product = mapped[0]!;
        normalized.productConfirmed = true;
      }
    }
  }

  if (!normalized.product) {
    const raw = (payload["product"] ?? payload["offer"] ?? payload["plan"]) as string | null;
    normalized.product = await mapExternalProduct(admin, typeof raw === "string" ? raw : null);
  }

  const result = await applyWebhookEffect(admin, normalized, provider);
  await finish({
    event_type: normalized.eventType,
    processed: result.ok,
    processing_error: result.ok ? null : (result.reason ?? "falha"),
  });
  return { ...result, email: normalized.email };
}
