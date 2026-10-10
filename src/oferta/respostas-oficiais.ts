/**
 * RESPOSTAS OFICIAIS DO SUPORTE
 *
 * Respostas validadas pela equipe em testes reais. Quando a pergunta casa com uma delas,
 * a IA recebe o texto como conhecimento oficial (mesmo valor das aulas) e os cartões das
 * aulas indicadas são anexados pelo servidor. Elas nunca viram "isso não é ensinado".
 *
 * MSI (04/10/2026): começa vazia. As 7 respostas do MGA (BM, anúncios, Payt, criativos...) foram
 * retiradas porque esses assuntos não existem na MSI. As dúvidas frequentes de cada aula já estão na
 * base de aulas (trechos "FAQ" vindos de "Pontos para o suporte"). Quando a equipe validar uma
 * resposta em atendimento real, ela entra aqui. Modelo:
 *
 *   {
 *     id: "SUP.EXEMPLO",
 *     title: "Título curto da dúvida",
 *     answer: "Resposta validada pela equipe.",
 *     lessons: ["V1.M07.A02"],
 *     match: [/(cadastro|conta).*(99 ?freelas)/],
 *   },
 */

export type SupportAnswer = {
  id: string;
  title: string;
  answer: string;
  /** Códigos das aulas (ex.: V4.M06.A05) que viram cartão. */
  lessons: string[];
  /** Início do título do material de apoio (aba Materiais) que vai junto, se existir. */
  materialTitle?: string;
  /** Frase acrescentada no fim quando o material (print) vai junto. */
  materialNote?: string;
  /** Instrução interna ao bot (não é texto para a pessoa). */
  note?: string;
  /** Quando esta resposta casa, estas outras (ids) são descartadas por serem mais genéricas. */
  replaces?: string[];
  /** Comparado com a pergunta sem acento e em minúsculas. */
  match: RegExp[];
};

export const SUPPORT_ANSWERS: SupportAnswer[] = [];
