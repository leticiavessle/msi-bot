import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { ATALHOS_EXECUCAO, QUICK_ACTIONS, CASOS_ATENDIMENTO_HUMANO } from "../../oferta/atalhos";
import { OFFICIAL_LINKS } from "../../oferta/links";
import { SUPPORT_ANSWERS } from "../../oferta/respostas-oficiais";
import { TOPICS, STAGES } from "../../oferta/relatorios";
import { INTENTS, SYNONYMS } from "../../oferta/vocabulario";
import { classifyIntents } from "./retrieval.server";

const atalho = (t: string) => ATALHOS_EXECUCAO.find((a) => a.re.test(t))?.id ?? null;

describe("MSI: atalho de cadastro por plataforma", () => {
  for (const [t, id] of [
    ["não consegui criar a conta no 99Freelas", "cadastro_99freelas"],
    ["não consigo me cadastrar na Workana", "cadastro_workana"],
    ["como faço o cadastro na Vinte Pila?", "cadastro_vinte_pila"],
    ["ainda não criei minha conta no GetNinjas", "cadastro_getninjas"],
    ["não consegui fazer meu cadastro no Vinte Conto", "cadastro_vinte_conto"],
    ["não consigo criar conta no Freelancer", "cadastro_freelancer"],
    ["não consegui criar a conta de freelancer no Workana", "cadastro_workana"],
  ] as const)
    test(t, () => assert.equal(atalho(t), id));
  test("dúvida que não é cadastro vai para a IA", () => assert.equal(atalho("como mando proposta no 99Freelas?"), null));
  test("todo atalho aponta para uma aula e não tem link solto", () => {
    for (const a of ATALHOS_EXECUCAO) {
      assert.match(a.aula ?? "", /^V1\.M\d{2}\.A\d{2}$/);
      assert.equal(/https?:/.test(a.texto), false);
    }
  });
});

describe("MSI: nada do MGA nos textos fixos e nas listas gravadas", () => {
  const MGA = /payt|\bstr\b|mgv|pmj|hydra|\bmga\b|an[úu]ncio|campanha|\bbm\b|pixel|tr[áa]fego|afilia|evolution|tiktok shop/i;
  test("botões rápidos", () => QUICK_ACTIONS.forEach((q) => assert.equal(MGA.test(q.label), false, q.label)));
  test("atalhos e casos humanos", () => {
    for (const a of ATALHOS_EXECUCAO) assert.equal(MGA.test(a.texto), false, a.id);
    for (const c of CASOS_ATENDIMENTO_HUMANO) assert.equal(MGA.test(c.resposta + c.descricao), false, c.nota);
  });
  test("links oficiais", () => {
    for (const [k, l] of Object.entries(OFFICIAL_LINKS)) assert.equal(MGA.test(`${k} ${l.label} ${l.url} ${l.quando}`), false, k);
  });
  test("respostas oficiais, temas, etapas, intenções e sinônimos", () => {
    assert.equal(SUPPORT_ANSWERS.some((a) => MGA.test(a.title + a.answer)), false);
    for (const x of [...TOPICS, ...STAGES, ...INTENTS]) assert.equal(MGA.test(x.replace(/_/g, " ")), false, x);
    for (const [k, v] of Object.entries(SYNONYMS)) assert.equal(MGA.test(`${k} ${v.join(" ")}`), false, k);
  });
});

describe("MSI: intenções", () => {
  for (const [t, intent] of [
    ["não consigo me cadastrar no 99freelas", "plataformas"],
    ["como mando proposta pro cliente?", "propostas"],
    ["quanto eu cobro pelo meu serviço?", "preco_servico"],
    ["quando eu recebo o pix?", "recebimento"],
    ["vale a pena o attapoll?", "pesquisas"],
  ] as const)
    test(t, () => assert.ok(classifyIntents(t).includes(intent), classifyIntents(t).join(",")));
});

describe("MSI: botão Onde encontrar demandas (resposta pronta)", () => {
  const botao = QUICK_ACTIONS.find((q) => q.intent === "plataformas")!;
  test("rótulo sem nomes de aplicativo", () => assert.equal(botao.label, "💼 Onde encontrar demandas"));
  test("3 aplicativos na ordem, com botões e cartões das aulas de cadastro", () => {
    assert.deepEqual(botao.resposta?.links, ["app_99freelas", "app_vintepila", "app_vinteconto"]);
    assert.deepEqual(botao.resposta?.aulas, ["V1.M07.A02", "V1.M10.A02", "V1.M12.A02"]);
    const t = botao.resposta!.texto;
    assert.ok(t.indexOf("99Freelas") < t.indexOf("Vinte Pila") && t.indexOf("Vinte Pila") < t.indexOf("Vinte Conto"));
    assert.ok(t.includes("CPF do cadastro precisa ser do mesmo titular da conta bancária"));
  });
  test("sem palavras proibidas da voz", () => {
    const PROIBIDAS = /\b(plataformas?|sites?|clientes?|servi[çc]os?|projetos?|tarefas?|atividades?|freelancers?(?!\.com)|trabalho|jornada)\b/i;
    assert.equal(PROIBIDAS.test(botao.resposta!.texto), false);
    for (const q of QUICK_ACTIONS) assert.equal(PROIBIDAS.test(q.label), false, q.label);
  });
});
