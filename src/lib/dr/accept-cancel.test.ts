/// <reference path="./bun-test.d.ts" />
import { describe, expect, it } from "bun:test";
import {
  ATIVACAO_OPCOES,
  EMPTY_FLOW,
  advanceFlow,
  guardRefundOutput,
  isDeadlineFollowUp,
  isHedgedAccept,
  isHypotheticalRefund,
  isProposalContext,
  isRefundTrigger,
  isTypedAccept,
  startFlow,
  type RefundFlowState,
} from "./refund-protocol";

const proposta: RefundFlowState = { ...EMPTY_FLOW, active: true, route: "1", stage: "ativacao_proposta", updatedAt: new Date().toISOString() };

describe("aceite digitado", () => {
  it.each(["bora", "Sim, bora", "aceito", "quero sim", "tô dentro", "pode fazer a proposta", "Perfeito, pode mandar", "ok, vamos", "manda o dia 1", "fechou!", "combinado 👊", "vamos nessa"])(
    "%s conta",
    (t) => expect(isTypedAccept(t)).toBe(true),
  );
  it.each(["acho que sim", "talvez", "vou pensar", "deixa eu ver", "sim, mas não sei se vou ter tempo", "e se não der certo?", "não sei", "ok", "vou ver se dá", "sim?"])(
    "%s NÃO conta",
    (t) => expect(isTypedAccept(t)).toBe(false),
  );
  it("ressalva é marcada", () => {
    expect(isHedgedAccept("acho que sim")).toBe(true);
    expect(isHedgedAccept("sim, mas...")).toBe(true);
  });

  it('"bora" depois da proposta segue o caminho do clique, sem repetir a proposta', () => {
    const out = advanceFlow(proposta, "bora", "Ana");
    expect(out.events?.activationAccepted).toBe(true);
    expect(out.events?.accept?.origin).toBe("digitado");
    expect(out.events?.accept?.node).toMatch(/condição/);
    expect(out.state.stage).toBe("ativacao_whatsapp");
    expect(out.content).toContain("A sua virada começa AGORA");
    expect(out.content).not.toContain("Posso te fazer uma proposta");
  });
  it("clique no botão continua funcionando", () => {
    const out = advanceFlow(proposta, ATIVACAO_OPCOES[0]!, "Ana");
    expect(out.events?.accept?.origin).toBe("botão");
    expect(out.events?.activationAccepted).toBe(true);
  });
  it('"acho que sim" não é aceite (vai para a rota suave)', () => {
    const out = advanceFlow(proposta, "acho que sim", "Ana");
    expect(out.events?.activationAccepted).toBeFalsy();
    expect(out.state.route).toBe("D3");
  });
  it("frase fora do roteiro não vira aceite", () => {
    const out = advanceFlow(proposta, "Nada vai fazer eu mudar de ideia", "Ana");
    expect(out.events?.activationAccepted).toBeFalsy();
  });
  it('"sim" numa conversa técnica não é contexto de proposta', () => {
    expect(isProposalContext(EMPTY_FLOW)).toBe(false);
    expect(isRefundTrigger("sim")).toBe(false);
  });
  it('"bora" na pergunta de proposta da rota leva à proposta da Ativação', () => {
    const rota: RefundFlowState = { ...proposta, stage: "aguardando_resposta_rota", route: "1" };
    const out = advanceFlow(rota, "bora", "Ana");
    expect(out.state.stage).toBe("ativacao_proposta");
  });
});

describe("cancelamento abre o 7D", () => {
  it.each(["quero cancelar minha compra", "cancela compra", "Cancelamento", "quero cancelamento", "Cancelar minha inscrição", "não quero mais", "quero desfazer a compra", "quero desistir"])(
    "%s entra no 7D",
    (t) => {
      expect(isRefundTrigger(t)).toBe(true);
      const out = startFlow(t, "Ana", { topic: "cancelamento", cancelKind: "compra" });
      expect(out.content).not.toMatch(/suporte@|assunto/i);
      expect(out.state.active).toBe(true);
    },
  );
  it("pagamento cancelado ou desistir de mim não abre", () => {
    expect(isRefundTrigger("minha compra foi cancelada no cartão")).toBe(false);
    expect(isRefundTrigger("acho que vcs vão desistir de mim")).toBe(false);
  });
  it("hipotética é objeção", () => {
    expect(isHypotheticalRefund("como faço para cancelar se eu não gostar?")).toBe(true);
    const out = startFlow("como faço para cancelar se eu não gostar?", "Ana", { topic: "cancelamento", cancelKind: "compra" });
    expect(out.state.route).toBe("5");
    expect(out.content + (out.followUpContent ?? "")).not.toMatch(/suporte@/i);
  });

  it("4 recusas: só a 4ª entrega o encaminhamento", () => {
    let st: RefundFlowState = { ...startFlow("quero cancelar minha compra", "Ana", { topic: "cancelamento", cancelKind: "compra" }).state, updatedAt: new Date().toISOString() };
    st = advanceFlow(st, "não tenho tempo", "Ana").state; // motivo → rota
    const buttons = advanceFlow({ ...st }, "pode fazer a proposta", "Ana");
    expect(buttons.state.stage).toBe("ativacao_proposta");
    expect(buttons.replies.length).toBe(2);
    expect(buttons.replies.some((r) => /Prefiro Deixar Como Está/.test(r))).toBe(true);
    st = buttons.state;
    const outs = [1, 2, 3, 4].map(() => {
      const o = advanceFlow(st, "quero cancelar minha compra", "Ana");
      st = o.state;
      return o;
    });
    for (const o of outs.slice(0, 3)) expect(o.content).not.toMatch(/suporte@/);
    expect(outs[3]!.state.endpoint).toBe(true);
    expect(outs[3]!.content).toMatch(/suporte@demandasinvisiveis/);
  });

  it("filtro duro bloqueia passo a passo de cancelamento abaixo de 4", () => {
    const g = guardRefundOutput({
      content: "Pra cancelar, envia um e-mail para suporte@demandasinvisiveis.com com assunto “Cancelamento”.",
      state: { ...EMPTY_FLOW, insistencia_reembolso: 2 },
      currentUserText: "quero cancelar",
      name: "Ana",
    });
    expect(g.audit.decision).toBe("blocked");
    expect(g.audit.rule).toBe("cancel_endpoint_v1");
    const davi = guardRefundOutput({
      content: "Como você quer cancelar a compra, esse pedido precisa seguir o fluxo oficial de cancelamento.",
      state: EMPTY_FLOW,
      currentUserText: "cancela compra",
      name: "",
    });
    expect(davi.audit.decision).toBe("blocked");
  });

  it("assinatura recorrente: encaminhamento de assinatura na 4ª", () => {
    const st: RefundFlowState = { ...proposta, topic: "cancelamento", cancelKind: "assinatura", insistencia_reembolso: 3 };
    const o = advanceFlow(st, "quero cancelar a assinatura", "Ana");
    expect(o.state.endpoint).toBe(true);
    expect(o.content).toMatch(/assinatura/);
    expect(o.content).not.toMatch(/suporte@/);
    expect(o.support).not.toBeNull();
  });
});

describe("cobrança de prazo", () => {
  it.each(["Pedi o cancelamento e não foi feito", "ola, pedi o cancelamento na semana passada e ainda nao tive resposta", "Solicitei o cancelamento e até o momento não obtive retorno", "estou aguardando já mais de 2 semanas o cancelamento e o rebolso"])(
    "%s é cobrança",
    (t) => expect(isDeadlineFollowUp(t)).toBe(true),
  );
  it.each(["quero cancelar", "Cancelamento", "cancela compra"])("%s NÃO é cobrança", (t) =>
    expect(isDeadlineFollowUp(t)).toBe(false),
  );
});

import { N143_CONFIRMACAO, N145_PS, n134Perguntas, asksWhatsappLinkAgain, looksLikeDiagnosisAnswer, fillName as fill } from "./refund-protocol";
import { OFFICIAL_LINKS, extractOfficialLinks } from "./official-links";

const WA = "https://wa.me/5531988589871?text=Quero%20come%C3%A7ar%20a%20Ativa%C3%A7%C3%A3o%20S%C3%B3cia%20Invis%C3%ADvel";

describe("aceite → mensagem do board + WhatsApp (MSI, 08/10)", () => {
  for (const [label, text] of [["clique", ATIVACAO_OPCOES[0]!], ["digitado", "bora"]] as const) {
    it(`${label}: "A sua virada começa AGORA!" e o link logo abaixo, sem P.S.`, () => {
      const out = advanceFlow(proposta, text, "Ana");
      expect(out.content).toBe(fill(N143_CONFIRMACAO, "Ana"));
      expect(out.extras?.length).toBe(1);
      const wa = out.extras![0]!;
      expect(wa.content).toContain("é só **enviar** a mensagem");
      expect(wa.content).toContain("Bem-vinda de volta");
      expect(wa.links).toEqual(["whatsapp_7d"]);
      expect(wa.content).not.toMatch(/copie|cole/i);
      expect(out.events?.activationAccepted).toBe(true);
      expect(out.events?.whatsappSent).toBe(true);
    });
  }
  it("aluno homem recebe \"Bem-vindo\"", () => {
    const out = advanceFlow(proposta, "bora", "Carlos");
    expect(out.extras![0]!.content).toContain("Bem-vindo de volta");
  });
  it("o link é exatamente o oficial, inteiro", () => {
    expect(OFFICIAL_LINKS.whatsapp_7d.url).toBe(WA);
  });
  it("se a IA escrever o link, ele vira cartão inteiro (não fica partido no texto)", () => {
    const r = extractOfficialLinks(`Manda aqui: ${WA}`);
    expect(r.links).toEqual([{ kind: "link", url: WA, label: OFFICIAL_LINKS.whatsapp_7d.label }]);
    expect(r.content).not.toContain("wa.me");
  });
  it("seis perguntas do N134", () => {
    expect(n134Perguntas().split("\n").length).toBe(6);
  });
  it("mensagem comum depois não pede o link de novo", () => {
    expect(asksWhatsappLinkAgain("como faço pra criar meu perfil no 99Freelas?")).toBe(false);
    expect(asksWhatsappLinkAgain("manda o link do whats de novo")).toBe(true);
  });
  it("respostas da listinha no chat são reconhecidas", () => {
    expect(looksLikeDiagnosisAnswer("Entrei na área de membros, fui até a aula 2 do módulo 7\nCriei conta no 99Freelas, ainda não mandei proposta\nTravei no perfil\n1 hora por dia\nAnsiosa")).toBe(true);
    expect(looksLikeDiagnosisAnswer("Fui até o módulo 9, comecei pelas pesquisas, 30 min por dia, perdida")).toBe(true);
    expect(looksLikeDiagnosisAnswer("obrigada!")).toBe(false);
    expect(looksLikeDiagnosisAnswer("como faço pra criar o perfil no 99freelas?")).toBe(false);
  });
});
