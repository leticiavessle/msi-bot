/**
 * MARCA E IDENTIDADE DO ASSISTENTE
 * Tudo o que a pessoa vê com o nome da oferta: telas, cabeçalho do chat, notificações.
 *
 * MSI · Método Sócia Invisível (Gabriela Soares). Público: mulheres.
 * Nomes, garantia (Seguro 180D) e preço ("é com o time" + alerta de venda) confirmados em 04/10/2026.
 * ⚠️ Ainda falta: siteUrl.
 */

export const MARCA = {
  /** Nome do produto/oferta (aparece em textos do sistema e no painel). */
  nomeProduto: "Método Sócia Invisível",
  /** Nome do assistente (cabeçalho do chat, título das páginas, notificações). */
  nomeAssistente: "Suporte Método Invisível",
  /** Nome curto (ícone do app no celular, banner de instalação no iPhone). */
  nomeCurto: "Trilha MSI",
  /** Como a equipe aparece quando uma pessoa do time assume a conversa. */
  nomeEquipe: "Equipe Gabi Soares",
  /** Como o bot chama a expert, Gabriela Soares (o bot NUNCA finge ser essa pessoa). */
  nomeExpert: "Gabi",
  /** Imagem do avatar do assistente (arquivo em /public). */
  avatarUrl: "/avatar.png",
  /** Endereço oficial do app (usado em links de notificação e documentação). ⚠️ Definir na publicação. */
  siteUrl: "",
} as const;

/** Regras de política que entram no prompt e nas respostas. */
export const POLITICAS = {
  /** Prazo da garantia (o bot só informa se perguntarem DIRETAMENTE o prazo). */
  garantiaDias: 180,
  /** Nome da garantia (MSI: "garantia estendida de 180 dias", chamada de Seguro 180D). */
  nomeGarantia: "Seguro 180D",
  /**
   * O que dizer quando perguntam preço, desconto, parcelamento ou cupom.
   * MSI: "é com o time" + alerta de venda no painel (aba Vendas).
   */
  respostaPreco: "essa informação é com o time",
  /** Frase padrão quando a resposta não está nas aulas (decisão do system prompt v2 do MGA). */
  fraseNaoEncontrei: "Isso eu não encontrei no conteúdo das aulas.",
  /**
   * Como tratar a pessoa quando o nome não indica o gênero (MSI, 08/10/2026: público quase todo feminino;
   * masculino só quando o primeiro nome é claramente de homem — regra em src/lib/dr/genero.ts).
   */
  tratamentoPadrao: "feminino" as "feminino" | "masculino",
} as const;

/** Textos fixos das telas do chat e do login. */
export const IDENTITY = {
  name: MARCA.nomeAssistente,
  subtitle: "Assistente oficial das aulas do Método Sócia Invisível",
  initials: "MSI",
  onlineLabel: "Online",
  secureLabel: "Canal oficial e seguro",
  badges: ["🔒 Canal oficial e seguro", "Online"] as const,
  composerPlaceholder: "Escreva sua dúvida sobre as aulas...",
  footerNote: "🔒 Suporte oficial do Método Sócia Invisível",

  disclaimer: "Respostas geradas com base nas aulas do Método Sócia Invisível.",
  /** Primeira mensagem que aparece no chat. */
  welcome:
    "Oi! 💛 Eu sou a assistente das aulas do Método Sócia Invisível. Me conta sua dúvida que eu te mostro o que a aula ensina e onde ela está.",
  /** Resposta quando perguntam se é humano / se é o expert. */
  humanCheck:
    "Eu sou da equipe do Método Sócia Invisível, mas não sou uma pessoa: sou uma inteligência artificial treinada com o conteúdo das aulas, pra facilitar o seu processo com velocidade e o máximo de qualidade possível. Não sou a Gabi.",
  /** Descrição das páginas (aparece no Google e ao compartilhar o link). */
  pageDescription: "Assistente oficial das aulas do Método Sócia Invisível.",
  /** Texto da tela de login. */
  loginDescription: "Acesse o suporte oficial das aulas do Método Sócia Invisível com o e-mail da sua compra.",
} as const;
