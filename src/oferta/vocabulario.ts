/**
 * VOCABULÁRIO DA OFERTA: INTENÇÕES E SINÔNIMOS · MSI (Método Sócia Invisível)
 *
 * - Intenções: etiquetas detectadas por padrão de texto em cada mensagem (aparecem no painel,
 *   em "Analytics", ficam gravadas na mensagem e entram no prompt como contexto). Não decidem a rota sozinhas.
 * - Sinônimos: como as alunas falam → termos que aparecem nas aulas (melhora a busca).
 *
 * As intenções "comecar", "material_aula", "preciso_ajuda" e "outro" são usadas pelo motor:
 * mantenha esses nomes. As demais são da MSI (04/10/2026), tiradas das aulas: plataformas de
 * demandas, propostas, preço do serviço, recebimento, pesquisas remuneradas, habilidades e portfólio,
 * rotina, UGC, WePink. As do MGA (Payt, afiliação STR/MGV/PMJ, anúncios, TikTok) foram retiradas.
 * Os padrões comparam o texto SEM acento e em minúsculas.
 */

/** Lista oficial de intenções. */
export const INTENTS = [
  "comecar",
  "aulas",
  "material_aula",
  "conteudo_bloqueado",
  "plataformas",
  "cadastro_perfil",
  "propostas",
  "preco_servico",
  "recebimento",
  "pesquisas",
  "habilidades_portfolio",
  "rotina_tempo",
  "ugc_videos",
  "wepink",
  "sofia",
  "comunidade",
  "suporte",
  "problema_tecnico",
  "produto",
  "link",
  "reembolso",
  "golpe",
  "garantia",
  "risco_vida",
  "copy_roteiro",
  "preciso_ajuda",
  "outro",
] as const;

export type Intent = (typeof INTENTS)[number];

const PLATAFORMAS =
  "99 ?freelas|workana|vinte pila|vinte conto|get ?ninjas|freelancer|upwork|fiverr|plataformas? de (demandas?|freela)";
const PESQUISAS = "pesquisas?( pagas| remuneradas)?|attapoll|grabpoints|falai|voissy|meseems|modatta|ysense|opiniao";

export const INTENT_RULES: { intent: Intent; re: RegExp }[] = [
  { intent: "copy_roteiro", re: /(copy|copywriting)/ },
  {
    intent: "copy_roteiro",
    re: /(escrev|cria(r|e|m)?|gera(r|e|m)?|faz(er)?|faca|monta(r|e|m)?|reescrev|produz|redig)[a-z]*\s+(uma?\s+|o\s+|um\s+|meu\s+|minha\s+|pra\s+mim\s+|para\s+mim\s+)*(copy|roteiro|headline|cta|texto|script|proposta|descricao|bio|legenda)/,
  },
  {
    intent: "copy_roteiro",
    re: /(quer(o|ia)|precis\w*|mand(a|e)|me da)\s+(uma?\s+|o\s+|um\s+)*(copy|roteiro|headline|cta|proposta pronta|modelo de proposta)\b/,
  },
  {
    intent: "reembolso",
    re: /(reembolso|estorno|cancelar (minha )?(compra|assinatura|curso)|quero cancelar)/,
  },
  { intent: "golpe", re: /(golpe|fraude|enganacao|enganaram)/ },
  { intent: "garantia", re: /(garantia|seguro 180|prazo.*reembolso|quantos dias.*reembolso)/ },
  {
    intent: "risco_vida",
    re: /(quero morrer|vou me matar|me machucar|tirar minha vida|nao quero mais viver)/,
  },
  {
    intent: "comecar",
    re: /(por onde (eu )?comeco|o que (eu )?(faco|devo fazer)|primeiro passo|proximo passo|primeira aula|boas[ -]vindas)/,
  },
  {
    intent: "conteudo_bloqueado",
    re: /(bloqueada|bloqueado|nao libera|nao aparece a aula|sem acesso a aula)/,
  },
  {
    intent: "material_aula",
    re: /(material|materiais|arquivo|apostila|pdf|planilha|template|modelo|checklist|guia|download|baixar|documento|certificado)/,
  },
  { intent: "aulas", re: /(aula|aulas|modulo|vitrine|conteudo do curso)/ },
  { intent: "plataformas", re: new RegExp(`(${PLATAFORMAS})`) },
  { intent: "cadastro_perfil", re: /(cadastr\w*|criar (a |minha )?conta|perfil|vitrine digital|foto do perfil|descricao do perfil)/ },
  { intent: "propostas", re: /(proposta|propostas|lance|candidat\w*|conex(ao|oes)|moedas|follow ?up|cliente nao respond|mensagens? que fecham)/ },
  { intent: "preco_servico", re: /(quanto (eu )?cobr\w*|precific\w*|preco do (meu )?servico|valor do (meu )?servico|orcamento|pacote de servico)/ },
  { intent: "recebimento", re: /(receb\w*|saque|sacar|pix|paypal|mercado pago|conta bancaria|dados bancarios|ciclo de pagamento|quando (eu )?recebo)/ },
  { intent: "pesquisas", re: new RegExp(`(${PESQUISAS})`) },
  { intent: "habilidades_portfolio", re: /(habilidade|habilidades|skills?|portfolio|o que eu sei fazer|inventario|talento)/ },
  { intent: "rotina_tempo", re: /(tempo|rotina|produtividade|sobrecarga|organiza\w*|clt|filhos?|dupla jornada)/ },
  { intent: "ugc_videos", re: /(ugc|video|videos|capcut|gravar|reels|stories|edicao|testadora|testar produtos?)/ },
  { intent: "wepink", re: /(wepink|we pink)/ },
  { intent: "sofia", re: /\bsoff?ia\b/ },
  { intent: "comunidade", re: /(grupo|comunidade|whatsapp|link do grupo|telegram)/ },
  { intent: "produto", re: /(produto|plano|upgrade|assinar|mentoria|top demandas|cofre pix|vitalicia)/ },
  {
    intent: "problema_tecnico",
    re: /(erro|bug|travou|nao (abre|carrega|funciona)|nao consigo (criar|acessar|entrar|logar))/,
  },
  { intent: "suporte", re: /(suporte|atendimento|falar com alguem|falar com o time)/ },
  { intent: "link", re: /(link|site|url|endereco)/ },
];

/** Sinônimos usados pelas alunas → termos das aulas. */
export const SYNONYMS: Record<string, string[]> = {
  comunidade: ["whatsapp", "grupo", "comunidade"],
  grupo: ["whatsapp", "comunidade"],
  whats: ["whatsapp"],
  zap: ["whatsapp"],
  suporte: ["suporte", "atendimento", "ajuda"],
  conta: ["cadastro", "acesso", "login", "perfil"],
  cadastro: ["conta", "perfil", "vitrine digital"],
  perfil: ["cadastro", "vitrine digital", "portfolio"],
  reembolso: ["reembolso", "estorno", "cancelamento", "suporte"],
  assinatura: ["plano", "mensalidade"],
  comecar: ["comeco", "inicio", "primeira aula", "boas vindas", "primeiros passos"],
  comeco: ["comecar", "inicio", "primeira aula", "boas vindas"],
  // Vocabulário do Método Sócia Invisível
  demanda: ["demandas", "subdemanda", "subdemandas", "microprojeto", "projeto"],
  demandas: ["demanda", "subdemandas", "microprojetos", "projetos"],
  subdemanda: ["demanda", "subdemandas", "microprojeto"],
  freela: ["demanda", "microprojeto", "projeto", "freelancer"],
  freelas: ["demandas", "microprojetos", "projetos"],
  job: ["demanda", "projeto", "microprojeto"],
  trabalho: ["demanda", "projeto"],
  servico: ["gig", "demanda", "microprojeto", "oferta"],
  gig: ["servico", "vinte pila"],
  proposta: ["propostas", "lance", "candidatura", "orcamento"],
  mensagens: ["proposta", "propostas"],
  fecham: ["proposta", "propostas", "contratar"],
  fechar: ["proposta", "propostas", "contratar"],
  lance: ["proposta", "freelancer"],
  conexoes: ["99freelas", "proposta", "plano"],
  moedas: ["getninjas", "pedido"],
  cobrar: ["precificacao", "preco", "valor", "orcamento"],
  preco: ["precificacao", "valor", "orcamento"],
  valor: ["precificacao", "preco", "orcamento"],
  receber: ["recebimento", "saque", "pagamento", "pix", "ciclo de pagamento"],
  recebo: ["recebimento", "saque", "pagamento", "pix"],
  saque: ["receber", "sacar", "saldo minimo"],
  pagamento: ["recebimento", "ciclo de pagamento", "pix"],
  pesquisa: ["pesquisas", "pesquisas remuneradas", "opiniao"],
  pesquisas: ["pesquisas remuneradas", "opiniao", "plataformas de pesquisa"],
  habilidades: ["skills", "talentos", "inventario", "portfolio"],
  portfolio: ["portfólio", "cases", "vitrine digital"],
  "99freelas": ["99 freelas", "noventa e nove freelas"],
  getninjas: ["get ninjas"],
  tempo: ["rotina", "auditoria de tempo", "produtividade"],
  ugc: ["video", "conteudo gerado pelo usuario", "mis"],
  video: ["capcut", "gravar", "ugc"],
  soffia: ["sofia", "inteligencia artificial", "ia"],
  sofia: ["soffia", "inteligencia artificial"],
};
