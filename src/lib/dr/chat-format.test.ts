import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { formatAssistantMessage } from "./chat-format";

describe("formatação de mensagens", () => {
  it("nunca divide uma URL ao reorganizar parágrafos longos", () => {
    const urls = [
      "https://alunos.demandasinvisiveis.com/member/1/7?aula=2",
      "https://t.me/+FeH8KapN-tszNWEx",
      "https://alunos.sociasuprema.com/member/2/11?preview=true",
    ];
    const formatted = formatAssistantMessage(
      `Primeiro, assista à aula do cadastro no 99Freelas: ${urls[0]}. Depois entre no Telegram do Cofre PIX: ${urls[1]}. Por fim, abra a área da Mentoria: ${urls[2]}. Siga essa ordem para não se perder nos primeiros passos da plataforma.`,
    );
    for (const url of urls) assert.equal(formatted.includes(url), true, url);
    assert.equal(formatted.includes("demandasinvisiveis.\n\ncom/"), false);
    assert.equal(formatted.includes("11?\n\npreview=true"), false);
  });
});