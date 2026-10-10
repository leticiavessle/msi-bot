/**
 * Configurações do assistente.
 * Tudo o que muda de uma oferta para outra fica em src/oferta/ — este arquivo só reexporta,
 * para o resto do código continuar importando de "./config".
 */
import { QUICK_ACTIONS, type QuickAction } from "../../oferta/atalhos";
import type { Product } from "../../oferta/produtos";

export { IDENTITY, MARCA } from "../../oferta/marca";
export {
  PRODUCTS,
  PRODUCT_LABELS,
  PRODUTO_PADRAO,
  PRODUTO_RECORRENTE,
  type Product,
} from "../../oferta/produtos";
export { QUICK_ACTIONS, INTENT_COMUNIDADE, type QuickAction } from "../../oferta/atalhos";

export function actionsForProducts(_products: readonly Product[]): QuickAction[] {
  return QUICK_ACTIONS;
}
