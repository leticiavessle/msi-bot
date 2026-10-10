import type { ChatAttachment } from "./attachments";
import { OFFICIAL_LINKS, type OfficialLinkKey } from "../../oferta/links";
import type { Product } from "../../oferta/produtos";

/** Links oficiais (lista em src/oferta/links.ts) sempre viram cartão clicável, nunca URL crua no texto. */
export { OFFICIAL_LINKS, type OfficialLinkKey } from "../../oferta/links";

export function officialLink(key: OfficialLinkKey): ChatAttachment {
  const l = OFFICIAL_LINKS[key];
  return { kind: "link", url: l.url, label: l.label };
}

const URL_RE = /https?:\/\/[^\s<>()[\]"'`]+/g;
const MD_LINK_RE = /\[([^\]]*)\]\((https?:\/\/[^)\s]+)\)/g;
const COPY_PASTE_RE =
  /[^.!?\n]*\b(n[aã]o fic(ar|ou) clic[aá]vel|copie (o|esse|este) (endere[cç]o|link)|cole (direto|diretamente|na barra))[^.!?\n]*[.!?]?/gi;

/** Remove pontuação final grudada no endereço. */
export function trimUrl(raw: string) {
  return raw.replace(/[.,;:!?…]+$/, "");
}

function findOfficial(url: string, products: readonly Product[] | "todos"): OfficialLinkKey | "blocked" | null {
  for (const [key, def] of Object.entries(OFFICIAL_LINKS) as [
    OfficialLinkKey,
    { match: RegExp; soParaProduto?: Product },
  ][]) {
    if (def.match.test(url)) {
      // Link restrito a um produto (ex.: comunidade da mentoria): some para quem não tem.
      if (def.soParaProduto && products !== "todos" && !products.includes(def.soParaProduto)) return "blocked";
      return key;
    }
  }
  return null;
}

/**
 * Tira os links oficiais do texto e devolve cartões clicáveis separados.
 * Também remove qualquer instrução de "copie e cole" o endereço.
 */
export function extractOfficialLinks(
  content: string,
  opts: { products?: readonly Product[] | "todos" } = {},
): { content: string; links: ChatAttachment[] } {
  // Sem produtos informados, links restritos a produto ficam bloqueados (comportamento do MGA).
  const allowed = opts.products ?? [];
  const found: OfficialLinkKey[] = [];
  const note = (key: OfficialLinkKey) => {
    if (!found.includes(key)) found.push(key);
  };

  let text = content.replace(COPY_PASTE_RE, "");

  // Markdown [texto](url)
  text = text.replace(MD_LINK_RE, (full, label: string, url: string) => {
    const key = findOfficial(trimUrl(url), allowed);
    if (key === "blocked") return "";
    if (key) {
      note(key);
      return "";
    }
    return full;
  });

  // URLs soltas, com rótulo curto opcional antes ("STR: https://...")
  text = text.replace(
    /(?:[•*]\s*|-\s+)?(?:\b[A-Za-zÀ-ú]{2,12}\s*[:–-]\s*)?https?:\/\/[^\s<>()[\]"'`]+/g,
    (full) => {
      const url = full.match(URL_RE)?.[0];
      if (!url) return full;
      const key = findOfficial(trimUrl(url), allowed);
      if (key === "blocked") return "";
      if (!key) return full;
      note(key);
      const trailing = url.slice(trimUrl(url).length);
      return trailing.replace(/[:;,]/g, "");
    },
  );

  const lines = text
    .split("\n")
    .map((line) => line.replace(/[ \t]{2,}/g, " ").replace(/\s+([.,;!?])/g, "$1").trimEnd())
    .filter((line) => {
      const core = line.replace(/^\s*(?:[-•*]|\d+[.)])\s*/, "").trim();
      if (!found.length) return true;
      if (!core && line.trim()) return false; // só marcador de lista
      if (/^[A-Za-zÀ-ú ]{0,25}[:–-]?$/.test(core) && core.length > 0 && core.length <= 25 && /[:–-]$/.test(core)) return false;
      return true;
    })
    .map((line) =>
      found.length && /(?:por aqui|aqui|neste link|nesse link|link)\s*[:–-]\s*$/i.test(line)
        ? line.replace(/\s*[:–-]\s*$/, " (botão abaixo).")
        : found.length && /:\s*$/.test(line) && line.trim().length > 25
          ? line.replace(/:\s*$/, " (botões abaixo).")
          : line,
    );

  const cleaned = lines.join("\n").replace(/\n{3,}/g, "\n\n").trim();
  return { content: cleaned, links: found.map(officialLink) };
}

/** Junta cartões sem repetir o mesmo endereço. */
export function mergeLinkAttachments(existing: ChatAttachment[], links: ChatAttachment[]) {
  const urls = new Set(
    existing.flatMap((a) => (a.kind === "link" || a.kind === "support" || a.kind === "lesson" ? [a.url] : [])),
  );
  const extra = links.filter((a) => a.kind === "link" && !urls.has(a.url));
  // Cartões de link logo depois das respostas rápidas/antes dos outros cartões.
  return [...extra, ...existing];
}
