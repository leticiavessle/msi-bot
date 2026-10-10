import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { isPaidInvoiceStatus, parseStudentsCsv } from "./csv";

describe("status de fatura", () => {
  test("só Paga, Aprovada e Ativa liberam", () => {
    assert.equal(isPaidInvoiceStatus("Paga"), true);
    assert.equal(isPaidInvoiceStatus("Aprovada"), true);
    assert.equal(isPaidInvoiceStatus("Ativa"), true);
  });
  test("as seis palavras bloqueadas nunca liberam", () => {
    for (const s of ["Não paga", "Em aberto", "Reembolsada", "Chargeback", "Em disputa", "Nao paga"]) {
      assert.equal(isPaidInvoiceStatus(s), false);
    }
  });
  test("faturas Hubla não pagas são ignoradas", () => {
    const csv = [
      "ID da fatura,Email do cliente,Nome do cliente,Status da fatura",
      "1,a@x.com,A,Paga",
      "2,b@x.com,B,Não paga",
      "3,c@x.com,C,Em aberto",
      "4,d@x.com,D,Reembolsada",
      "5,e@x.com,E,Chargeback",
      "6,f@x.com,F,Em disputa",
    ].join("\n");
    const res = parseStudentsCsv(csv);
    assert.deepEqual(res.rows.map((r) => r.email), ["a@x.com"]);
    assert.equal(res.skippedRows.length, 5);
  });
});
