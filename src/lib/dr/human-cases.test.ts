import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { humanCardCases, serverHandledHumanCase } from "./human-cases";
import { ATENDIMENTO_HUMANO } from "../../oferta/produtos";
import { OFFICIAL_LINKS } from "../../oferta/links";
import { detectSalesInterest } from "./sales-alert";

describe("MSI: atendimento humano só na Ativação aceita", () => {
  test("o cartão humano leva ao WhatsApp do acompanhamento de 7 dias", () => {
    assert.equal(ATENDIMENTO_HUMANO.cartaoNosCasos, false);
    assert.equal(ATENDIMENTO_HUMANO.padrao, OFFICIAL_LINKS.whatsapp_7d.url);
  });
  test("comprei e não tenho acesso → servidor responde e manda para a aba Acessos", () => {
    const c = serverHandledHumanCase("comprei ontem e até agora não tenho acesso");
    assert.equal(c?.painel, "acessos");
    assert.equal(c?.nota, "Acesso, veio do bot");
    assert.equal(/wa\.me|https?:/.test(c!.resposta), false);
  });
  for (const s of ["fui cobrada duas vezes no cartão", "teve uma cobrança indevida na minha fatura", "não reconheço essa compra"])
    test(`${s} → aba Alertas`, () => assert.equal(serverHandledHumanCase(s)?.painel, "alertas"));
  test("dúvida comum não é caso humano", () => assert.equal(serverHandledHumanCase("como funciona o ciclo de pagamento?"), null));
  test("no prompt, o cartão só existe na Ativação aceita", () => {
    assert.deepEqual(humanCardCases("Ativação Sócia Invisível"), ["Ativação Sócia Invisível aceita no Protocolo 7D"]);
  });
});

describe("MSI: nomes antigos do método", () => {
  test("pergunta de preço da Mentoria Projetos Remunerados é do Método Sócia Invisível, não da Sócia Suprema", () => {
    assert.deepEqual(detectSalesInterest("quanto custa a mentoria projetos remunerados?"), { product: "principal" });
  });
});
