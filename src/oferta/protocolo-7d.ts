/**
 * PROTOCOLO 7D: TEXTOS DA RETENÇÃO DE REEMBOLSO/CANCELAMENTO · MSI
 *
 * Fonte: board do Miro "Retenção de Reembolso IA Suporte MSI" (lido em 08/10/2026). Quando a aluna
 * pede reembolso, cancelamento, desistência, acusa golpe ou fala em risco de vida, quem responde é o
 * SERVIDOR com estes textos, na ordem decidida pelo motor (src/lib/dr/refund-protocol.ts).
 * A IA nunca escreve nada deste fluxo.
 *
 * Trocas permitidas nos textos: [nome] → primeiro nome e as marcas de gênero {feminino|masculino}
 * (ex.: "pront{a|o}"), resolvidas pelo nome (feminino por padrão; masculino só quando o nome é de
 * homem — src/lib/dr/genero.ts). A voz do próprio bot é feminina ("obrigada").
 *
 * Fiel ao board, com 3 ajustes de propósito:
 *   1. Frases em que o bot diria ser a Gabi (história pessoal, "o método que eu montei", "meu filho")
 *      foram passadas para a 3ª pessoa ("a Gabi montou..."): a restrição herdada diz que o bot nunca
 *      finge ser a expert.
 *   2. Adjetivos dirigidos à aluna ganharam a forma masculina ({a|o}) para os alunos homens.
 *   3. A régua de 4 insistências (restrição herdada) continua: no board, "Prefiro deixar como está"
 *      vai direto para o e-mail; aqui, antes do e-mail, vêm 3 reenquadramentos tirados do próprio board
 *      (Soffia, "quem está assumindo o risco sou eu", "não seria mais inteligente testar?").
 * Ao mexer: toda rota de proposta precisa de pelo menos um botão de aceite e um de recusa (ou de dúvida);
 * o N154 (e-mail) fica só aqui; os testes (npm test) conferem essas regras.
 */
import { EMAIL_SUPORTE } from "./links";
import { MARCA, POLITICAS } from "./marca";
import { optAceite, optRed, optRota, optYes, type Condicao, type RouteDef, type RouteId } from "../lib/dr/refund-types";

/** Nome do acompanhamento oferecido na retenção (aparece nos alertas do painel e relatórios). */
export const NOME_ATIVACAO = "Ativação Sócia Invisível";

/* ------------------------------------------------------------------ */
/* Entrada (N002 acolhimento, N004 pergunta de diagnóstico)            */
/* ------------------------------------------------------------------ */

/** Board #105, 1ª parte: acolhimento (vai antes da rota quando o motivo já veio na mensagem). */
export const N002_ACOLHIMENTO = "Oiie, [nome]! Recebi a sua solicitação de reembolso aqui.";

/** Board #105, 2ª parte: pergunta do motivo (quando a mensagem ainda não diz o motivo). */
export const N004_DIAGNOSTICO =
  "Antes da gente seguir, me conta uma coisa: o que te trouxe até o Método Sócia Invisível? Qual era o sonho por trás dessa decisão?\n\nPorque, sem romantizar nada, ninguém investe assim sem um motivo forte, né?\n\n👉🏻 Me explica o que exatamente não funcionou pra você?\n\nEstou aqui pra te ajudar da melhor forma possível! ✨";

/* Endpoint Vermelho (board #121 → #122 → #123 → #124). Só sai na 4ª insistência. */
export const N154_REEMBOLSO = `Todos os processos de reembolso são feitos exclusivamente por e-mail. Por qualquer outro canal de suporte, infelizmente, eu não consigo dar andamento nesse tipo de solicitação.

O nosso canal oficial pra esse atendimento é:

📧 ${EMAIL_SUPORTE}`;

/** Board #122–#124: depois do e-mail. Também é a resposta para quem diz que JÁ mandou o pedido. */
const APOS_EMAIL = `Se você já mandou a sua solicitação por e-mail, é só aguardar o nosso retorno por lá.

👉🏻 O tempo médio de resposta é de 1 a 3 dias úteis.

O suporte por e-mail atende a todas, então em períodos de alta demanda esse prazo pode variar um pouco.

🚨 Atenção: quanto mais e-mails sobre o mesmo assunto você enviar, mais demorado fica o seu atendimento! Isso acontece porque a conversa perde a continuidade e o processo volta pro começo da fila. Por isso, aguarde o nosso contato pra tudo andar mais rápido! ‼️

O seu pedido já está registrado com o setor responsável, que vai entrar em contato em breve pra finalizar a solicitação.

Todas as atualizações sobre o seu reembolso vão direto pro seu e-mail, então fica de olho por lá pra não perder nenhuma informação importante.

Obrigada pela compreensão e pela paciência! Caso mude de ideia sobre a solicitação, estou por aqui 😊`;

export const N155_FECHAMENTO = APOS_EMAIL;

/**
 * Endpoint de assinatura recorrente: mesma trava de 4, mas o encaminhamento é o de
 * cancelamento de assinatura, pelo atendimento humano.
 * MSI: hoje nenhum produto é recorrente (produtos.ts › PRODUTO_RECORRENTE = null), então este
 * texto só sai se um produto de assinatura for criado. PROVISÓRIO: aguardando o texto oficial do time.
 */
export const ASSINATURA_ENCERRAMENTO =
  "Entendo e respeito sua decisão, [nome]. O cancelamento da assinatura é feito pelo atendimento humano: é só tocar no botão abaixo que o time cuida disso com você.";

/** Seção 6 · D1 insiste na acusação de golpe (sem emoji). */
export const D1_GOLPE_INSISTIDO =
  `Entendo, [nome]. Pra que isso seja analisado com a seriedade que merece, peço que você formalize pelo nosso canal oficial: **${EMAIL_SUPORTE}**. Lá o time olha o seu caso junto com o seu cadastro e te responde por escrito.`;

/** Seção 6 · D3 continua sem decidir. */
export const D3_FINALIZACAO =
  `Tudo bem, [nome], sem pressão nenhuma. Vou deixar sua vaga na **${NOME_ATIVACAO}** separada aqui por enquanto. Quando decidir, é só me mandar um **sim** nessa conversa que eu monto seu Dia 1 na hora 💛`;

export const D3_REATIVACAO =
  `[nome], passando aqui rapidinho: sua vaga na **${NOME_ATIVACAO}** continua separada 💛 Me responde só com o horário que é melhor pra você (**manhã**, **almoço** ou **noite**) que eu já deixo seu Dia 1 pronto. Se preferir não seguir agora, tudo bem também, é só me falar.`;

/* ------------------------------------------------------------------ */
/* Bloco central · Ativação Sócia Invisível (N133–N147)                */
/* ------------------------------------------------------------------ */

/** N134 · diagnóstico obrigatório antes da proposta. As linhas "• " vão para o WhatsApp. */
export const N134_DIAGNOSTICO = `Pra eu montar seu plano certinho, me responde essa listinha rapidinho, pode ser em uma mensagem só, bem direto:

• Já conseguiu entrar na **área de membros**? Até que módulo e aula você foi?
• Já criou sua conta em alguma **plataforma de demandas** (99Freelas, Workana, GetNinjas...) ou começou pelas **pesquisas remuneradas**?
• Já montou seu **perfil** e mandou alguma **proposta**? Se mandou, mais ou menos quantas?
• Onde exatamente você travou? (se apareceu algum erro ou tela estranha, me manda o print)
• Quanto tempo por dia você consegue me dar? (vale qualquer janela, mesmo que sejam 30 minutinhos)
• E numa palavra: como você tá se sentindo com isso hoje (animad{a|o}, perdid{a|o}, ansios{a|o})?

Responde aí que com isso eu já monto seu plano.`;

/* N134–N140: bloco do modelo MGA. Na MSI não aparece (CONDICAO_PADRAO = condição geral do board). */

/** N135 · abertura da oferta. */
export const N135_OFERTA = `Olha só o que eu vou fazer especificamente pra você, [nome].

Eu vou te dar **7 dias do meu tempo**, comigo acompanhando de perto e com o time mais experiente daqui junto quando precisar. É a **${NOME_ATIVACAO}**, e eu não libero isso pra todo mundo que aparece nesse chat.`;

/** N136 · por que não é pra todo mundo. */
export const N136_JUSTIFICATIVA = `E vou te contar por que eu não faço isso sempre, pra você não achar que é frase de atendimento: porque é intensivo.

É próximo demais, é eu olhando o seu print, o seu perfil, a sua proposta, todo dia. Não tem como eu fazer isso com muita gente ao mesmo tempo sem fazer malfeito, e eu não vou fazer malfeito com você.`;

/** N137 · o único trecho com preenchimento: [diagnostico]. */
export const N137_PERSONALIZADO = `Mas olhando o que você me contou aqui, [nome], o seu caso não é de desistir e nem de começar tudo de novo. É de **organização**.

O que tá pesando pra você é [diagnostico], e falta alguém colocar isso na ordem certa e caminhar com você. Isso eu faço.`;

/** N138 · a lista objetiva dos 7 dias. */
export const N138_SETE_DIAS = `Nesses 7 dias, eu e você vamos:

• **Destravar seu acesso e te colocar na ordem certa dos módulos**, sabendo qual aula assistir agora
• **Escolher seu ponto de partida**: plataformas de demandas (como 99Freelas e Workana) ou pesquisas remuneradas
• **Criar seu perfil e montar seu portfólio comigo**, mesmo achando que não tem nada pra mostrar
• **Revisar suas primeiras propostas**: você me manda antes de enviar e a gente ajusta junto
• **Fechar o plano da semana seguinte**, escrito, pra você não acordar no dia 8 perdid{a|o}

É acompanhamento próximo, sem enrolação, direto no que cabe na **SUA** realidade. Não é aula nova, não é conteúdo novo, é execução com alguém do lado.`;

/** N139 · o que entra (bônus do acompanhamento, não do curso). */
export const N139_BONUS = `Pra ficar bem claro o que entra nesses 7 dias:

✅ **A ${NOME_ATIVACAO} completa**: 7 dias de acompanhamento personalizado comigo, com plano dia a dia montado no seu ponto de partida
🎁 **Bônus 1 · Diagnóstico de entrada.** Antes de qualquer tarefa, eu descubro com você onde você travou de verdade
🎁 **Bônus 2 · Revisão do seu perfil e do seu portfólio.** Você me manda, eu leio e te devolvo com os ajustes
🎁 **Bônus 3 · Leitura dos seus primeiros retornos comigo.** Proposta sem resposta, cliente que chamou, pesquisa que não fechou: a gente olha junto, do jeito que dá pra entender
🎁 **Bônus 4 · Curadoria de aula.** Eu te digo qual aula assistir agora e qual pode esperar
🎁 **Bônus 5 · Plano da semana 8.** No dia 7 eu não te solto: eu fecho com você o plano da semana seguinte, escrito

**Quanto custa:** nada. Zero. Já tá dentro do que você comprou.`;

/** N140 · CTA de compromisso. */
export const N140_COMPROMISSO = `Mas eu preciso de um compromisso seu, [nome], e é sério.

Se eu separar esses 7 dias pra você, você se compromete a fazer o que eu te orientar, mesmo nos dias em que o cansaço bater e mesmo quando parecer chato?

Não precisa ser perfeito, não precisa ser rápido. Precisa ser feito.

Me responde só com um **sim** que eu já começo o seu **Dia 1** hoje ✨`;

/** Botões da proposta quando ela vem de um reenquadramento (os mesmos da condição geral do board). */
export const ATIVACAO_OPCOES = ["🗣️ Aceito a Ativação com a Gabi", "❌ Desistir: Prefiro Deixar Como Está"];

/** Rotas que terminam numa pergunta de proposta (precisam de aceite e de recusa/dúvida). */
export const PROPOSAL_ROUTE_IDS = [
  "1", "1D", "2", "2D", "3", "3D", "4", "4D", "4B", "4BD", "5", "6", "7", "8", "9", "10", "11", "11D", "12", "SF",
  "D1", "D2", "D4", "D5",
] as const satisfies readonly RouteId[];

/** Aceite (board #90, 1ª parte): "A sua virada começa AGORA!". */
export const N143_CONFIRMACAO = `A sua virada começa AGORA! 🚀

Sabe o que isso significa? Que você escolheu o seu futuro em vez do seu medo.

ANOTE OS SEUS PRÓXIMOS PASSOS:

✅ Entender a sua situação específica
✅ Descobrir onde você travou dentro do Método
✅ Montar o seu plano personalizado de 7 dias
✅ Iniciar a sua ${NOME_ATIVACAO}`;

/** Introdução do N134 quando ele vem depois do SIM. */
export const N134_INTRO = "Pra eu deixar seu Dia 1 certinho, me responde essa listinha:";

/** N145 · P.S.: o board da MSI não tem (vazio = não envia). */
export const N145_PS = "";

/**
 * Aceite (board #90, 2ª parte), com o botão do WhatsApp do acompanhamento logo abaixo.
 * Ajustado em 09/10/2026 a pedido da dona do produto: deixar claro que é preciso tocar no botão e ENVIAR
 * a mensagem pronta, e que lá o atendimento é humano (pode levar alguns minutos).
 */
export const WHATSAPP_7D_MENSAGEM = `👇 Toque no botão abaixo pra liberar a sua Ativação. Ele abre o WhatsApp da equipe com uma mensagem pronta: é só **enviar** a mensagem do jeito que ela aparecer. 👇

Esse é o canal oficial onde a equipe vai mapear o que está travando os seus resultados e montar a sua estratégia. Lá o atendimento é feito por pessoas, então pode levar alguns minutinhos pra te responderem. É só aguardar, que o seu acompanhamento começa o quanto antes.

Bem-{vinda|vindo} de volta ao Método Sócia Invisível! 💜`;

/** Quando a pessoa pede o link do WhatsApp de novo, depois do aceite. */
export const WHATSAPP_LINK_DE_NOVO = "Claro, [nome]! O link do WhatsApp tá aqui de novo, no botão abaixo 👇";

/**
 * Sinais de que a aluna respondeu a listinha (N134) aqui no chat em vez de no WhatsApp.
 * Um sinal por pergunta da listinha. Conta como resposta com 3 sinais (ou 2 sinais + 3 linhas).
 */
export const DIAGNOSTICO_SINAIS: RegExp[] = [
  /[áa]rea de membros|aula|m[óo]dulo/,
  /freela|workana|vinte ?(pila|conto)|get ?ninjas|plataforma|pesquisa|grabpoints|attapoll|fala[íi]|voissy|meseems|modatta|ysense|cadastr|criei (a |minha )?conta/,
  /perfil|portf[óo]lio|proposta|demanda|cliente/,
  /trav|erro|parei|n[ãa]o entendi|n[ãa]o consegui|print|bloque|reprova/,
  /\d+\s*(h|hora|min)|hora|minuto|por dia/,
  /animad|perdid|ansios|confus|motivad|cansad|esperan|desanimad|insegur|frustrad|empolgad/,
];

export const WHATSAPP_THANKS =
  "Recebi suas respostas, [nome], obrigada 🙏 Ficou tudo registrado aqui pra equipe.";

/** Encaminhamento final, já com o cartão de atendimento humano. */
export const ATIVACAO_ENCAMINHADA =
  "Perfeito, [nome]. Já passei tudo pro time montar seu Dia 1 com você 💛";

export const ATIVACAO_NOTA = `${NOME_ATIVACAO}, veio do bot`;

/** Rotas sem emoji (no MGA também a 3; o board da MSI usa emoji na rota do aperto financeiro). */
export const NO_EMOJI_ROUTES: RouteId[] = ["D1"];

/** Risco de vida (N128/N157): acolhimento + CVV, sem cartão e sem próximo passo de curso. */
export const ESCALACAO_RISCO =
  "[nome], eu li o que você escreveu e isso importa mais do que qualquer outra coisa aqui. Você não precisa passar por isso sozinh{a|o}.\n\nLiga pro CVV no **188**: é gratuito, funciona 24 horas e tem alguém treinado pra te ouvir agora. Se preferir conversar por escrito, o endereço é **cvv.org.br**.\n\nEu fico por aqui, e o curso pode esperar o tempo que você precisar.";

/** Ameaça jurídica (Procon, processo, advogado, Reclame Aqui): sem emoji, sem cartão. */
export const AMEACA_JURIDICA =
  `Entendo, [nome]. Pra que seu caso seja tratado com a formalidade que ele merece, peço que você registre tudo por escrito no nosso canal oficial: ${EMAIL_SUPORTE}. O time responde por lá, com registro, e acompanha o seu pedido até o fim.`;

/** Quem diz que JÁ mandou o pedido: board #122–#124 (sem endereço de e-mail e sem passo a passo). */
export const COBRANCA_PRAZO = APOS_EMAIL;

/** Pedido de humano de quem já teve o cartão liberado antes (reenvia o cartão, sem retenção). */
export const HUMANO_DE_NOVO = "Claro, [nome] 💛 É só tocar no botão abaixo que o time te atende por lá.";

/** Resposta fora dos botões na proposta (board #12): pergunta a dúvida e mantém os botões. */
export const NAO_CONTA_TEXTO =
  "[nome], me conta: qual é a sua dúvida exatamente? O que está segurando você de dar o próximo passo?";

/**
 * Reenquadramentos da insistência 1, 2 e 3 (a 4ª manda o e-mail). Textos do próprio board:
 * 1 = argumento da Soffia ("utilizar como argumento de retenção em todos os casos", rota SF);
 * 2 = board #129; 3 = board #139.
 */
export const INSISTENCIA_REENQUADRAMENTO: (string | { rota: RouteId })[] = [
  { rota: "SF" },
  "Agora pensa comigo:\n\nO dinheiro já saiu da sua conta, então você não tem nada a perder. Você vai ter o Método completo na mão e um acompanhamento individual, feito sob medida pra sua realidade. E, mesmo assim, se não for pra você, o reembolso continua garantido.\n\nQuem está assumindo todo o risco aqui sou eu, porque eu acredito no que faço e sei que posso te ajudar.\n\nEntão, podemos começar? A sua segurança está garantida e você só tem a ganhar.",
  "Não seria mais inteligente pelo menos testar com a minha ajuda, pra ver o que acontece? Porque se der certo, esse valor volta multiplicado pra você.\n\nO que você escolhe: desistir sem nem tentar ou aceitar a minha ajuda de perto?",
];

/* Rota 5 usada para pergunta hipotética ("e se eu não gostar?", "posso pedir depois?"). */
/** Pergunta hipotética repetida dentro da Rota 5. [nome] vira o primeiro nome ou "você". */
export const HIPOTETICA_REPETIDA =
  `Sim, [nome]: essa possibilidade continua existindo dentro do ${POLITICAS.nomeGarantia}. O que eu não quero é que você decida agora só pelo receio de não conseguir. Decide depois de testar na prática, com informação e sem pressa.`;
/** Frase que fecha a primeira mensagem da Rota 5 na pergunta hipotética (vazio: o board não tem). */
export const HIPOTETICA_PONTE = "";
/** Segunda mensagem (com os botões) da pergunta hipotética: o resto da Rota 5 do board (#128, #129). */
export const HIPOTETICA_PROPOSTA = "";

/** Botões da reativação (D3, 1 hora depois do "deixa eu ver"). */
export const D3_REATIVACAO_OPCOES = ["🌅 Manhã", "☀️ Almoço", "🌙 Noite", "Prefiro seguir com o reembolso"];

/* ------------------------------------------------------------------ */
/* Condição exclusiva (texto do board)                                  */
/* ------------------------------------------------------------------ */

/** Condição geral (board #137–#140/#146): usada nas objeções, na Soffia e onde a rota não tem condição própria. */
export const CONDICAO_GERAL: Condicao = {
  messages: [
    `Olha a minha condição pra você:\n\nEm vez de jogar fora essa oportunidade que você mesma criou, que tal aceitar 7 dias de ${NOME_ATIVACAO}, individual e personalizada, comigo e com a minha equipe?\n\nNesses 7 dias você tem:\n✅ Atenção 100% voltada pra você, como se fosse {minha única Parceira|meu único Parceiro}\n✅ Eu te guiando passo a passo, sem pressa e sem pressão\n✅ O Método adaptado ao seu perfil e ao tempo que você tem\n✅ Suporte direto no WhatsApp pra qualquer dúvida\n✅ As Demandas mais práticas pra o seu primeiro PIX sair rápido`,
    `E agora o mais importante: eu vou ESTENDER o seu prazo legal de 7 dias de reembolso para o ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda quiser o reembolso, é só pedir, sem perder direito nenhum!\n\nPensa comigo:\n- O dinheiro já saiu da sua conta\n- Você já tem o Método completo na mão\n- Eu estou te oferecendo acompanhamento individual\n- E o seu direito ao reembolso continua intacto`,
    "Não seria mais inteligente pelo menos testar com a minha ajuda, pra ver o que acontece? Porque se der certo, esse valor volta multiplicado pra você.\n\nO que você escolhe: desistir sem nem tentar ou aceitar a minha ajuda de perto?",
  ],
  aceite: "🗣️ Aceito a Ativação com a Gabi",
  recusa: "❌ Desistir: Prefiro Deixar Como Está",
};

/** Condição usada quando a rota não define a sua (MSI: a geral). null = bloco N135–N140 do modelo MGA. */
export const CONDICAO_PADRAO: Condicao | null = CONDICAO_GERAL;

const RECUSA = "❌ Prefiro Deixar Como Está";
const PODE_MANDAR = "📩 Pode Me Mandar a Condição";

/* ------------------------------------------------------------------ */
/* Rotas · textos do board "Retenção de Reembolso IA Suporte MSI"       */
/* (#n = número da caixa na leitura do board em 08/10/2026)             */
/* ------------------------------------------------------------------ */

export const ROUTES: Record<RouteId, RouteDef> = {
  /* Situação: "Não estou conseguindo resultado" / "Ainda não caiu nenhum PIX" (#2) */
  "1": {
    id: "1",
    messages: [
      `[nome], eu entendo essa angústia de verdade, no começo a Gabi também sentiu isso. Essa sensação de estar remando e não sair do lugar é horrível mesmo.\n\nMas me responde uma coisa com sinceridade: você já assistiu o Método do começo ao fim? Porque o ${MARCA.nomeProduto} não é promessa mágica, é um sistema que a Gabi montou testando Demanda por Demanda, na prática.`,
      "Me diz se você já passou por:\n• As primeiras aulas, onde a Gabi mostra exatamente por onde começar?\n• O passo a passo da sequência do primeiro dia, feito pro seu primeiro PIX sair rápido?\n• A parte em que a Gabi abre os bastidores de como as Demandas mais bem pagas funcionam?\n\nResultado não nasce de assistir aula, [nome]. Nasce de EXECUTAR com direção e eu consigo enxergar exatamente onde você pode estar travando.\n\nPosso te apresentar uma condição exclusiva? Uma coisa que eu só abro pra quem está de verdade dispost{a|o} a virar esse jogo.",
    ],
    options: [optYes(PODE_MANDAR), optRota("🤔 Ainda Fiquei com Dúvida", "1D")],
    condicao: {
      messages: [
        `Pela sua resposta eu já consegui enxergar uma coisa: com alguém do lado te apontando o caminho, você chega onde quer.\n\nEntão deixa eu te fazer um convite que eu quase nunca abro, porque não dá pra atender muita gente assim: 7 dias de ${NOME_ATIVACAO} comigo e com a minha equipe, pra descobrir exatamente onde você empacou e destravar isso junto com você.`,
        "Nesses 7 dias você recebe:\n\n✅ Acompanhamento feito sob medida, um a um\n✅ Direcionamento passo a passo no seu ritmo\n✅ O diagnóstico exato do ponto onde você travou\n✅ Um caminho desenhado pro tempo que você realmente tem\n✅ Linha direta no WhatsApp pra tirar TODAS as suas dúvidas\n\nEu faço isso porque tenho CERTEZA: quando você executa o Método do jeito certo e bem acompanhad{a|o}, esse valor volta pro seu bolso multiplicado.\n\nSe você topar, é agora.",
      ],
      aceite: `✨ Quero a ${NOME_ATIVACAO}`,
      recusa: RECUSA,
    },
  },
  /* Botão "🤔 Ainda Fiquei com Dúvida" (#11): pergunta, espera a resposta e segue (#12 → #13, #14) */
  "1D": {
    id: "1D",
    messages: ["[nome], me conta: qual é a sua dúvida exatamente? O que está segurando você de dar o próximo passo?"],
    continuacao: [
      "Olha, uma coisa eu posso te afirmar: ficar parad{a|o} não resolve nada.\n\nEu tenho aqui uma coisa que pode ser exatamente o empurrão que falta pra você destravar e ver o dinheiro entrando. É algo que eu só libero em situações bem específicas, porque exige uma proximidade e uma dedicação que eu não consigo dar pra todo mundo.",
      "Essa condição pode ser o ponto de virada da sua história, [nome]. Ela nasceu pra {mulheres|pessoas} que querem mesmo mudar de vida e estão prontas pra dar o próximo passo.\n\nPosso te mandar como funciona? Eu tenho certeza de que isso muda a sua realidade.",
    ],
    options: [optYes("✅ Pode Me Mandar a Condição"), optRed(RECUSA)],
  },
  /* Situação: "Comprei por impulso" / "Me arrependi de ter comprado" (#56) */
  "2": {
    id: "2",
    messages: [
      "[nome], olha, comprar no impulso acontece com todo mundo!\n\nMas me deixa te falar uma coisa? Mesmo sendo impulso, tinha uma dor real por trás, né? Uma necessidade, um sonho, alguma coisa que você queria mudar na sua vida.\n\nE sabe o que a gente aprendeu em todos esses anos ajudando mulheres?\n\nAs maiores viradas começaram exatamente assim numa decisão rápida, quase instintiva, porque lá no fundo elas SABIAM que precisavam mudar.\n\nPosso te apresentar uma condição diferente? Algo que eu não abro pra {qualquer uma|qualquer um}?",
    ],
    options: [optYes(PODE_MANDAR), optRota("😰 Não Sei Se Fiz a Escolha Certa", "2D")],
    condicao: {
      messages: [
        `Olha a minha condição pra você:\n\nEm vez de jogar fora essa oportunidade que você mesma criou, que tal aceitar 7 dias de ${NOME_ATIVACAO}, individual e personalizada, comigo e com a minha equipe?\n\nNesses 7 dias você tem:\n✅ Atenção 100% voltada pra você, como se fosse {minha única Parceira|meu único Parceiro}\n✅ Eu te guiando passo a passo, sem pressa e sem pressão\n✅ O Método adaptado ao seu perfil e ao tempo que você tem\n✅ Suporte direto no WhatsApp pra qualquer dúvida\n✅ As Demandas mais práticas pra o seu primeiro PIX sair rápido`,
        `E agora o mais importante: eu vou ESTENDER o seu prazo de 7 dias de reembolso para o ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda preferir não continuar, é só me dizer sem perder direito nenhum!\n\nPensa comigo:\n- O dinheiro já saiu da sua conta\n- Você já tem o Método completo na mão\n- Eu estou te oferecendo acompanhamento individual\n- E o seu direito continua intacto`,
        "Não seria mais inteligente pelo menos testar com a minha ajuda, pra ver o que acontece? Porque se der certo, esse valor volta multiplicado pra você.\n\nO que você escolhe: desistir sem nem tentar ou aceitar a minha ajuda de perto?",
      ],
      aceite: "🗣️ Aceito a Ativação com a Gabi",
      recusa: "❌ Desistir: Prefiro Deixar Como Está",
    },
  },
  /* Botão "😰 Não Sei Se Fiz a Escolha Certa" (#64): perguntas, espera a resposta e segue (#65, #66 → #68) */
  "2D": {
    id: "2D",
    messages: [
      "[nome], respira fundo! Esse sentimento é normal e muito humano.\n\nVou te fazer algumas perguntas sinceras:\n\n• O que te fez comprar naquela hora? (sem julgamento nenhum, só quero entender)\n• Qual era a situação que você queria resolver?\n• Você está comparando isso com alguma experiência ruim que já teve?",
      "Olha, vou ser bem honesta com você: eu prefiro mil vezes alguém que questiona a própria decisão do que alguém que compra e some na primeira dificuldade.\n\nO que mais te deixa insegur{a|o} agora?",
    ],
    continuacao: [
      "Eu quero te ajudar a transformar essa dúvida em clareza. Tenho aqui uma saída que é exatamente o que você precisa pra virar esse jogo.\n\nPosso te mandar como funciona? Tenho certeza de que faz toda a diferença pra você.",
    ],
    options: [optYes("✅ Pode Me Mandar a Condição"), optRed(RECUSA)],
  },
  /* Situação: "Estou apertada financeiramente" / "Preciso desse dinheiro de volta" (#76) */
  "3": {
    id: "3",
    messages: [
      "[nome], eu entendo PERFEITAMENTE. A Gabi já viveu meses de aperto e sabe bem o peso dessa pressão quando tem família contando com você. Ela mesma já passou por essa situação com o filho dela.\n\nMas me deixa fazer uma reflexão {de mulher pra mulher|sincera}? Justamente por estar nessa situação é que você precisa MAIS do Método, e não menos.\n\nEscuta o que eu vi nesses anos:\n\nAs Parceiras que mais fizeram dinheiro comigo foram exatamente as que estavam onde você está: apertadas, precisando de resultado urgente, sem margem pra errar.\n\nA pressão financeira te dá uma vantagem: você não enrola, não procrastina. Você FAZ acontecer, porque não tem outra opção.\n\nPosso te apresentar uma condição diferente? Algo que eu só abro em casos bem específicos como o seu?",
    ],
    options: [optYes(PODE_MANDAR), optRota("⚡ Preciso de Dinheiro Rápido, Não Dá Pra Errar", "3D")],
    condicao: {
      messages: [
        `Olha o que eu vou fazer por você:\n\nTe dou 7 dias de ${NOME_ATIVACAO}, individual, próxima e 100% sob medida. Nesse período:\n\n✅ Te ensino as Demandas de retorno mais rápido do Método\n✅ Foco total em resultado de curto prazo pro seu caso\n✅ Atendimento direto comigo e com a minha equipe, como se fosse só você\n✅ Suporte no WhatsApp pra você não ficar perdid{a|o}\n✅ Adapto tudo ao tempo que você realmente tem`,
        "Pensa comigo:\n- O reembolso te devolve esse dinheiro uma única vez\n- O Método pode te colocar esse valor no bolso TODO MÊS\n- E te tirar desse aperto de vez\n\nMuitas Parceiras minhas começaram exatamente no ponto em que você está e hoje faturam bem mais do que investiram.",
        "Me responde: você consegue se dedicar por 7 dias? Porque se conseguir, eu te mostro os caminhos que dão retorno em semanas.\n\nPra aceitar a minha ajuda:",
      ],
      aceite: "🗣️ Quero a Mão da Gabi",
      recusa: RECUSA,
    },
  },
  /* Botão "⚡ Preciso de Dinheiro Rápido, Não Dá Pra Errar" (#78): perguntas, espera a resposta e segue (#86 → #87) */
  "3D": {
    id: "3D",
    messages: [
      "[nome], eu te entendo de um jeito que você nem imagina. A Gabi já esteve exatamente aí: olhando o saldo, contando cada centavo, com aquele nó no peito e precisando comprar o leite do filho dela, que tinha APLV.\n\nVou ser direta com você:\n\n• Qual é o prazo que você tem pra ver dinheiro entrando?\n• Quanto você precisa faturar pra resolver a sua situação?\n• Você tem algumas horas por dia pra se dedicar?",
    ],
    continuacao: [
      "Então vamos fazer assim: eu não vou te enrolar com teoria. Se você está apertad{a|o}, eu te mostro as Demandas que dão retorno MAIS rápido dentro do Método.\n\nExiste um atalho quando a necessidade é urgente. Não é o caminho ideal, mas funciona.\n\nPosso te mandar aquela condição exclusiva que eu comentei? É algo que eu guardo só pra casos como o seu.\n\nSó que ela vale se você estiver dispost{a|o} a dar tudo de si.\n\nPodemos começar?",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva"), optRed(RECUSA)],
    condicao: {
      messages: [
        `Olha a minha condição pra você:\n\nEm vez de jogar fora essa oportunidade que você mesma criou, que tal aceitar 7 dias de ${NOME_ATIVACAO}, individual e personalizada, comigo e com a minha equipe?\n\nNesses 7 dias você tem:\n✅ Atenção 100% voltada pra você, como se fosse {minha única Parceira|meu único Parceiro}\n✅ Eu te guiando passo a passo, sem pressa e sem pressão\n✅ O Método adaptado ao seu perfil e ao tempo que você tem\n✅ Suporte direto no WhatsApp pra qualquer dúvida\n✅ As Demandas mais práticas pra o seu primeiro PIX sair rápido`,
        `E agora o mais importante: eu vou ESTENDER o seu prazo de 7 dias para o ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda preferir não continuar, é só pedir!\n\nPensa comigo:\n- O dinheiro já saiu da sua conta\n- Você já tem o Método completo na mão\n- Eu estou te oferecendo acompanhamento individual\n- E o seu direito continua intacto`,
        "Não seria mais inteligente pelo menos testar com a minha ajuda, pra ver o que acontece? Porque se der certo, esse valor volta multiplicado pra você.\n\nO que você escolhe: desistir sem nem tentar ou aceitar a minha ajuda de perto?",
      ],
      aceite: "🗣️ Quero a Mão da Gabi",
      recusa: "❌ Agora Não, Obrigada",
    },
  },
  /* Situação: "Não tenho tempo pra fazer" / "Minha rotina é muito corrida" (#17) */
  "4": {
    id: "4",
    messages: [
      `[nome], eu entendo você. Equilibrar casa, família, trabalho e ainda aprender uma coisa nova é desafiador mesmo.\n\nMas me deixa te devolver uma pergunta sincera: o que te trouxe até aqui foi exatamente essa vida corrida e sem sobra, né? A vontade de ter um dinheiro a mais, de respirar um pouco?\n\nO ${MARCA.nomeProduto} nasceu pensando na mulher que faz mil coisas ao mesmo tempo. Não é sobre virar noite estudando é sobre usar as brechinhas do seu dia com inteligência, pelo celular.`,
      "É sobre transformar minutinhos soltos em PIX na conta:\n\n• Pouco mais de uma hora por dia já muda o jogo\n• Demandas simples, que cabem na sua rotina de verdade\n• Você escolhe quando e quanto pegar, nada é fixo\n• Caminhos pensados pra quem tem pouquíssimo tempo\n\nPorque desistir hoje é assinar embaixo que daqui a 6 meses você vai estar exatamente no mesmo ponto, [nome].\n\nPosso te apresentar uma condição diferente? Algo que eu não abro pra {qualquer uma|qualquer um}?",
    ],
    options: [optYes("💡 Quero Entender a Condição"), optRota("⏱️ Não Sei Se Cabe na Minha Rotina", "4D")],
    condicao: {
      messages: [
        "Então olha o que eu vou fazer especialmente por você:\n\nVou te dar 7 dias do meu tempo (eu e a minha equipe mais experiente) numa Ativação que eu só libero em casos bem pontuais.\n\nPor que não faço isso sempre? Porque é intenso, é próximo demais, e eu não teria fôlego pra atender muita gente nesse nível.\n\nMas olhando o seu caso, o que você precisa é de organização e direção, nada além disso.",
        "Nesses 7 dias vamos:\n\n✅ Arrumar a sua rotina com precisão cirúrgica\n✅ Montar um cronograma encaixado nas suas janelas livres\n✅ Ir direto nas Demandas que pagam mais rápido\n✅ Te dar suporte no WhatsApp pra você não travar em nada\n\nÉ acompanhamento de perto, sem enrolação, focado no que funciona pra SUA vida.\n\nMas eu preciso de um compromisso seu: se eu reservar esse tempo pra você, você se compromete a seguir o que eu orientar?",
      ],
      aceite: `✨ Quero a ${NOME_ATIVACAO} (7 Dias)`,
      recusa: RECUSA,
    },
  },
  /* Botão "⏱️ Não Sei Se Cabe na Minha Rotina" (#20): pergunta, espera a resposta e segue (#25 → #27) */
  "4D": {
    id: "4D",
    messages: [
      "[nome], essa é A dúvida que mais chega aqui! E sabe o que ela me diz sobre você? Que você é pé no chão e responsável.\n\nVou ser bem honesta: se você está pensando nisso, é porque já entrou em coisa que não cabia na sua vida real, né?\n\nMe conta, qual é a sua dúvida?",
    ],
    continuacao: [
      "Olha, eu tenho aqui uma coisa que pode te ajudar a organizar tudo isso de um jeito prático e direto.\n\nÉ uma condição que eu só abro em casos bem específicos, mas que pode ser exatamente o que falta pra você finalmente encaixar o Método na sua vida e ver o dinheiro entrando.\n\nPosso te mandar como funciona? Pode ser a saída que você estava procurando.",
    ],
    options: [optYes("✅ Pode Me Mandar a Condição"), optRed(RECUSA)],
    condicao: {
      messages: [
        "[nome], olha o que eu vou fazer especialmente por você:\n\nVou te dar 7 dias do meu tempo (eu e a minha equipe mais experiente) numa Ativação que eu só libero em casos bem pontuais.\n\nPor que não faço isso sempre? Porque é intenso, é próximo demais, e eu não teria fôlego pra atender muita gente nesse nível. Mas olhando o seu caso, o que falta é organização e direção pra começar a ver o dinheiro entrando.",
        "Nesses 7 dias, {juntas|juntos}, vamos:\n✅ Arrumar a sua rotina com precisão cirúrgica, pra o Método caber no seu dia.\n✅ Montar um cronograma nas suas janelas livres, priorizando o que traz retorno.\n✅ Ir direto nas Demandas que pagam mais rápido, pra o PIX começar logo.\n✅ Te dar suporte no WhatsApp, pra você não travar e ter clareza em cada passo.\n\nÉ acompanhamento de perto, sem enrolação, focado no que funciona pra SUA vida.",
        "Mas eu preciso de um compromisso seu: se eu reservar esse tempo pra você, você se compromete a seguir o que eu orientar?\n\nEssa é uma condição que eu abro pra pouquíssimas Parceiras, porque exige dedicação minha e sua. Se você está pront{a|o} pra dar esse passo, a gente vira esse jogo junto.\n\nO que você me diz? Posso te mandar os próximos passos pra começarmos?",
      ],
      aceite: "🗣️ Aceito a Ativação com a Gabi",
      recusa: RECUSA,
    },
  },
  /* Situação: "Não tenho tempo pra fazer" (#97, segunda versão do board) */
  "4B": {
    id: "4B",
    messages: [
      "[nome], EU ENTENDO PERFEITAMENTE. A Gabi é mãe, empresária, esposa e sabe o que é essa correria maluca do dia a dia.\n\nMas me deixa te fazer uma pergunta sincera: o que te trouxe até aqui foi justamente essa falta de tempo livre, né? A vontade de ter um dinheiro a mais, de ter mais liberdade?\n\nO Método da Gabi nasceu pensando exatamente na sua realidade. {Mulher que concilia|Gente que concilia} mil coisas e mesmo assim quer construir uma renda.\n\nPosso te apresentar uma condição exclusiva? Algo que eu só abro pra {mulheres|pessoas} na sua situação?",
    ],
    options: [optYes(PODE_MANDAR), optRota("⏰ Ainda Acho Que Não Vou Ter Tempo", "4BD")],
    condicao: {
      messages: [
        `Olha a minha condição especial pra você:\n\n7 dias de ${NOME_ATIVACAO}, individual e personalizada, onde eu e a minha equipe vamos:\n\n✅ Montar um plano encaixado no SEU tempo disponível\n✅ Te mostrar as Demandas mais rápidas e simples\n✅ Te acompanhar passo a passo, sem pressa\n✅ Adaptar tudo à sua rotina de hoje\n✅ Te dar suporte no WhatsApp nos horários que você conseguir`,
        `E olha só: você ainda tem o ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda achar que não cabe na sua rotina, é só pedir o reembolso tranquilamente.\n\nPorque a real é essa:\n- Pouco mais de uma hora por dia já faz TODA a diferença\n- Eu tenho caminhos pensados pra quem tem pouco tempo\n- Muitas Demandas você faz no SEU ritmo, quando der\n- Tem Parceira que começou com 20 minutinhos por dia`,
        "A pergunta é: você quer seguir nessa correria sem perspectiva ou aceita a minha ajuda pra aproveitar o pouco tempo que você tem e construir a sua liberdade?\n\nPra aceitar:",
      ],
      aceite: "🗣️ Quero a Ativação Personalizada",
      recusa: RECUSA,
    },
  },
  /* Botão "⏰ Ainda Acho Que Não Vou Ter Tempo" (#99 → #106, #107) */
  "4BD": {
    id: "4BD",
    messages: [
      "[nome], vou ser bem direta com você: essa é a desculpa que mantém você parad{a|o} exatamente onde está.\n\nQuantas {mulheres|pessoas} você conhece que “não têm tempo” mas passam 2 horas rolando o feed? Quantas “não conseguem” mas dão conta de maratonar a série inteira?\n\nDói ouvir, mas precisa ser dito: VOCÊ TEM TEMPO. O que falta é PRIORIDADE clara.",
      "Dentro da área de membros tem uma aula inteira sobre como auditar o seu tempo, que mostra onde está o SEU “tempo escondido”, aqueles minutos que escorrem sem você perceber e que podem virar PIX na sua conta.\n\nPosso te mandar a Condição Exclusiva que eu comentei na mensagem anterior e te ajudar a mudar essa realidade?",
    ],
    options: [optYes(PODE_MANDAR), optRed(RECUSA)],
    condicao: {
      messages: [
        `Olha a minha condição pra você:\n\nEm vez de jogar fora essa oportunidade que você mesma criou, que tal aceitar 7 dias de ${NOME_ATIVACAO}, individual e personalizada, comigo e com a minha equipe?\n\nNesses 7 dias você tem:\n✅ Atenção 100% voltada pra você, como se fosse {minha única Parceira|meu único Parceiro}\n✅ Eu te guiando passo a passo, sem pressa e sem pressão\n✅ O Método adaptado ao seu perfil e ao tempo que você tem\n✅ Suporte direto no WhatsApp pra qualquer dúvida\n✅ As Demandas mais práticas pra o seu primeiro PIX sair rápido`,
        `E agora o mais importante: você está respaldad{a|o} pelo ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda quiser o reembolso, é só pedir!\n\nPensa comigo:\n- O dinheiro já saiu da sua conta\n- Você já tem o Método completo na mão\n- Eu estou te oferecendo acompanhamento individual\n- E o seu direito continua intacto`,
        "Não seria mais inteligente pelo menos testar com a minha ajuda, pra ver o que acontece? Porque se der certo, esse valor volta multiplicado pra você.\n\nO que você escolhe: desistir sem nem tentar ou aceitar a minha ajuda de perto?",
      ],
      aceite: "🗣️ Quero a Mão da Gabi",
      recusa: RECUSA,
    },
  },
  /* Objeção: prazo de reembolso / "Tenho medo do prazo vencer" (#126) */
  "5": {
    id: "5",
    messages: [
      `[nome], eu entendo a sua preocupação e vou te tranquilizar de uma vez:\n\nVocê tem 7 dias de reembolso garantidos por lei, e eu faço questão de respeitar isso. Mas vou fazer ainda melhor por você: o ${POLITICAS.nomeGarantia}, ou seja, você tem ${POLITICAS.garantiaDias} dias para solicitar o cancelamento.`,
      "Isso quer dizer que, mesmo depois dos 7 dias de Ativação, se você sentir que não é pra você, pode pedir o reembolso sem problema nenhum. Sem burocracia, sem pressão, com o seu direito preservado.\n\nEu quero você aqui com a cabeça tranquila, sabendo que está segur{a|o}. O meu compromisso é te entregar resultado, não te deixar insegur{a|o} nem arrependid{a|o}.",
      "Agora pensa comigo:\n\nO dinheiro já saiu da sua conta, então você não tem nada a perder. Você vai ter o Método completo na mão e um acompanhamento individual, feito sob medida pra sua realidade. E, mesmo assim, se não for pra você, o reembolso continua garantido.\n\nQuem está assumindo todo o risco aqui sou eu, porque eu acredito no que faço e sei que posso te ajudar.\n\nEntão, podemos começar? A sua segurança está garantida e você só tem a ganhar.",
    ],
    options: [optYes("✅ Quero Testar Sem Risco"), optRed(RECUSA)],
  },
  /* Objeção: "Não tenho certeza se vou conseguir aplicar o método" (#131) */
  "6": {
    id: "6",
    messages: [
      "[nome], deixa eu te falar uma coisa: essa dúvida é normal, mas ela não pode te paralisar. O que importa mesmo é dar o primeiro passo.\n\nEu comentei antes que tenho uma condição exclusiva, que eu não abro pra todo mundo justamente porque consome muito do meu tempo e da minha dedicação. Ela nasceu pra ajudar {mulheres|pessoas} exatamente como você, que sentem que precisam de um apoio a mais pra começar.",
      "Essa é uma oportunidade que eu só ofereço pra quem quer mesmo dar o próximo passo. Posso te mandar como funciona agora?",
    ],
    options: [optYes("✅ Quero Receber a Condição Exclusiva"), optRed(RECUSA)],
  },
  /* Objeção: "Eu não sei fazer nada" / "Não tenho habilidade nenhuma" (#141) */
  "7": {
    id: "7",
    messages: [
      "[nome], deixa eu te acalmar: ninguém nasce sabendo, e todo mundo aqui começou do zero. O que pesa mesmo é estar dispost{a|o} a aprender e dar o primeiro passo.\n\nE olha só: dentro do Método tem aulas que mostram habilidades que você já usa no dia a dia sem nem perceber, coisas simples que dá pra transformar em dinheiro entrando.",
      "Além disso, você aprende exatamente o que as grandes empresas mais pedem hoje, incluindo as Demandas que estão bombando neste momento. Tudo explicado de forma prática e mastigada, pra você conseguir aplicar mesmo começando do zero.\n\nEu comentei antes que tenho uma condição exclusiva, que não abro pra todo mundo justamente porque consome muito do meu tempo e da minha dedicação. Ela existe pra quem sente que precisa de um direcionamento mais próximo pra começar do jeito certo.",
      "Essa é uma oportunidade única e eu quero te dar essa chance. Se você estiver pront{a|o} pra esse passo, eu te guio! Mas só vale se você estiver dispost{a|o} a dar tudo de si.\n\nPodemos começar?",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva"), optRed(RECUSA)],
  },
  /* Objeção: "Já tentei outras coisas antes e não deu certo" (#147) */
  "8": {
    id: "8",
    messages: [
      "[nome], eu sei exatamente o que você está sentindo.\n\nMuita gente que chega até aqui já passou por essa mesma frustração. Tentou de tudo, gastou tempo e energia, e o resultado não veio. E sabe o que eu sempre digo? O problema nunca foi você, foi o caminho que te mostraram. Faltou direção.\n\nDeixa eu te falar uma coisa importante: só porque não deu certo antes, não quer dizer que você não possa virar o jogo agora. O que muda tudo é ter um método testado, validado e feito sob medida pra quem decidiu fazer diferente.",
      "Posso te mandar aquela condição exclusiva que eu comentei? Ela não é aberta pra todo mundo porque exige muito do meu tempo e da minha dedicação, mas nasceu exatamente pra quem, como você, está pront{a|o} pra dar o próximo passo com seriedade.\n\nÉ uma oportunidade que eu guardo pra casos especiais, mas ela só faz sentido se você estiver dispost{a|o} a dar tudo de si dessa vez.\n\nSe você estiver pront{a|o}, a gente começa agora mesmo. O que acha?",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva"), optRed(RECUSA)],
  },
  /* Objeção: "Já conheço essas empresas e plataformas" (#152) */
  "9": {
    id: "9",
    messages: [
      "[nome], que bom saber que você já conhece essas plataformas! Isso é uma baita vantagem, porque significa que você já parte de uma base sólida. E sabe o melhor? Isso pode te fazer avançar muito mais rápido.\n\nMas deixa eu te contar uma coisa importante: conhecer as plataformas é só o começo. O que separa quem tenta de quem realmente recebe é saber usar essas plataformas com estratégia, foco e método. É isso que transforma esforço em PIX na conta.",
      "Posso te mandar aquela condição exclusiva que eu comentei? Ela não é aberta pra todo mundo porque exige muito do meu tempo e da minha dedicação, mas foi feita pra quem quer mesmo virar o jogo e fazer diferente dessa vez.\n\nÉ algo que eu guardo só pra casos como o seu, mas só vale se você estiver dispost{a|o} a dar tudo de si.\n\nPodemos começar?",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva"), optRed(RECUSA)],
  },
  /* Objeção: "E se eu não tiver resultado?" (#157) */
  "10": {
    id: "10",
    messages: [
      "[nome], o Método foi validado não só pela Gabi, mas também pela equipe. Aqui dentro também tem alunas que, com o direcionamento correto, conseguiram resultados extraordinários (e elas estavam como você, prestes a desistir).\n\nSe você seguir o que o Método ensina corretamente, com a rotina adaptada pra você e com o suporte ao seu lado, seus resultados serão questão de tempo.",
      "Posso te mandar aquela condição exclusiva que eu comentei? Ela foi feita justamente pra quem, como você, sabe onde quer chegar e sonha em levar isso pra outro patamar. Não é algo que eu abro pra todo mundo, porque exige muito do meu tempo e da minha dedicação, mas é perfeita pra quem está comprometid{a|o} em fazer diferente dessa vez.\n\nSe você estiver dispost{a|o} a dar tudo de si, a gente começa agora mesmo. O que acha?",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva"), optRed(RECUSA)],
  },
  /* Situação: "Não era isso que eu esperava" / "Imaginei uma coisa diferente" (#39) */
  "11": {
    id: "11",
    messages: [
      `[nome], entendo essa frustração de quando a expectativa não bate com o que a gente encontra.\n\nMas me conta: o que exatamente você esperava ver aqui? Porque muita vez a gente monta uma imagem na cabeça e, quando vê o sistema real funcionando, parece outra coisa.\nO ${MARCA.nomeProduto} a Gabi construiu ao longo de anos, testando Demanda por Demanda. Não é sobre “dinheiro fácil” é sobre um caminho completo que funciona na vida real de {mulheres|pessoas} como você.`,
      "Escuta, vou ser direta com você:\n\nMuitas Parceiras chegaram esperando uma coisa e encontraram um caminho bem melhor do que imaginavam. O que parecia “não ser isso” virou exatamente a solução que faltava na vida delas.\n\nPosso te apresentar uma condição exclusiva?",
    ],
    options: [optYes(PODE_MANDAR), optRota("🤷‍♀️ Acho Que Não É Pro Meu Perfil", "11D")],
    condicao: {
      messages: [
        `Então aqui está a minha condição:\n\nEu te dou 7 dias de ${NOME_ATIVACAO}, individual e 100% sob medida, comigo e com a minha equipe. Nesse período:\n\n✅ Te mostro exatamente onde está, dentro do Método, aquilo que você procura\n✅ Acompanhamento próximo, passo a passo, como se você fosse {minha única Parceira|meu único Parceiro}\n✅ Adapto as Demandas ao seu perfil e ao que você esperava\n✅ Suporte direto pra esclarecer TUDO que gerar dúvida\n✅ Direção prática pra o seu primeiro resultado sair rápido`,
        `E o mais importante: eu vou ESTENDER o seu prazo de 7 dias de reembolso para ${POLITICAS.garantiaDias} dias, o ${POLITICAS.nomeGarantia}. Ou seja, depois da Ativação, se você ainda achar que não é pra você, pede o reembolso com toda tranquilidade, sem pressa e sem perder direito nenhum.\n\nPorque eu tenho certeza absoluta de que, quando você entender o Método direito, vai ver que é exatamente isso que você procurava pra mudar a sua vida financeira.\n\nMe diz: você prefere desistir pela primeira impressão ou aceitar a minha ajuda de perto pra descobrir o que isso pode virar?`,
      ],
      aceite: "🗣️ Quero a Ativação Personalizada",
      recusa: RECUSA,
    },
  },
  /* Botão "🤷‍♀️ Acho Que Não É Pro Meu Perfil" (#42): perguntas, espera a resposta e segue (#43, #44 → #46, #47) */
  "11D": {
    id: "11D",
    messages: [
      "[nome], essa dúvida é muito mais comum do que você imagina! E sabe por que ela aparece?\n\nPorque cada {mulher|pessoa} chega aqui com uma história, uma rotina, uma realidade só dela e às vezes o que a gente vê de primeira parece não encaixar no nosso mundo.",
      "Me ajuda a te entender melhor:\n\n• O que você esperava encontrar quando chegou aqui?\n• Que parte te fez pensar “isso não é pra mim”?",
    ],
    continuacao: [
      `Deixa eu te contar uma coisa: o ${MARCA.nomeProduto} foi desenhado justamente pra abraçar perfis e realidades bem diferentes. Não importa se você tem pouco tempo, se nunca fez nada parecido ou se acha que não tem habilidade nenhuma.\n\nEu quero te ajudar a enxergar como isso se encaixa na SUA vida.`,
      "Olha, eu tenho aqui uma coisa que pode te ajudar a organizar tudo isso de um jeito prático e direto.\n\nÉ uma condição que eu só abro em casos bem específicos, mas que pode ser exatamente o que falta pra você finalmente encaixar o Método na sua vida e ver o dinheiro entrando.",
    ],
    options: [optYes("✅ Pode Me Mandar a Condição"), optRed(RECUSA)],
    condicao: {
      messages: [
        "[nome], olha o que eu vou fazer especialmente por você:\n\nVou te dar 7 dias do meu tempo (eu e a minha equipe mais experiente) numa Ativação que eu só libero em casos bem pontuais.\n\nPor que não faço isso sempre? Porque é intenso, é próximo demais, e eu não teria fôlego pra atender muita gente nesse nível. Mas olhando o seu caso, o que falta é organização e direção pra começar a ver o dinheiro entrando.",
        "Nesses 7 dias, {juntas|juntos}, vamos:\n✅ Arrumar a sua rotina com precisão cirúrgica, pra o Método caber no seu dia.\n✅ Montar um cronograma nas suas janelas livres, priorizando o que traz retorno.\n✅ Ir direto nas Demandas que pagam mais rápido, pra o PIX começar logo.\n✅ Te dar suporte no WhatsApp, pra você não travar e ter clareza em cada passo.\n\nÉ acompanhamento de perto, sem enrolação, focado no que funciona pra SUA vida.",
        "Mas eu preciso de um compromisso seu: se eu reservar esse tempo pra você, você se compromete a seguir o que eu orientar?\n\nEssa é uma condição que eu abro pra pouquíssimas Parceiras, porque exige dedicação minha e sua. Se você está pront{a|o} pra dar esse passo, a gente vira esse jogo junto.\n\nO que você me diz? Posso te mandar os próximos passos pra começarmos?",
      ],
      aceite: "🗣️ Aceito a Ativação com a Gabi",
      recusa: RECUSA,
    },
  },
  /* Situação: "Cliente muda de ideia e quer continuar" (#162 → #163, #164 → #165 → aceite) */
  MD: {
    id: "MD",
    semAcolhimento: true,
    messages: [
      "[nome], que decisão maravilhosa! 🎉 De verdade, fico muito feliz em saber que você escolheu continuar. É exatamente isso que separa quem para no meio do caminho de quem chega lá: a coragem de corrigir a rota e seguir com ainda mais força. 💪\n\nSabe o que isso me mostra? Que você está comprometid{a|o} com o que realmente importa. E compromisso é o que transforma vontade em resultado. 🚀 Agora a gente pode focar no que interessa: colocar essa decisão em prática e construir algo que mude a sua vida.",
      "Eu estou aqui pra te ajudar a tirar o máximo dessa virada. Vamos {juntas|juntos}, passo a passo, porque o que vem pela frente pode ser muito maior do que você imagina. 🌟",
    ],
    options: [optAceite("✅ Sim, Quero a Condição Exclusiva")],
  },
  /* "Quebra de objeção geral com foco na Soffia" (#115): o board manda usar em todos os casos.
     Aqui ela é o 1º reenquadramento depois de uma recusa (INSISTENCIA_REENQUADRAMENTO). */
  SF: {
    id: "SF",
    messages: [
      "[nome], eu entendo as suas dúvidas de verdade. Às vezes a gente olha pra tudo que precisa fazer e pensa: “Será que eu dou conta disso?”. Mas deixa eu te mostrar uma coisa que muda completamente o jogo pra você.\n\nVocê não precisa fazer tudo sozinh{a|o}. Foi exatamente pra isso que a gente criou a Soffia.ai, uma inteligência artificial que assume o trabalho pesado por você. 📊✍️🖼️",
      "Com a Soffia.ai, você consegue:\n\n- Transformar textos em PDFs prontos em segundos. 📄➡️✏️\n- Criar textos persuasivos que vendem. 💰\n- Gerar imagens incríveis sem esforço nenhum. 🖼️\n- Escrever propostas profissionais em minutos. 📑\n- Montar roteiros completos pra vídeo, venda ou o que você precisar. E MUITO mais 🎥📝\n\nEla dá conta de um monte de coisa enquanto você só acompanha e organiza os resultados. É como ter uma equipe inteira trabalhando com você, sem o custo e sem a dor de cabeça de contratar ninguém. E o melhor: você tem 30 dias grátis pra testar tudo isso, sem compromisso.",
      "Deixa eu te perguntar: por que não aproveitar pra ver com os seus próprios olhos o que a Soffia faz por você? Você não tem nada a perder e tem muito a ganhar. 🚀\n\nSe precisar de ajuda pra começar ou quiser que eu te mostre como extrair o máximo dela, é só me chamar. Estou aqui pra transformar essa decisão em resultado de verdade! 🙌",
    ],
    options: [optYes("✅ Sim, Quero a Condição Exclusiva + Soffia"), optRed(RECUSA)],
  },
  /* Fora do board da MSI (mantidas do modelo, com texto da MSI): 12, D1–D5. */
  "12": {
    id: "12",
    messages: [
      "Te ouvi, e essa merece resposta reta. Me conta qual foi a parte que você entendeu de um jeito e encontrou de outro, com as suas palavras mesmo. Eu quero saber de verdade.",
      "E enquanto eu entendo isso com você, te proponho o seguinte: em vez de ficar com essa dúvida martelando na cabeça, me deixa te mostrar na prática o que tem aqui dentro.\n\nEu caminho com você pelos primeiros passos e você vê com os próprios olhos como o método funciona. Aí você decide com informação, não com impressão.\n\nPosso te montar esses 7 dias?",
    ],
    options: [optYes("✅ Pode montar", /pode montar|montar|sim|bora|aceito/i), optRed()],
  },
  D1: {
    id: "D1",
    messages: [
      "Entendo sua desconfiança, [nome]. Dinheiro é coisa séria e você tem todo direito de questionar.",
      "Deixa eu te mostrar o que é fato, sem discurso: o seu acesso está ativo aqui, com as aulas do método liberadas na área de membros, e você pode abrir e conferir cada módulo agora mesmo.\n\nE tem mais uma coisa concreta: você está falando comigo neste momento, e eu vou te responder até o fim.",
      `Quero fazer uma coisa por você agora: te colocar na **${NOME_ATIVACAO}**, comigo do seu lado pelos próximos 7 dias, pra você ver na prática como o método funciona, passo a passo.\n\nSe depois disso você ainda achar que não é pra você, o caminho continua aberto e eu te direciono.`,
    ],
    options: [
      optYes(`Aceito a ${NOME_ATIVACAO}`, /aceito|ativa[çc][ãa]o|pode|sim|bora/i),
      optRed("Quero o dinheiro de volta"),
      {
        label: "Continuo achando que é golpe",
        match: /golpe|fraude|enganaç|roubo|picaretagem/i,
        target: { kind: "scam_end" },
      },
    ],
  },
  D2: {
    id: "D2",
    messages: [
      `Não precisa, [nome], pode ficar tranquil{a|o} 💛 Com o ${MARCA.nomeProduto} que você já tem, você já começa numa boa. Nada do que aparece depois é obrigatório pra dar o start.`,
      `E não é que o resto seja ruim, é que é passo pra depois. Os outros produtos da ${MARCA.nomeExpert} são pra quando você quiser ir mais longe lá na frente, se fizer sentido pra você. No seu tempo, sem pressa nenhuma.\n\nAgora o que importa é você começar com o que já tá na sua mão. Posso te montar esse começo?`,
    ],
    options: [optYes("✨ Pode montar"), optRed()],
  },
  D3: {
    id: "D3",
    messages: [
      "Tudo bem, [nome], sem compromisso nenhum ainda 💛\n\nEntão faz assim comigo: me responde só qual horário do dia é o seu (**de manhã**, **no almoço** ou **de noite**) que eu já monto o seu Dia 1 em cima do seu tempo e te mando.\n\nVocê olha, e se fizer sentido eu sigo com você. Se não fizer, eu paro na hora e fico por aqui do mesmo jeito.",
    ],
    options: [
      optYes("🌅 Manhã", /manh[ãa]/i),
      optYes("☀️ Almoço", /almo[çc]o/i),
      optYes("🌙 Noite", /noite/i),
      optRed("Prefiro seguir com o reembolso"),
      {
        label: "Continua sem decidir",
        match: /deixa eu ver|depois|n[ãa]o sei|pensar|continua sem decidir/i,
        target: { kind: "finalize" },
      },
    ],
  },
  D4: {
    id: "D4",
    messages: [
      `[nome], passei só pra te dizer que seu lugar na **${NOME_ATIVACAO}** continua aqui comigo, e que eu não te dei baixa 🙏\n\nQuando você puder, me manda um **sim** e eu começo seu Dia 1 no mesmo dia. Se preferir esperar um pouco, também tá tudo bem, eu fico por aqui.`,
    ],
    options: [optYes("✅ Sim, bora"), optRed()],
  },
  D5: {
    id: "D5",
    messages: [
      "[nome], obrigada por confiar e me contar isso 💛 Não vou tratar como detalhe e não vou te vir com frase pronta.\n\nVocê não precisa dar conta de tudo hoje. Só do próximo passo.",
      "Se você topar, eu faço o caminho mais leve possível com você: um passo por dia, do tamanho que cabe no seu dia, e você só me responde com o print. Nada além disso.\n\nQuer que eu monte assim?",
    ],
    options: [
      optYes("💛 Quero, monta assim", /quero|monta|sim|bora|topo/i),
      optRed("Prefiro seguir com o reembolso"),
    ],
  },
};

// No board, o "✅ Pode me mandar a condição" depois da dúvida leva à condição da própria situação
// (#7 → #8 na rota 1; #70 → #59 na rota 2).
ROUTES["1D"].condicao = ROUTES["1"].condicao!;
ROUTES["2D"].condicao = ROUTES["2"].condicao!;

/**
 * Resumo curto do motivo da rota, usado no N137 ("O que tá pesando pra você é [diagnostico]").
 * Até 15 palavras, cada um alinhado à situação da sua rota no board.
 */
export const ROUTE_REASON: Record<RouteId, string> = {
  "1": "a sensação de fazer e ainda não ver o PIX caindo",
  "1D": "uma dúvida que ainda segura o próximo passo",
  "2": "a compra por impulso e o arrependimento",
  "2D": "a insegurança sobre ter feito a escolha certa",
  "3": "o aperto financeiro deste momento",
  "3D": "a urgência de ver dinheiro entrando sem poder errar",
  "4": "a rotina corrida, sem sobra de tempo",
  "4D": "a dúvida se o método cabe na rotina",
  "4B": "a falta de tempo",
  "4BD": "a sensação de que não vai ter tempo",
  "5": "o receio de perder o prazo do reembolso",
  "6": "a dúvida se vai conseguir aplicar o método",
  "7": "a sensação de não saber fazer nada",
  "8": "o peso das tentativas que não deram certo antes",
  "9": "já conhecer as plataformas e ainda não ter resultado",
  "10": "o medo de não ter resultado",
  "11": "a expectativa diferente do que encontrou",
  "11D": "a impressão de que o método não é pro seu perfil",
  "12": "a impressão de que a divulgação prometia outra coisa",
  MD: "a decisão de continuar",
  SF: "o peso de dar conta de tudo",
  D1: "a desconfiança com a compra",
  D2: "a ideia de que precisa comprar mais alguma coisa pra começar",
  D3: "a indecisão entre continuar ou parar",
  D4: "a correria que te afastou da conversa",
  D5: "o cansaço de dar conta de tudo sem ajuda",
};

/* ------------------------------------------------------------------ */
/* Classificação do motivo (N005): a primeira regra que casar escolhe a rota */
/* ------------------------------------------------------------------ */

const escapeRe = (text: string) => text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
/** Nome e prazo da garantia vindos de POLITICAS (ex.: "Seguro 180D", "180 dias"). */
const GARANTIA_RE_SRC = `${escapeRe(POLITICAS.nomeGarantia)}|${POLITICAS.garantiaDias} ?d(ias)?\\b`;

export const CLASSIFIERS: { route: RouteId; re: RegExp }[] = [
  { route: "D1", re: /golpe|fraude|picaret|roubo|enganaç|estelionat|pir[âa]mide/i },
  {
    route: "D5",
    re: /depress|ansiedad|exaust|esgotad|cansad|sobrecarreg|n[ãa]o aguento|chorando|sofrendo/i,
  },
  {
    route: "3",
    re: /(sem dinheiro|t[oô] dur[oa]|desempregad|aperto|apertad[oa] (de|com) dinheiro|contas? pra pagar|d[íi]vidas?\b|preciso do dinheiro|n[ãa]o tenho dinheiro|dinheiro faz falta|preciso desse valor|problemas? financeir|situa[çc][ãa]o financeira|(dif[íi]cil|apertad[oa]|complicad[oa]) financeiramente|^\s*(foi\s+)?(o\s+)?dinheiro[\s.!]*$)/i,
  },
  {
    // Antes da Rota 4 de propósito: "perder tempo" é medo de não ter retorno, não falta de tempo.
    route: "10",
    re: /(e se eu n[ãa]o tiver resultado|e se n[ãa]o der certo|medo de perder (meu |o meu |o )?tempo|perder (meu |o meu |o )?tempo|medo de n[ãa]o ter (retorno|resultado)|vou (mesmo )?ter (retorno|resultado)|garant(e|em|ir) (que )?(eu )?(vou )?(ter )?resultado|(demora|leva) (pra|para) (ter|ver|dar) (resultado|retorno))/i,
  },
  {
    // Board: "Não tenho tempo pra fazer / Minha rotina é muito corrida" (#17).
    route: "4",
    re: /(corrid[oa]|rotina|trabalho o dia|ocupad|dupla jornada|trabalho (fora|clt)|cuid(o|ar|ando) d[aoe]s? (casa|filhos|crian[çc]as))/i,
  },
  // Board: "Não tenho tempo pra fazer" (#97, segunda versão): falta de tempo sem falar da rotina.
  { route: "4B", re: /(tempo)/i },
  {
    route: "5",
    re: new RegExp(`(prazo|garantia|${GARANTIA_RE_SRC}|seis meses|6 meses|7 dias|prazo passar)`, "i"),
  },
  { route: "2", re: /(impulso|me arrependi|arrependid|comprei sem pensar|n[ãa]o (devia|deveria) ter comprado)/i },
  { route: "12", re: /(vsl|p[áa]gina de vendas|v[íi]deo de vendas|prometeu|prometia|propaganda)/i },
  {
    route: "11",
    re: /(n[ãa]o era (isso|o) que eu esperava|esperava outra coisa|imaginei (uma coisa|outra coisa|algo) diferente|achei que ia ser|expectativa|decepcion)/i,
  },
  {
    route: "9",
    re: /(j[áa] conhe[çc]o (essas|as|essas empresas e|as empresas e) (empresas|plataformas)|j[áa] (sou|fui|trabalho como|trabalhei como) freela|j[áa] (trabalho|trabalhei|fa[çc]o|fiz|mexo|mexi|uso|usei|conhe[çc]o) (com |n[oa]s? |em )?(o |a |os |as )?(freela|99 ?freelas|workana|get ?ninjas|vinte pila|vinte conto|pesquisas?|demandas?)|j[áa] sou do meio)/i,
  },
  {
    route: "8",
    re: /(j[áa] tentei|outros cursos|v[áa]rios cursos|nunca funciona|sempre d[áa] errado|nada funcionou|nada d[áa] certo)/i,
  },
  {
    route: "7",
    re: /(n[ãa]o sei fazer|n[ãa]o tenho habilidade|n[ãa]o entendo nada|sou leig|n[ãa]o sei mexer|n[ãa]o levo jeito|n[ãa]o tenho experi[êe]ncia|n[ãa]o sou boa com (tecnologia|internet|celular|computador)|n[ãa]o sei (criar|montar|mandar|escrever) (o |a |um |uma |meu |minha )?(perfil|portf[óo]lio|proposta|cadastro|conta)|n[ãa]o (consigo|consegui) (criar|fazer|montar|mandar|enviar|terminar) (o |a |um |uma |meu |minha |os |as |meus |minhas )?(perfil|portf[óo]lio|propostas?|cadastro|conta)|n[ãa]o (consigo|consegui) (me cadastrar|cadastrar|entender)|trav(ei|ada|ou) n[oa] (cadastro|perfil|proposta|plataforma|portf[óo]lio)|(achei|[ée]|muito|bem) (muito |bem )?(dif[íi]cil|complicad[oa]))/i,
  },
  {
    route: "6",
    re: /(n[ãa]o tenho certeza|ser[áa] que eu consigo|ser[áa] que vou conseguir|insegur[oa]|medo de n[ãa]o conseguir|n[ãa]o sei se (eu )?(vou conseguir|consigo)|n[ãa]o [ée] pra mim)/i,
  },
  {
    route: "D2",
    re: /(upsell|preciso comprar|ter que comprar|tenho que comprar|precisa comprar|(mentoria|s[óo]cia suprema|top demandas|accelerator|cofre( pix)?|vital[íi]cia|soff?ia) (pra|para) come[çc]ar|(pagar|assinar) (a soff?ia|o plano da soff?ia|plano pago|o plano pago))/i,
  },
  {
    route: "1",
    re: /(n[ãa]o caiu (nenhum |nada de )?pix|n[ãa]o (consigo|estou|tô) (tendo|ganhando)|n[ãa]o (consigo|consegui) (ter|ver) (nenhum )?resultado|sem resultado|nenhum resultado|n[ãa]o vendi|n[ãa]o ganhei nada|n[ãa]o fechei nenhum|ningu[ée]m (me )?(respondeu|responde|contratou|chamou))/i,
  },
];

/** Nó do board onde a proposta foi feita (para auditoria no painel). */
export const ROUTE_PROPOSAL_NODE: Partial<Record<RouteId, string>> = {
  "1": "MSI #4", "1D": "MSI #14", "2": "MSI #57", "2D": "MSI #68", "3": "MSI #77", "3D": "MSI #87",
  "4": "MSI #19", "4D": "MSI #27", "4B": "MSI #98", "4BD": "MSI #107", "5": "MSI #129", "6": "MSI #133",
  "7": "MSI #144", "8": "MSI #149", "9": "MSI #154", "10": "MSI #159", "11": "MSI #41", "11D": "MSI #47",
  "12": "N099", SF: "MSI #118", D2: "N114", D4: "N125", D5: "N131",
};

/** "Mudei de ideia, quero continuar" (board #162): vence a palavra "reembolso" da mesma frase. */
export const ROTA_MUDOU_DE_IDEIA: { route: RouteId; re: RegExp } | null = {
  route: "MD",
  re: /(mudei de ideia|quero continuar|vou continuar|decidi (continuar|ficar)|n[ãa]o quero mais (o |meu )?(reembolso|cancelamento)|desisti do (reembolso|cancelamento)|cancel(a|e|ar) (o |meu )?(pedido de )?reembolso|retir(o|ar) (o |meu )?pedido)/i,
};
