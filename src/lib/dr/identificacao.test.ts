import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { describe, test } from "node:test";
import {
  ACENTOS_DE,
  ACENTOS_PARA,
  PARTICULAS_NOME,
  chaveTelefone,
  cpfValido,
  escolherCadastro,
  formatarCpf,
  formatarTelefone,
  mascararEmail,
  nomeCompletoValido,
  normalizarCpf,
  normalizarNome,
  normalizarTelefone,
  passouDoLimite,
  proximaEtapa,
  viaPrecisaConferir,
  type CadastroCandidato,
} from "./identificacao";

describe("CPF", () => {
  test("dígitos verificadores", () => {
    assert.equal(cpfValido("52998224725"), true);
    assert.equal(cpfValido("52998224726"), false);
    assert.equal(cpfValido("11111111111"), false);
    assert.equal(cpfValido("1234567890"), false);
  });
  test("aceita com pontos e traço; recusa CNPJ", () => {
    assert.equal(normalizarCpf("529.982.247-25"), "52998224725");
    assert.equal(normalizarCpf("11.222.333/0001-81"), null);
    assert.equal(normalizarCpf(""), null);
  });
  test("planilha que perdeu o zero do começo", () => {
    assert.equal(normalizarCpf("1234567890"), null);
    assert.equal(normalizarCpf("1234567890", { completarZeros: true }) !== null, cpfValido("01234567890"));
    assert.equal(normalizarCpf("6573618017", { completarZeros: true }), "06573618017");
  });
  test("formata para a equipe", () => {
    assert.equal(formatarCpf("52998224725"), "529.982.247-25");
  });
});

describe("WhatsApp", () => {
  test("mesma pessoa, vários jeitos de escrever", () => {
    const formas = ["(31) 98888-7777", "+55 31 98888-7777", "5531988887777", "031988887777", "31 8888-7777", "553188887777"];
    const chaves = formas.map((f) => chaveTelefone(normalizarTelefone(f)!));
    assert.deepEqual(new Set(chaves), new Set(["3188887777"]));
  });
  test("guarda com 55", () => {
    assert.equal(normalizarTelefone("(31) 98888-7777"), "5531988887777");
    assert.equal(normalizarTelefone("0055 11 91234-5678"), "5511912345678");
  });
  test("sem DDD ou inválido não vale", () => {
    assert.equal(normalizarTelefone("98888-7777"), null);
    assert.equal(normalizarTelefone("(31) 88888-7777"), null); // 9 números sem começar com 9
    assert.equal(normalizarTelefone("(00) 98888-7777"), null);
    assert.equal(normalizarTelefone(""), null);
  });
  test("número de fora do Brasil fica como veio", () => {
    assert.equal(normalizarTelefone("+351 912 345 678"), "351912345678");
    assert.equal(chaveTelefone("351912345678"), "351912345678");
  });
  test("formata para mostrar", () => {
    assert.equal(formatarTelefone("5531988887777"), "(31) 98888-7777");
    assert.equal(formatarTelefone("553188887777"), "(31) 8888-7777");
  });
});

describe("nome", () => {
  test("sem acento, sem maiúscula, sem de/da/dos", () => {
    assert.equal(normalizarNome("  MARIA  da Conceição dos Santos "), "maria conceicao santos");
    assert.equal(normalizarNome("Maria Conceicao Santos"), "maria conceicao santos");
    assert.equal(normalizarNome("Ana D'Ávila"), "ana avila");
    assert.equal(normalizarNome("   "), null);
  });
  test("nome completo = pelo menos duas palavras", () => {
    assert.equal(nomeCompletoValido("Maria"), false);
    assert.equal(nomeCompletoValido("Maria de"), false);
    assert.equal(nomeCompletoValido("Maria Souza"), true);
  });
  test("tabela de acentos igual à do banco (migração)", () => {
    assert.equal([...ACENTOS_DE].length, [...ACENTOS_PARA].length);
    for (const [i, letra] of [...ACENTOS_DE].entries()) {
      assert.equal(letra.normalize("NFD").replace(/[̀-ͯ]/g, ""), [...ACENTOS_PARA][i], letra);
    }
    const sql = readFileSync(new URL("../../../supabase/migrations/20261009010000_identificacao.sql", import.meta.url), "utf8");
    assert.ok(sql.includes(`'${ACENTOS_DE}'`), "letras com acento");
    assert.ok(sql.includes(`'${ACENTOS_PARA}'`), "letras sem acento");
    assert.ok(sql.includes(PARTICULAS_NOME.map((p) => `'${p}'`).join(", ")), "partículas");
    assert.ok(sql.includes("'^55[0-9]{10,11}$' then substr(telefone, 3, 2) || right(telefone, 8)"), "chave do telefone");
  });
});

describe("e-mail escondido", () => {
  test("mostra só o começo e o domínio", () => {
    assert.equal(mascararEmail("mariana.souza@gmail.com"), "ma•••@gmail.com");
    assert.equal(mascararEmail("ab@x.com"), "a•••@x.com");
  });
});

const c = (p: Partial<CadastroCandidato> & { id: string }): CadastroCandidato => ({
  email: `${p.id}@x.com`,
  status: "active",
  access_expires_at: null,
  ...p,
});

describe("qual cadastro vale", () => {
  test("nenhum ativo = não encontrado (reembolsado não entra por reserva)", () => {
    const r = escolherCadastro("cpf", [c({ id: "a", status: "refunded" })]);
    assert.equal(r.cadastro, null);
  });
  test("vencido não entra", () => {
    const r = escolherCadastro("nome", [c({ id: "a", access_expires_at: "2020-01-01T00:00:00Z" })]);
    assert.equal(r.cadastro, null);
  });
  test("CPF em dois e-mails: vale o mais recente", () => {
    const r = escolherCadastro("cpf", [
      c({ id: "velho", last_login_at: "2026-09-01T00:00:00Z" }),
      c({ id: "novo", last_login_at: "2026-10-01T00:00:00Z" }),
    ]);
    assert.equal(r.cadastro?.id, "novo");
  });
  test("nome com homônimo não entra", () => {
    const r = escolherCadastro("nome", [c({ id: "a", cpf: "1" }), c({ id: "b", cpf: "2" })]);
    assert.deepEqual(r, { cadastro: null, motivo: "homonimo" });
  });
  test("nome repetido mas mesmo CPF (mesma pessoa, dois e-mails) entra", () => {
    const r = escolherCadastro("nome", [c({ id: "a", cpf: "1" }), c({ id: "b", cpf: "1", updated_at: "2026-10-01" })]);
    assert.equal(r.cadastro?.id, "b");
  });
  test("WhatsApp em dois cadastros: desempata pelo nome digitado", () => {
    const lista = [c({ id: "mae", nome_busca: "ana souza" }), c({ id: "filha", nome_busca: "julia souza" })];
    assert.equal(escolherCadastro("whatsapp", lista, { nomeBusca: "julia souza" }).cadastro?.id, "filha");
    assert.deepEqual(escolherCadastro("whatsapp", lista, { nomeBusca: "outra pessoa" }), { cadastro: null, motivo: "varios" });
  });
});

describe("etapas, dupla checagem e limite", () => {
  test("ordem e-mail › CPF › nome › WhatsApp", () => {
    assert.equal(proximaEtapa("email"), "cpf");
    assert.equal(proximaEtapa("cpf"), "nome");
    assert.equal(proximaEtapa("nome"), "whatsapp");
    assert.equal(proximaEtapa("whatsapp"), null);
  });
  test("link direto só para e-mail e CPF (decisão d)", () => {
    assert.equal(viaPrecisaConferir("email"), false);
    assert.equal(viaPrecisaConferir("email_anterior"), false);
    assert.equal(viaPrecisaConferir("cpf"), false);
    assert.equal(viaPrecisaConferir("nome"), true);
    assert.equal(viaPrecisaConferir("whatsapp"), true);
    assert.equal(viaPrecisaConferir(null), false);
  });
  test("limite por aparelho e por rede", () => {
    assert.equal(passouDoLimite({ aparelho: 5, rede: 5 }), false);
    assert.equal(passouDoLimite({ aparelho: 6, rede: 6 }), true);
    assert.equal(passouDoLimite({ aparelho: 0, rede: 20 }), true);
  });
});
