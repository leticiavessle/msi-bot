/**
 * Tratamento por gênero a partir do primeiro nome (MSI, pedido de 08/10/2026).
 *
 * Regra: usa o tratamento padrão da oferta (marca.ts › POLITICAS.tratamentoPadrao, MSI = feminino) e só
 * troca para masculino quando o primeiro nome é claramente de homem. Na dúvida (nome raro, unissex
 * ou sem nome), fica o padrão. Errar para o masculino com uma aluna é pior do que o contrário.
 *
 * Textos fixos marcam as duas formas assim: {feminino|masculino}. Ex.: "pront{a|o}", "{aluna|aluno}".
 * Módulo puro, sem banco.
 */
import { POLITICAS } from "../../oferta/marca";

export type Genero = "feminino" | "masculino";

const norm = (s: string) => s.normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase().trim();

/** Nomes masculinos comuns no Brasil que a regra de terminação não pega (ou pega errado). */
const MASCULINOS = new Set(
  `adriel abel abner abraao adail adair adao adelmo ademar ademir adilson adriano afonso agnaldo ailton airton alan alef alessandro
  alex alexander alexandre alexsandro alfredo allan alisson altair alvaro amauri anderson andre andrei andrey angelo anselmo antonio
  ari ariovaldo arlindo armando arnaldo arthur artur augusto benedito benjamin bernardo breno bruno bryan caio caique carlos cassio
  cauan caue cesar christian cicero claudio cleber cleiton cleyton cristiano cristian cristovao damiao daniel danilo dario davi david
  davison deivid denis dennis diego diogo dirceu douglas edgar edimar edmilson edson eduardo elias elton emanuel emerson enzo erick
  erik eric ernesto estevao eugenio evandro everton ezequiel fabiano fabio fabricio felipe fellipe filipe fernando flavio francisco
  frederico gabriel gean geovane geraldo gerson getulio gian gilberto gilmar gilson giovane giovani giovanni gleison guilherme gustavo
  heitor helio henrique henry herbert hugo humberto icaro igor isaac isaque isaias ismael israel itamar ivan jair jairo james jardel
  jean jefferson jeferson jhon jhonatan jhony joao joaquim joel john jonas jonatan jonathan jorge jose josue juan juarez julio juliano
  julio kaique kaua kauan kelvin kevin klaus laercio lauro leandro leonardo leonel levi lincoln lourival luan lucas luca lucca luciano
  luis luiz manoel manuel marcelo marcio marco marcos mario mateus matheus mauricio mauro max maycon michael michel miguel milton
  moises murilo natan nathan natanael nelson newton nicolas nicolau nilton noah noe oscar osmar osvaldo otavio pablo patrick paulo
  pedro rafael raimundo ramon raul reginaldo reinaldo renan renato ricardo roberto robson rodolfo rodrigo rogerio romario ronaldo ruan
  rubens rui ryan samuel saulo sebastiao sergio silas silvio simao tadeu thales thiago tiago tobias tomas thomas valdir valter vicente
  victor vitor vinicius wagner waldir walter washington wellington wesley william willian wilson yago yan yuri zacarias`.split(/\s+/),
);

/** Nomes femininos com terminação que parece masculina. */
const FEMININOS_EXCECAO = new Set(
  `socorro rosario amparo consuelo carmo rocio conceicao assuncao jo`.split(/\s+/),
);

/** Gênero indicado pelo primeiro nome, ou null quando não dá para dizer com segurança. */
export function generoPeloNome(nome?: string | null): Genero | null {
  const primeiro = norm((nome ?? "").split(/\s+/)[0] ?? "");
  if (primeiro.length < 2) return null;
  if (FEMININOS_EXCECAO.has(primeiro)) return "feminino";
  if (MASCULINOS.has(primeiro)) return "masculino";
  if (/(son|ton)$/.test(primeiro)) return "masculino"; // Anderson, Wellington, Edson...
  if (/[^c]ao$/.test(primeiro)) return "masculino"; // João, Sebastião (Conceição fica de fora)
  if (/o$/.test(primeiro)) return "masculino"; // Paulo, Marcelo, Ricardo...
  if (/a$/.test(primeiro)) return "feminino";
  return null;
}

/** Tratamento a usar com esta pessoa: masculino só quando o nome indica; senão, o padrão da oferta. */
export function tratamento(nome?: string | null): Genero {
  return generoPeloNome(nome) === "masculino" ? "masculino" : POLITICAS.tratamentoPadrao;
}

/** Troca cada {feminino|masculino} pela forma certa. */
export function fillGenero(texto: string, genero: Genero): string {
  return texto.replace(/\{([^{}|]*)\|([^{}|]*)\}/g, (_m, f: string, m: string) => (genero === "masculino" ? m : f));
}
