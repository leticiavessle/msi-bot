# Como publicar fora do Lovable (Supabase + Cloudflare) · MSI

O caminho é o mesmo planejado para externalizar o MGA (`MGA - bot/7-externalizacao-jornada.md`), só que mais
simples: a nova oferta começa com **banco novo e vazio** (não há alunos nem senhas para migrar).

Legenda: **[você]** precisa da sua conta/clique · **[eu]** eu faço aqui · **[juntos]** eu preparo e você confirma.

## 1. Banco (Supabase) — [você] + [eu] · ✅ FEITO em 09/10/2026
> Projeto **msi-bot** (ref `ateqpkgbptywwbfonjyv`, São Paulo, organização Hydra Markers) com as 4 migrações e a base de
> aulas (519 trechos / 117 aulas); "Allow new users to sign up" desligado; administradora `acessos@hydramarkers.com`
> cadastrada. Falta só o passo 4 (Site URL), quando houver o endereço do bot.

1. [você] Criar um projeto novo no Supabase com o nome **msi-bot** (região South America · São Paulo). Para testar, o plano gratuito serve;
   para produção, o Pro (US$ 25/mês).
2. [eu] Rodar, nesta ordem, `supabase/migrations/20261004000000_estrutura_inicial.sql`,
   `supabase/migrations/20261004010000_alerta_de_venda.sql`, `supabase/migrations/20261009000000_lastlink.sql` e
   `supabase/migrations/20261009010000_identificacao.sql` (SQL Editor › colar › Run). Cria as tabelas, regras de
   segurança, funções do painel, as 2 pastas de arquivos, o alerta de venda, a origem LastLink e a entrada no bot
   por e-mail › CPF › nome › WhatsApp (MSI).
3. [você] Em **Authentication › Sign In / Providers**:
   - Email: ligado. **"Allow new users to sign up": DESLIGADO.** O login do app cria a conta pelo servidor,
     então nada quebra; e ninguém consegue criar conta direto pela API (no MGA o cadastro estava aberto).
   - Google: desligado (o app não tem botão do Google).
4. [você] Em **Authentication › URL Configuration**: Site URL = o endereço final do app.
5. [você] Copiar de **Project Settings › API**: URL, publishable key e service role key → `.env`.

## 2. Chaves e segredos — [juntos]
Copie `.env.example` para `.env` e preencha. Para gerar os segredos:
- `AI_SETTINGS_ENC_KEY` e `REPORT_API_TOKEN`: `openssl rand -hex 32` (um para cada).
- Notificações: `npx web-push generate-vapid-keys` → pública em `VITE_VAPID_PUBLIC_KEY`, privada em `VAPID_PRIVATE_KEY`.
- Webhooks: crie uma senha para cada plataforma e use a mesma no painel da plataforma.

## 3. Testar no seu computador — [eu]
```bash
npm install
npm run check
npm run dev
```
- Abre em http://localhost:8080.
- Primeira administradora (SQL Editor do Supabase):
  `insert into authorized_users (email, name, role) values ('seu@email.com', 'Seu nome', 'admin');`
  Depois é só entrar com esse e-mail.
- Em **Admin › Configurações › IA**: escolher OpenAI ou Gemini, colar a chave, escolher os modelos e
  **Testar conexão**. (Ou preencher `AI_PROVIDER`, `AI_API_KEY` e `AI_MODEL_CHAT` no `.env` para testar antes.)

## 4. Publicar na Cloudflare (mesma hospedagem que o Lovable usava) — [juntos]
1. [você] Ter uma conta Cloudflare (a mesma do DNS do domínio é o ideal). Workers Paid: US$ 5/mês.
2. [eu] Compilar (as variáveis `VITE_*` do `.env` entram no build):
   ```bash
   npm run build
   ```
3. [você] Entrar na Cloudflare pelo terminal (abre o navegador para você autorizar):
   ```bash
   npx wrangler login
   ```
4. [juntos] Cadastrar cada segredo do servidor (você cola o valor quando pedir), um comando por variável:
   ```bash
   npx wrangler secret put SUPABASE_SERVICE_ROLE_KEY --config dist/server/wrangler.json
   ```
   Repetir para: `SUPABASE_URL`, `SUPABASE_PUBLISHABLE_KEY`, `AI_SETTINGS_ENC_KEY`, `VAPID_PRIVATE_KEY`,
   `VAPID_SUBJECT`, `REPORT_API_TOKEN`, `WHATSAPP_TOKEN`, `WHATSAPP_PHONE_NUMBER_ID`, `REPORT_WHATSAPP_TO`
   e os `WEBHOOK_SECRET_*` que for usar.
5. [eu] Publicar:
   ```bash
   npm run deploy
   ```
6. [você] Na Cloudflare: **Workers › msi-bot › Settings › Domains & Routes** → adicionar o domínio
   (ex.: `suporte.suaoferta.com.br`).

**Alternativa Vercel:** `NITRO_PRESET=vercel npm run build` e `npx vercel deploy --prebuilt`, com as
variáveis no painel da Vercel (Pro: US$ 20/mês).

## 5. Depois de publicado — [juntos]
1. Tarefas automáticas: rodar `supabase/agendamentos.sql` no SQL Editor, trocando `SEU-DOMINIO`.
2. Webhooks (MSI: Hubla, Payt e, se for usar, LastLink): cadastrar `https://SEU-DOMINIO/api/public/webhooks/hubla`,
   `.../payt` e `.../lastlink` com a senha (Hubla: cabeçalho `x-hubla-token`; Payt e LastLink: `?token=<senha>` no fim
   do endereço). LastLink: em cada produto › Integrações › Webhook da Lastlink › Novo webhook, marcar Compra Completa,
   Pagamento Reembolsado, Pagamento Estornado e (se tiver assinatura) Assinatura Cancelada/Expirada.
3. Relatórios 08h/17h: criar as duas rotinas com o prompt de `docs/06-rotina-relatorios.md` (já adaptado para a MSI),
   trocando `SEU-DOMINIO`; o modelo `relatorio_msi` precisa estar aprovado no WhatsApp Manager.
4. Base de aulas: rodar `base-aulas/importar-course_chunks.sql` no SQL Editor (519 partes, 117 aulas; pode rodar de
   novo sempre que a base for gerada outra vez com `scripts/gerar_base.py`).

## 6. Teste final antes de liberar para alunos
- Login com e-mail autorizado; e-mail não autorizado pede o CPF › nome › WhatsApp (entrar por cada um, com uma compra
  de teste que tenha CPF e telefone); nenhum dado certo → aviso na aba Acessos › Entrada no bot.
- Painel: trocar o e-mail de uma aluna de teste e entrar com o novo (a conversa antiga tem que aparecer).
- Pergunta de aula → resposta com cartão da aula certa.
- "quero reembolso" → acolhimento + rota do 7D (nunca o e-mail de cara); 4 pedidos explícitos → e-mail.
- "e se eu não gostar?" → Rota 5 (garantia + proposta).
- Botão "Comunidade" → link do produto certo.
- Print enviado no chat → resposta.
- Painel: assumir conversa, devolver ao bot, alertas, fila da Ativação, custos.
- Webhook de teste de cada plataforma → acesso liberado no painel.
- Notificação de teste (Admin › Notificações) chegando no celular.
