/**
 * PRODUTOS DA OFERTA · MSI (Método Sócia Invisível)
 *
 * 5 produtos, todos de pagamento único, vendidos pela Hubla e pela Payt (confirmado em 04/10/2026):
 *   - principal    → Método Sócia Invisível (front, com as Vitrines 2 e 3 de bônus + comunidade)
 *   - top_demandas → Top Demandas Accelerator (aulas)
 *   - cofre_pix    → Cofre PIX Relâmpago (aulas + grupo no Telegram)
 *   - mentoria     → Mentoria Sócia Suprema (aulas + área de membros separada + comunidade da mentoria)
 *   - vitalicia    → Sócia Vitalícia (só a aula de apresentação)
 *
 * As chaves são as mesmas do banco (tipo product_type em supabase/migrations). Para ter mais ou
 * menos produtos, mude a lista aqui E no banco (migração + src/integrations/supabase/types.ts).
 *
 * Comunidade e atendimento humano preenchidos em 04/10/2026 (comunidade da Mentoria ainda vai ser criada).
 */

import { OFFICIAL_LINKS } from "./links";

export const PRODUCTS = ["principal", "top_demandas", "cofre_pix", "mentoria", "vitalicia"] as const;
export type Product = (typeof PRODUCTS)[number];

/** Nome de cada produto como aparece no painel e no prompt. */
export const PRODUCT_LABELS: Record<Product, string> = {
  principal: "Método Sócia Invisível",
  top_demandas: "Top Demandas Accelerator",
  cofre_pix: "Cofre PIX Relâmpago",
  mentoria: "Mentoria Sócia Suprema",
  vitalicia: "Sócia Vitalícia",
};

/** Produto usado quando a compra chega sem nome de produto reconhecível. */
export const PRODUTO_PADRAO: Product = "principal";

/**
 * Produto de assinatura (cobrança recorrente). Pedido de "cancelar a assinatura" de quem tem
 * esse produto segue o encerramento de assinatura (pelo atendimento humano), não o e-mail de reembolso.
 * MSI: todos os produtos são de pagamento único, então não há produto recorrente.
 */
export const PRODUTO_RECORRENTE: Product | null = null;

/** Palavras que indicam que o cancelamento é da assinatura (só valem se houver produto recorrente). */
export const ASSINATURA_RE = /(assinatura|mensalidade|recorr[êe]ncia|plano mensal)/i;

/* ------------------------------------------------------------------ */
/* Nome do produto na compra (Hubla, Payt, Cademí, planilha) → produto  */
/* ------------------------------------------------------------------ */
/*
 * Os nomes são comparados sem acento e em minúsculas. A primeira regra que casar vale.
 * Na Hubla os nomes chegam como "Top Demandas Accelerator - MSI | Gabriela Soares | F":
 * como todos têm "MSI" e quase todos têm "Sócia", os produtos de nome mais específico vêm
 * primeiro e o principal fica por último.
 */

/**
 * Só produtos DESTA oferta liberam o bot. As contas da Hubla, da Payt e da LastLink também vendem produtos de
 * outros experts (Máquina Hydra/MGA, Mentoria Hydra Evolution, Paola Lellis, Bianca Rodrigues...): nome que não
 * casa aqui é "outra oferta" e é ignorado, na compra (webhook) e na planilha. Visto nas planilhas de 09/10/2026.
 */
export const DA_OFERTA_RE = /gabriela soares|socia invisivel|socia suprema|socia vitalicia|top demandas|cofre pix|pix relampago|\bmsi\b/;

/**
 * Produtos da oferta que NÃO liberam o bot (registra e ignora).
 * MSI: "Plataforma Soffia AI - MSI" (ferramenta de IA vendida na Payt, não é aula) — a confirmar com a dona do produto.
 */
export const SEM_ACESSO_RE: RegExp[] = [/soff?ia/];

export const MAPA_NOMES_DE_PRODUTO: { re: RegExp; products: Product[] }[] = [
  { re: /socia suprema|mentoria/, products: ["mentoria"] },
  { re: /top demandas|accelerator/, products: ["top_demandas"] },
  { re: /cofre pix|pix relampago/, products: ["cofre_pix"] },
  { re: /socia vitalicia|vitalicia/, products: ["vitalicia"] },
  { re: /socia invisivel|\bmsi\b/, products: ["principal"] },
];

/**
 * Payt: só mapeia quando o nome é inequívoco (sem combo e sem "padrão").
 * Nome não reconhecido fica pendente para mapear no painel (Webhooks).
 */
export const MAPA_NOMES_PAYT: { re: RegExp; product: Product }[] = [
  { re: /socia suprema|mentoria/, product: "mentoria" },
  { re: /top demandas|accelerator/, product: "top_demandas" },
  { re: /cofre pix|pix relampago/, product: "cofre_pix" },
  { re: /socia vitalicia|vitalicia/, product: "vitalicia" },
  { re: /socia invisivel|\bmsi\b/, product: "principal" },
];

/* ------------------------------------------------------------------ */
/* Comunidade e atendimento humano por produto                          */
/* ------------------------------------------------------------------ */

export const COMUNIDADE = {
  /** Como o bot chama a comunidade (nunca "grupo"). */
  nome: "Comunidade do Método Sócia Invisível",
  /** Texto do botão. */
  rotulo: "Entrar na Comunidade",
  /** Texto do botão rápido "Comunidade". */
  mensagem: "Aqui está o acesso à comunidade liberado para o seu produto.",
  /**
   * Link para quem tem um produto da lista abaixo (prioridade na ordem).
   * ⚠️ A comunidade da Mentoria Sócia Suprema ainda vai ser criada (04/10/2026). Quando existir:
   * [{ product: "mentoria", url: "https://chat.whatsapp.com/..." }]. Até lá, todas recebem a comunidade padrão.
   */
  porProduto: [] as { product: Product; url: string }[],
  /** Link para todos os outros (comunidade do Método Sócia Invisível, no WhatsApp). */
  padrao: "https://chat.whatsapp.com/G1JEuuigWnu4IDajeilOS0",
};

export function communityUrlFor(products: readonly Product[]) {
  return COMUNIDADE.porProduto.find((c) => products.includes(c.product))?.url ?? COMUNIDADE.padrao;
}

/**
 * Cartão "Falar com o atendimento humano".
 * MSI (04/10/2026): o link humano é o WhatsApp do acompanhamento de 7 dias e só é liberado na
 * Ativação aceita. Nos casos oficiais (atalhos.ts › CASOS_ATENDIMENTO_HUMANO) não há link: o servidor
 * responde e registra no painel. No MGA o cartão aparecia também nesses casos (cartaoNosCasos = true).
 */
export const ATENDIMENTO_HUMANO = {
  rotulo: "Falar com o atendimento humano",
  padrao: OFFICIAL_LINKS.whatsapp_7d.url as string,
  /** Formulário próprio para quem tem só um destes produtos (MSI: nenhum). */
  porProduto: [] as { product: Product; url: string }[],
  /** true = cartão também nos casos oficiais (como no MGA); false = só na Ativação aceita (MSI). */
  cartaoNosCasos: false,
};

export function supportUrlFor(products: readonly Product[]) {
  if (products.includes(PRODUTO_PADRAO)) return ATENDIMENTO_HUMANO.padrao;
  return ATENDIMENTO_HUMANO.porProduto.find((c) => products.includes(c.product))?.url ?? ATENDIMENTO_HUMANO.padrao;
}
