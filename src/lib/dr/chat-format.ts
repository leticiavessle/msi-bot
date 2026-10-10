const BULLET_RE = /^\s*(?:[-•*]|\d+[.)])\s+/;

function splitLongProse(text: string) {
  const clean = text.replace(/\s+/g, " ").trim();
  if (clean.length < 120) return clean;

  // Protege URLs antes de separar frases. Sem isso, pontos do domínio
  // (ex.: app.payt.com.br) podem ser interpretados como fim de frase.
  const urls: string[] = [];
  const protectedText = clean.replace(/https?:\/\/[^\s<>()[\]"'`]+/g, (url) => {
    const token = `URLTOKEN${urls.length}END`;
    urls.push(url);
    return token;
  });
  const restoreUrls = (value: string) =>
    value.replace(/URLTOKEN(\d+)END/g, (_match, index: string) => urls[Number(index)] ?? "");

  const sentences =
    protectedText
      .match(/[^.!?]+(?:[.!?]+(?=\s|$)|$)/g)
      ?.map((sentence) => sentence.trim())
      .filter(Boolean) ?? [];
  if (sentences.length < 2) return clean;

  const paragraphs: string[] = [];
  let paragraph = "";

  for (const sentence of sentences) {
    if (paragraph && `${paragraph} ${sentence}`.length > 150) {
      paragraphs.push(paragraph);
      paragraph = sentence;
    } else {
      paragraph = paragraph ? `${paragraph} ${sentence}` : sentence;
    }
  }

  if (paragraph) paragraphs.push(paragraph);
  return restoreUrls(paragraphs.join("\n\n"));
}

/**
 * Preserva o markdown correto e cria blocos legíveis quando uma resposta longa
 * chega sem linhas em branco. Também separa transições entre prosa e listas.
 */
export function formatAssistantMessage(text: string) {
  return text
    .replace(/\r\n?/g, "\n")
    .split(/\n{2,}/)
    .map((rawBlock) => {
      const lines = rawBlock
        .split("\n")
        .map((line) => line.trim())
        .filter(Boolean);
      if (lines.length === 0) return "";

      const groups: { list: boolean; lines: string[] }[] = [];
      for (const line of lines) {
        const list = BULLET_RE.test(line);
        const previous = groups.at(-1);
        if (!previous || previous.list !== list) groups.push({ list, lines: [line] });
        else previous.lines.push(line);
      }

      return groups
        .map((group) => {
          if (group.list) {
            return group.lines.map((line) => `- ${line.replace(BULLET_RE, "")}`).join("\n");
          }
          return splitLongProse(group.lines.join(" "));
        })
        .join("\n\n");
    })
    .filter(Boolean)
    .join("\n\n");
}
