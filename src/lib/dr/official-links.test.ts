import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { extractOfficialLinks } from "./official-links";

describe("links oficiais viram cartões", () => {
  it("separa os links oficiais grudados num parágrafo e tira o copie e cole", () => {
    const r = extractOfficialLinks(
      "Entra na área de membros: https://alunos.demandasinvisiveis.com e no Telegram do Cofre PIX: https://t.me/+FeH8KapN-tszNWEx. A Gabi recomenda seguir os módulos na ordem. Se ele não ficar clicável, copie o endereço completo e cole diretamente na barra do navegador.",
      { products: ["principal", "cofre_pix"] },
    );
    assert.deepEqual(
      r.links.map((l) => (l.kind === "link" ? l.label : "")),
      ["Entrar na área de membros", "Entrar no Telegram do Cofre PIX Relâmpago"],
    );
    assert.equal(r.content.includes("http"), false);
    assert.equal(/clicável|copie/i.test(r.content), false);
    assert.ok(r.content.includes("A Gabi recomenda"));
  });
  it("markdown e área da Mentoria só para quem tem a Mentoria", () => {
    const md = "1. [área de membros](https://alunos.demandasinvisiveis.com/)\n2. [Mentoria](https://alunos.sociasuprema.com)";
    assert.equal(extractOfficialLinks(md, { products: ["principal", "mentoria"] }).links.length, 2);
    const semMentoria = extractOfficialLinks(md, { products: ["principal"] });
    assert.equal(semMentoria.links.length, 1);
    assert.equal(semMentoria.content.includes("http"), false);
  });
  it("link de aula não vira o botão da área de membros", () => {
    const r = extractOfficialLinks("Veja a aula: https://alunos.demandasinvisiveis.com/member/1/4", { products: ["principal"] });
    assert.equal(r.links.length, 0);
  });
  it("bloqueia o Telegram do Cofre PIX para quem não tem o Cofre PIX", () => {
    const r = extractOfficialLinks("Entra aqui: https://t.me/+FeH8KapN-tszNWEx", { products: ["principal"] });
    assert.equal(r.links.length, 0);
    assert.equal(r.content.includes("http"), false);
  });
  it("libera o Telegram do Cofre PIX para quem tem", () => {
    const r = extractOfficialLinks("Entra aqui: https://t.me/+FeH8KapN-tszNWEx", { products: ["principal", "cofre_pix"] });
    assert.deepEqual(r.links.map((l) => (l.kind === "link" ? l.label : "")), ["Entrar no Telegram do Cofre PIX Relâmpago"]);
    assert.equal(r.content.includes("http"), false);
  });
});
