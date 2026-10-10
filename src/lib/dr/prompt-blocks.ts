/**
 * Carrega os blocos de texto do prompt (src/oferta/prompt/*.md) no build.
 * Separado de prompt.ts para que a montagem possa ser testada lendo os arquivos direto do disco.
 */
import identidade from "../../oferta/prompt/01-identidade-e-voz.md?raw";
import restricoes from "../../oferta/prompt/02-restricoes.md?raw";
import regrasOferta from "../../oferta/prompt/03-regras-da-oferta.md?raw";
import regrasTecnicas from "../../oferta/prompt/04-regras-tecnicas.md?raw";
import type { PromptBlocks } from "./prompt";

export const PROMPT_BLOCKS: PromptBlocks = { identidade, restricoes, regrasOferta, regrasTecnicas };
