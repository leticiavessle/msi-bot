/**
 * Casos oficiais de atendimento humano fora do 7D (lista em src/oferta/atalhos.ts).
 * Módulo puro (sem banco) para ser testável.
 */
import { CASOS_ATENDIMENTO_HUMANO } from "../../oferta/atalhos";
import { ATENDIMENTO_HUMANO } from "../../oferta/produtos";
import { ENTRADA } from "../../oferta/entrada";

export type HumanCase = (typeof CASOS_ATENDIMENTO_HUMANO)[number];

/** Caso oficial que a mensagem descreve (o primeiro que casar), ou null. */
export function detectHumanCase(text: string): HumanCase | null {
  return CASOS_ATENDIMENTO_HUMANO.find((c) => c.re.test(text)) ?? null;
}

/**
 * Caso que o SERVIDOR responde sozinho, sem link humano (MSI: o WhatsApp só sai na Ativação aceita).
 * Com cartaoNosCasos = true (MGA), devolve null e o fluxo antigo segue: IA responde + cartão.
 */
export function serverHandledHumanCase(text: string): HumanCase | null {
  return ATENDIMENTO_HUMANO.cartaoNosCasos ? null : detectHumanCase(text);
}

/** Casos que entram no prompt como "o cartão só existe nestes casos". */
export function humanCardCases(nomeAtivacao: string): string[] {
  return [
    `${nomeAtivacao} aceita no Protocolo 7D`,
    ...(ATENDIMENTO_HUMANO.cartaoNosCasos ? CASOS_ATENDIMENTO_HUMANO.map((c) => c.descricao) : []),
  ];
}

/**
 * Dupla checagem (decisão d, 09/10): frase que entra no fim da resposta de "comprei e não tenho acesso"
 * quando ela entrou no bot pelo nome ou pelo WhatsApp.
 */
export function textoDuplaChecagem(via: string | null): string {
  return ENTRADA.duplaChecagem.replace("[via]", via === "whatsapp" ? "WhatsApp" : "nome");
}
