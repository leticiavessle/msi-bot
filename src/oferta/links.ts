/**
 * LINKS E CANAIS OFICIAIS
 *
 * Regra herdada: o bot só pode mandar links desta lista (e os links das aulas).
 * Todo link desta lista que aparecer numa resposta vira um BOTÃO clicável separado;
 * link fora da lista não vira botão. O e-mail de suporte só é liberado pelo servidor
 * no fim do Protocolo 7D (4ª insistência) — a IA nunca escreve esse e-mail.
 *
 * MSI (04/10/2026): área de membros, área da Mentoria, Telegram do Cofre PIX, comunidade e WhatsApp do 7D.
 * Os links do MGA (Payt, afiliações STR/MGV/PMJ, material da Payt) foram retirados: não existem na MSI.
 */
import type { Product } from "./produtos";

/** E-mail oficial (reembolso formal, ameaça jurídica, acusação de golpe mantida). */
export const EMAIL_SUPORTE = "suporte@demandasinvisiveis.com";

export type OfficialLinkDef = {
  /** Texto do botão. */
  label: string;
  /** Quando o bot pode mandar (vai para a tabela de links do prompt). */
  quando: string;
  url: string;
  /** Como reconhecer o link dentro de um texto (parte única da URL). */
  match: RegExp;
  /** Só aparece para quem tem este produto (para os outros, o link é removido da resposta). */
  soParaProduto?: Product;
  /** Link que só o servidor envia: a IA não vê o endereço (só sabe que existe). */
  soServidor?: boolean;
};

export const OFFICIAL_LINKS = {
  area_membros: {
    label: "Entrar na área de membros",
    quando: "Quando a aluna pedir o link da área de membros ou perguntar onde assistir às aulas",
    url: "https://alunos.demandasinvisiveis.com",
    match: /alunos\.demandasinvisiveis\.com\/?(?![\w/])/i,
  },
  area_mentoria: {
    label: "Entrar na área da Mentoria Sócia Suprema",
    quando: "Quando a aluna da Mentoria Sócia Suprema pedir o link da área de membros da mentoria",
    url: "https://alunos.sociasuprema.com",
    match: /alunos\.sociasuprema\.com\/?(?![\w/])/i,
    soParaProduto: "mentoria",
  },
  app_99freelas: {
    label: "Abrir o 99Freelas",
    quando: "No botão \"Onde encontrar demandas\" ou quando a aluna pedir o link do 99Freelas",
    url: "https://www.99freelas.com.br",
    match: /99freelas\.com\.br/i,
  },
  app_vintepila: {
    label: "Abrir o Vinte Pila",
    quando: "No botão \"Onde encontrar demandas\" ou quando a aluna pedir o link do Vinte Pila",
    url: "https://www.vintepila.com.br",
    match: /vintepila\.com\.br/i,
  },
  app_vinteconto: {
    label: "Abrir o Vinte Conto",
    quando: "No botão \"Onde encontrar demandas\" ou quando a aluna pedir o link do Vinte Conto",
    url: "https://www.vinteconto.com.br",
    match: /vinteconto\.com\.br/i,
  },
  soffia: {
    label: "Ativar a Soffia.ai (30 dias grátis)",
    quando:
      "Sempre que você indicar a Soffia.ai (pedido para escrever pela aluna, pergunta de preço de produto, travou na proposta ou no perfil) ou quando a aluna pedir o link da Soffia",
    url: "https://soffia.ai/msi/?src=bot-msi",
    match: /soffia\.ai\/msi/i,
  },
  telegram_cofre_pix: {
    label: "Entrar no Telegram do Cofre PIX Relâmpago",
    quando: "Quando a aluna do Cofre PIX Relâmpago pedir o link do Telegram do Cofre PIX ou perguntar onde ficam os avisos do Cofre PIX",
    url: "https://t.me/+FeH8KapN-tszNWEx",
    match: /t\.me\/\+FeH8KapN-tszNWEx/,
    soParaProduto: "cofre_pix",
  },
  /**
   * OBRIGATÓRIO (o Protocolo 7D usa): para onde vai quem aceita o acompanhamento de 7 dias.
   * MSI: WhatsApp do time, com a mensagem pronta "Quero começar a Ativação Sócia Invisível" (trocada em 08/10).
   */
  whatsapp_7d: {
    label: "Enviar minhas respostas no WhatsApp",
    quando: "Nunca por conta própria: só o servidor envia, depois do aceite no Protocolo 7D",
    soServidor: true,
    url: "https://wa.me/5531988589871?text=Quero%20come%C3%A7ar%20a%20Ativa%C3%A7%C3%A3o%20S%C3%B3cia%20Invis%C3%ADvel",
    match: /wa\.me\/5531988589871/,
  },
  comunidade: {
    label: "Entrar na Comunidade",
    quando: "Não escreva: retorne community_link=true (o servidor escolhe pelo produto da pessoa)",
    soServidor: true,
    url: "https://chat.whatsapp.com/G1JEuuigWnu4IDajeilOS0",
    match: /G1JEuuigWnu4IDajeilOS0/,
  },
} as const satisfies Record<string, OfficialLinkDef> & { whatsapp_7d: OfficialLinkDef };

export type OfficialLinkKey = keyof typeof OFFICIAL_LINKS;

/** Trecho da URL do WhatsApp do 7D (usado no painel para saber quem clicou). */
export const WHATSAPP_7D_URL_PART = "wa.me/5531988589871";
