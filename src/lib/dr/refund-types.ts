/**
 * Tipos e montadores de opção do Protocolo 7D.
 * Separado do motor (refund-protocol.ts) para que os TEXTOS fiquem em src/oferta/protocolo-7d.ts
 * sem import circular.
 */

export type RouteId =
  | "1"
  | "2"
  | "3"
  | "4"
  | "5"
  | "6"
  | "7"
  | "8"
  | "9"
  | "10"
  | "11"
  | "12"
  | "D1"
  | "D2"
  | "D3"
  | "D4"
  | "D5"
  // MSI (board "Retenção de Reembolso IA Suporte MSI", 08/10/2026): botões de dúvida de cada
  // situação (…D), segunda versão de "não tenho tempo" (4B), "mudei de ideia" (MD) e Soffia (SF).
  | "1D"
  | "2D"
  | "3D"
  | "4D"
  | "4B"
  | "4BD"
  | "11D"
  | "MD"
  | "SF";

export type RefundTarget =
  | { kind: "route"; route: RouteId }
  | { kind: "activation" }
  /** Aceite direto, sem passar pela condição (MSI: "mudei de ideia" → mensagem de aceite). */
  | { kind: "accept" }
  | { kind: "red" }
  | { kind: "scam_end" }
  | { kind: "finalize" }
  | { kind: "escalate" };

export type RefundOption = {
  label: string;
  match: RegExp;
  target: RefundTarget;
};

export type RouteDef = {
  id: RouteId;
  /** Mensagens-script da rota, na ordem do board. */
  messages: string[];
  options: RefundOption[];
  /**
   * "Espera responder" do board: as `messages` fazem uma pergunta e o bot espera a resposta da
   * pessoa, sem botões. Qualquer resposta que não seja recusa recebe estas mensagens + os botões.
   */
  continuacao?: string[];
  /**
   * Condição oferecida quando a pessoa aceita ouvir a proposta nesta rota (no MGA era sempre o
   * bloco N135–N140). Mensagens + botão de aceite (vai para a mensagem de aceite) e de recusa.
   */
  condicao?: Condicao;
  /** Não começa com o acolhimento (N002) quando abre o fluxo (ex.: "mudei de ideia"). */
  semAcolhimento?: boolean;
};

export type Condicao = {
  messages: string[];
  aceite: string;
  recusa: string;
};

/** Qualquer sinal de "quero o dinheiro / quero sair" dentro do fluxo. */
export const RED_MATCH =
  /reembolso|dinheiro de volta|estorno|valor de volta|\bcancel(?:ar|a|o|e|amento)\b|\bdesist(?:ir|o|[êe]ncia)\b|n[ãa]o quero mais|quero sair|quero encerrar|desfazer a compra/i;
const YES_MATCH = /pode fazer|pode montar|proposta|topo|combinado|aceito|sim|bora|consigo|quero/i;

/** Botão de recusa: leva ao Endpoint Vermelho (passando pela régua de insistência). */
export const optRed = (label = "❌ Prefiro seguir com o reembolso"): RefundOption => ({
  label,
  match: RED_MATCH,
  target: { kind: "red" },
});

/** Botão de aceite: leva à proposta do acompanhamento de 7 dias. */
export const optYes = (label: string, match: RegExp = YES_MATCH): RefundOption => ({
  label,
  match,
  target: { kind: "activation" },
});

/** Botão que leva para outra rota (ex.: "🤔 Ainda fiquei com dúvida"). Só o clique exato conta. */
export const optRota = (label: string, route: RouteId): RefundOption => ({
  label,
  match: /(?!)/,
  target: { kind: "route", route },
});

/** Botão de aceite direto (vai para a mensagem de aceite, sem passar pela condição). */
export const optAceite = (label: string, match: RegExp = YES_MATCH): RefundOption => ({
  label,
  match,
  target: { kind: "accept" },
});
