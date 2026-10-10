/**
 * Entrada no bot (MSI, 09/10/2026): e-mail › CPF › nome da compra › WhatsApp.
 *
 * Textos da tela de entrada e do aviso de segurança no chat. A regra (o que vale como "encontrada",
 * limite de tentativas, o que vai para o painel) fica no motor: src/lib/dr/identificacao.ts e
 * src/lib/dr/access.functions.ts. Plano completo: docs/plano-identificacao-e-membrium.md.
 *
 * {feminino|masculino}: na tela de entrada ainda não sabemos o nome, então vale o tratamento padrão
 * da oferta (marca.ts › POLITICAS.tratamentoPadrao). [email] e [whatsapp] são trocados pelo valor digitado.
 */
import { EMAIL_SUPORTE } from "./links";

export const ENTRADA = {
  titulo: "Acesso d{a aluna|o aluno}",

  /** Uma etapa por vez; cada uma só aparece quando a anterior não encontrou a compra. */
  etapas: {
    email: {
      texto: "Informe o e-mail usado na sua compra. Neste aparelho você entra direto nas próximas vezes.",
      placeholder: "seu@email.com",
      botao: "Entrar",
    },
    cpf: {
      aviso: "Não encontrei uma compra com o e-mail [email].",
      texto: "Vamos tentar pelo seu CPF? Use o CPF informado na compra. Ele serve só para encontrar o seu cadastro.",
      placeholder: "000.000.000-00",
      botao: "Procurar pelo CPF",
      pular: "Prefiro não informar o CPF",
    },
    nome: {
      aviso: "Ainda não encontrei sua compra.",
      texto: "Qual é o seu nome completo, do jeitinho que você colocou na compra?",
      placeholder: "Nome e sobrenome",
      botao: "Procurar pelo nome",
    },
    whatsapp: {
      aviso: "Quase lá! Ainda não encontrei sua compra.",
      texto: "Qual é o seu WhatsApp com DDD? Pode ser o número que você usou na compra.",
      placeholder: "(31) 98888-7777",
      botao: "Procurar pelo WhatsApp",
    },
  },

  /** Dado digitado com erro (não conta como tentativa). */
  invalido: {
    email: "Confira o e-mail: parece que falta alguma parte (ex.: nome@gmail.com).",
    cpf: "Esse CPF não parece certo. Confira os 11 números e tente de novo.",
    nome: "Escreva o nome completo, com sobrenome, igual ao da compra.",
    whatsapp: "Coloque o número com DDD, por exemplo (31) 98888-7777.",
  },

  /** Encontrou por CPF, nome ou WhatsApp (ou por um e-mail antigo): mostra o e-mail da compra escondido. */
  encontrada: {
    titulo: "Encontrei sua compra! ✨",
    texto: "Da próxima vez, entre com o e-mail da sua compra:",
    /** Ela digitou outro e-mail no começo: a equipe recebe esse e-mail no painel (aba Acessos › Entrada no bot). */
    dicaEmailDiferente:
      "Se esse não é mais o seu e-mail, fica tranquil{a|o}: a equipe recebeu o e-mail que você digitou e pode atualizar o seu cadastro. Até lá, você continua entrando pelo CPF, pelo nome ou pelo WhatsApp.",
    /** Ela digitou um e-mail antigo, que a equipe já trocou no painel. */
    dicaEmailAtualizado: "O seu e-mail de acesso foi atualizado pela equipe. Use este daqui pra frente.",
    botao: "Entrar no chat",
  },

  /** Nenhum dado encontrou a compra: a equipe recebe tudo o que ela digitou (aba Acessos do painel). */
  naoEncontrada: {
    titulo: "Ainda não encontrei sua compra",
    texto:
      "Já avisei a equipe com os dados que você informou. Vamos procurar a sua compra e te chamar no WhatsApp [whatsapp]. Se a compra foi feita há poucos minutos, a liberação pode demorar um pouquinho: tente de novo mais tarde.",
    contato: `Se preferir, escreva para ${EMAIL_SUPORTE} contando o e-mail e o nome usados na compra.`,
    botao: "Tentar com outro e-mail",
  },

  /** Muitas tentativas seguidas no mesmo aparelho/rede. */
  limite: `Muitas tentativas seguidas. Por segurança, espere 15 minutos e tente de novo, ou escreva para ${EMAIL_SUPORTE}.`,

  voltar: "Usar outro e-mail",

  /** Antes de sair do chat: lembra o e-mail de entrada (escondido). */
  confirmarSaida: "Para entrar de novo, use o e-mail [email]. Quer sair agora?",

  /**
   * "Dupla checagem" (decisão d, 09/10): quem entrou pelo NOME ou pelo WHATSAPP não recebe link de acesso
   * direto; a equipe confere antes. Este texto entra no fim da resposta fixa de "comprei e não tenho acesso",
   * e a aba Acessos do painel mostra a etiqueta "conferir identidade". [via] = "nome" ou "WhatsApp".
   */
  duplaChecagem:
    "Como você entrou aqui pelo [via] (e não pelo e-mail ou CPF da compra), por segurança a equipe vai fazer uma conferência rápida dos seus dados antes de reenviar o acesso.",
} as const;
