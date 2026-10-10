# Comece aqui: bot de suporte da oferta MSI

Este arquivo é o briefing para o chat que vai montar o bot da **MSI**. Ele traz o pedido original,
tudo o que já foi feito e o que falta.

## 1. O pedido original (04/10/2026)

> "Eu preciso que você leia a parte do bot do MGA, do Lovable, que você tem acesso. Eu quero criar exatamente
> a mesma estrutura da Jornada Hydra ATIVO e eu quero que você baixe ele para eu conseguir alterar para a oferta
> que eu preciso. Só que eu vou renovar absolutamente tudo. Eu vou fazer outro system prompt, mas eu quero que
> você me entregue com as restrições que já existem dentro do MGA. Em relação ao número de aulas, descrição e
> todo esse processo, eu ainda vou te passar. O que eu preciso é que você tenha em mente todo o código, todo o
> planejamento, tudo que tem lá dentro, só que ao invés de construir isso dentro do Lovable, eu vou construir
> aqui dentro de você e depois a gente vai fazer um caminho para poder publicar por fora."

Depois: "quero abrir outro chat na pasta MSI - bot, com os documentos que preciso alterar e com todo o último
pedido e orientações. O que acabou de ser feito (Nova Oferta - bot) fica como está, para ser replicável."

## 2. O que já foi feito

1. **Código do Lovable baixado** (projeto "Jornada Hydra - ATIVO") e guardado intocado em
   `/Users/leticiavessle/MGA - bot/codigo-lovable-original`.
2. **Lido por inteiro:** código, os 7 documentos de planejamento em `/Users/leticiavessle/MGA - bot/`
   e a estrutura do banco (só leitura, pelo SQL editor do Lovable Cloud).
3. **Modelo replicável criado** em `/Users/leticiavessle/Nova Oferta - bot`, a mesma estrutura sem Lovable.
   ⚠️ **Não mexer nessa pasta:** ela é o modelo para as próximas ofertas.
4. **Esta pasta (`MSI - bot`) é uma cópia desse modelo**, para virar a oferta MSI. Hoje o conteúdo ainda é o
   do MGA (como exemplo, para tudo funcionar), marcado com "⚠️ PREENCHER".

Já verificado no modelo: compila sem Lovable (Worker da Cloudflare), 121 testes passam, a estrutura do banco
rodou num Postgres de teste e as telas abrem no navegador.

## 3. Documentos que precisam ser alterados para a MSI

Tudo o que muda de oferta fica em `src/oferta/` (guia: `src/oferta/README.md`):

| Arquivo | O que trocar |
|---|---|
| `src/oferta/marca.ts` | Nome do produto/assistente/equipe/expert, avatar, site, garantia, texto de preço, textos das telas |
| `src/oferta/prompt/01-identidade-e-voz.md` | **O system prompt novo** (a pessoa usuária escreve; as restrições entram depois sozinhas) |
| `src/oferta/prompt/03-regras-da-oferta.md` | Primeiros passos, ordem de cadastro, temas delicados, o que cada produto cobre |
| `src/oferta/produtos.ts` | Produtos, nome na compra → produto, comunidade e atendimento humano por produto |
| `src/oferta/links.ts` | E-mail de suporte e links oficiais (o `whatsapp_7d` é obrigatório) |
| `src/oferta/aulas.ts` | Níveis/módulos, nomes, formato do link da aula, primeiras aulas |
| `src/oferta/atalhos.ts` | Botões rápidos, respostas fixas, casos do cartão humano, assunto técnico sem 7D |
| `src/oferta/respostas-oficiais.ts` | Respostas validadas pela equipe (pode começar vazio) |
| `src/oferta/protocolo-7d.ts` | Textos da retenção de reembolso (17 rotas, proposta, aceite, e-mail) |
| `src/oferta/vocabulario.ts` | Intenções e sinônimos da busca |
| `src/oferta/relatorios.ts` | Temas e etapas do funil do relatório, modelo de mensagem do WhatsApp |
| `public/avatar.png`, `public/icons/`, `public/manifest.webmanifest`, `src/styles.css` | Logo, ícones, nome do app no celular, cores |

**Não precisam mudar** (são as restrições herdadas do MGA): `src/oferta/prompt/02-restricoes.md` e
`04-regras-tecnicas.md`, e o motor em `src/lib/dr/`.

Se a quantidade de produtos mudar (hoje: `principal`, `upsell`, `mentoria`), mudar também o tipo
`product_type` em `supabase/migrations/20261004000000_estrutura_inicial.sql` e em
`src/integrations/supabase/types.ts`.

## 4. O que perguntar à pessoa usuária (ainda não foi passado)

1. O que é a MSI: nome completo do produto, nome do assistente, nome curto, nome da equipe e do expert.
2. O system prompt novo (identidade, missão, público, voz, exemplos).
3. Produtos: quantos, nomes, e como cada um aparece na compra (Hubla/Payt/Cademí/Kiwify).
4. Garantia (dias) e o texto oficial de preço (ou manter "essa informação é com o time").
5. Aulas: número de níveis/módulos/aulas, nome e descrição de cada um, link de cada aula, transcrições
   (no modelo dos .docx do MGA, com "Perguntas que esta aula responde" e "O que esta aula NÃO cobre").
6. Primeiras aulas e a sequência de primeiros passos.
7. Links oficiais: plataformas de cadastro, materiais, comunidade por produto, WhatsApp do time,
   formulário do atendimento humano, e-mail de suporte.
8. Textos do Protocolo 7D: novos, ou manter a lógica e adaptar o texto do MGA.
9. Assunto técnico que nunca deve abrir o 7D (no MGA: anúncios/Meta).
10. Temas do relatório e etapas do onboarding.
11. Logo, ícones e cores.

Lista detalhada: `docs/03-o-que-preencher.md`.

## 5. Ordem de trabalho sugerida

1. `npm install` (as dependências não foram copiadas) e `npm run check` para confirmar que está tudo verde.
2. Coletar as respostas da seção 4.
3. Preencher `marca.ts`, `produtos.ts`, `links.ts`, `aulas.ts`, `atalhos.ts`.
4. Colocar o system prompt da pessoa em `prompt/01-identidade-e-voz.md` e as regras da oferta em `prompt/03`.
5. Base de aulas: limpar as transcrições e gerar os trechos (`course_chunks`, ids `V1.M01.A01-01`, link no
   trecho `-01`, produto certo em cada trecho). Exemplo do que foi feito no MGA: `MGA - bot/base-aulas` e
   `MGA - bot/scripts/gerar_base.py`.
6. Textos do 7D em `protocolo-7d.ts`; vocabulário e relatórios.
7. Visual: avatar, ícones, manifesto, cores.
8. `npm run check` depois de cada etapa.
9. Publicar fora do Lovable: `docs/04-publicar-fora-do-lovable.md` (Supabase novo + Cloudflare).

## 6. Regras para este trabalho

- Manter todas as restrições do MGA (`docs/02-restricoes-herdadas.md`). Os testes conferem as principais.
- Não alterar `/Users/leticiavessle/Nova Oferta - bot` (modelo), nem `MGA - bot/codigo-lovable-original`,
  nem nada no Lovable ou no site do MGA em produção.
- Falar com a pessoa usuária em português simples, sem jargão técnico.

## 7. Referências

- `LEIA-ME.md` e `CLAUDE.md` desta pasta (visão geral e notas técnicas).
- `docs/01-mapa-do-sistema.md` (como tudo funciona), `docs/05-achados-no-mga.md` (problemas do MGA já corrigidos aqui).
- `docs/referencia-mga/` (documento de restrições v4 e board do Protocolo 7D, completos).
- `/Users/leticiavessle/MGA - bot/5-system-prompt-v2.md`: modelo de system prompt em blocos, com 12 exemplos de resposta.
- `/Users/leticiavessle/MGA - bot/4-relatorio-agente-ia-rag.md` e `6-prompts-lovable-implementacao.md`:
  melhorias planejadas para depois (busca por sentido, "porteiro" AULA/GERAL).

## 8. Progresso (atualizar a cada etapa)

**04/10/2026**
- `npm install` feito; `npm run check` verde.
- Nomes confirmados e gravados (`marca.ts`, `public/manifest.webmanifest`): Método Sócia Invisível, expert
  Gabriela Soares, assistente "Suporte Método Invisível", nome curto "Trilha MSI", equipe "Equipe Gabi Soares".
  Público: mulheres.
- 5 produtos, todos de pagamento único, vendidos por Hubla + Payt (`produtos.ts`, migração e `types.ts`):
  `principal` (Método Sócia Invisível: front + Vitrine 2 Bônus I + Vitrine 3 Bônus II + comunidade),
  `top_demandas` (aulas), `cofre_pix` (aulas + Telegram), `mentoria` (Mentoria Sócia Suprema: aulas + área de
  membros separada + comunidade da mentoria), `vitalicia` (Sócia Vitalícia: só aula de apresentação).
  Sem produto recorrente. Testes de mapeamento de nomes reescritos para a MSI (120 testes).
- Preço: mantém "essa informação é com o time" + **alerta de venda** novo no painel (aba "Vendas", tabela `sales_alerts`,
  migração `20261004010000_alerta_de_venda.sql`, testada num Postgres em memória). 142 testes.
- Aulas: fichas em `MSI - CLAUDE DOCS/` (Vitrines 1, 2 e 3; 123 .docx com metadados e link por aula).
  Vitrine 4 = Top Demandas; os outros produtos ainda sem número de vitrine. `LESSON_URL_RE` aceita as duas áreas
  de membros (demandasinvisiveis e sociasuprema). Links "Entrar na área de membros" e "da Mentoria" em `links.ts`.
- Base de aulas gerada: `python3 scripts/gerar_base.py "MSI - CLAUDE DOCS" base-aulas` → `base-aulas/chunks.jsonl`
  (117 aulas, 519 trechos, tudo produto `principal`; `lesson` = "código — nome da aula", formato que o cartão usa).
  Fora do bot: "Pontos a validar" (620, listados em `base-aulas/relatorio-base.md`) e as orientações de pedir
  reembolso das aulas V1.M02.A02/A03 (regra herdada: a IA nunca fala de reembolso). Links das fichas são por módulo.
  Ainda não importada em banco (falta o Supabase novo). `PRIMEIRAS_AULAS` proposta: V1.M01.A01, V1.M02.A01, V1.M02.A02.
- Garantia: **Seguro 180D** (180 dias) em `marca.ts` (`garantiaDias`, `nomeGarantia`), na regra da oferta (`prompt/03`)
  e no texto da rota 5 do 7D (antes estava fixo "90 dias" do MGA). Sofia: o bot repete os preços que a aula mostra
  (ferramentas de terceiros são conteúdo de aula; a regra de preço vale para os produtos da Gabriela).
- Links: e-mail `suporte@demandasinvisiveis.com`; WhatsApp do 7D `wa.me/5531988589871` ("Quero começar a Ativação
  Invisível"); `NOME_ATIVACAO = "Ativação Sócia Invisível"` (nome trocado em 08/10); Telegram do Cofre PIX (só para quem tem `cofre_pix`);
  comunidade da Mentoria ainda não existe (todas recebem a comunidade padrão). 143 testes.
- Comunidade: `https://chat.whatsapp.com/G1JEuuigWnu4IDajeilOS0` ("Comunidade do Método Sócia Invisível").
- Atendimento humano (decisão de 04/10): o link humano (WhatsApp 31 98858-9871) só sai na Ativação aceita.
  "Comprei e não tenho acesso" e "cobrança errada" são respondidos pelo servidor com texto fixo, sem link, e vão
  para o painel (aba Acessos / aba Alertas), com a mesma nota do MGA ("Acesso, veio do bot"...).
  Código: `src/lib/dr/human-cases.ts`, `ATENDIMENTO_HUMANO.cartaoNosCasos = false`. Caso "Meta" do MGA removido.
- Expert: o bot chama de **Gabi** (nas gravações aparece "Gabriela Vitorino"; a base troca por "Gabi").
  Nomes antigos nas aulas (Método GV, Mentoria Projetos Remunerados, Estratégia MPI) = Método Sócia Invisível,
  versão mais recente e atualizada (`prompt/03`; o alerta de venda conta como produto principal).
- "Por onde eu começo?": só a Boas-Vindas (V1.M01.A01). 151 testes.

- **Troca completa do MGA pela MSI (pedido de 04/10):** botões rápidos (plataformas, propostas, pesquisas,
  recebimento, comunidade), atalhos de cadastro por plataforma (cartão da aula "Construindo Sua Vitrine Digital"),
  links da Payt/afiliação retirados, respostas oficiais do MGA retiradas (lista vazia), vocabulário e intenções
  da MSI, temas/etapas/motivos do relatório da MSI (`relatorio_msi` como modelo de WhatsApp), regras da oferta
  (`prompt/03`) reescritas, rascunho provisório de identidade (`prompt/01`), "formulário" tirado do `prompt/04`,
  assunto técnico que não abre o 7D = cancelar coisas das plataformas (proposta, projeto, plano da Sofia...),
  nomes gravados no banco sem "hydra" (`ativacao_atendida`, `alunas_ativacao`, `msi-broadcast`), avatar e ícones
  provisórios "MSI" (preto e dourado, como o banner). Textos do 7D reescritos para a MSI por um ajudante (conferir).
  Banco: nenhuma carga do MGA nas migrações; a única base de conteúdo é `base-aulas/chunks.jsonl` (só MSI).

## Onde paramos (09/10/2026) — leia isto primeiro num chat novo
- Conteúdo da MSI completo no bot (marca, produtos, aulas, links, atalhos, 7D do board do Miro, gênero, alerta de
  venda, prompt revisado pela dona do produto). `npm run check` verde (203 testes).
- Base de aulas pronta para o banco: `base-aulas/importar-course_chunks.sql` (testado).
- **Próximo passo combinado: publicar.** A dona do produto vai criar o projeto no Supabase e a conta na Cloudflare,
  dizer qual IA usar (OpenAI ou Gemini) e o endereço do bot. Ela mesma cola chaves e senhas no `.env` (nunca pedir
  para colar segredos no chat). Guia: `docs/04-publicar-fora-do-lovable.md`.
- Botões do chat (09/10): "💼 Onde encontrar demandas" tem resposta pronta (99Freelas › Vinte Pila › Vinte Conto, cadastro
  resumido, botões dos aplicativos, cartões das aulas e aviso do CPF); "✍️ Mensagens que fecham demandas" (antes
  "Como mandar propostas"); "💸 Como eu recebo" vai para a IA com a regra do CPF (`prompt/03`). "👥 Comunidade" é fixo.
- LastLink pronta no código (webhook `/api/public/webhooks/lastlink?token=`), caso vendam por lá.
- Soffia.ai virou botão oficial (09/10).
- **09/10: Parte 1 do `docs/plano-identificacao-e-membrium.md` construída** — entrada no bot por e-mail › CPF › nome
  da compra › WhatsApp, aba Acessos › "Entrada no bot", troca de e-mail no painel e "dupla checagem" para quem entra
  pelo nome ou WhatsApp. CPF completo visível para a equipe; troca de e-mail mantém a conversa (e junta dois
  cadastros, se o e-mail novo já tiver um). Migração nova `20261009010000_identificacao.sql`. `npm run check` verde
  (240 testes).
  Falta conferir: cabeçalho real dos CSVs de vendas (Hubla, Payt, LastLink) e os campos de CPF/telefone no primeiro
  aviso real de cada plataforma. **Parte 2 (Membrium)** continua esperando a resposta do suporte da Membrium.
- Nome do projeto no Supabase: **msi-bot** (São Paulo, organização Hydra Markers; o outro projeto, `jornada-hydra`,
  é do MGA e não se mexe). **09/10: banco montado** pelo SQL Editor (via Chrome): as 4 migrações + base de aulas.
  Conferido: 34 tabelas, todas com RLS; 519 trechos / 117 aulas; pastas `knowledge` e `uploads`; 0 cadastros.
  "Allow new users to sign up" desligado e administradora `acessos@hydramarkers.com` cadastrada (09/10).
- **09/10: a publicação vai para um dev** (projeto no Drive). Guia de entrega: `ENTREGA-PARA-O-DEV.md`.
  Roteiro dos relatórios trazido para `docs/06-rotina-relatorios.md` (antes ficava na pasta do MGA).
- Depois de publicar: webhooks Hubla e Payt + compra de teste, relatórios (modelo `relatorio_msi`), teste real com
  ~30 perguntas de aluna tiradas das aulas.

## 9. Pendências (manter atualizado)

**Com a Gabi / equipe (aguardando)**
- [ ] Fichas que faltam (a equipe vai solicitar): em branco V1.M02.A04, V1.M13.A01, V1.M14.A03, V2.M03.A06,
  V2.M06.A02; V2.M03.A03 "Geometria Visual" (o arquivo é cópia da aula 02); pasta do V1 Módulo 17 vazia;
  V1.M11 aulas 05 e 06 (confirmar se existem). Depois: rodar de novo `scripts/gerar_base.py`.
- [ ] **Link exato de cada aula.** As fichas só têm o link do módulo (`/member/1/4`) e a decisão é que o cartão
  abra a aula exata. O exemplo enviado (`/member/1/1`) é a Boas-Vindas, única aula do Módulo 01, então não mostra
  o formato. Pedir o link de uma aula de módulo com várias aulas (ex.: Módulo 04, Aula 03) e depois a lista.
- [ ] Comunidade da Mentoria Sócia Suprema (ainda vai ser criada) → `COMUNIDADE.porProduto` em `produtos.ts`.
- [ ] Aulas e número de vitrine dos outros produtos: Top Demandas (Vitrine 4), Cofre PIX, Mentoria Sócia
  Suprema (área separada), Sócia Vitalícia.
- [ ] 620 "Pontos a validar" das fichas (em `base-aulas/relatorio-base.md`). O bot funciona sem eles.
- [x] Textos fixos de "comprei e não tenho acesso" e "cobrança errada" aprovados (04/10).
- [x] 09/10: system prompt revisado pela dona do produto (`docs/system-prompt-para-revisar.md`; anotações dela em
  `docs/system-prompt-revisado-pela-gabi-09-10.md`): palavras proibidas na voz, "sou da equipe, mas sou uma IA",
  Soffia.ai no lugar de escrever pela aluna e em perguntas de preço, nomes antigos (Estratégia MPR), retomar depois do
  CVV, "sinalizei o time" só com alerta de venda gravado, mensagem do WhatsApp do 7D explicando o envio e a espera.
- [x] 09/10: "a gente vai" trocado por "vamos" nas 3 condições (bot e board). "trabalho" e "plataformas" do board
  ficam como estão (decisão da dona do produto).
- [x] 09/10: link da Soffia.ai é botão oficial ("Ativar a Soffia.ai (30 dias grátis)", `soffia` em `links.ts`),
  mandado sempre que o bot indica a Soffia. LastLink usa os mesmos nomes de produto da Hubla e da Payt.
- [x] 09/10: entrada por e-mail › CPF › nome › WhatsApp construída (Parte 1 do plano).
- [x] 09/10: planilhas da Hubla, Payt e LastLink recebidas e conferidas (colunas reconhecidas). Simulação sem gravar:
  Hubla 83 pessoas da MSI (235 linhas de outros produtos ignoradas), LastLink 75 (44 "Expirada" = não pago),
  Payt 0 (nenhuma venda paga de produto da MSI; só Plataforma Soffia AI - MSI). Regra nova: só produtos da MSI liberam.
- [x] 09/10: "Plataforma Soffia AI - MSI" não mexe no acesso (nem libera nem tira); quem comprou a MSI na Hubla,
  LastLink ou Payt entra pela compra da MSI. Mentoria Sócia Suprema reconhecida em todas as formas de nome.
- [x] 09/10: na Payt, os produtos da MSI aparecem com os mesmos nomes da Hubla e da LastLink (a planilha recebida
  ainda não tinha venda da MSI). Nome que não casa com `DA_OFERTA_RE` é ignorado.
- [ ] **Membrium (Parte 2 do plano):** cadastros e bônus manuais + link de acesso direto só no chat, com dupla
  checagem para quem entrou pelo nome ou WhatsApp. Aguardando a resposta do suporte da Membrium.
- [x] 09/10: order bump não é usado (só principal e upsell). Hubla e Payt continuam lendo um produto por aviso.

**Comigo (próximas etapas)**
- [x] 08/10: board da retenção lido no Chrome e textos do 7D trocados pelos do board
  (`docs/referencia-msi/board-retencao-msi.md`). Prazo do financeiro: 1 a 3 dias úteis (board).
- [x] 08/10: diferenças em relação ao board aprovadas (régua de 4 recusas, Gabi na 3ª pessoa, divisão do "não tenho
  tempo"). Situações que faltavam no board foram acrescentadas nele (seção abaixo do Quadro 1).
- [ ] Revisar com a Gabi os botões rápidos do chat.
- [x] 08/10: nome "Ativação Sócia Invisível" (também na mensagem pronta do WhatsApp do 7D); voz do bot feminina e tratamento por gênero pelo nome; "quando as
  crianças dormem" mantido (público quase todo com filhos); concordância do N154 corrigida.
- [ ] Logo oficial (hoje: ícone provisório "MSI") e endereço do site.
- [ ] Criar e aprovar o modelo `relatorio_msi` no WhatsApp Manager.
- [ ] Publicar: Supabase novo (4 migrações) + `base-aulas/importar-course_chunks.sql` (pronto e testado) + Cloudflare
  (guia: `docs/04-publicar-fora-do-lovable.md`).

**Ideias para depois (guardadas a pedido da dona do produto)**
- Avisar a equipe pelo WhatsApp na hora em que alguém aceita a Ativação Sócia Invisível (precisa de um modelo de
  mensagem aprovado no WhatsApp Manager; dá para reaproveitar `WHATSAPP_TOKEN`/`WHATSAPP_PHONE_NUMBER_ID` dos
  relatórios). Pedido de 09/10/2026.
