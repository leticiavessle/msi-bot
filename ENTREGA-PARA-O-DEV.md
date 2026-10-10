# Entrega para o dev: bot de suporte da MSI (09/10/2026)

Bot de suporte do **Método Sócia Invisível** (Gabriela Soares). Feito a partir do bot do MGA (Lovable), agora fora do
Lovable: TanStack Start + React + Supabase, compilado para Cloudflare Workers. Tudo em português.
**O código está pronto e testado; falta publicar.**

## 1. Ler primeiro (nesta ordem)
1. Este arquivo.
2. `CLAUDE.md`: onde fica cada coisa, comandos e as regras que não podem quebrar (com o porquê de cada uma).
3. `docs/04-publicar-fora-do-lovable.md`: o passo a passo da publicação.
4. `COMECE-AQUI.md` (seção "Onde paramos" e seção 9, pendências) e `docs/01-mapa-do-sistema.md`.

## 2. O que já está pronto
- **Código:** `npm install` e depois `npm run check` (tipos + 249 testes + build), tudo verde em 09/10.
- **Banco (Supabase):** projeto **msi-bot**, ref `ateqpkgbptywwbfonjyv`, região São Paulo, organização Hydra Markers.
  As 4 migrações de `supabase/migrations/` e a base de aulas (`base-aulas/importar-course_chunks.sql`) já rodaram e
  foram conferidas: 34 tabelas, todas com RLS; 519 trechos / 117 aulas; pastas `knowledge` e `uploads`.
  "Allow new users to sign up" está **desligado** (o login cria a conta pelo servidor). Administradora do painel:
  `acessos@hydramarkers.com`. ⚠️ O projeto `jornada-hydra`, na mesma organização, é o bot do MGA: não mexer.
- **Conteúdo da MSI:** marca, produtos, aulas, links, prompt revisado pela dona do produto, Protocolo 7D, gênero,
  alerta de venda, entrada por e-mail › CPF › nome › WhatsApp (`docs/plano-identificacao-e-membrium.md`).

## 3. O que falta para publicar (detalhe em `docs/04`)
1. **`.env`:** copiar `.env.example` para `.env` e preencher. URL e chaves do Supabase em Project Settings › API.
   Gerar `AI_SETTINGS_ENC_KEY` e `REPORT_API_TOKEN` com `openssl rand -hex 32`; chaves de push com
   `npx web-push generate-vapid-keys`; uma senha por plataforma de venda (`WEBHOOK_SECRET_HUBLA`, `_PAYT`, `_LASTLINK`).
2. **Testar localmente:** `npm run dev` (porta 8080), entrar com `acessos@hydramarkers.com`, Admin › Configurações › IA:
   escolher OpenAI ou Gemini, colar a chave e testar a conexão.
3. **Cloudflare:** Workers Paid; `npm run build`, `npx wrangler login`, `npx wrangler secret put ...` para cada segredo
   do servidor (lista em `docs/04`, passo 4.4), `npm run deploy` e ligar o domínio.
4. **Supabase:** Authentication › URL Configuration › Site URL = o endereço final.
5. **Depois de publicado:** `supabase/agendamentos.sql` (trocar `SEU-DOMINIO`); webhooks da Hubla, Payt e LastLink
   (`https://SEU-DOMINIO/api/public/webhooks/<hubla|payt|lastlink>`; Hubla com cabeçalho `x-hubla-token`, Payt e
   LastLink com `?token=`) e uma compra de teste com CPF e telefone, para conferir que chegam; relatórios 08h/17h com
   `docs/06-rotina-relatorios.md` e o modelo `relatorio_msi` aprovado no WhatsApp Manager.
6. **Importar quem comprou antes do bot:** painel › Usuários › Importar CSV, com as planilhas exportadas **na hora**
   da Hubla, LastLink e Payt. As colunas já são reconhecidas (conferido com as planilhas reais em 09/10).
7. **Teste final:** lista em `docs/04`, seção 6.

## 4. Acessos que o dev precisa receber (por convite, não por senha)
- Supabase: membro da organização Hydra Markers.
- Cloudflare: membro da conta (e o DNS do domínio, se estiver lá).
- Hubla, Payt e LastLink: para cadastrar os webhooks.
- WhatsApp Manager: para o modelo `relatorio_msi` e o token dos relatórios.
- Chave da IA (OpenAI ou Gemini): colada no painel do bot, nunca no código.

## 5. Segurança e dados de alunas
- **Segredos nunca vão para o Drive nem para o código.** O `.env` não existe na pasta entregue; cada pessoa cria o seu.
  Senhas e chaves vão por um canal seguro (gerenciador de senhas).
- **Planilhas de vendas têm dados pessoais** (nome, CPF, e-mail, telefone): não ficam nesta pasta nem no Drive do
  projeto; exportar na hora de importar e apagar depois.
- O painel mostra o CPF completo para a equipe (decisão da dona do produto); a aluna nunca vê.

## 6. Regras que não podem quebrar (resumo; o porquê está no `CLAUDE.md`)
- A IA nunca escreve sobre reembolso: o Protocolo 7D é decidido no servidor; o e-mail de reembolso só sai na 4ª insistência.
- Só produtos da MSI liberam o bot: as contas da Hubla, Payt e LastLink vendem produtos de outros experts
  (`DA_OFERTA_RE` em `src/oferta/produtos.ts`). Um nome de produto novo da MSI precisa casar com essa regra.
- Hubla manda nas revogações (reembolso lá bloqueia reativação por outra plataforma).
- Quem entrou pelo nome ou WhatsApp não recebe link de acesso direto (dupla checagem).
- Depois de mexer em `src/oferta/` ou em `src/lib/dr/`: `npm run check`.

## 7. Pendências que não impedem publicar
Na seção 9 do `COMECE-AQUI.md`: fichas de aula que faltam, link exato de cada aula, comunidade da Mentoria, aulas dos
outros produtos, logo oficial e Parte 2 (Membrium, aguardando o suporte da Membrium).

## 8. O que fica fora desta pasta (não é necessário)
- `MGA - bot/` e `Nova Oferta - bot/` (citadas nos documentos): referências históricas do bot do MGA e o modelo de
  onde esta pasta saiu. Nada nelas é necessário para publicar; o roteiro dos relatórios já foi trazido para `docs/06`.
- `node_modules/` e `dist/` não vão na entrega: são recriados com `npm install` e `npm run build`.
