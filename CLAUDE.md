# Bot de suporte da oferta MSI (cópia da estrutura do "Jornada Hydra - ATIVO" / MGA)

**Leia `COMECE-AQUI.md` antes de começar** (pedido original, o que já foi feito, o que falta).
Para quem vai publicar: `ENTREGA-PARA-O-DEV.md`.
Modelo de origem, que NÃO deve ser alterado: `/Users/leticiavessle/Nova Oferta - bot`.

Projeto feito fora do Lovable em 04/10/2026, a partir do código baixado do Lovable
(original intocado em `/Users/leticiavessle/MGA - bot/codigo-lovable-original`).
TanStack Start + React + Supabase, compilado para Cloudflare Workers (Nitro). Tudo em português.

## Onde fica cada coisa
- `src/oferta/` — TUDO que muda de uma oferta para outra (marca, produtos, links, aulas, atalhos,
  respostas oficiais, textos do 7D, vocabulário, relatórios e os 4 blocos do prompt em `prompt/*.md`).
  Conteúdo da MSI desde 04/10/2026 (o que falta: seção 9 do `COMECE-AQUI.md`).
- `src/lib/dr/` — o motor (não muda com a oferta): chat, 7D, travas, IA, busca, webhooks, painel.
- `supabase/migrations/` — estrutura do banco (validada em Postgres); `supabase/agendamentos.sql` — tarefas pg_cron.
- `docs/` — mapa do sistema, restrições, o que preencher, como publicar, achados no MGA.

## Comandos
- `npm run dev` (porta 8080) · `npm run typecheck` · `npm test` (Bun) · `npm run build` · `npm run check` (os três)
- Sempre rode `npm run check` depois de mexer em `src/oferta/` ou no motor.

## Regras herdadas do MGA (o porquê de cada trava)
- Toda mensagem do bot passa por `guardRefundOutput` antes de ser gravada (auditoria em `metadata.refund_guard`);
  abaixo de 4/4 insistências, texto com o e-mail de reembolso/cancelamento é trocado pela Rota 5.
  Por quê: nenhuma rota, IA ou estado antigo pode furar a regra do e-mail de reembolso.
- O Protocolo 7D é decidido 100% no servidor (`refund-protocol.ts`) com os textos de `src/oferta/protocolo-7d.ts`;
  a IA nunca escreve sobre reembolso. Toda proposta tem pelo menos um aceite e uma recusa (`proposalReplies`).
- Cancelamento/desistência = pedido de reembolso (mesma régua de 4). "Já mandei o pedido" (`isDeadlineFollowUp`)
  recebe COBRANCA_PRAZO, sem e-mail e sem passo a passo.
- Aceite digitado só conta logo depois de uma proposta oficial (`isProposalContext`) e sem ressalva (`isTypedAccept`);
  na dúvida, não é aceite. Aceite → N143 + cartão do WhatsApp (+ N145 se a oferta tiver; na MSI é a caixa #90 do board).
- Dúvida técnica (no MGA: anúncios/Meta, `TEMA_TECNICO_SEM_7D_RE`) e respostas oficiais nunca abrem o 7D,
  a não ser que haja pedido efetivo de reembolso/cancelamento.
- Atendimento humano assumido (`conversations.human_takeover_*`): o bot grava a mensagem e fica em silêncio;
  mensagens da equipe (`metadata.human`) não contam para o estado do 7D. Só "Devolver ao bot" libera.
- Cartão "Falar com o atendimento humano" só nos casos oficiais (`CASOS_ATENDIMENTO_HUMANO` + Ativação aceita).
- `lesson_refs` só vira cartão se o id estiver entre os trechos encontrados (anti-invenção de aula).
- Links oficiais viram botões e nunca ficam crus no texto (`extractOfficialLinks`); links `soServidor` não vão para a IA.
- Insights (`conversation_insights`) e relatórios (`daily_reports`) são só leitura para relatório; o chat nunca lê.
  API de relatório: Bearer `REPORT_API_TOKEN`; `publicar` grava antes de mandar o WhatsApp.
- Hubla manda nas revogações: reembolso/chargeback/cancelamento na Hubla bloqueia reativação por Payt/Cademí.
  Payt sem produto mapeado libera o produto padrão com `metadata.payt_provisional` (revogável em lote).
- Métricas do painel são contadas no banco (`admin_overview_metrics` / `admin_usage_series`);
  listas usam `fetchAll` (a API limita 1.000 linhas por leitura).
- IA: `runAI` em `ai-provider.server.ts`. Chave ativa no painel vence sempre e nunca cai para a reserva do `.env`.
  Chaves criptografadas com AES-GCM (`AI_SETTINGS_ENC_KEY`); `ai_settings`/`ai_usage_log` só para o servidor.

## Mudanças em relação ao MGA (de propósito)
- Sem Lovable: config Vite própria, sem gateway de IA do Lovable, sem login intermediado, avatar local.
- Produtos da MSI (5, todos de pagamento único, Hubla + Payt): `principal`, `top_demandas`, `cofre_pix`, `mentoria`,
  `vitalicia` (no MGA eram mga, med, evolution). Sem produto recorrente (`PRODUTO_RECORRENTE = null`).
- Chat recusa quem não tem nenhum produto ativo; memória do aluno gravada com upsert (no MGA nunca gravava).
- Gatilho `on_auth_user_created` ligado no banco; tarefas pg_cron leem a senha de `job_tokens` (nada fixo no SQL).
- Notificações push com handler importado pelo service worker (no MGA o handler era sobrescrito no build).
- Alerta de venda (MSI, não existia no MGA): pergunta de preço/desconto/parcelamento/como comprar continua recebendo
  `POLITICAS.respostaPreco` ("é com o time") e grava em `sales_alerts` (aba "Vendas" do painel). Detecção em
  `src/lib/dr/sales-alert.ts`; nomes dos produtos e exclusões em `src/oferta/atalhos.ts` (`VENDA_PRODUTOS`, `VENDA_EXCLUIR_RE`).
- Atendimento humano (MSI): o link humano (WhatsApp) só sai na Ativação aceita (`ATENDIMENTO_HUMANO.cartaoNosCasos = false`).
  Os casos oficiais (acesso, pagamento) são respondidos pelo servidor com texto fixo e vão para o painel
  (Acessos / Alertas) — `src/lib/dr/human-cases.ts`. Com `cartaoNosCasos = true` volta o comportamento do MGA.
- Pendências da oferta: seção 9 do `COMECE-AQUI.md`.
- 7D da MSI: textos reescritos (mesma estrutura do board). Duas correções no motor achadas na MSI: pergunta hipotética
  na 1ª mensagem usa o motivo da Rota 5 no N137 (no MGA saía o texto cru da aluna) e `stripEmoji` não deixa espaço
  no começo da linha.
- Gênero (MSI, 08/10): voz do bot no feminino ("obrigada", "a assistente"); a pessoa é tratada no feminino e só no
  masculino quando o primeiro nome é claramente de homem (`src/lib/dr/genero.ts`, `POLITICAS.tratamentoPadrao`).
  Textos fixos usam `{feminino|masculino}` (ex.: `pront{a|o}`), resolvido dentro de `fillName`; a IA recebe
  "Tratamento: feminino/masculino" no contexto do servidor.
- 7D da MSI segue o board do Miro (`docs/referencia-msi/board-retencao-msi.md`). Recursos novos no motor, todos
  ligados por `src/oferta/protocolo-7d.ts`: `condicao` por rota (no MGA era sempre N135–N140; `CONDICAO_PADRAO`),
  `continuacao` ("espera responder": etapa `aguardando_resposta_pergunta`), alvo `accept` (aceite direto),
  `optRota` (botão de dúvida), reenquadramento que é uma rota inteira (`{ rota: "SF" }`), `ROTA_MUDOU_DE_IDEIA`,
  recusa reconhecida pelo texto do botão (`isRedLabel`) e N145 opcional. A régua de 4 insistências continua.
- Prompt revisado pela dona do produto (09/10): palavras proibidas na voz (bloco 01), Soffia.ai como resposta para
  "escreve pra mim" e perguntas de preço (02/03). A IA só diz que avisou o time quando o servidor gravou o alerta de
  venda (`salesAlerted` → "Interesse de compra avisado ao time agora: sim" no contexto).
- LastLink (MSI, 09/10): adapter `lastlink` em `webhooks.server.ts` (formato oficial `{ Id, IsTest, Event, Data: { Buyer,
  Products } }`, senha `?token=` = `WEBHOOK_SECRET_LASTLINK`, origem `access_source = 'lastlink'`, migração
  `20261009000000_lastlink.sql`). Nomes de produto pelas mesmas regras da Hubla.
- Entrada no bot (MSI, 09/10): e-mail › CPF › nome da compra › WhatsApp, um de cada vez (`iniciarEntrada` em
  `access.functions.ts`, regras em `identificacao.ts`, textos em `src/oferta/entrada.ts`). CPF guardado completo
  (`authorized_users.cpf`, a equipe vê no painel; a aluna nunca vê); nome só vale com uma pessoa; cadastro inativo
  nunca entra por reserva; limite de tentativas por aparelho e rede. Nada encontrado → aba Acessos › Entrada no bot.
  E-mail alterável no painel (`changeAuthorizedEmail`): ela passa a entrar com o novo e a conversa antiga continua;
  o antigo vai para `emails_anteriores` e webhooks, login e planilha continuam achando a pessoa. Se o e-mail novo já
  tem cadastro, os dois são juntados (produtos somam, histórico vai para a mesma conta). Dupla checagem: quem entrou pelo nome ou WhatsApp não recebe link de acesso
  direto (`viaPrecisaConferir`, `ultimaEntrada`); o alerta de acesso ganha `conferir_identidade`.
- Só produtos da MSI liberam o bot (09/10): as contas da Hubla, Payt e LastLink vendem produtos de outros experts
  (MGA/Jeoacas, Paola Lellis, Bianca Rodrigues...). `DA_OFERTA_RE` em `src/oferta/produtos.ts`: nome que não casa é
  "outra oferta" e é ignorado no webhook (sem Payt provisório) e na planilha. "Plataforma Soffia AI - MSI" está em
  `SEM_ACESSO_RE` (não libera; a confirmar). Antes disso, "mentoria" sozinho e produto desconhecido viravam produto da MSI.
- Botões do chat podem ter resposta pronta sem IA (`QuickAction.resposta`: texto + links oficiais + cartões de aula);
  na MSI, "💼 Onde encontrar demandas" (99Freelas › Vinte Pila › Vinte Conto, com o aviso do CPF).

