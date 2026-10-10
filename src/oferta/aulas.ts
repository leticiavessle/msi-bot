/**
 * AULAS: COMO SÃO IDENTIFICADAS E MOSTRADAS
 *
 * No MGA cada aula tem um código no formato V{vitrine}.M{módulo}.A{aula} (ex.: V4.M06.A09)
 * e cada trecho da base tem o código da aula + número do trecho (ex.: V4.M06.A09-02).
 * O link e o nome oficial da aula ficam no PRIMEIRO trecho (-01).
 *
 * MSI: fichas das aulas em "MSI - CLAUDE DOCS/" (base gerada por scripts/gerar_base.py).
 */

/** Como o nível mais alto do curso se chama nos cartões ("Vitrine", "Fase", "Nível"...). MSI: "Vitrine", como na área de membros. */
export const ROTULO_NIVEL = "Vitrine";

/**
 * Nome de cada nível (aparece no cartão da aula: "Vitrine 1 (Método Sócia Invisível) · Módulo 4 ...").
 * MSI: Vitrines 1 a 3 = Método Sócia Invisível (2 e 3 são os bônus); Vitrine 4 = Top Demandas.
 * ⚠️ Os outros produtos (Cofre PIX, Mentoria, Vitalícia) ainda não têm número de vitrine (04/10/2026).
 */
export const NOMES_DOS_NIVEIS: Record<number, string> = {
  1: "Método Sócia Invisível",
  2: "Bônus I · Skills das Sub Demandas",
  3: "Bônus II · Missão Dólar Rápido",
  4: "Top Demandas",
};

/**
 * Endereço de uma aula na área de membros. O servidor acha o link dentro do trecho -01,
 * transforma em cartão e tira a URL crua do texto da resposta.
 * MSI: duas áreas de membros (a da Mentoria Sócia Suprema é separada). As fichas trazem o link do
 * MÓDULO (/member/1/4); o link exato de cada aula ainda vai chegar (⚠️ pendência de 04/10/2026), por
 * isso o padrão aceita mais partes no caminho. O "?preview=true" é tirado na geração da base.
 */
export const LESSON_URL_RE = /https?:\/\/alunos\.(?:demandasinvisiveis|sociasuprema)\.com\/member\/\d+(?:\/[\w-]+)+/;

/**
 * As primeiras aulas da jornada ("por onde eu começo?" sempre recebe estes cartões).
 * MSI (confirmado em 04/10/2026): só a Aula de Boas-Vindas (Módulo 01, Aula 01).
 */
export const PRIMEIRAS_AULAS = ["V1.M01.A01"];
