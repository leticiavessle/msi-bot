import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { fillGenero, generoPeloNome, tratamento } from "./genero";
import { fillName } from "./refund-protocol";

const FEMININOS =
  "Maria Ana Francisca Antônia Adriana Juliana Márcia Fernanda Patrícia Aline Sandra Camila Amanda Bruna Jéssica Letícia Júlia Luciana Vanessa Mariana Gabriela Vera Vitória Larissa Cláudia Beatriz Luana Rita Sônia Renata Eliane Josefa Simone Natália Cristiane Carla Débora Rosângela Jaqueline Rosana Daniela Aparecida Marlene Terezinha Raimunda Andreia Fabiana Lúcia Raquel Ângela Rafaela Joana Luzia Elaine Daniele Regina Daiane Sueli Alessandra Isabel Michele Rosa Ingrid Lourdes Íris Thaís Inês Carmen Nazaré Socorro Rosário Consuelo Conceição Jô Kelly Karen Ellen Yasmin Gisele Tatiane Viviane Edilene Cleide Ivone Irene Denise Alice Ester Mirian Lais Rachel Heloísa Lívia Sophia Valentina Laura Cecília";
const MASCULINOS =
  "José João Antônio Francisco Carlos Paulo Pedro Lucas Luiz Marcos Luis Gabriel Rafael Daniel Marcelo Bruno Eduardo Felipe Raimundo Rodrigo Manoel Mateus André Fernando Fábio Leonardo Gustavo Guilherme Leandro Tiago Anderson Ricardo Marcio Jorge Sebastião Alexandre Roberto Edson Diego Vitor Sérgio Claudio Matheus Thiago Geraldo Adriano Luciano Julio Renato Alex Vinicius Rogério Samuel Ronaldo Mario Flávio Douglas Igor Davi Miguel Arthur Heitor Wellington Washington Cleiton Robson";

describe("tratamento pelo nome", () => {
  test("nomes femininos comuns nunca viram masculino", () => {
    for (const n of FEMININOS.split(" ")) assert.notEqual(generoPeloNome(n), "masculino", n);
  });
  test("nomes masculinos comuns viram masculino", () => {
    for (const n of MASCULINOS.split(" ")) assert.equal(generoPeloNome(n), "masculino", n);
  });
  test("sem nome, nome raro ou unissex: tratamento padrão (feminino)", () => {
    for (const n of ["", null, "Ariel", "Darci", "Juraci", "X", "Kim"]) assert.equal(tratamento(n), "feminino", String(n));
  });
  test("nome completo usa só o primeiro nome", () => {
    assert.equal(tratamento("Maria José da Silva"), "feminino");
    assert.equal(tratamento("José Maria Souza"), "masculino");
  });
});

describe("textos com {feminino|masculino}", () => {
  test("troca as marcas", () => {
    assert.equal(fillGenero("você não precisa chegar pront{a|o}, {aluna|aluno}", "feminino"), "você não precisa chegar pronta, aluna");
    assert.equal(fillGenero("você não precisa chegar pront{a|o}, {aluna|aluno}", "masculino"), "você não precisa chegar pronto, aluno");
  });
  test("fillName troca o nome e o gênero juntos (sem nome = feminino)", () => {
    assert.equal(fillName("[nome], você está comprometid{a|o}?", "Carlos"), "Carlos, você está comprometido?");
    assert.equal(fillName("[nome], você está comprometid{a|o}?", "Ana"), "Ana, você está comprometida?");
    assert.equal(fillName("[nome], você está comprometid{a|o}?", ""), "você está comprometida?");
  });
});
