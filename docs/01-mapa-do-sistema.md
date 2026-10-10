# Mapa do sistema (a mesma estrutura do Jornada Hydra - ATIVO)

Levantado em 04/10/2026 lendo o código baixado do Lovable (288 arquivos) e a estrutura do banco
no Lovable Cloud (somente leitura). Este projeto é uma cópia dessa estrutura, fora do Lovable.

## As peças

| Peça | O que é | Onde fica |
|---|---|---|
| App | Site + chat + painel admin, em TanStack Start (React) | `src/routes`, `src/components` |
| Motor do bot | Decide cada resposta, travas, 7D, IA, busca nas aulas | `src/lib/dr` |
| Conteúdo da oferta | Nome, produtos, links, aulas, textos do 7D, prompt | `src/oferta` |
| Banco | Supabase (Postgres + login + arquivos) | `supabase/migrations` |
| Tarefas automáticas | Classificação de hora em hora e reativação do 7D | `supabase/agendamentos.sql` |
| Hospedagem | Cloudflare Workers (como no Lovable) ou Vercel | `vite.config.ts` |

## Telas
- `/` apresentação → `/auth` login → `/chat` o chat → `/admin` painel (só administradoras).
- **Login só com o e-mail da compra.** O servidor confere a lista `authorized_users` (ativo e não vencido),
  cria a conta se não existir e já entra, sem senha e sem e-mail de confirmação. Neste aparelho, a pessoa
  continua logada.
- App instalável no celular (PWA) com notificações.

## O caminho de uma mensagem (ordem de decisão, igual ao MGA)

Cada mensagem passa por estas etapas, nesta ordem. A primeira que "pegar" responde, e as seguintes não rodam.

| # | Situação | O que acontece | Usa IA? |
|---|---|---|---|
| 0 | Pessoa sem nenhum produto ativo | Recusa ("seu acesso não está ativo") — **trava nova** | Não |
| 1 | Reclamação de acesso à área de membros | Só cria alerta no painel (não muda a resposta) | Não |
| 2 | Atendimento humano assumiu a conversa | Grava a mensagem e o bot fica calado | Não |
| 3 | Botão "Comunidade" | Link da comunidade do produto da pessoa | Não |
| 4 | Pediu humano e já teve o cartão liberado antes | Reenvia o cartão do atendimento humano | Não |
| 5 | Ameaça jurídica (Procon, processo, advogado...) | Texto oficial fixo, sem emoji | Não |
| 6 | "Já mandei o pedido e ninguém respondeu" | Texto fixo de prazo (3 dias úteis) | Não |
| 7 | Depois de aceitar o 7D (WhatsApp) | Reenvia o link se pedir; agradece a listinha uma vez | Não |
| 8 | **Reembolso, cancelamento, golpe ou risco de vida** | **Protocolo 7D: máquina de estados com textos fixos** | **Não** |
| 9 | Atalho de execução (no MGA: Payt sem conta/afiliação) | Passos fixos com botões | Não |
| 10 | Todo o resto | **IA**, com o prompt montado + trechos das aulas + respostas oficiais | **Sim** |

Depois da IA (etapa 10), ainda no servidor:
- só vira cartão de aula o que a IA citou E estava entre os trechos encontrados;
- links oficiais viram botões; link restrito a produto some para quem não tem;
- cartão de atendimento humano só nos casos oficiais;
- a **trava de saída** (`guardRefundOutput`) confere o texto e troca qualquer texto de reembolso fora de hora;
- grava a resposta, o custo, a memória da pessoa e os alertas.

## O Protocolo 7D (retenção de reembolso), em resumo
- **Entrada:** acolhimento (N002) + rota classificada pelo motivo ou a pergunta "o que te fez chegar nesse ponto?" (N004).
- **17 rotas** (1 a 12 e D1 a D5), cada uma com mensagens fixas e botões: aceitar → proposta; recusar → insistência.
- **Proposta** (N135–N140): acompanhamento de 7 dias, bônus e "me responde só com um sim".
- **Aceite** (clique ou "sim" digitado logo depois da proposta): confirmação (N143), listinha + botão do WhatsApp
  do time, P.S. (N145). Cria alerta "Ativação aceita" no painel e avisa o time por notificação.
- **Insistência:** cada pedido explícito de reembolso conta 1. Na 1ª, 2ª e 3ª, reenquadramentos diferentes.
  Só na **4ª** sai o e-mail de reembolso (N154/N155), ou o encerramento da assinatura (mentoria).
- **Pergunta hipotética** ("e se eu não gostar?", "posso pedir depois?") nunca conta como pedido: vai para a Rota 5
  (garantia + proposta).
- **"Deixa eu ver"**: Rota D3 (escolher horário); repetido → finalização e uma reativação 1 hora depois
  (no chat e por notificação).
- **Risco de vida:** acolhimento + CVV 188, sem curso e sem cartão.
- Estado guardado na própria conversa (`messages.metadata.refund_state`); estado com mais de 24h recomeça.

## A IA
- Uma camada só (`runAI`) para o chat e para o classificador do relatório.
- Provedor: OpenAI ou Gemini, com a chave salva e testada em **Admin › Configurações › IA**
  (criptografada; nenhum navegador lê). Enquanto não houver chave no painel, usa a reserva do `.env`.
- Resposta sempre em JSON: texto, aulas citadas, diagnóstico interno, memória, comunidade, etc.
- Histórico: últimas 20 mensagens da conversa.

## Busca nas aulas
- Tabela `course_chunks`: um registro por trecho de aula (id `V1.M01.A01-01`), com produto, vitrine,
  módulo, aula, título, conteúdo e palavras-chave. O link da aula fica no trecho `-01`.
- Busca por **palavra** (com tolerância a erro e sinônimos), pontuando título, palavras-chave, tópico e conteúdo.
  Pergunta sobre um módulo inteiro traz 1 trecho por aula. Mesmo comportamento do MGA.
- Planejado no MGA e ainda não feito (fica para depois das aulas novas): busca por sentido (pgvector),
  "porteiro" que separa modo AULA/GERAL e prompt em blocos editáveis no admin
  (ver `MGA - bot/4-relatorio-agente-ia-rag.md` e `6-prompts-lovable-implementacao.md`).

## Painel admin (17 abas)
Relatórios · Visão geral · Usuários · Conversas · Conversas agrupadas · Alertas · Acessos (dificuldade de
acesso) · Vendas (perguntas de preço/compra, criado na MSI) · Ativação (7D) · Analytics · Custos · Acessos (sessões e aparelhos) · Materiais · Catálogo ·
Webhooks · Notificações · Base · Configurações › IA.
Inclui: assumir conversa (atendimento humano), fila da Ativação ("Aceitaram" e "Possíveis retenções"),
importação de alunos por planilha (Hubla, Cademí ou simples), mapeamento de produtos dos webhooks,
envio de notificação para grupos de alunos e exportação de conversas.

## Integrações
- **Hubla, Payt, Cademí, Kiwify** → `POST /api/public/webhooks/<plataforma>` liberam/revogam acesso.
  Cada evento é gravado uma vez só (`webhook_events`). Sem a senha configurada, a plataforma fica desligada.
- **Relatórios 08h/17h** → rotinas externas leem `GET /api/relatorio/dados` e publicam em
  `POST /api/relatorio/publicar` (grava e manda o resumo pelo WhatsApp Cloud API).
- **Notificações** (Web Push) → inscrição pelo app, envio pelo servidor.

## Tabelas do banco (31)
Pessoas e acesso: `profiles`, `user_roles`, `authorized_users`, `user_products`, `product_access_grants`,
`access_sessions`, `audit_logs`.
Conversas: `conversations`, `messages`, `student_memory`, `student_memory_facts`.
Alertas e relatórios: `risk_alerts`, `access_alerts`, `sales_alerts` (MSI), `retention_actions`, `conversation_insights`,
`daily_reports`, `job_tokens`.
Conhecimento: `course_chunks`, `knowledge_documents`, `knowledge_chunks`, `support_materials`,
`material_requests`, `tool_links`, `assistant_config`.
IA e uso: `ai_settings`, `ai_usage_log`, `usage_events`.
Notificações e webhooks: `push_subscriptions`, `push_broadcasts`, `webhook_events`, `webhook_product_names`.
Arquivos: pastas privadas `knowledge` (documentos) e `uploads` (prints enviados no chat).
