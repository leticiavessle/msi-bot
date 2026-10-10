/**
 * Respostas oficiais do suporte (lista em src/oferta/respostas-oficiais.ts).
 * Entram no mesmo nível dos trechos das aulas: quando a pergunta casa,
 * o bot recebe esta orientação como conhecimento oficial e os cartões
 * das aulas indicadas são anexados pelo servidor.
 */
import { TEMA_TECNICO_SEM_7D_RE } from "../../oferta/atalhos";
import { SUPPORT_ANSWERS, type SupportAnswer } from "../../oferta/respostas-oficiais";

export { SUPPORT_ANSWERS, type SupportAnswer };

function flat(text: string) {
  return text
    .toLowerCase()
    .normalize("NFD")
    .replace(/[̀-ͯ]/g, "")
    .replace(/\s+/g, " ");
}

/** Dúvida técnica (no MGA: anúncios/Meta) nunca entra no 7D. */
export function isAdsTechnical(text: string) {
  return TEMA_TECNICO_SEM_7D_RE.test(flat(text));
}

/**
 * Respostas oficiais que casam com a pergunta (a mais específica primeiro).
 * Uma resposta mais específica descarta as genéricas que ela substitui (campo `replaces`).
 */
export function matchSupportAnswers(text: string): SupportAnswer[] {
  const t = flat(text);
  const hits = SUPPORT_ANSWERS.filter((a) => a.match.some((re) => re.test(t)));
  const replaced = new Set(hits.flatMap((h) => h.replaces ?? []));
  return hits.filter((h) => !replaced.has(h.id)).slice(0, 2);
}

export function supportAnswerKnowledge(a: SupportAnswer, links: Map<string, string>) {
  const lessonLines = a.lessons
    .map((id) => (links.get(id) ? `${id}: ${links.get(id)}` : null))
    .filter(Boolean);
  return `[${a.id} | RESPOSTA OFICIAL DO SUPORTE — mesmo valor das aulas; responda com esta orientação e não diga que não é ensinado${lessonLines.length ? ` | aulas: ${lessonLines.join(" ; ")}` : ""}]\n${a.title}\n${a.answer}${a.note ? `\n(Regra interna: ${a.note})` : ""}`;
}
