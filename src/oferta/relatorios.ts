/**
 * RELATÓRIOS (08h e 17h) E CLASSIFICAÇÃO DAS CONVERSAS
 *
 * A cada hora, uma IA de tarefas lê as conversas novas e grava um "insight" por conversa
 * (só para o relatório; nunca muda o chat). MSI (04/10/2026): temas e etapas tirados das aulas
 * (plataformas de demandas, propostas, recebimento, pesquisas...). As do MGA (Payt/STR, pixel,
 * campanha no Meta, conta bloqueada, quanto investir) foram retiradas.
 * (No banco não há trava nessas listas; quem confere é o código.)
 */

/** Assunto principal da conversa (MSI: tirado das aulas). */
export const TOPICS = [
  "acesso_login",
  "primeiros_passos",
  "cadastro_plataforma",
  "propostas_clientes",
  "preco_do_servico",
  "recebimento_saque",
  "pesquisas_remuneradas",
  "habilidades_portfolio",
  "rotina_tempo",
  "conteudo_aula",
  "quando_vou_ganhar",
  "interesse_compra",
  "reembolso_cancelamento",
  "outros",
] as const;

/** Motivo do pedido de reembolso. */
export const REFUND_REASONS = [
  "nao_conseguiu_acessar",
  "achou_dificil",
  "nao_era_o_esperado",
  "sem_tempo",
  "aperto_financeiro",
  "sem_resultado_rapido",
  "sem_demandas_ou_clientes",
  "comprou_por_impulso",
  "desconfianca_golpe",
  "outro",
] as const;

/** Etapas da jornada da aluna, na ordem (funil do relatório). */
export const STAGES = [
  "1_acesso",
  "2_boas_vindas_comunidade",
  "3_habilidades_portfolio",
  "4_cadastro_plataforma",
  "5_primeira_proposta",
  "6_primeiro_ganho",
] as const;

/** Como o classificador chama o curso. */
export const NOME_DO_CURSO_NO_RELATORIO = "curso Método Sócia Invisível";

/**
 * Modelo (template) aprovado no WhatsApp Manager para o resumo do relatório (8 parâmetros).
 * ⚠️ Precisa ser criado e aprovado no WhatsApp Manager da MSI com este nome antes de publicar.
 */
export const WHATSAPP_TEMPLATE_RELATORIO = "relatorio_msi";
