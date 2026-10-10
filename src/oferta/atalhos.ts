/**
 * ATALHOS: BOTÕES RÁPIDOS E RESPOSTAS FIXAS SEM IA
 *
 * Tudo aqui é decidido pelo servidor, antes da IA. Quando um atalho casa, a resposta é o
 * texto fixo daqui (com [nome] trocado pelo primeiro nome), com os botões de link indicados.
 *
 * MSI (04/10/2026): botões e atalhos montados a partir das aulas (plataformas de demandas, propostas,
 * pesquisas remuneradas, recebimento). Os atalhos do MGA (Payt, afiliação, anúncios no Meta) foram retirados.
 */
import type { OfficialLinkKey } from "./links";
import type { Product } from "./produtos";

/* ------------------------------------------------------------------ */
/* Botões rápidos acima da caixa de texto do chat                       */
/* ------------------------------------------------------------------ */

export type QuickAction = {
  intent: string;
  label: string;
  product: Product;
  /**
   * Resposta pronta do servidor, sem IA (MSI). Sem isto, o texto do botão vai para a IA com a intenção.
   * [nome] vira o primeiro nome; `links` viram botões; `aulas` viram cartões de aula.
   */
  resposta?: { texto: string; links?: OfficialLinkKey[]; aulas?: string[] };
};

/** Observação do cadastro e do saque (pedido da dona do produto, 09/10/2026). */
export const AVISO_CPF_TITULAR =
  "⚠️ Antes de começar: em geral, o CPF do cadastro precisa ser do mesmo titular da conta bancária do saque. Cadastrou no seu CPF? A conta bancária também precisa estar no seu CPF. Se usar o CPF de alguém de confiança, a conta bancária precisa ser dessa mesma pessoa. Fazer certinho agora leva uns minutos a mais e evita saque travado lá na frente.";

/**
 * Botão "Onde encontrar demandas" (MSI, 09/10/2026): por ordem de chance de primeiro resultado, segundo as aulas.
 * 1. 99Freelas (demandas rápidas e pontuais, cadastro grátis); 2. Vinte Pila (a partir de R$ 20, quem contrata te
 * encontra); 3. Vinte Conto (feito pra quem está começando). Depois: Workana, GetNinjas (paga moedas) e Freelancer.com.
 */
const ONDE_ENCONTRAR_DEMANDAS = `[nome], pra ter o seu primeiro resultado mais rápido, comece por estes 3, nesta ordem 👇

**1. 99Freelas** (Módulo 07): demandas rápidas e pontuais, e o cadastro é grátis.
• Toque em **Abrir o 99Freelas** › **Cadastre-se** › escolha **Eu quero trabalhar** › nome, e-mail e senha.
• Em **Editar perfil**, capriche no **título profissional** (é a primeira coisa que quem contrata vê) e coloque uma foto clara, com o rosto.

**2. Vinte Pila** (Módulo 10): você anuncia o que sabe fazer, a partir de R$ 20, e quem contrata te encontra.
• Botão verde pra criar a conta › pessoa física › nome, celular, e-mail, CPF, senha e endereço.
• Em **Editar perfil**, escreva uma apresentação curta (até 300 caracteres) e já preencha os dados bancários, que ficam na mesma tela.

**3. Vinte Conto** (Módulo 12): feito pra quem está começando. Você publica o que oferece e quem contrata te encontra.
• **Registrar** › nome, e-mail e senha. Depois, publique o que você oferece (Aula 03 do Módulo 12).

Com o perfil rodando, os próximos são o Workana (Módulo 08), o GetNinjas (Módulo 11) e o Freelancer.com (Módulo 13).

${AVISO_CPF_TITULAR}

Quando terminar o primeiro cadastro, me conta que eu te digo o próximo passo 💛`;

/** Intenção do botão "Comunidade": responde na hora com o link da comunidade do produto da pessoa. */
export const INTENT_COMUNIDADE = "comunidade";

export const QUICK_ACTIONS: QuickAction[] = [
  { intent: "comecar", label: "🚀 Por onde eu começo?", product: "principal" },
  { intent: "duvida_aula", label: "📚 Dúvida sobre uma aula", product: "principal" },
  {
    intent: "plataformas",
    label: "💼 Onde encontrar demandas",
    product: "principal",
    resposta: {
      texto: ONDE_ENCONTRAR_DEMANDAS,
      links: ["app_99freelas", "app_vintepila", "app_vinteconto"],
      aulas: ["V1.M07.A02", "V1.M10.A02", "V1.M12.A02"],
    },
  },
  { intent: "propostas", label: "✍️ Mensagens que fecham demandas", product: "principal" },
  { intent: "pesquisas", label: "📝 Pesquisas remuneradas", product: "principal" },
  { intent: "recebimento", label: "💸 Como eu recebo pelas demandas", product: "principal" },
  { intent: INTENT_COMUNIDADE, label: "👥 Comunidade", product: "principal" },
];

/* ------------------------------------------------------------------ */
/* Passos de execução respondidos na hora (sem IA)                      */
/* ------------------------------------------------------------------ */

export type AtalhoExecucao = {
  id: string;
  /** Quando a mensagem casa com este padrão (e não casou nenhuma resposta oficial). */
  re: RegExp;
  /** Texto fixo. [nome] vira o primeiro nome (ou some, se não houver nome). */
  texto: string;
  /** Links oficiais que viram botões, na ordem. */
  links: OfficialLinkKey[];
  /** Aula que vira cartão junto (código da aula, ex.: V4.M05.A03). */
  aula?: string;
};

/**
 * MSI: "não consegui me cadastrar na plataforma X" → cartão da aula de cadastro daquela plataforma
 * (todas são gravação de tela, passo a passo). O texto é o mesmo para todas; [plataforma] vira o nome.
 */
const CADASTRO_TEXTO =
  "[nome], o cadastro no [plataforma] está passo a passo nesta aula, com gravação de tela (cartão abaixo) 💛\n\nAbre a aula e vai fazendo junto, tela por tela. Importante: o CPF do cadastro precisa ser do mesmo titular da conta bancária do saque.\n\nSe travar em alguma parte, me conta em qual passo parou (pode mandar print) que eu te ajudo a destravar.";

/** Plataformas de demandas do curso e a aula de cadastro de cada uma. Sem acento, minúsculas. */
const CADASTRO_POR_PLATAFORMA: { id: string; nome: string; re: string; aula: string }[] = [
  { id: "cadastro_99freelas", nome: "99Freelas", re: "99 ?freelas", aula: "V1.M07.A02" },
  { id: "cadastro_workana", nome: "Workana", re: "workana", aula: "V1.M08.A02" },
  { id: "cadastro_vinte_pila", nome: "Vinte Pila", re: "vinte ?pila", aula: "V1.M10.A02" },
  { id: "cadastro_getninjas", nome: "GetNinjas", re: "get ?ninjas", aula: "V1.M11.A02" },
  { id: "cadastro_vinte_conto", nome: "Vinte Conto", re: "vinte ?conto", aula: "V1.M12.A02" },
  { id: "cadastro_freelancer", nome: "Freelancer.com", re: "freelancer(?:\\.com)?", aula: "V1.M13.A02" },
];

/** "não consegui criar a conta / me cadastrar / fazer o cadastro ... no [plataforma]" (e variações). */
const NAO_CONSEGUI_CADASTRO =
  "(n[ãa]o\\s+(consegui|consigo|sei)|ainda\\s+n[ãa]o\\s+(criei|fiz|consegui)|como\\s+(eu\\s+)?(fa[çc]o|crio))\\s+(o\\s+|a\\s+|meu\\s+|minha\\s+)?(criar\\s+|fazer\\s+|abrir\\s+)?(a\\s+|o\\s+|meu\\s+|minha\\s+)?(conta|cadastro|me\\s+cadastrar|cadastrar)";

/** A ordem importa: o primeiro que casar responde. */
export const ATALHOS_EXECUCAO: AtalhoExecucao[] = CADASTRO_POR_PLATAFORMA.map((p) => ({
  id: p.id,
  re: new RegExp(`\\b${NAO_CONSEGUI_CADASTRO}\\b[\\s\\S]{0,25}\\b(n[oa]|d[oa])\\s+${p.re}\\b`, "i"),
  texto: CADASTRO_TEXTO.replace("[plataforma]", p.nome),
  links: [],
  aula: p.aula,
}));

/* ------------------------------------------------------------------ */
/* Casos oficiais de atendimento humano fora do 7D                       */
/* ------------------------------------------------------------------ */
/*
 * Regra do MGA: o cartão de atendimento humano SÓ aparece nestes casos oficiais
 * (além da Ativação aceita no 7D). A IA nunca decide isso sozinha.
 *
 * MSI (decisão de 04/10/2026): o link humano (WhatsApp) só é liberado no acompanhamento de 7 dias.
 * Por isso ATENDIMENTO_HUMANO.cartaoNosCasos = false (produtos.ts): nestes casos o SERVIDOR responde
 * com o texto fixo de `resposta` ([nome] vira o primeiro nome) e registra no painel, sem link:
 *   painel "acessos" → aba Acessos (access_alerts); painel "alertas" → aba Alertas (risk_alerts).
 * A `nota` é a mesma métrica do MGA ("Acesso, veio do bot"...).
 */
export const CASOS_ATENDIMENTO_HUMANO: {
  nota: string;
  descricao: string;
  re: RegExp;
  painel: "acessos" | "alertas";
  resposta: string;
}[] = [
  {
    // Comprou e não tem acesso à área de membros.
    nota: "Acesso, veio do bot",
    descricao: "a pessoa comprou e não tem acesso à área de membros",
    re: /\b(comprei|paguei|fiz a compra|adquiri)\b[\s\S]{0,80}\b(n[ãa]o|sem)\b[\s\S]{0,40}\b(acesso|entrar|entro|consigo entrar|liberado|liberaram|chegou)\b/i,
    painel: "acessos",
    resposta:
      "[nome], já registrei aqui que você comprou e ainda não conseguiu entrar na área de membros. A equipe vai conferir o seu acesso e reenviar para o e-mail da sua compra 💛\n\nEnquanto isso, dá uma olhadinha na caixa de spam e na aba Promoções desse e-mail, porque às vezes o acesso cai lá.",
  },
  {
    // Suspeita de fraude ou cobrança errada no pagamento.
    nota: "Pagamento, veio do bot",
    descricao: "suspeita de fraude ou cobrança errada no pagamento",
    re: /\b(cobran[çc]a\s+(indevida|errada|duplicada|a\s+mais)|cobrad[oa]\s+(duas\s+vezes|a\s+mais|errad[oa])|cobraram\s+(duas\s+vezes|a\s+mais|errado)|compra\s+que\s+eu\s+n[ãa]o\s+fiz|n[ãa]o\s+reconhe[çc]o\s+(essa\s+)?(compra|cobran[çc]a)|fraude\s+no\s+(cart[ãa]o|pagamento))\b/i,
    painel: "alertas",
    resposta:
      "[nome], já registrei aqui o problema com o seu pagamento e passei para a equipe conferir. Não precisa refazer a compra e nem mandar dados do cartão por aqui, tá? 💛",
  },
];

/* ------------------------------------------------------------------ */
/* Assuntos técnicos que NUNCA entram no Protocolo 7D                    */
/* ------------------------------------------------------------------ */
/*
 * No MGA era qualquer menção a anúncios/Meta ("cancelar campanha" não é cancelar a compra).
 * MSI (04/10/2026): cancelar/desistir de coisas DAS PLATAFORMAS (proposta, projeto, pedido, lance,
 * gig, conexões, moedas, plano ou conta numa plataforma, plano da Soffia) é dúvida técnica, não pedido
 * de cancelamento da compra. Só frases desse tipo: "quero cancelar minha compra" continua indo para o 7D.
 * Comparado sem acento e em minúsculas.
 */
const PLATAFORMAS_RE =
  "(99 ?freelas|workana|vinte pila|vinte conto|get ?ninjas|freelancer(\\.com)?|upwork|fiverr|attapoll|grabpoints|falai|voissy|meseems|modatta|ysense|wepink|soff?ia|mis|capcut)";
export const TEMA_TECNICO_SEM_7D_RE = new RegExp(
  "\\b(cancel\\w*|desist\\w*|excluir|apagar|retirar)\\s+((a|o|as|os|minha|meu|minhas|meus|essa|esse|uma|um|da|do)\\s+){0,2}" +
    "(propostas?|projetos?|lances?|ofertas? (do|de) servico|pedidos?|gigs?|candidaturas?|conex(ao|oes)|moedas|" +
    `(plano|assinatura|conta|perfil) (do|da|no|na) ${PLATAFORMAS_RE})\\b`,
);

/* ------------------------------------------------------------------ */
/* Alerta "dificuldade de acesso" (só painel)                            */
/* ------------------------------------------------------------------ */
/**
 * Assuntos que parecem "não consigo acessar" mas NÃO são a área de membros.
 * MSI: contas nas plataformas de demandas e de pesquisas, apps, comunidade, Telegram, meios de pagamento.
 * (No MGA: pasta de divulgação, Payt, gerenciador de anúncios.) Sem acento, minúsculas.
 */
export const ACESSO_EXCLUIR_RE = new RegExp(
  `\\b(?:${PLATAFORMAS_RE}|canva|inshot|chatgpt|paypal|mercado pago|grupo|comunidade|telegram|instagram|insta|tiktok|facebook)\\b`,
);

/* ------------------------------------------------------------------ */
/* Alerta de venda (só painel)                                          */
/* ------------------------------------------------------------------ */
/*
 * MSI (pedido de 04/10/2026): quando a aluna pergunta preço, desconto, parcelamento ou como
 * comprar um produto, o bot continua respondendo POLITICAS.respostaPreco ("é com o time") e o
 * painel ganha um alerta na aba "Vendas" para o time chamar. A regra de detecção fica em
 * src/lib/dr/sales-alert.ts; aqui ficam só os nomes da oferta. Sem acento, minúsculas.
 */

/** Como a aluna chama cada produto (o primeiro que casar vale; o principal fica por último). */
export const VENDA_PRODUTOS: { product: Product; re: RegExp }[] = [
  // Nomes antigos do próprio método nas gravações (Mentoria Projetos Remunerados, Método GV, Estratégia MPR)
  // = Método Sócia Invisível; vêm antes da mentoria para "mentoria projetos remunerados" não virar Sócia Suprema.
  { product: "principal", re: /\b(mentoria projetos remunerados|projetos remunerados|metodo gv|estrategia mp[ir])\b/ },
  { product: "mentoria", re: /\b(mentoria|socia suprema)\b/ },
  { product: "top_demandas", re: /\b(top demandas?|accelerator)\b/ },
  { product: "cofre_pix", re: /\b(cofre( do)?( pix)?|pix relampago)\b/ },
  { product: "vitalicia", re: /\b(vitalici[ao]|socia vitalicia)\b/ },
  { product: "principal", re: /\b(metodo socia invisivel|socia invisivel|metodo invisivel|msi)\b/ },
];

/**
 * Quando a aluna NÃO cita um produto da Gabriela, estes assuntos indicam que o preço é de
 * outra coisa (ferramenta citada nas aulas, plataforma de demandas, o valor que ELA cobra)
 * ou de uma compra já feita (problema de cobrança): não é alerta de venda.
 */
export const VENDA_EXCLUIR_RE =
  /\b(soff?ia|wepink|capcut|workana|99 ?freelas|getninjas|vinte pila|vinte conto|freelancer|upwork|attapoll|grabpoints|falai|voissy|meseems|modatta|ysense|demandas?|clientes?|servicos?|propostas?|cobrar|cobro|cobran\w*|cobrad\w*|cobraram|paguei|comprei|estorn\w*|reembols\w*)\b/;
