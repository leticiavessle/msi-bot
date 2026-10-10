import assert from "node:assert/strict";
import { describe, it } from "node:test";
import {
  EMPTY_FLOW,
  N154_REEMBOLSO,
  PROPOSAL_ROUTE_IDS,
  ROUTES,
  ATIVACAO_OPCOES,
  advanceFlow,
  classifyRoute,
  containsRefundEndpoint,
  guardRefundOutput,
  isHypotheticalRefund,
  proposalReplies,
  startFlow,
  stripEmoji,
  fillName,
  type RefundFlowState,
} from "./refund-protocol";
import * as PROTOCOLO from "../../oferta/protocolo-7d";
import { POLITICAS } from "../../oferta/marca";

const QUESTIONS = [
  "Posso pedir o reembolso depois se eu quiser?",
  "Mas eu consigo pedir o reembolso depois se eu quiser?",
  "Posso pedir o reembolso se eu não conseguir?",
  "E se eu não tiver resultado?",
  "Tem como cancelar depois?",
  "Dá pra pedir o dinheiro de volta depois?",
];

describe("trava final do Endpoint Vermelho", () => {
  it("classifica as seis perguntas como objeção e devolve a Rota 5", () => {
    for (const question of QUESTIONS) {
      assert.equal(isHypotheticalRefund(question), true, question);
      const outcome = startFlow(question, "Letícia");
      assert.equal(outcome.state.route, "5", question);
      assert.equal(outcome.state.endpoint, false, question);
      assert.equal(containsRefundEndpoint(outcome.content), false, question);
      assert.deepEqual(outcome.replies, ["✅ Quero Testar Sem Risco", "❌ Prefiro Deixar Como Está"], question);
      assert.ok(outcome.followUpContent?.startsWith("Isso quer dizer que"), question);
    }
  });

  it("substitui qualquer N152 abaixo de 4/4 pela Rota 5", () => {
    const stale: RefundFlowState = {
      ...EMPTY_FLOW,
      active: false,
      route: "1",
      stage: "encerrado",
      endpoint: true,
      insistencia_reembolso: 0,
    };
    for (const question of QUESTIONS) {
      const guarded = guardRefundOutput({
        content: N154_REEMBOLSO,
        state: stale,
        currentUserText: question,
        name: "Letícia",
      });
      assert.equal(guarded.audit.decision, "blocked", question);
      assert.equal(guarded.state.route, "5", question);
      assert.equal(guarded.state.endpoint, false, question);
      assert.equal(containsRefundEndpoint(guarded.content), false, question);
    }
  });

  it("mantém perguntas repetidas na Rota 5 sem voltar ao N002", () => {
    let outcome = startFlow("Reembolso", "Letícia");
    outcome = advanceFlow(outcome.state, "Não consegui", "Letícia");
    for (const question of QUESTIONS.slice(0, 2)) {
      outcome = advanceFlow(outcome.state, question, "Letícia");
      assert.equal(outcome.state.route, "5");
      assert.equal(outcome.state.endpoint, false);
      assert.equal(outcome.content.includes("Recebi a sua solicitação de reembolso aqui"), false);
      assert.equal(containsRefundEndpoint(outcome.content), false);
    }
  });

  it("protege a sequência Reembolso → motivo → duas perguntas repetidas", () => {
    const first = startFlow("Reembolso", "Letícia");
    assert.equal(first.content.includes("Recebi a sua solicitação de reembolso aqui"), true);
    const second = advanceFlow(first.state, "Não consegui", "Letícia");
    assert.equal(second.state.route, "1");
    assert.equal(second.content.includes("Posso te apresentar uma condição exclusiva?"), true);

    const third = advanceFlow(
      second.state,
      "Posso pedir o reembolso depois se eu quiser?",
      "Letícia",
    );
    assert.equal(third.state.route, "5");
    assert.equal(third.state.insistencia_reembolso, 0);
    assert.equal(containsRefundEndpoint(third.content), false);

    const fourth = advanceFlow(
      third.state,
      "Mas eu consigo pedir o reembolso depois se eu quiser?",
      "Letícia",
    );
    assert.equal(fourth.state.route, "5");
    assert.equal(fourth.state.insistencia_reembolso, 0);
    assert.equal(fourth.content.includes("Recebi a sua solicitação de reembolso aqui"), false);
    assert.equal(containsRefundEndpoint(fourth.content), false);
    assert.notEqual(fourth.content, third.content);
  });

  it("o botão de reembolso soma só uma insistência e não abre o e-mail", () => {
    const proposed = startFlow("Posso pedir reembolso se não der certo?", "Letícia");
    const refused = advanceFlow(
      proposed.state,
      "❌ Prefiro seguir com o reembolso",
      "Letícia",
    );
    assert.equal(refused.state.insistencia_reembolso, 1);
    assert.equal(refused.state.endpoint, false);
    assert.equal(containsRefundEndpoint(refused.content), false);
  });
});

describe("botões das propostas do Protocolo 7D", () => {
  it("percorre todas as rotas de proposta e exige aceitação e recusa", () => {
    for (const routeId of PROPOSAL_ROUTE_IDS) {
      const route = ROUTES[routeId];
      const replies = proposalReplies(route);
      assert.ok(replies.length >= 2, `Rota ${routeId} saiu com menos de dois botões`);
      assert.ok(
        route.options.some((option) => option.target.kind === "activation"),
        `Rota ${routeId} ficou sem aceite`,
      );
      assert.ok(
        route.options.some(
          (option) => option.target.kind === "red" || option.target.kind === "route",
        ),
        `Rota ${routeId} ficou sem recusa`,
      );
    }
  });

  it("mantém os rótulos literais dos botões do board da MSI", () => {
    const RECUSA = "❌ Prefiro Deixar Como Está";
    assert.deepEqual(proposalReplies(ROUTES["1"]), ["📩 Pode Me Mandar a Condição", "🤔 Ainda Fiquei com Dúvida"]);
    assert.deepEqual(proposalReplies(ROUTES["2"]), ["📩 Pode Me Mandar a Condição", "😰 Não Sei Se Fiz a Escolha Certa"]);
    assert.deepEqual(proposalReplies(ROUTES["3"]), ["📩 Pode Me Mandar a Condição", "⚡ Preciso de Dinheiro Rápido, Não Dá Pra Errar"]);
    assert.deepEqual(proposalReplies(ROUTES["4"]), ["💡 Quero Entender a Condição", "⏱️ Não Sei Se Cabe na Minha Rotina"]);
    assert.deepEqual(proposalReplies(ROUTES["4B"]), ["📩 Pode Me Mandar a Condição", "⏰ Ainda Acho Que Não Vou Ter Tempo"]);
    assert.deepEqual(proposalReplies(ROUTES["11"]), ["📩 Pode Me Mandar a Condição", "🤷‍♀️ Acho Que Não É Pro Meu Perfil"]);
    assert.deepEqual(proposalReplies(ROUTES["5"]), ["✅ Quero Testar Sem Risco", RECUSA]);
    assert.deepEqual(proposalReplies(ROUTES["6"]), ["✅ Quero Receber a Condição Exclusiva", RECUSA]);
    for (const id of ["7", "8", "9", "10"] as const) {
      assert.deepEqual(proposalReplies(ROUTES[id]), ["✅ Sim, Quero a Condição Exclusiva", RECUSA], id);
    }
    assert.deepEqual(proposalReplies(ROUTES.SF), ["✅ Sim, Quero a Condição Exclusiva + Soffia", RECUSA]);
    assert.deepEqual(ATIVACAO_OPCOES, ["🗣️ Aceito a Ativação com a Gabi", "❌ Desistir: Prefiro Deixar Como Está"]);

    // "Pode me mandar a condição" na rota 1 → condição da própria rota, com aceite e recusa do board.
    const activation = advanceFlow(startFlow("Não estou tendo resultado", "Letícia").state, "📩 Pode Me Mandar a Condição", "Letícia");
    assert.equal(activation.state.stage, "ativacao_proposta");
    assert.ok(activation.content.includes("7 dias de Ativação Sócia Invisível comigo"));
    assert.deepEqual(activation.replies, ["✨ Quero a Ativação Sócia Invisível", RECUSA]);
    // Objeções usam a condição geral.
    const geral = advanceFlow(startFlow("já tentei outras coisas e nada funcionou", "Letícia").state, "✅ Sim, Quero a Condição Exclusiva", "Letícia");
    assert.deepEqual(geral.replies, ATIVACAO_OPCOES);
  });

  it("botão de dúvida: pergunta, espera a resposta e só então mostra os botões", () => {
    const rota = advanceFlow(startFlow("Não estou tendo resultado", "Letícia").state, "🤔 Ainda Fiquei com Dúvida", "Letícia");
    assert.equal(rota.state.route, "1D");
    assert.equal(rota.state.stage, "aguardando_resposta_pergunta");
    assert.deepEqual(rota.replies, []);
    const resposta = advanceFlow(rota.state, "tenho medo de não dar conta", "Letícia");
    assert.equal(resposta.state.stage, "aguardando_resposta_rota");
    assert.ok(resposta.content.startsWith("Olha, uma coisa eu posso te afirmar"));
    assert.deepEqual(resposta.replies, ["✅ Pode Me Mandar a Condição", "❌ Prefiro Deixar Como Está"]);
    const condicao = advanceFlow(resposta.state, "✅ Pode Me Mandar a Condição", "Letícia");
    assert.deepEqual(condicao.replies, ["✨ Quero a Ativação Sócia Invisível", "❌ Prefiro Deixar Como Está"]);
  });

  it("recusa pelo botão do board: 1ª Soffia, 2ª e 3ª reenquadramento, 4ª e-mail", () => {
    let st = advanceFlow(startFlow("comprei por impulso", "Letícia").state, "📩 Pode Me Mandar a Condição", "Letícia").state;
    const outs = ["❌ Desistir: Prefiro Deixar Como Está", "❌ Prefiro Deixar Como Está", "❌ Desistir: Prefiro Deixar Como Está", "❌ Desistir: Prefiro Deixar Como Está"].map((t) => {
      const o = advanceFlow(st, t, "Letícia");
      st = o.state;
      return o;
    });
    assert.equal(outs[0]!.state.route, "SF");
    assert.ok(outs[0]!.content.includes("Soffia.ai"));
    assert.equal(outs[0]!.state.insistencia_reembolso, 1);
    for (const o of outs.slice(0, 3)) assert.equal(containsRefundEndpoint(o.content), false);
    assert.equal(outs[3]!.state.endpoint, true);
    assert.ok(outs[3]!.content.includes("suporte@demandasinvisiveis.com"));
    assert.ok(outs[3]!.content.includes("1 a 3 dias úteis"));
    assert.equal(containsRefundEndpoint(outs[3]!.content), true);
  });

  it("mudei de ideia: parabéns e aceite direto, sem e-mail", () => {
    const st = advanceFlow(startFlow("Não estou tendo resultado", "Letícia").state, "mudei de ideia, não quero mais o reembolso", "Letícia");
    assert.equal(st.state.route, "MD");
    assert.ok(st.content.includes("que decisão maravilhosa"));
    const aceite = advanceFlow(st.state, "✅ Sim, Quero a Condição Exclusiva", "Letícia");
    assert.equal(aceite.events?.activationAccepted, true);
    assert.ok(aceite.content.startsWith("A sua virada começa AGORA"));
  });

  it("a Rota 5 nova termina com os dois botões e a recusa soma somente 1/4", () => {
    const proposed = startFlow("Quanto tempo eu tenho para pedir reembolso?", "Letícia");
    assert.deepEqual(proposed.replies, ["✅ Quero Testar Sem Risco", "❌ Prefiro Deixar Como Está"]);
    assert.ok(proposed.followUpContent?.endsWith("você só tem a ganhar."));

    const refused = advanceFlow(
      proposed.state,
      "❌ Prefiro seguir com o reembolso",
      "Letícia",
    );
    assert.equal(refused.state.insistencia_reembolso, 1);
    assert.equal(refused.state.endpoint, false);
    assert.equal(containsRefundEndpoint(refused.content), false);
  });
});
describe("textos do 7D da MSI", () => {
  const textos: [string, string][] = [];
  for (const [nome, valor] of Object.entries(PROTOCOLO)) {
    if (typeof valor === "string") textos.push([nome, valor]);
    else if (Array.isArray(valor) && valor.every((v) => typeof v === "string")) {
      valor.forEach((v, i) => textos.push([`${nome}[${i}]`, v as string]));
    }
  }
  PROTOCOLO.CONDICAO_GERAL.messages.forEach((m, i) => textos.push([`Condição geral ${i + 1}`, m]));
  PROTOCOLO.INSISTENCIA_REENQUADRAMENTO.forEach((m, i) => typeof m === "string" && textos.push([`Reenquadramento ${i + 1}`, m]));
  for (const route of Object.values(ROUTES)) {
    route.messages.forEach((m, i) => textos.push([`Rota ${route.id} msg ${i + 1}`, m]));
    route.options.forEach((o) => textos.push([`Rota ${route.id} botão`, o.label]));
    (route.continuacao ?? []).forEach((m, i) => textos.push([`Rota ${route.id} continuação ${i + 1}`, m]));
    if (route.condicao) {
      route.condicao.messages.forEach((m, i) => textos.push([`Rota ${route.id} condição ${i + 1}`, m]));
      textos.push([`Rota ${route.id} condição aceite`, route.condicao.aceite], [`Rota ${route.id} condição recusa`, route.condicao.recusa]);
    }
  }

  it("nenhum texto do 7D fala do MGA", () => {
    const MGA = /payt|\bstr\b|mgv|pmj|hydra|\bmga\b|an[úu]ncio|campanha|criativo|\bbm\b|pixel|tr[áa]fego|afilia|evolution|tiktok|\bjeo\b|👊|🐉/i;
    for (const [nome, texto] of textos) assert.equal(MGA.test(texto), false, `${nome}: ${texto.slice(0, 80)}`);
  });

  it("a aluna é tratada no feminino (padrão e nomes femininos)", () => {
    const MASCULINO = /\b(aluno|sozinho|tranquilo|perdido|pronto pra começar|sincero comigo|comprometido|animado|ansioso)\b/i;
    for (const nomeAluna of ["Ana", ""])
      for (const [nome, texto] of textos)
        assert.equal(MASCULINO.test(fillName(texto, nomeAluna)), false, `${nome}: ${texto.slice(0, 80)}`);
  });
  it("aluno com nome de homem é tratado no masculino", () => {
    const FEMININO = /\b(minha aluna|minha única parceira|sozinha|(?<!cabeça )tranquila|perdida|(?<!frase |mensagem )pronta|disposta|parada|insegura|arrependida|respaldada|apertada|acompanhada|bem-vinda|sincera comigo|comprometida|animada|ansiosa)\b/i;
    for (const [nome, texto] of textos)
      assert.equal(FEMININO.test(fillName(texto, "Carlos")), false, `${nome}: ${texto.slice(0, 80)}`);
    assert.ok(fillName(PROTOCOLO.CONDICAO_GERAL.messages[0]!, "Carlos").includes("meu único Parceiro"));
    assert.ok(fillName(PROTOCOLO.WHATSAPP_7D_MENSAGEM, "Carlos").includes("Bem-vindo"));
    assert.ok(fillName(PROTOCOLO.WHATSAPP_7D_MENSAGEM, "Ana").includes("Bem-vinda"));
  });
  it("nenhuma marca de gênero fica sem resolver", () => {
    for (const [nome, texto] of textos) assert.equal(/\{[^{}|]*\|[^{}|]*\}/.test(fillName(texto, "Ana")), false, nome);
  });
  it("a voz do bot é feminina", () => {
    for (const [nome, texto] of textos) assert.equal(/\bobrigado\b/i.test(texto), false, nome);
  });

  it("garantia e nome do acompanhamento vêm das constantes", () => {
    assert.ok(ROUTES["5"].messages[0]!.includes(`${POLITICAS.garantiaDias} dias`));
    assert.ok(ROUTES["5"].messages[0]!.includes(POLITICAS.nomeGarantia));
    assert.ok(PROTOCOLO.N143_CONFIRMACAO.includes(PROTOCOLO.NOME_ATIVACAO));
    assert.ok(PROTOCOLO.CONDICAO_GERAL.messages[1]!.includes(POLITICAS.nomeGarantia));
  });

  it("classifica os motivos da MSI na rota certa, sem uma rota roubar a outra", () => {
    const casos: [string, string | null][] = [
      ["não estou tendo resultado", "1"],
      ["mandei várias propostas e ninguém respondeu", "1"],
      ["comprei por impulso", "2"],
      ["foi o dinheiro", "3"],
      ["tô dura esse mês", "3"],
      ["minha rotina é muito corrida", "4"],
      ["trabalho CLT e cuido dos filhos", "4"],
      ["não tenho tempo", "4B"],
      ["ainda não caiu nenhum PIX", "1"],
      ["não era isso que eu esperava", "11"],
      ["já conheço essas plataformas", "9"],
      ["tenho medo de perder meu tempo", "10"],
      ["o Seguro 180D vale mesmo?", "5"],
      ["já comprei outros cursos e nada funcionou", "8"],
      ["já trabalho com o 99freelas", "9"],
      ["travei no cadastro do 99freelas", "7"],
      ["não tenho experiência nenhuma", "7"],
      ["isso não é pra mim", "6"],
      ["preciso comprar a mentoria pra começar?", "D2"],
      ["Não consegui", null],
      ["quero cancelar minha compra", null],
    ];
    for (const [texto, rota] of casos) assert.equal(classifyRoute(texto), rota, texto);
  });

  it("rotas sem emoji continuam sem emoji", () => {
    const EMOJI = /[\u{1F000}-\u{1FAFF}\u{2600}-\u{27BF}]/u;
    for (const id of PROTOCOLO.NO_EMOJI_ROUTES) {
      for (const texto of [...ROUTES[id].messages, ...ROUTES[id].options.map((o) => o.label)]) {
        assert.equal(EMOJI.test(texto), false, `Rota ${id}: ${texto.slice(0, 80)}`);
      }
    }
    // MSI: o e-mail de reembolso do board usa emoji (📧, 👉🏻, 🚨); golpe e ameaça jurídica continuam sem.
    for (const texto of [PROTOCOLO.D1_GOLPE_INSISTIDO, PROTOCOLO.AMEACA_JURIDICA]) {
      assert.equal(EMOJI.test(texto), false, texto.slice(0, 80));
    }
  });
});

describe("correções no motor (achadas na MSI)", () => {
  it("pergunta hipotética na primeira mensagem usa o motivo da Rota 5, não o texto da aluna", () => {
    const o = startFlow("posso pedir reembolso depois se eu não conseguir?", "Ana");
    assert.equal(o.state.route, "5");
    assert.equal(o.state.reason, PROTOCOLO.ROUTE_REASON["5"]);
  });
  it("tirar emoji não deixa espaço no começo da linha", () => {
    const t = stripEmoji("✅ **Primeira linha**\n🎁 Segunda linha\n• terceira");
    assert.equal(t, "**Primeira linha**\nSegunda linha\n• terceira");
  });
});
