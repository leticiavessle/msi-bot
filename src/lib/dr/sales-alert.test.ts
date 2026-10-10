import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { detectSalesInterest, groupSalesAlerts, type SalesAlertRow } from "./sales-alert";

describe("alerta de venda: dispara e reconhece o produto", () => {
  for (const [s, product] of [
    ["qual o valor da mentoria?", "mentoria"],
    ["quanto custa a Mentoria Sócia Suprema?", "mentoria"],
    ["quero comprar o Top Demandas", "top_demandas"],
    ["tem desconto no Cofre PIX?", "cofre_pix"],
    ["como faço pra garantir a Sócia Vitalícia?", "vitalicia"],
    ["vale a pena comprar a mentoria?", "mentoria"],
    ["dá pra parcelar o Método Sócia Invisível pra minha irmã?", "principal"],
    ["comprei o método, quanto custa o accelerator?", "top_demandas"],
  ] as const) test(s, () => assert.deepEqual(detectSalesInterest(s), { product }));
});

describe("alerta de venda: dispara sem produto citado", () => {
  for (const s of ["qual o preço do curso?", "tem cupom pra outro produto?", "quero fazer o upgrade do meu plano"])
    test(s, () => assert.deepEqual(detectSalesInterest(s), { product: null }));
});

describe("alerta de venda: não dispara", () => {
  for (const s of [
    "quanto custa o plano da Sofia?",
    "qual o valor que eu cobro numa demanda?",
    "quanto cobrar pelo serviço no Workana?",
    "a parcela do curso foi cobrada duas vezes",
    "quero meu dinheiro de volta",
    "quero cancelar a compra",
    "comprei a mentoria e não liberou nada",
    "como funciona o ciclo de pagamento?",
    "onde fica a aula 3 do módulo 4?",
  ]) test(s, () => assert.equal(detectSalesInterest(s), null));
});

const row = (p: Partial<SalesAlertRow>): SalesAlertRow => ({
  id: crypto.randomUUID(), user_id: "u1", conversation_id: "c1", trigger_text: "qual o valor da mentoria?",
  product: "mentoria", status: "pending", resolved_by: null, resolved_at: null, created_at: "2026-10-04T10:00:00Z", ...p,
});

describe("alerta de venda: agrupamento", () => {
  test("uma linha por pessoa, com os produtos perguntados sem repetir", () => {
    const g = groupSalesAlerts([row({}), row({ product: "cofre_pix", created_at: "2026-10-04T11:00:00Z" }), row({})], "pending");
    assert.equal(g.length, 1);
    assert.equal(g[0]!.count, 3);
    assert.deepEqual(g[0]!.askedProducts.sort(), ["cofre_pix", "mentoria"]);
  });
  test("atendida sai dos pendentes e vai para os atendidos", () => {
    const done = [row({ status: "resolved", resolved_at: "2026-10-04T12:00:00Z" })];
    assert.equal(groupSalesAlerts(done, "pending").length, 0);
    assert.equal(groupSalesAlerts(done, "resolved").length, 1);
  });
});
