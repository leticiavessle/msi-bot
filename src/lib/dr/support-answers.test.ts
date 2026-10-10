import assert from "node:assert/strict";
import { describe, test as it } from "node:test";
import { isAdsTechnical, matchSupportAnswers, SUPPORT_ANSWERS } from "./support-answers";
import { isRefundTrigger } from "./refund-protocol";

describe("respostas oficiais do suporte (MSI)", () => {
  it("começa vazia: nada do MGA (BM, anúncios, Payt) responde por aqui", () => {
    assert.equal(SUPPORT_ANSWERS.length, 0);
    for (const q of ["Como criar BM?", "Meus criativos foram rejeitados", "questionário da afiliação na Payt"])
      assert.equal(matchSupportAnswers(q).length, 0);
  });
  it("toda resposta oficial cadastrada tem id, texto e padrão", () => {
    for (const a of SUPPORT_ANSWERS) {
      assert.ok(a.id && a.title && a.answer);
      assert.ok(a.match.length > 0);
    }
  });
});

describe("assunto técnico das plataformas não abre o 7D (MSI)", () => {
  for (const q of [
    "quero cancelar a minha proposta no 99Freelas",
    "o cliente pediu pra cancelar o projeto",
    "como cancelo o plano da Sofia?",
    "quero cancelar minha conta no Workana",
    "desisti do pedido no GetNinjas, perco as moedas?",
  ])
    it(q, () => assert.equal(isAdsTechnical(q), true));
  for (const q of ["quero cancelar minha compra", "quero meu reembolso", "quero desistir do curso", "quero cancelar"])
    it(`${q} → continua sendo pedido (7D)`, () => {
      assert.equal(isAdsTechnical(q), false);
      assert.equal(isRefundTrigger(q), true);
    });
});
