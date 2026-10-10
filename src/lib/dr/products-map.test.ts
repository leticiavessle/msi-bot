import { describe, expect, test } from "bun:test";
import { resolveProductName, parseStudentsCsv } from "./csv";
import { ADAPTERS, cademiProductRefs, paytProductFromName } from "./webhooks.server";

describe("produtos Hubla", () => {
  test("cada nome de compra da MSI vira o produto certo (o principal fica por último)", () => {
    const casos: [string, string][] = [
      ["Método Sócia Invisível | Gabriela Soares | F", "principal"],
      ["Top Demandas Accelerator - MSI | Gabriela Soares | F", "top_demandas"],
      ["Cofre PIX Relâmpago - MSI | Gabriela Soares | Y", "cofre_pix"],
      ["Mentoria Sócia Suprema - MSI | Gabriela Soares | INT", "mentoria"],
      ["Sócia Vitalícia - MSI | Gabriela Soares | F", "vitalicia"],
    ];
    for (const [nome, produto] of casos) expect(resolveProductName(nome)).toEqual({ products: [produto], known: true });
  });
  test("nome da MSI ainda não mapeado cai no produto padrão marcado como não confirmado", () => {
    expect(resolveProductName("Produto Novo | Gabriela Soares")).toEqual({ products: ["principal"], known: false });
  });
  test("produto de outro expert na mesma conta não libera o bot", () => {
    for (const nome of [
      "Máquina Hydra de Ganhos Automáticos | Jeoacas Pereira | F",
      "Mentoria Hydra Evolution | Jeoacas Pereira",
      "Mentoria Império Da Renda Academy | Paola Lellis [197]",
      "Super Acesso Vitalício Hydra | Jeoacas Pereira | F",
      "Guia Finanças Online",
      "Produto X",
    ]) expect(resolveProductName(nome)).toEqual({ products: [], known: true, outraOferta: true });
  });
  test("Mentoria Sócia Suprema em qualquer forma de nome", () => {
    for (const nome of ["Mentoria Sócia Suprema", "MENTORIA SOCIA SUPREMA [1997]", "Mentoria Sócia Suprema - MSI | Gabriela Soares | F"]) {
      expect(resolveProductName(nome).products).toEqual(["mentoria"]);
      expect(paytProductFromName(nome)).toBe("mentoria");
    }
  });
  test("Plataforma Soffia AI - MSI não libera o bot", () => {
    expect(resolveProductName("Plataforma Soffia AI - MSI [97]").products).toEqual([]);
  });
  test("webhook Hubla de produto de outro expert é ignorado", () => {
    const n = ADAPTERS["hubla"]!.parse({ type: "invoice.payment_succeeded", event: { user: { email: "a@b.com" }, product: { name: "Mentoria Hydra Evolution | Jeoacas Pereira | F" } } });
    expect(n?.noAccessProduct).toBe("Mentoria Hydra Evolution | Jeoacas Pereira | F");
    expect(n?.product).toBeNull();
  });
  test("webhook Hubla do upsell libera só o upsell", () => {
    const n = ADAPTERS["hubla"]!.parse({ type: "invoice.payment_succeeded", event: { user: { email: "a@b.com" }, product: { name: "Cofre PIX Relâmpago - MSI | Gabriela Soares | F" } } });
    expect(n?.product).toBe("cofre_pix");
    expect(n?.productConfirmed).toBe(true);
  });
  test("planilha Hubla com front e mentoria", () => {
    const csv = "Nome do cliente,Email do cliente,Nome do produto,Status da fatura\nA,a@b.com,Método Sócia Invisível | Gabriela Soares | F,Paga\nB,b@b.com,Mentoria Sócia Suprema - MSI | Gabriela Soares | F,Paga";
    const r = parseStudentsCsv(csv);
    if (r.format === "hubla") {
      expect(r.rows.map((x) => x.products)).toEqual([["principal"], ["mentoria"]]);
    }
  });
});

describe("produtos Payt", () => {
  test("nome inequívoco vira produto; desconhecido fica pendente", () => {
    expect(paytProductFromName("Top Demandas Accelerator - MSI")).toBe("top_demandas");
    expect(paytProductFromName("Método Sócia Invisível")).toBe("principal");
    expect(paytProductFromName("Oferta qualquer")).toBeNull();
  });
  test("produto de outro expert ou Soffia: ignorado, sem Payt provisório", () => {
    for (const nome of ["Guia Finanças Online", "Plataforma Soffia AI - MSI [97]", "Máquina Hydra de Ganhos Automáticos - MGA | Jeoacas Pereira [197]"]) {
      const n = ADAPTERS["payt"]!.parse({ status: "paid", transaction_id: "t", customer: { email: "a@b.com" }, product: { name: nome } });
      expect(n?.noAccessProduct).toBe(nome);
      expect(n?.unmappedProductName).toBeNull();
      expect(n?.product).toBeNull();
    }
  });
});

describe("produto da Cademí em vários formatos", () => {
  test("texto, número, lista e objeto", () => {
    expect(cademiProductRefs("Cofre PIX Relâmpago").names).toEqual(["Cofre PIX Relâmpago"]);
    expect(cademiProductRefs(123).ids).toEqual(["123"]);
    expect(cademiProductRefs([{ id: 7, nome: "Mentoria Sócia Suprema" }, { codigo: "99" }])).toEqual({ names: ["Mentoria Sócia Suprema"], ids: ["99"] });
    expect(cademiProductRefs("12,34").ids).toEqual(["12", "34"]);
  });
  const ev = (extra: Record<string, unknown>) =>
    ADAPTERS["cademi"]!.parse({ event: "user.created", payload: { user: { email: "x@y.com", nome: "X" }, ...extra } });
  test("sem produto: produto padrão e aviso", () => {
    const n = ev({});
    expect(n?.products).toEqual(["principal"]);
    expect(n?.cademiMissingProduct).toBe(true);
    expect(n?.productConfirmed).toBe(false);
  });
  test("com nome: produto confirmado", () => {
    const n = ev({ produto: "Top Demandas Accelerator" });
    expect(n?.products).toEqual(["top_demandas"]);
    expect(n?.productConfirmed).toBe(true);
  });
  test("só com id: guarda o código para mapear", () => {
    const n = ev({ produto: { id: 555 } });
    expect(n?.cademiProductIds).toEqual(["555"]);
    expect(n?.productConfirmed).toBe(false);
  });
});

describe("webhook da LastLink (formato da documentação oficial)", () => {
  const ll = (Event: string, Data: Record<string, unknown>) => ADAPTERS["lastlink"]!.parse({ Id: "ev-1", IsTest: false, Event, CreatedAt: "2026-10-09T12:00:00Z", Data });
  const buyer = { Buyer: { Email: "Ana@Email.com", Name: "Ana Souza" } };
  test("compra completa libera o produto certo", () => {
    const n = ll("Purchase_Order_Confirmed", { ...buyer, Products: [{ Id: "p1", Name: "Método Sócia Invisível" }] });
    expect(n?.eventType).toBe("purchase_approved");
    expect(n?.email).toBe("ana@email.com");
    expect(n?.product).toBe("principal");
    expect(n?.accessSource).toBe("lastlink");
    expect(n?.productConfirmed).toBe(true);
  });
  test("compra com dois produtos libera os dois", () => {
    const n = ll("Purchase_Order_Confirmed", { ...buyer, Products: [{ Name: "Método Sócia Invisível" }, { Name: "Cofre PIX Relâmpago - MSI" }] });
    expect(n?.products?.sort()).toEqual(["cofre_pix", "principal"]);
  });
  test("reembolso, estorno e cancelamento", () => {
    expect(ll("Payment_Refund", { ...buyer, Products: [{ Name: "Top Demandas Accelerator" }] })?.eventType).toBe("refund");
    expect(ll("Payment_Chargeback", { ...buyer, Products: [] })?.eventType).toBe("chargeback");
    expect(ll("Subscription_Canceled", buyer)?.eventType).toBe("subscription_canceled");
    expect(ll("Product_Access_Ended", buyer)?.eventType).toBe("access_revoked");
  });
  test("liberação/remoção de acesso pela ação", () => {
    expect(ll("Subscription_Product_Access", { ...buyer, Action: "Add" })?.eventType).toBe("purchase_approved");
    expect(ll("Subscription_Product_Access", { ...buyer, Action: "Remove" })?.eventType).toBe("access_revoked");
  });
  test("carrinho abandonado e fatura criada não mexem no acesso", () => {
    expect(ll("Abandoned_Cart", buyer)).toBeNull();
    expect(ll("Purchase_Request_Confirmed", buyer)).toBeNull();
    expect(ll("Refund_Requested", buyer)).toBeNull();
  });
  test("a senha vai no endereço (?token=)", () => {
    expect(ADAPTERS["lastlink"]!.tokenQueryParam).toBe("token");
    expect(ADAPTERS["lastlink"]!.secretEnv).toBe("WEBHOOK_SECRET_LASTLINK");
  });
});
