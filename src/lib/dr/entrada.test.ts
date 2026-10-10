import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { acharColuna, parseStudentsCsv, situacaoDoPagamento } from "./csv";
import { ADAPTERS } from "./webhooks.server";
import { dadosDeReserva, juntarCadastros, juntarDadosDeReserva } from "./identificacao";
import { textoDuplaChecagem } from "./human-cases";

// CPFs válidos de exemplo (gerados para teste, não são de ninguém).
const CPF = "52998224725";
const CPF_SEM_ZERO = "6573618017"; // 065.736.180-17 depois que o Excel tirou o zero

describe("planilhas: colunas de CPF e WhatsApp pelo nome", () => {
  test("nomes que a Hubla, a Payt e a LastLink usam", () => {
    const h = (cols: string[]) => ({ cpf: acharColuna(cols, "cpf"), fone: acharColuna(cols, "telefone"), nome: acharColuna(cols, "nome") });
    assert.deepEqual(h(["Nome completo", "E-mail", "Telefone / WhatsApp", "CPF / CNPJ"]), { cpf: 3, fone: 2, nome: 0 });
    assert.deepEqual(
      h(["Nome do Comprador (Customer Name)", "E-mail (Customer Email)", "Telefone/Celular (Customer Phone)", "Documento (CPF/CNPJ)"]),
      { cpf: 3, fone: 2, nome: 0 },
    );
    assert.deepEqual(h(["Nome do produto", "Nome do cliente", "Documento do cliente", "Telefone do cliente"]), { cpf: 2, fone: 3, nome: 1 });
  });
  test("coluna do afiliado ou do produtor nunca vale", () => {
    assert.equal(acharColuna(["Telefone do afiliado", "Telefone do cliente"], "telefone"), 1);
    assert.equal(acharColuna(["Documento do produtor"], "cpf"), -1);
    assert.equal(acharColuna(["Tipo de documento", "Documento"], "cpf"), 1);
  });

  test("Hubla: CPF e telefone entram na linha da aluna", () => {
    const csv = [
      "ID da fatura,Nome do cliente,Email do cliente,Documento do cliente,Telefone do cliente,Nome do produto,Status da fatura",
      `1,Ana Souza,ana@x.com,529.982.247-25,(31) 98888-7777,Método Sócia Invisível | Gabriela Soares | F,Paga`,
    ].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.format, "hubla");
    assert.equal(r.rows[0]?.cpf, CPF);
    assert.equal(r.rows[0]?.telefone, "5531988887777");
    assert.equal(r.colunas?.cpf, "Documento do cliente");
  });

  test("Payt/LastLink (planilha com cabeçalho): status pago entra, reembolso e pendente não", () => {
    const csv = [
      "Nome do Comprador;E-mail;Telefone / WhatsApp;CPF / CNPJ;Produto;Status",
      `Ana Souza;ana@x.com;31988887777;${CPF};Método Sócia Invisível;Aprovada`,
      "Bia Lima;bia@x.com;11912345678;;Método Sócia Invisível;Reembolsada",
      "Caio Melo;caio@x.com;;;Método Sócia Invisível;Aguardando pagamento",
    ].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.format, "planilha");
    assert.deepEqual(r.rows.map((x) => x.email), ["ana@x.com"]);
    assert.equal(r.rows[0]?.cpf, CPF);
    assert.equal(r.rows[0]?.telefone, "5531988887777");
    assert.equal(r.semStatus, false);
    assert.match(r.skippedRows.find((x) => x.email === "bia@x.com")?.reason ?? "", /reembolso/);
    assert.match(r.skippedRows.find((x) => x.email === "caio@x.com")?.reason ?? "", /não pago/);
  });

  test("sem coluna de status: avisa o painel; zero perdido do CPF e DDD separado", () => {
    const csv = ["Nome,E-mail,DDD,Telefone,CPF", `Ana Souza,ana@x.com,31,98888-7777,${CPF_SEM_ZERO}`].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.semStatus, true);
    assert.equal(r.rows[0]?.cpf, "06573618017");
    assert.equal(r.rows[0]?.telefone, "5531988887777");
  });

  test("CPF inválido ou CNPJ não entra; a linha continua", () => {
    const csv = ["Nome,E-mail,CPF / CNPJ,Status", "Loja X,loja@x.com,11.222.333/0001-81,Paga"].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.rows.length, 1);
    assert.equal(r.rows[0]?.cpf, null);
  });

  test("formato simples continua igual (e aceita cpf e telefone no fim)", () => {
    const r = parseStudentsCsv(`email;nome;produtos;cpf;telefone\nana@x.com;Ana;principal;${CPF};31988887777`);
    assert.equal(r.format, "simples");
    assert.equal(r.rows.length, 1);
    assert.equal(r.rows[0]?.cpf, CPF);
    assert.equal(r.skippedRows.length, 0);
    assert.equal(parseStudentsCsv("ana@x.com;Ana;principal").rows[0]?.products[0], "principal");
  });
});

describe("webhooks: CPF e telefone da compra", () => {
  test("Hubla v2", () => {
    const n = ADAPTERS["hubla"]!.parse({
      type: "invoice.payment_succeeded",
      event: {
        product: { name: "Método Sócia Invisível" },
        invoice: { id: "f1", status: "paid" },
        user: { email: "ana@x.com", firstName: "Ana", lastName: "Souza", document: CPF, phone: "+5531988887777" },
      },
    });
    assert.equal(n?.document, CPF);
    assert.equal(n?.phone, "+5531988887777");
  });
  test("Payt", () => {
    const n = ADAPTERS["payt"]!.parse({
      status: "paid",
      transaction_id: "t1",
      customer: { email: "ana@x.com", name: "Ana", doc: "529.982.247-25", phone: "31988887777" },
      product: { name: "Método Sócia Invisível" },
    });
    assert.equal(n?.document, "529.982.247-25");
    assert.equal(n?.phone, "31988887777");
  });
  test("LastLink", () => {
    const n = ADAPTERS["lastlink"]!.parse({
      Id: "e1",
      Event: "Purchase_Order_Confirmed",
      Data: {
        Products: [{ Id: "p", Name: "Método Sócia Invisível" }],
        Buyer: { Email: "ana@x.com", Name: "Ana", Document: CPF, PhoneNumber: "5531988887777" },
      },
    });
    assert.equal(n?.document, CPF);
    assert.equal(n?.phone, "5531988887777");
  });
});

describe("dados de reserva no cadastro", () => {
  test("CPF completo (a equipe vê) e telefone com 55; CNPJ não entra", () => {
    assert.deepEqual(dadosDeReserva("529.982.247-25", "(31) 98888-7777"), { cpf: CPF, telefone: "5531988887777" });
    assert.deepEqual(dadosDeReserva("11.222.333/0001-81", null), { cpf: null, telefone: null });
  });
  test("CPF que já existe não é trocado; telefone novo vence só no webhook", () => {
    const atual = { cpf: "11111111111", telefone: "5531900000000" };
    const novo = { cpf: "22222222222", telefone: "5531988887777" };
    assert.deepEqual(juntarDadosDeReserva(atual, novo, { telefoneNovoVence: true }), {
      cpf: "11111111111",
      telefone: "5531988887777",
    });
    assert.equal(juntarDadosDeReserva(atual, novo, { telefoneNovoVence: false }).telefone, "5531900000000");
    assert.deepEqual(juntarDadosDeReserva(null, novo, { telefoneNovoVence: false }), novo);
    assert.equal(juntarDadosDeReserva(atual, { cpf: null, telefone: null }, { telefoneNovoVence: true }).telefone, "5531900000000");
  });
});

describe("dupla checagem no chat", () => {
  test("texto diz por onde ela entrou", () => {
    assert.match(textoDuplaChecagem("whatsapp"), /pelo WhatsApp/);
    assert.match(textoDuplaChecagem("nome"), /pelo nome/);
  });
});

describe("e-mail trocado: dois cadastros da mesma pessoa viram um", () => {
  const base = {
    role: "student" as const,
    access_expires_at: null,
    product_origin: "padrao",
    metadata: null,
    cpf: null,
    telefone: null,
    emails_anteriores: [],
  };
  test("produtos somam, ativo vence, dados que faltam são preenchidos", () => {
    const antigo = { ...base, id: "1", email: "velho@x.com", name: "Ana Souza", status: "refunded" as const, product_access: ["principal"], cpf: CPF, metadata: { access_history: [{ a: 1 }] } };
    const novo = { ...base, id: "2", email: "novo@x.com", name: null, status: "active" as const, product_access: ["mentoria"], telefone: "5531988887777", product_origin: "confirmado", metadata: { access_history: [{ b: 2 }] } };
    const j = juntarCadastros(antigo, novo);
    assert.equal(j.status, "active");
    assert.deepEqual(j.product_access.sort(), ["mentoria", "principal"]);
    assert.equal(j.name, "Ana Souza");
    assert.equal(j.cpf, CPF);
    assert.equal(j.telefone, "5531988887777");
    assert.equal(j.product_origin, "confirmado");
    assert.equal((j.metadata["access_history"] as unknown[]).length, 2);
  });
  test("vencimento: sem prazo vence; administradora continua administradora", () => {
    const a = { ...base, id: "1", email: "a@x.com", name: null, status: "active" as const, product_access: [], access_expires_at: "2027-01-01T00:00:00Z", role: "admin" as const };
    const b = { ...base, id: "2", email: "b@x.com", name: null, status: "active" as const, product_access: [] };
    assert.equal(juntarCadastros(a, b).access_expires_at, null);
    assert.equal(juntarCadastros(a, b).role, "admin");
  });
});

describe("planilhas reais (cabeçalhos de 09/10, dados inventados)", () => {
  test("Hubla: só produtos da MSI entram; Máquina Hydra e Mentoria Hydra ficam de fora", () => {
    const csv = [
      "ID da fatura,Status da fatura,Nome do produto,Nome do cliente,Documento do cliente,Email do cliente,Telefone do cliente",
      `1,Paga,Método Sócia Invisível | Gabriela Soares | F,Ana Souza,${CPF},ana@x.com,+5531988887777`,
      "2,Paga,Máquina Hydra de Ganhos Automáticos | Jeoacas Pereira | F,Beto Lima,11144477735,beto@x.com,+5511912345678",
      "3,Paga,Top Demandas Accelerator - MSI | Gabriela Soares | F,Ana Souza,,ana@x.com,",
    ].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.format, "hubla");
    assert.deepEqual(r.rows.map((x) => [x.email, x.products.sort().join("+"), x.cpf, x.telefone]), [
      ["ana@x.com", "principal+top_demandas", CPF, "5531988887777"],
    ]);
    assert.match(r.skippedRows[0]?.reason ?? "", /outra oferta \(Máquina Hydra/);
  });
  test("Payt: 'Cliente' é o nome; Soffia e produtos de outros experts não entram", () => {
    const csv = [
      "ID Fatura,Status Compra,Telefone,Cliente,Email,Documento,Status Pagamento,Produto",
      `1,Compra Aprovada,31988887777,Ana Souza,ana@x.com,${CPF},Pagamento Aprovado,Método Sócia Invisível`,
      "2,Compra Aprovada,11912345678,Bia Lima,bia@x.com,11144477735,Pagamento Aprovado,Plataforma Soffia AI - MSI [97]",
      "3,Compra Aprovada,11912345678,Caio Melo,caio@x.com,11144477735,Pagamento Aprovado,Guia Finanças Online",
      "4,Período Grátis,11912345678,Dani Reis,dani@x.com,11144477735,Período Grátis,Método Sócia Invisível",
      "5,Cancelada,11912345678,Edu Paz,edu@x.com,11144477735,Pagamento Cancelado,Método Sócia Invisível",
    ].join("\n");
    const r = parseStudentsCsv(csv);
    assert.equal(r.format, "planilha");
    assert.deepEqual(r.rows.map((x) => [x.email, x.name, x.cpf, x.telefone]), [["ana@x.com", "Ana Souza", CPF, "5531988887777"]]);
    const motivo = (e: string) => r.skippedRows.find((x) => x.email === e)?.reason ?? "";
    assert.match(motivo("bia@x.com"), /sem acesso ao bot/);
    assert.match(motivo("caio@x.com"), /outra oferta/);
    assert.match(motivo("dani@x.com"), /não pago/);
    assert.match(motivo("edu@x.com"), /reembolso\/cancelamento/);
    assert.equal(r.colunas?.nome, "Cliente");
  });
  test("LastLink: Expirada não entra; Mentoria Hydra Evolution não entra", () => {
    const csv = [
      "Identificador da venda,Status da venda,E-mail do membro,Nome/Razão social do membro,Telefone do membro,Documento do membro,Produto principal",
      `a,Aprovada,ana@x.com,Ana Souza ,+5531988887777,${CPF},Mentoria Sócia Suprema - MSI | Gabriela Soares`,
      `b,Expirada,bia@x.com,Bia Lima,+5511912345678,11144477735,Método Sócia Invisível | Gabriela Soares`,
      `c,Aprovada,caio@x.com,Caio Melo,+5511912345678,11144477735,Mentoria Hydra Evolution | Jeoacas Pereira`,
    ].join("\n");
    const r = parseStudentsCsv(csv);
    assert.deepEqual(r.rows.map((x) => [x.email, x.products.join("+"), x.name]), [["ana@x.com", "mentoria", "Ana Souza"]]);
    assert.equal(r.skippedRows.length, 2);
  });
  test("status das plataformas", () => {
    assert.equal(situacaoDoPagamento("Compra Aprovada"), "pago");
    assert.equal(situacaoDoPagamento("Aguardando Pagamento"), "nao_pago");
    assert.equal(situacaoDoPagamento("Período Grátis"), "nao_pago");
    assert.equal(situacaoDoPagamento("Expirada"), "nao_pago");
    assert.equal(situacaoDoPagamento("Compra Reembolsada"), "devolvido");
    assert.equal(situacaoDoPagamento("Pagamento Cancelado"), "devolvido");
    assert.equal(situacaoDoPagamento("Paga"), "pago");
  });
});
