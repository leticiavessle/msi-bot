# Plano: identificar a aluna (e-mail › CPF › nome › WhatsApp) e ler a Membrium

Pedido da dona do produto em 09/10/2026. Duas partes independentes:
**a parte 1 foi construída em 09/10/2026** (resumo logo abaixo); a parte 2 depende da resposta do suporte da Membrium.

## Parte 1 construída (09/10/2026) — o que ficou pronto
- Decisões finais da dona do produto (09/10, revistas no mesmo dia): a) **CPF completo para a equipe** (guardado com
  os 11 números; a aluna nunca vê), b) sim, c) **o e-mail pode ser alterado**: ela passa a entrar com o e-mail novo
  (trocado ou para onde reenviamos o acesso) e a conversa antiga continua, d) **link de acesso direto só no chat**; quem
  entrou pelo nome ou WhatsApp passa por uma "dupla checagem": a aluna é informada e a equipe é sinalizada.
- Banco: `supabase/migrations/20261009010000_identificacao.sql` (testada num Postgres em memória; pode rodar de
  novo sem erro): `cpf`, `telefone`, `emails_anteriores` e as colunas calculadas `nome_busca`/`telefone_busca` em
  `authorized_users`; tabelas `tentativas_entrada` (limite de chutes + por onde entrou, por aparelho) e
  `identificacao_alertas` (aba Acessos › Entrada no bot); `access_alerts.conferir_identidade`/`entrada_via`.
- Regras: `src/lib/dr/identificacao.ts` (CPF com dígito verificador, nome sem acento e sem "de/da/dos", WhatsApp com
  e sem 55 e com e sem o 9, e-mail escondido, qual cadastro vale, limite 6 por aparelho e 20 por rede em 15 min).
- Servidor: `iniciarEntrada` em `src/lib/dr/access.functions.ts` (substituiu `startEmailSession`). Cadastro
  reembolsado, cancelado, bloqueado ou vencido nunca entra por dado de reserva; a mensagem é a mesma em qualquer etapa.
- Tela: `src/routes/auth.tsx`, um campo por vez; textos em `src/oferta/entrada.ts`. "Prefiro não informar o CPF"
  pula para o nome. Ao entrar por reserva (ou por e-mail antigo), mostra `ma•••@gmail.com`. Antes de sair do chat,
  o bot lembra o e-mail de entrada.
- E-mail alterável: painel › ficha da aluna › "Trocar e-mail", aba Acessos › Entrada no bot › "Trocar para o e-mail
  digitado" e aba Acessos › Área de membros › "Reenviado para outro e-mail". Troca o cadastro, a conta (a conversa
  antiga continua) e a ficha; o e-mail antigo vai para `emails_anteriores` e continua valendo para login, webhooks
  (reembolso) e planilha. Se o e-mail novo já tem cadastro, o painel pergunta e junta os dois (produtos somam, o
  histórico das duas contas fica numa só).
- Dupla checagem (decisão d): o chat grava `conferir_identidade` no alerta de acesso e a resposta de "comprei e não
  tenho acesso" ganha a frase `ENTRADA.duplaChecagem`. A Parte 2 usa `ultimaEntrada` (`access.server.ts`) e
  `viaPrecisaConferir` para decidir se o link direto da Membrium pode sair.
- Webhooks Hubla, Payt, LastLink e Cademí leem CPF e telefone (caminhos prováveis; conferir no primeiro payload real
  em `webhook_events`). Planilha: colunas de CPF e WhatsApp reconhecidas pelo nome (Hubla, Payt, LastLink, simples);
  planilha sem coluna de status pergunta se libera acesso ou só completa os dados.
- Testes: `identificacao.test.ts` e `entrada.test.ts`.
- Planilhas reais recebidas (09/10) e conferidas: Hubla ("Documento do cliente", "Telefone do cliente"), Payt
  ("Cliente", "Documento", "Telefone", "Status Compra"), LastLink ("Nome/Razão social do membro", "Documento do membro",
  "Telefone do membro", "Status da venda"). As contas vendem produtos de outros experts: só produtos da MSI liberam
  (`DA_OFERTA_RE`), na planilha e no webhook.

## Respostas já dadas (09/10)
- Não haverá botão de "acesso rápido". O link direto da Membrium só sai quando o bot entender que é problema de
  acesso às aulas, depois de uma pergunta para confirmar.
- Não usam order bump (só produto principal e upsell): Hubla e Payt continuam lendo um produto por aviso.
- O bot precisa saber dos cadastros feitos à mão na Membrium (ex.: bônus liberado manualmente).

---

## Parte 1 — Entrada no bot com dados de reserva

**Antes (até 09/10):** a tela `/auth` pedia só o e-mail; `startEmailSession` conferia `authorized_users` e entrava
direto (sem código no e-mail). Hoje: `iniciarEntrada` (ver "Parte 1 construída" acima).

**Pedido:** se o e-mail não for encontrado, pedir o próximo dado, um de cada vez, só quando o anterior falhar:
1. e-mail → 2. CPF → 3. nome completo usado na compra → 4. WhatsApp (com DDD).

Achou em qualquer passo → entra na conta da compra, sem perguntar os próximos. Nenhum encontrado → mensagem final
e alerta na aba Acessos do painel com tudo o que ela digitou (o time procura e chama).

**O que construir**
- Banco (migração nova): em `authorized_users`, `cpf` (decisão revista: completo, a equipe vê), `telefone` (só dígitos, com 55), `nome_busca` (sem acento, minúsculo,
  espaços normalizados), com índices. Tabela de tentativas para limitar chutes (por aparelho/IP).
- Webhooks Hubla, Payt e LastLink: gravar CPF e telefone que já vêm no aviso de compra (conferir os campos no
  payload real salvo em `webhook_events`; prováveis: Hubla `user.document`/`user.phone`, Payt
  `customer.doc`/`customer.phone`, LastLink `Data.Buyer.Document`/`Data.Buyer.PhoneNumber`).
- Importação por planilha no painel: aceitar colunas de CPF e telefone (para quem comprou antes do bot).
- Servidor: entrada com etapa (`email | cpf | nome | whatsapp`):
  - CPF: só dígitos, confere o dígito verificador, compara o código.
  - Nome: igual sem acento/maiúsculas e só vale se achar **uma** pessoa (homônimo → pede o WhatsApp).
  - WhatsApp: só dígitos; aceita com e sem 55 e com e sem o 9.
- Tela: um campo por vez, com texto curto em cada etapa. Ao entrar por dado de reserva, mostrar o e-mail da compra
  mascarado (`ma•••@gmail.com`) para ela usar da próxima vez.
- Segurança: limite de tentativas (ex.: 5 a cada 15 min por aparelho); nunca mostrar CPF, telefone ou e-mail
  completos; mesma mensagem de "não encontrei" em qualquer etapa.
- Testes (`npm run check`).

**Decisões (recomendação marcada)**
- a) CPF guardado só como código (LGPD), nunca o número. *Recomendado.* → **Revisto em 09/10: CPF completo para a equipe.**
- b) Nome só vale quando encontra uma única pessoa. *Recomendado.*
- c) Mostrar o e-mail da compra mascarado depois de entrar por dado de reserva. *Recomendado.*
- d) Link direto da Membrium dentro do chat só para quem entrou por e-mail ou CPF; quem entrou por nome ou
  WhatsApp recebe o link da própria Membrium no e-mail/WhatsApp cadastrado. *Recomendado* — o link da Membrium
  abre a área de membros sem senha, e nome é fácil de adivinhar.

---

## Parte 2 — Membrium (cadastros manuais e link de acesso direto)

**O que já se sabe (09/10, lendo o sistema da Membrium da MSI)**
- Duas Membrium: MSI `alunos.demandasinvisiveis.com`; Mentoria `alunos.sociasuprema.com`.
- A Membrium recebe as vendas direto da Hubla/Payt/LastLink (um webhook por curso; também "API (n8n)" e combos).
  Ela não avisa o bot.
- Não achei chave de API própria nem aviso de saída: o painel funciona com login de administrador (cookie) e só
  existe o papel "admin".
- Endpoints usados pelo painel (não oficiais, podem mudar): `POST /api/auth/login`,
  `GET /api/students?search=&course_id=`, `GET /api/students/courses`, `GET /api/courses`,
  `POST /api/students/{id}/resend-access`.
- Cada aluna tem um link de acesso direto `https://<área>/quick-access/<token>` (o painel tem "copiar link";
  entra sem e-mail e senha). O cadastro da aluna guarda dados da compra (`extra_data.customer`: CPF, telefone).
- Público, sem login: `POST /api/auth/quick-access/send {email}` faz a Membrium mandar o link para o
  e-mail/WhatsApp da aluna (ligado: MSI e-mail + WhatsApp; Mentoria só e-mail).

**Caminho A (preferido):** o suporte da Membrium libera um acesso oficial (token de API) para buscar a aluna por
e-mail (e CPF/telefone), listar os cursos dela e pegar o link de acesso direto; e/ou um aviso (webhook de saída)
quando um curso é liberado ou retirado.

**Caminho B (se não houver API):** um administrador só para o bot em cada Membrium; e-mail e senha no `.env`
(`MEMBRIUM_MSI_URL`, `MEMBRIUM_MSI_EMAIL`, `MEMBRIUM_MSI_SENHA` e o mesmo com `MEMBRIUM_MENTORIA_`). Riscos: a
conta tem poder total e os endpoints não são oficiais.

**O que construir (depois da resposta da Membrium)**
- `src/lib/dr/membrium.server.ts`: sessão, buscar aluna, cursos e link direto.
- Mapa curso da Membrium → produto do bot em `src/oferta/produtos.ts` (`MAPA_CURSOS_MEMBRIUM`), incluindo os
  bônus liberados à mão. Bônus que não for nenhum dos 5 produtos: decidir se vira produto novo (com aulas na base).
- Ao entrar no bot (e de tempos em tempos): cursos que a Membrium tem e o bot não sabe entram em `user_products`
  com origem `membrium` (novo valor em `access_source`). A Membrium também serve de fonte na parte 1 (aluna
  cadastrada à mão que não está em `authorized_users`).
- Chat: problema de acesso às aulas (caso de acesso em `src/lib/dr/human-cases.ts`) → pergunta de confirmação com
  botões Sim/Não → "Sim" → botão "Entrar na área de membros" com o link direto dela (regra da decisão d).
  Sem link → texto fixo atual + aba Acessos.

**O que a dona do produto vai mandar**
1. A resposta do suporte da Membrium (documentação e onde gerar o token). O token ela cola no `.env`.
2. Se não houver API: criar um administrador só para o bot em cada Membrium e colar e-mail/senha no `.env`.
3. A lista de cursos de cada Membrium (print da tela de cursos) dizendo qual produto ou bônus é cada um.
4. Uma aluna de teste (o próprio e-mail dela) com um bônus liberado à mão.
5. Para a parte 1: só o cabeçalho (nomes das colunas) das planilhas de vendas da Hubla, Payt e LastLink, sem
   dados das alunas.
