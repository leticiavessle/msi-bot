/**
 * Detecção de "interesse de compra" (alerta de venda, criado para a MSI) e agrupamento por pessoa.
 * Módulo puro (sem banco) para ser testável. NÃO altera a resposta do bot: preço continua
 * sendo POLITICAS.respostaPreco; o alerta só aparece no painel, na aba "Vendas".
 */
import type { Product } from "../../oferta/produtos";
import { VENDA_EXCLUIR_RE, VENDA_PRODUTOS } from "../../oferta/atalhos";
import { isAccessComplaint } from "./access-alert";
import { isRefundTrigger } from "./refund-protocol";

const strip = (t: string) =>
  t.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/\s+/g, " ").trim();

/** Pergunta de preço ou condição de pagamento. */
const PRICE =
  /\b(precos?|valor(es)?|quanto (custa|e|fica|sai|ta|esta|seria|voces cobram)|desconto|cupom|parcel\w*|promoc\w*|condic\w* (especial|de pagamento)|forma de pagamento|boleto|checkout|link (de|da|do|pra|para) (compra|comprar|pagamento|pagar))\b/;

/** Intenção de comprar. */
const BUY =
  /\b(quero|queria|gostaria de|vou|posso|como (eu )?(faco|fasso|consigo) (pra|para)|onde (eu )?|da pra|tem como|vale a pena)\s*(\w+ ){0,2}(comprar|compro|adquirir|garantir|assinar|contratar|fazer (o )?upgrade)\b/;

/** Fala de produto sem dizer qual. */
const GENERIC = /\b(curso|produto|mentoria|acesso|plano|upgrade|pacote|combo|vaga)\b/;

export type SalesInterest = { product: Product | null };

/** null = não é interesse de compra. */
export function detectSalesInterest(text: string | null | undefined): SalesInterest | null {
  if (!text) return null;
  const t = strip(text);
  if (t.length < 6) return null;
  // Reembolso/cancelamento é do Protocolo 7D; "comprei e não liberou" é alerta de acesso.
  if (isRefundTrigger(text) || isAccessComplaint(text)) return null;
  if (!PRICE.test(t) && !BUY.test(t)) return null;
  const product = VENDA_PRODUTOS.find((p) => p.re.test(t))?.product ?? null;
  if (product) return { product };
  if (GENERIC.test(t) && !VENDA_EXCLUIR_RE.test(t)) return { product: null };
  return null;
}

export type SalesAlertRow = {
  id: string;
  user_id: string;
  conversation_id: string | null;
  trigger_text: string;
  product: string | null;
  status: string;
  resolved_by: string | null;
  resolved_at: string | null;
  created_at: string;
};

export type SalesPerson = {
  userId: string;
  count: number;
  latestAt: string;
  latestText: string;
  conversationId: string | null;
  /** Produtos pelos quais perguntou (chaves), sem repetir. */
  askedProducts: string[];
  resolvedAt: string | null;
  resolvedBy: string | null;
};

/** Uma linha por pessoa. pending: só alertas pendentes; resolved: quem não tem pendente. */
export function groupSalesAlerts(rows: SalesAlertRow[], view: "pending" | "resolved"): SalesPerson[] {
  const byUser = new Map<string, SalesAlertRow[]>();
  for (const r of rows) byUser.set(r.user_id, [...(byUser.get(r.user_id) ?? []), r]);
  const out: SalesPerson[] = [];
  for (const [userId, all] of byUser) {
    const pending = all.filter((a) => a.status === "pending");
    const pick = view === "pending" ? pending : pending.length ? [] : all.filter((a) => a.status === "resolved");
    if (!pick.length) continue;
    pick.sort((a, b) => b.created_at.localeCompare(a.created_at));
    const latest = pick[0]!;
    const lastResolved = all
      .filter((a) => a.resolved_at)
      .sort((a, b) => b.resolved_at!.localeCompare(a.resolved_at!))[0];
    out.push({
      userId,
      count: pick.length,
      latestAt: latest.created_at,
      latestText: latest.trigger_text,
      conversationId: latest.conversation_id,
      askedProducts: [...new Set(pick.map((a) => a.product).filter(Boolean) as string[])],
      resolvedAt: lastResolved?.resolved_at ?? null,
      resolvedBy: lastResolved?.resolved_by ?? null,
    });
  }
  return out.sort((a, b) => b.latestAt.localeCompare(a.latestAt));
}
