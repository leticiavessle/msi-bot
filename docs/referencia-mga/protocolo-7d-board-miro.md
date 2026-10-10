<!-- Cópia de referência do projeto Jornada Hydra - ATIVO (Lovable), arquivo src/lib/dr/hydra-rules.ts, baixado em 04/10/2026. Não é usado pelo app novo. -->

# Protocolo 7D · Fluxo de Retenção de Reembolso (board Miro)

Fonte: board Miro "Retenção de Reembolso MGA" (https://miro.com/app/board/uXjVHt-xMdk=/), frame único "Retenção de Reembolso MGA". Extraído do SVG canvas-composer em 2026-09-19.

Contagem: 488 itens no board = 1 frame + 232 elementos de conteúdo + 255 conectores. Os 232 elementos são 144 caixas arredondadas, 14 stickies e 74 textos (textArea). Dos 74 textos, 66 são **rótulos** encadeados entre caixas (ex.: "Mensagem:", "⬇️ Seguido de:", "Passo 2A · ...") e 8 são títulos/cabeçalhos sem conector. Os conectores **não têm rótulo próprio** no board: o papel de rótulo é feito por esses textos intermediários (cada um tem exatamente 1 entrada e 1 saída) e pelas caixas-botão verdes/vermelhas/laranja com a resposta da aluna. Neste documento os rótulos foram dobrados nas setas ("rótulo: «...»") e **não** recebem número próprio. Resultado: **157 nós numerados (N001–N157)** + 9 itens soltos. Todos os 255 conectores apontam para elementos existentes; não há conector duplicado.

Legenda de cores (inferida do board, sem legenda explícita nele): `#c6dcff` azul = situação das 12 rotas da Ramificação Esquerda; `#f8d3af` laranja = situação das rotas D1–D5 (Ramificação Direita) e respostas "meio-termo"; `#ffffff` = cabeçalho "ROTA ..."; `#e7e7e7` cinza = script para a aluna nas rotas; `#dedaff` lilás = scripts do bloco Ativação Hydra; `#fff4d6` = planos dia a dia (referência); `#e3f7ea` = scripts do endpoint verde; `#fde8e7` = scripts do endpoint vermelho; `#adf0c7` verde = resposta positiva da aluna; `#ffc6c6` rosa = resposta de reembolso / entrada / endpoint vermelho; sticky amarelo = orientação ao atendente; sticky vermelho = alerta/regra dura; sticky verde = complemento.

Texto verbatim: os blocos ```text``` reproduzem o texto do board exatamente (asteriscos `*assim*` são o negrito de WhatsApp, não markdown). Parágrafos vazios do Miro viram linhas em branco.

## 1. Visão geral

- **Entrada (N001–N004):** aluna pede reembolso ou sinaliza desistência → 3 mensagens fixas: acolhimento, pedido de dados (nome, e-mail, CPF) e a pergunta diagnóstica ("o que te fez chegar nesse ponto?").
- **Classificação (N005, sticky "🤖 IA classifica"):** 17 saídas: 12 rotas da Ramificação Esquerda (Rotas 1–12, objeções) + 5 da Ramificação Direita (D1 golpe, D2 upsell, D3 enrolou, D4 sumiu, D5 desabafo emocional). Aluna decidida ou com aperto financeiro real → Rota 3.
- **Cada rota:** 1 a 5 mensagens-script de quebra de objeção terminando numa pergunta ("Posso te fazer uma proposta?") com botões de resposta: positivo → **Ativação Hydra**; "Prefiro seguir com o reembolso" → **Endpoint Vermelho**. Desvios: Rota 2 "É o dinheiro que saiu" → Rota 3; Rota 10 "E quanto tempo eu tenho pra decidir?" → Rota 5; D5 "Sinal de risco" → **Escalação**.
- **Ativação Hydra (N133–N147):** bloco central de convergência = o acompanhamento de 7 dias (Protocolo Diagnóstico 7D). Diagnóstico obrigatório (listinha de 6 perguntas) → oferta com exclusividade → lista dos 7 dias → bônus → CTA de compromisso ("me responde só com um *sim*"). SIM → **Endpoint Verde** (confirmação + Dia 1 + P.S.); "Deixa eu ver" → Rota D3; reembolso → Endpoint Vermelho. Material de referência pendurado no bloco: planos dia a dia (pago / orgânico), versão sem verba e "linha do prazo" (garantia de 90 dias).
- **Saídas finais:** Endpoint Verde (ativação iniciada), Endpoint Vermelho (direcionamento para e-mail suporte@maquinahydra.com.br com assunto "Reembolso", sem nova retenção) e Escalação para humano (lista de casos fora do roteiro).

## 2. Fluxo completo (nós na ordem lógica)

Ordem: busca em profundidade a partir de N001; as saídas do classificador seguem a ordem visual do board (esquerda → direita: Rotas 1–12, depois D1–D5); os três pontos de convergência (Ativação Hydra, Endpoint Vermelho, Escalação) aparecem depois de todas as rotas. "entra de" lista todos os nós que apontam para o nó.

### Entrada

**N001** · situação / gatilho de entrada (cor #ffc6c6) · miro `032495` · x=1500, y=2585

```text
Situação: Aluno pede reembolso ou sinaliza que quer desistir
```
- → (rótulo: «Mensagem 1 (acolhimento, uma frase):») vá para N002

**N002** · mensagem-script para a aluna (cor #e7e7e7) · miro `032498` · x=1500, y=3065 · entra de: N001

Rótulo acima do nó no board: «Mensagem 1 (acolhimento, uma frase):»

```text
[nome], recebi aqui e eu vou te ouvir até o fim, sem enrolação e sem te empurrar nada 🙏
```
- → (rótulo: «Mensagem 2 (dados, sempre em tópicos e negrito):») vá para N003

**N003** · mensagem-script para a aluna (cor #e7e7e7) · miro `032500` · x=1500, y=3434 · entra de: N002

Rótulo acima do nó no board: «Mensagem 2 (dados, sempre em tópicos e negrito):»

```text
Antes de tudo, pra eu localizar seu acesso e te responder com o seu caso na mão, me manda aqui:

• *Nome completo*
• *E-mail* (o mesmo que você usou na compra)
• *CPF*
```
- → (rótulo: «Mensagem 3 (a pergunta que diagnostica):») vá para N004

**N004** · mensagem-script para a aluna (cor #e7e7e7) · miro `032502` · x=1500, y=3968 · entra de: N003

Rótulo acima do nó no board: «Mensagem 3 (a pergunta que diagnostica):»

```text
E me conta uma coisa com sinceridade, que é o que vai definir como eu te ajudo: o que te fez chegar nesse ponto? Foi alguma coisa que travou na prática, foi o tempo, foi o dinheiro, ou foi outra coisa?
```
- → vá para N005

**N005** · observação / instrução interna (sticky light_yellow) · miro `032503` · x=1550, y=4246 · entra de: N004

```text
🤖 IA classifica a resposta em uma das 12 rotas da Ramificação Esquerda. Se o aluno já chegou decidido, ou se o motivo é aperto financeiro real, ir direto para a ROTA 3.
```
- → se classificada como «Situação: Aluno executou (ou acha que executou) e não vê retorno» vá para N006
- → se classificada como «Situação: Arrependimento da decisão de compra» vá para N014
- → se classificada como «Situação: Aperto financeiro real» vá para N022
- → se classificada como «Situação: Falta de tempo na rotina» vá para N029
- → se classificada como «Situação: Preocupação com o prazo da garantia» vá para N038
- → se classificada como «Situação: Insegurança quanto à própria execução» vá para N045
- → se classificada como «Situação: Acredita não ter habilidade técnica» vá para N052
- → se classificada como «Situação: Traumatizado por tentativas anteriores» vá para N060
- → se classificada como «Situação: Aluno experiente, já mexeu com tráfego» vá para N068
- → se classificada como «Situação: Medo de investir tempo e não ter retorno» vá para N077
- → se classificada como «Situação: Expectativa frustrada» vá para N087
- → se classificada como «Situação: Sente que a página de vendas prometeu outra coisa» vá para N095
- → se classificada como «Situação: Aluno acusa a operação de golpe ou fraude» vá para N101
- → se classificada como «Situação: Aluno acha que precisa de outro produto para dar o start» vá para N109
- → se classificada como «Situação: Respondeu algo mole tipo “deixa eu ver” ou “depois eu te falo”» vá para N115
- → se classificada como «Situação: Parou de responder durante a retenção» vá para N121
- → se classificada como «Situação: Aluno relata sobrecarga, cansaço ou sofrimento» vá para N126


### Rota 1

**N006** · situação / gatilho de entrada (cor #c6dcff) · miro `032505` · x=3900, y=4485 · entra de: N005

```text
Situação: Aluno executou (ou acha que executou) e não vê retorno
```
- → vá para N007

**N007** · cabeçalho de rota · miro `032506` · x=3900, y=4815 · entra de: N006

```text
ROTA 1 · “Não consigo ter resultados” / “Não estou ganhando dinheiro”
```
- → (rótulo: «Mensagem:») vá para N008

**N008** · mensagem-script para a aluna (cor #e7e7e7) · miro `032508` · x=3900, y=5205 · entra de: N007

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], entendo sua frustração, e não é frase de atendimento: essa sensação de estar patinando, fazendo coisa e não vendo retorno, é das piores que existe. Eu vejo isso nesse chat todo dia.
```
- → (rótulo: «⬇️ Seguido de:») vá para N009

**N009** · mensagem-script para a aluna (cor #e7e7e7) · miro `032510` · x=3900, y=5588 · entra de: N008

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas me conta uma coisa com sinceridade: você já *aplicou* o método, ou até agora você *assistiu* o método?

Eu pergunto porque são coisas completamente diferentes, e nove de cada dez vezes que alguém me diz “não tô tendo resultado”, eu descubro com a pessoa que faltou executar um pedaço específico, não que o método não serve.
```
- → (rótulo: «⬇️ Seguido de:») vá para N010

**N010** · mensagem-script para a aluna (cor #e7e7e7) · miro `032512` · x=3900, y=6066 · entra de: N009

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
A Máquina Hydra não é fórmula mágica, é um sistema: estrutura pronta, páginas e anúncios já validados, e um passo a passo na ordem.


Resultado não vem de consumir conteúdo, [nome], vem de aplicar com direção. E eu consigo achar em pouco tempo onde você travou.


Posso te fazer uma proposta? Uma coisa que eu só abro pra quem tá realmente comprometido em virar o jogo.
```
- → vá para N011

**N011** · observação / instrução interna (sticky light_yellow) · miro `032521` · x=3950, y=6582 · entra de: N010

```text
✋ A pergunta “você aplicou ou você assistiu?” tem que sair com tom de parceria, nunca de cobrança. Se soar como “você não fez sua parte”, ele fecha a conversa e não volta.
```
- → se a aluna responder «👊 Pode fazer a proposta» vá para N012
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N013

**N012** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032522` · x=3950, y=7164 · entra de: N011

```text
👊 Pode fazer a proposta
```
- → vá para N133

**N013** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032523` · x=3950, y=7414 · entra de: N011

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 2

**N014** · situação / gatilho de entrada (cor #c6dcff) · miro `032524` · x=5100, y=4485 · entra de: N005

```text
Situação: Arrependimento da decisão de compra
```
- → vá para N015

**N015** · cabeçalho de rota · miro `032525` · x=5100, y=4815 · entra de: N014

```text
ROTA 2 · “Comprei por impulso” / “Me arrependi da compra”
```
- → (rótulo: «Mensagem:») vá para N016

**N016** · mensagem-script para a aluna (cor #e7e7e7) · miro `032527` · x=5100, y=5205 · entra de: N015

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], obrigado por ser sincero comigo, sério 🙏 Comprar num impulso e no dia seguinte bater aquele aperto de “o que eu fui fazer” é humano, acontece com todo mundo.
```
- → (rótulo: «⬇️ Seguido de:») vá para N017

**N017** · mensagem-script para a aluna (cor #e7e7e7) · miro `032530` · x=5100, y=5615 · entra de: N016

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas deixa eu te perguntar uma coisa, e responde de verdade: o arrependimento é do *dinheiro* que saiu, ou é do *medo* de ter comprado uma coisa que você não vai conseguir usar?
```
- → (rótulo: «⬇️ Seguido de:») vá para N018

**N018** · mensagem-script para a aluna (cor #e7e7e7) · miro `032532` · x=5100, y=5921 · entra de: N017

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Pergunto porque são dois problemas diferentes e com saídas diferentes. Se for medo de não conseguir usar, esse eu resolvo com você, e resolvo rápido, porque é exatamente o que eu faço todo dia aqui.

Quase todo arrependimento que eu vejo nesse chat não é de quem comprou errado, é de quem abriu a área de membros, viu um monte de coisa e pensou “isso não é pra mim”. E não é isso, é só falta de alguém dizendo por onde começar.

Me responde essa e eu te faço uma proposta que eu não abro pra todo mundo.
```
- → vá para N019

**N019** · observação / instrução interna (sticky light_yellow) · miro `032533` · x=5150, y=6582 · entra de: N018

```text
✋ Regra dura: neste script NÃO se fala em reembolso, garantia nem prazo. Ele não pediu o dinheiro de volta, pediu ajuda com um sentimento. Se responder que o problema é o dinheiro que saiu, ir direto para a ROTA 3.
```
- → se a aluna responder «😰 É medo de não conseguir usar» vá para N020
- → se a aluna responder «💸 É o dinheiro que saiu» vá para N021

**N020** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032536` · x=5150, y=7138 · entra de: N019

```text
😰 É medo de não conseguir usar
```
- → vá para N133

**N021** · resposta da aluna (opção de saída; cor #f8d3af) · miro `032537` · x=5150, y=7388 · entra de: N019

```text
💸 É o dinheiro que saiu
```
- → vá para N022


### Rota 3

**N022** · situação / gatilho de entrada (cor #c6dcff) · miro `032538` · x=6300, y=4485 · entra de: N005, N021

```text
Situação: Aperto financeiro real
```
- → vá para N023

**N023** · cabeçalho de rota · miro `032539` · x=6300, y=4815 · entra de: N022

```text
ROTA 3 · “Estou com problemas financeiros” / “Preciso do dinheiro de volta”
```
- → vá para N024

**N024** · observação / instrução interna (sticky red) · miro `032540` · x=6350, y=5042 · entra de: N023

```text
⚠️ Este script é diferente de todos os outros, e de propósito. Aqui não tem quebra de objeção, tem respeito. Quando o dinheiro faz falta de verdade, insistir em acompanhamento é o caminho mais curto pro chargeback, pro Reclame Aqui e pro print circulando. UMA oferta genuína, só se a conversa abrir espaço. Se ele mantiver o pedido, direciona na hora. SEM EMOJI nesta rota inteira.
```
- → (rótulo: «Passo 1 · Acolhe e faz a única pergunta:») vá para N025

**N025** · mensagem-script para a aluna (cor #e7e7e7) · miro `032542` · x=6300, y=5792 · entra de: N024

Rótulo acima do nó no board: «Passo 1 · Acolhe e faz a única pergunta:»

```text
[nome], primeiro de tudo: obrigado por confiar e me contar isso. Aperto financeiro é coisa séria e eu não vou tratar como detalhe.

Deixa eu te perguntar uma coisa só, e é pra eu te ajudar de verdade, não pra te enrolar: o que aperta agora é a *falta desse valor de volta*, ou é a sensação de ter colocado dinheiro numa coisa que ainda não te deu retorno nenhum? Me diz com sinceridade que eu ajo de acordo.
```
- → (rótulo: «Passo 2A · Se for a sensação de não ter retorno (oferta, uma vez só):») vá para N026

**N026** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `032566` · x=6300, y=6410 · entra de: N025

Rótulo acima do nó no board: «Passo 2A · Se for a sensação de não ter retorno (oferta, uma vez só):»

```text
Então deixa eu te propor uma coisa antes de qualquer decisão, e a decisão continua sendo sua do começo ao fim.

Eu quero te colocar no *Protocolo Diagnóstico 7D*: 7 dias comigo do seu lado, com plano dia a dia, e montado no caminho *sem você colocar mais um real* em anúncio. Tem conteúdo lá dentro da área de membros ensinando a levantar uma graninha fazendo uns serviços e umas tarefas com IA, e eu começo o seu plano por aí.

Se depois desses 7 dias você ainda quiser sair, o caminho continua aberto e eu mesmo te direciono, sem drama nenhum. Topa tentar assim antes de decidir?
```
- → se a aluna responder «Topo tentar assim» vá para N027
- → se a aluna responder «Preciso do valor de volta» vá para N028

**N027** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032567` · x=6368, y=7478 · entra de: N026

```text
Topo tentar assim
```
- → vá para N133

**N028** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032568` · x=6368, y=7728 · entra de: N026

```text
Preciso do valor de volta
```
- → vá para N152


### Rota 4

**N029** · situação / gatilho de entrada (cor #c6dcff) · miro `032569` · x=7500, y=4485 · entra de: N005

```text
Situação: Falta de tempo na rotina
```
- → vá para N030

**N030** · cabeçalho de rota · miro `032570` · x=7500, y=4815 · entra de: N029

```text
ROTA 4 · “Não tenho tempo pra fazer” / “Está muito corrido”
```
- → (rótulo: «Mensagem:») vá para N031

**N031** · mensagem-script para a aluna (cor #e7e7e7) · miro `032573` · x=7500, y=5205 · entra de: N030

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], eu entendo, e não é papo: conciliar trabalho, casa, família e ainda aprender uma coisa nova é desafiador de verdade.
```
- → (rótulo: «⬇️ Seguido de:») vá para N032

**N032** · mensagem-script para a aluna (cor #e7e7e7) · miro `032575` · x=7500, y=5494 · entra de: N031

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas me deixa te fazer uma pergunta sincera: o que te trouxe até aqui foi justamente isso, né? A vida corrida, a necessidade de uma renda a mais, de mais liberdade pra escolher seu tempo.

Se o tempo apertado é o problema, ele é também o motivo pra não parar agora.
```
- → (rótulo: «⬇️ Seguido de:») vá para N033

**N033** · mensagem-script para a aluna (cor #e7e7e7) · miro `032577` · x=7500, y=5942 · entra de: N032

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E olha, a Máquina Hydra foi pensada exatamente pra quem tem pouco tempo. Não é sobre virar noite estudando, é sobre usar as janelas que você já tem, de um jeito organizado:

• *30 minutos por dia* já dão pra executar a tarefa do dia
• Estratégias práticas, que cabem na rotina, sem hora marcada e sem aula ao vivo
• Você escolhe *quando* fazer: de manhã, no almoço ou de noite
• A estrutura já vem pronta, então você *ativa*, não constrói do zero
```
- → (rótulo: «⬇️ Seguido de:») vá para N034

**N034** · mensagem-script para a aluna (cor #e7e7e7) · miro `032580` · x=7500, y=6602 · entra de: N033

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E vou ser reto contigo: desistir agora é a única forma de garantir que daqui seis meses você vai estar exatamente no mesmo lugar onde está hoje, [nome].

Posso te fazer uma proposta diferente? Uma coisa que eu normalmente não abro pra todo mundo.
```
- → vá para N035

**N035** · observação / instrução interna (sticky light_green) · miro `032581` · x=7550, y=7015 · entra de: N034

```text
➕ Se ele topar, manda a proposta canônica e emenda com: “E me diz qual horário do dia é o seu (*manhã*, *almoço* ou *noite*), que eu monto o seu plano em cima do seu tempo, não do meu 👊”
```
- → se a aluna responder «👊 Pode fazer a proposta» vá para N036
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N037

**N036** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032582` · x=7550, y=7628 · entra de: N035

```text
👊 Pode fazer a proposta
```
- → vá para N133

**N037** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032583` · x=7550, y=7878 · entra de: N035

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 5

**N038** · situação / gatilho de entrada (cor #c6dcff) · miro `032584` · x=8700, y=4485 · entra de: N005, N085

```text
Situação: Preocupação com o prazo da garantia
```
- → vá para N039

**N039** · cabeçalho de rota · miro `032585` · x=8700, y=4815 · entra de: N038

```text
ROTA 5 · Pergunta sobre prazo de reembolso / “Estou com medo do prazo passar”
```
- → vá para N040

**N040** · observação / instrução interna (sticky red) · miro `032586` · x=8750, y=5110 · entra de: N039

```text
⚠️ Só responder isso se ele perguntar direto. Prazo e garantia são assunto que o suporte NUNCA puxa por iniciativa própria. Perguntado, a resposta é curta, honesta, e volta na hora pra solução. Nunca prometer estender prazo, criar prazo novo ou citar número diferente de 90 dias.
```
- → (rótulo: «Mensagem:») vá para N041

**N041** · mensagem-script para a aluna (cor #e7e7e7) · miro `032597` · x=8700, y=5905 · entra de: N040

Rótulo acima do nó no board: «Mensagem:»

```text
Respondendo direto, porque você merece clareza: a garantia da sua compra é de *90 dias*, [nome]. Então relaxa, você não tá com o relógio na cabeça e não vai perder prazo nenhum por me dar uma semana.
```
- → (rótulo: «⬇️ Seguido de:») vá para N042

**N042** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `032599` · x=8700, y=6188 · entra de: N041

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E é justamente por isso que eu quero te propor o seguinte: em vez de você decidir agora, com medo de perder data, decide *depois de ver funcionando*.

Me dá 7 dias, eu monto sua estrutura com você e você olha o negócio rodando na sua tela. Aí você escolhe com informação, não com pressa. Se no fim você ainda quiser sair, o caminho continua aberto e eu mesmo te direciono.

Combinado assim? Posso te montar esses 7 dias?
```
- → se a aluna responder «✅ Combinado, pode montar» vá para N043
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N044

**N043** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032600` · x=8750, y=6700 · entra de: N042

```text
✅ Combinado, pode montar
```
- → vá para N133

**N044** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032601` · x=8750, y=6950 · entra de: N042

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 6

**N045** · situação / gatilho de entrada (cor #c6dcff) · miro `032602` · x=9900, y=4485 · entra de: N005

```text
Situação: Insegurança quanto à própria execução
```
- → vá para N046

**N046** · cabeçalho de rota · miro `032603` · x=9900, y=4815 · entra de: N045

```text
ROTA 6 · “Não tenho certeza se vou conseguir aplicar o método”
```
- → (rótulo: «Mensagem:») vá para N047

**N047** · mensagem-script para a aluna (cor #e7e7e7) · miro `032605` · x=9900, y=5192 · entra de: N046

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], essa dúvida é a mais honesta que aparece aqui, e eu vou te dizer uma coisa que talvez te alivie: você *não precisa* de certeza pra começar. Ninguém tem certeza antes, a certeza vem depois do primeiro passo dar certo.
```
- → (rótulo: «⬇️ Seguido de:») vá para N048

**N048** · mensagem-script para a aluna (cor #e7e7e7) · miro `032607` · x=9900, y=5599 · entra de: N047

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Me conta só uma coisa: qual é o pedaço que você olha e pensa “esse aí eu não vou conseguir”? É a parte técnica, é escrever, é aparecer, é o dinheiro do anúncio?

Me diz qual é que eu te mostro o tamanho real dele, porque quase sempre o monstro na cabeça é maior que o passo na tela.
```
- → (rótulo: «⬇️ Seguido de:») vá para N049

**N049** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `032609` · x=9900, y=6000 · entra de: N048

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E é assim que eu trabalho: eu não te entrego o método inteiro na mão e digo “boa sorte”. Eu te mando *uma tarefa por dia*, você faz, me manda o print e eu confiro. Se estiver errado, eu corrijo antes de você seguir.

Você não tem como se perder sozinho, porque você não vai estar sozinho.

Posso te fazer uma proposta? É pra exatamente esse tipo de caso que eu abro ela.
```
- → se a aluna responder «👊 Pode fazer a proposta» vá para N050
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N051

**N050** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032610` · x=9950, y=6489 · entra de: N049

```text
👊 Pode fazer a proposta
```
- → vá para N133

**N051** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032611` · x=9950, y=6739 · entra de: N049

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 7

**N052** · situação / gatilho de entrada (cor #c6dcff) · miro `032612` · x=11100, y=4485 · entra de: N005

```text
Situação: Acredita não ter habilidade técnica
```
- → vá para N053

**N053** · cabeçalho de rota · miro `032613` · x=11100, y=4815 · entra de: N052

```text
ROTA 7 · “Eu não sei fazer nada” / “Não tenho habilidade”
```
- → (rótulo: «Mensagem:») vá para N054

**N054** · mensagem-script para a aluna (cor #e7e7e7) · miro `032615` · x=11100, y=5205 · entra de: N053

Rótulo acima do nó no board: «Mensagem:»

```text
Pode tirar isso da cabeça agora, [nome], sério 💛 Eu faço esse caminho toda semana com gente que nunca tinha criado nem uma conta de rede social, e não é bicho de sete cabeças.
```
- → (rótulo: «⬇️ Seguido de:») vá para N055

**N055** · mensagem-script para a aluna (cor #e7e7e7) · miro `032628` · x=11100, y=5574 · entra de: N054

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E deixa eu te tirar um peso: o método não te pede pra *criar*, te pede pra *ativar*. As páginas, os anúncios e a copy já vêm prontos e validados da casa.

Você não precisa escrever, não precisa desenhar nada e *não precisa aparecer* nem mostrar o rosto em momento nenhum. Dá pra trabalhar sem ninguém saber que é você.
```
- → (rótulo: «⬇️ Seguido de:») vá para N056

**N056** · mensagem-script para a aluna (cor #e7e7e7) · miro `032630` · x=11100, y=6047 · entra de: N055

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
A única habilidade que esse negócio exige é essa: seguir instrução e mandar print. Eu te falo o que abrir, você abre. Eu te falo onde clicar, você clica. Apareceu uma tela estranha ou deu erro? Você me manda o print e eu te digo o que fazer.
```
- → (rótulo: «⬇️ Seguido de:») vá para N057

**N057** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `032632` · x=11100, y=6435 · entra de: N056

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Me responde uma coisa: você consegue me dar 30 minutinhos por dia e mandar um print?

Se consegue, você tem habilidade suficiente, e eu te provo isso em 7 dias. Posso te fazer a proposta?
```
- → se a aluna responder «👊 Consigo, pode fazer a proposta» vá para N058
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N059

**N058** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032633` · x=11150, y=6814 · entra de: N057

```text
👊 Consigo, pode fazer a proposta
```
- → vá para N133

**N059** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032634` · x=11150, y=7064 · entra de: N057

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 8

**N060** · situação / gatilho de entrada (cor #c6dcff) · miro `032635` · x=12300, y=4485 · entra de: N005

```text
Situação: Traumatizado por tentativas anteriores
```
- → vá para N061

**N061** · cabeçalho de rota · miro `032636` · x=12300, y=4815 · entra de: N060

```text
ROTA 8 · “Já tentei outras coisas antes e não funcionou”
```
- → (rótulo: «Mensagem:») vá para N062

**N062** · mensagem-script para a aluna (cor #e7e7e7) · miro `032638` · x=12300, y=5205 · entra de: N061

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], eu te entendo, e não vou fingir que essa é fácil de ouvir. Quem já tentou e não deu certo não tá com preguiça, tá se protegendo de mais uma decepção. Faz todo sentido.
```
- → (rótulo: «⬇️ Seguido de:») vá para N063

**N063** · mensagem-script para a aluna (cor #e7e7e7) · miro `032640` · x=12300, y=5514 · entra de: N062

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas me conta com detalhe: o que você tentou antes, e em que ponto exatamente você parou?

Eu pergunto porque essa resposta muda tudo. Na maioria das vezes que eu escuto essa história aqui, não faltou capacidade da pessoa e nem esforço. Faltaram três coisas: estrutura pronta pra usar, uma ordem clara do que fazer primeiro, e alguém do lado no dia em que travou.
```
- → (rótulo: «⬇️ Seguido de:») vá para N064

**N064** · mensagem-script para a aluna (cor #e7e7e7) · miro `032642` · x=12300, y=5994 · entra de: N063

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Essas três, olha, são exatamente as três que eu coloco na sua mão agora. A estrutura já existe e é validada, a ordem eu monto pro seu caso, e o alguém do lado sou eu.

Me diz onde você parou nas outras tentativas, que eu te mostro por que aqui o ponto de parada é diferente. E posso te fazer uma proposta pra isso.
```
- → vá para N065

**N065** · observação / instrução interna (sticky light_yellow) · miro `032643` · x=12350, y=6389 · entra de: N064

```text
✋ Não fale mal do que ele comprou antes. Quem depreciou a escolha anterior dele já disse, sem querer, que ele escolhe mal. Ataque o ponto de falha (falta de estrutura, ordem e acompanhamento), nunca o produto ou a pessoa.
```
- → se a aluna responder «👊 Pode fazer a proposta» vá para N066
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N067

**N066** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032644` · x=12350, y=7135 · entra de: N065

```text
👊 Pode fazer a proposta
```
- → vá para N133

**N067** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032646` · x=12350, y=7385 · entra de: N065

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 9

**N068** · situação / gatilho de entrada (cor #c6dcff) · miro `032647` · x=13500, y=4485 · entra de: N005

```text
Situação: Aluno experiente, já mexeu com tráfego
```
- → vá para N069

**N069** · cabeçalho de rota · miro `032648` · x=13500, y=4815 · entra de: N068

```text
ROTA 9 · “Já conheço tráfego pago” / “Já comprei outros cursos assim”
```
- → (rótulo: «Mensagem:») vá para N070

**N070** · mensagem-script para a aluna (cor #e7e7e7) · miro `032677` · x=13500, y=5192 · entra de: N069

Rótulo acima do nó no board: «Mensagem:»

```text
Então você tá com meio caminho andado, [nome], e eu falo isso sem puxar seu saco 🔥 Quem já mexeu com tráfego já passou pela parte que trava a maioria: gerenciador, pixel, conta, aquele medo inicial de subir campanha. Isso você já tem.
```
- → (rótulo: «⬇️ Seguido de:») vá para N071

**N071** · mensagem-script para a aluna (cor #e7e7e7) · miro `032679` · x=13500, y=5531 · entra de: N070

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas me conta: quando não deu certo antes, o que você tava anunciando?

Porque essa é a pergunta que costuma explicar tudo. Muita gente que sabe rodar tráfego perde dinheiro anunciando *oferta que nunca foi validada*, e aí não é a campanha que falha, é o que tem do outro lado do clique.
```
- → (rótulo: «⬇️ Seguido de:») vá para N072

**N072** · mensagem-script para a aluna (cor #e7e7e7) · miro `032681` · x=13500, y=6035 · entra de: N071

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Aqui a diferença tá exatamente aí: você não vai testar uma oferta sua no escuro. Você anuncia as estruturas da casa, que já são validadas e já vendem, as mesmas que o Jeo roda na operação dele. Você entra na parte que você já sabe fazer, com a parte que faltava resolvida.
```
- → (rótulo: «⬇️ Seguido de:») vá para N073

**N073** · mensagem-script para a aluna (cor #e7e7e7) · miro `032683` · x=13500, y=6399 · entra de: N072

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E olha, com o que você já sabe, o meu trabalho com você é outro: em vez de te ensinar o básico, eu vou direto pra leitura dos seus números e pro ajuste de criativo.

Posso te fazer uma proposta nesse nível?
```
- → vá para N074

**N074** · observação / instrução interna (sticky light_yellow) · miro `032684` · x=13550, y=6761 · entra de: N073

```text
✋ Adaptar a proposta para este perfil: trocar o Dia 1 de “destravar acesso” por “conferir a afiliação e a estrutura”, e concentrar os dias em criativo, campanha e leitura de dados. Aluno experiente que recebe plano de iniciante desiste na primeira mensagem.
```
- → se a aluna responder «🔥 Pode fazer, nesse nível» vá para N075
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N076

**N075** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032685` · x=13550, y=7539 · entra de: N074

```text
🔥 Pode fazer, nesse nível
```
- → vá para N133

**N076** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `032686` · x=13550, y=7789 · entra de: N074

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 10

**N077** · situação / gatilho de entrada (cor #c6dcff) · miro `032687` · x=14700, y=4485 · entra de: N005

```text
Situação: Medo de investir tempo e não ter retorno
```
- → vá para N078

**N078** · cabeçalho de rota · miro `032688` · x=14700, y=4815 · entra de: N077

```text
ROTA 10 · “E se eu não tiver resultados?”
```
- → (rótulo: «Mensagem:») vá para N079

**N079** · mensagem-script para a aluna (cor #e7e7e7) · miro `032691` · x=14700, y=5171 · entra de: N078

Rótulo acima do nó no board: «Mensagem:»

```text
Vou te responder essa com a verdade, [nome], mesmo que a verdade venda menos: o seu processo e resultado depende inteiramente de você.
```
- → (rótulo: «⬇️ Seguido de:») vá para N080

**N080** · mensagem-script para a aluna (cor #e7e7e7) · miro `032693` · x=14700, y=5513 · entra de: N079

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
O que eu posso te garantir é o *caminho*: a estrutura já pronta e validada, o passo a passo na ordem certa, e eu do seu lado nos 7 dias, corrigindo antes de você errar. Eu garanto o que tá na minha mão, e o que tá na minha mão é isso.
```
- → (rótulo: «⬇️ Seguido de:») vá para N081

**N081** · mensagem-script para a aluna (cor #e7e7e7) · miro `032695` · x=14700, y=6009 · entra de: N080

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E deixa eu te mostrar o outro lado da sua pergunta. Se em 7 dias comigo o resultado não aparecer, você não volta pro zero: você volta sabendo *exatamente* onde tá o gargalo, com sua estrutura no ar e sabendo ler seus próprios números.

Isso é uma posição completamente diferente de onde você tá agora, que é sem saber nem onde travou.
```
- → (rótulo: «⬇️ Seguido de:») vá para N082

**N082** · mensagem-script para a aluna (cor #e7e7e7) · miro `032732` · x=14700, y=6389 · entra de: N081

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
A pergunta que eu te devolvo é essa: você prefere decidir isso agora, no escuro, ou decidir daqui a 7 dias, olhando o seu negócio rodando na sua tela?

Posso montar esses 7 dias pra você?
```
- → vá para N083

**N083** · observação / instrução interna (sticky light_yellow) · miro `032733` · x=14750, y=6649 · entra de: N082

```text
✋ Se ele perguntar direto sobre garantia depois dessa, responder curto e honesto (90 dias, conforme a oferta) e voltar na hora pra solução. Não puxe o assunto você.
```
- → se a aluna responder «✅ Pode montar» vá para N084
- → se a aluna responder «⏳ E quanto tempo eu tenho pra decidir?» vá para N085
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N086

**N084** · resposta da aluna (opção de saída; cor #adf0c7) · miro `032734` · x=14750, y=7542 · entra de: N083

```text
✅ Pode montar
```
- → vá para N133

**N085** · resposta da aluna (opção de saída; cor #f8d3af) · miro `032735` · x=14750, y=7792 · entra de: N083

```text
⏳ E quanto tempo eu tenho pra decidir?
```
- → vá para N038

**N086** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144681` · x=14750, y=8042 · entra de: N083

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 11

**N087** · situação / gatilho de entrada (cor #c6dcff) · miro `144682` · x=15900, y=4485 · entra de: N005

```text
Situação: Expectativa frustrada
```
- → vá para N088

**N088** · cabeçalho de rota · miro `144683` · x=15900, y=4815 · entra de: N087

```text
ROTA 11 · “Não era isso que eu esperava” / “Achei que ia ser diferente”
```
- → (rótulo: «Mensagem:») vá para N089

**N089** · mensagem-script para a aluna (cor #e7e7e7) · miro `144685` · x=15900, y=5205 · entra de: N088

Rótulo acima do nó no board: «Mensagem:»

```text
[nome], entendo essa frustração de quando a expectativa não bate com o que a pessoa encontra, e obrigado por me falar na cara em vez de simplesmente sumir 🙏
```
- → (rótulo: «⬇️ Seguido de:») vá para N090

**N090** · mensagem-script para a aluna (cor #e7e7e7) · miro `144687` · x=15900, y=5574 · entra de: N089

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Mas me conta: o que exatamente você esperava encontrar?

Pergunto porque quase sempre a distância entre o que a pessoa imaginou e o que ela achou não é o produto, é a *ordem das coisas*. Quem entra e cai direto numa aula técnica sente que veio pro lugar errado. Quem entra com alguém dizendo “hoje você faz só isso” sente uma coisa completamente diferente.
```
- → (rótulo: «⬇️ Seguido de:») vá para N091

**N091** · mensagem-script para a aluna (cor #e7e7e7) · miro `144689` · x=15900, y=6066 · entra de: N090

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E vou ser transparente contigo sobre o que a Máquina Hydra é e o que ela não é. Ela não te engana.


Ela é um sistema: as páginas, os anúncios e a copy já vêm prontos e validados, e o seu trabalho é ativar e colocar no ar. É trabalho? É. É complicado? Não é, e é aí que eu entro.
```
- → (rótulo: «⬇️ Seguido de:») vá para N092

**N092** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `144691` · x=15900, y=6526 · entra de: N091

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
Me diz o que você esperava, que eu te falo com sinceridade se isso tá aqui dentro ou não. Se não estiver, eu te falo, sem te enrolar. E se estiver, eu te mostro onde.

Posso te fazer uma proposta exclusiva pra isso?
```
- → se a aluna responder «👊 Pode fazer a proposta» vá para N093
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N094

**N093** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144693` · x=15950, y=6899 · entra de: N092

```text
👊 Pode fazer a proposta
```
- → vá para N133

**N094** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144694` · x=15950, y=7149 · entra de: N092

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota 12

**N095** · situação / gatilho de entrada (cor #c6dcff) · miro `144695` · x=17100, y=4485 · entra de: N005

```text
Situação: Sente que a página de vendas prometeu outra coisa
```
- → vá para N096

**N096** · cabeçalho de rota · miro `144696` · x=17100, y=4815 · entra de: N095

```text
ROTA 12 · “Não foi isso que eu vi na VSL”
```
- → (rótulo: «Mensagem:») vá para N097

**N097** · mensagem-script para a aluna (cor #e7e7e7) · miro `144700` · x=17100, y=5192 · entra de: N096

Rótulo acima do nó no board: «Mensagem:»

```text
Te ouvi, e essa merece resposta reta. Me conta qual foi a parte que você entendeu de um jeito e encontrou de outro, com as suas palavras mesmo. Eu quero saber de verdade.
```
- → (rótulo: «⬇️ Seguido de:») vá para N098

**N098** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `144702` · x=17100, y=5508 · entra de: N097

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E enquanto eu resolvo isso com você, te proponho o seguinte: em vez de ficar com essa dúvida martelando na cabeça, me deixa te mostrar o negócio rodando.

Eu monto sua estrutura com você e você vê com o próprio olho o que tem aqui dentro. Aí você decide com informação, não com impressão.

Posso te montar esses 7 dias?
```
- → se a aluna responder «✅ Pode montar» vá para N099
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N100

**N099** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144703` · x=17150, y=6025 · entra de: N098

```text
✅ Pode montar
```
- → vá para N133

**N100** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144720` · x=17150, y=6275 · entra de: N098

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152


### Rota D1 (Ramificação Direita)

**N101** · situação / gatilho de entrada (cor #f8d3af) · miro `144722` · x=18900, y=4485 · entra de: N005

```text
Situação: Aluno acusa a operação de golpe ou fraude
```
- → vá para N102

**N102** · cabeçalho de rota · miro `144723` · x=18900, y=4815 · entra de: N101

```text
ROTA D1 · “Isso é golpe” / acusação
```
- → vá para N103

**N103** · observação / instrução interna (sticky red) · miro `144724` · x=18950, y=5055 · entra de: N102

```text
⚠️ Acusação não se rebate com quebra de objeção, se desarma com concretude. Pessoa ouvida e resolvida não printa conversa; pessoa pressionada, sim. Nunca se defenda com “nunca prometemos nada” nem devolva a acusação. SEM EMOJI nesta rota.
```
- → (rótulo: «Mensagem (valida a emoção, não a acusação):») vá para N104

**N104** · mensagem-script para a aluna (cor #e7e7e7) · miro `144726` · x=18900, y=5905 · entra de: N103

Rótulo acima do nó no board: «Mensagem (valida a emoção, não a acusação):»

```text
Entendo sua desconfiança, [nome]. Dinheiro é coisa séria e você tem todo direito de questionar.
```
- → (rótulo: «⬇️ Seguido de (o concreto):») vá para N105

**N105** · mensagem-script para a aluna (cor #e7e7e7) · miro `144728` · x=18900, y=6200 · entra de: N104

Rótulo acima do nó no board: «⬇️ Seguido de (o concreto):»

```text
Deixa eu te mostrar o que é fato, sem discurso: o seu acesso está ativo aqui, com a estrutura da casa dentro dele, e o seu histórico do que você já abriu está registrado.

E tem mais uma coisa concreta: você está falando comigo neste momento, e eu vou te responder até o fim.
```
- → (rótulo: «⬇️ Seguido de (a virada):») vá para N106

**N106** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `144730` · x=18900, y=6652 · entra de: N105

Rótulo acima do nó no board: «⬇️ Seguido de (a virada):»

```text
Quero fazer uma coisa por você agora: te colocar na *Ativação Hydra*, comigo do seu lado pelos próximos 7 dias, pra você ver o método funcionando na prática, comigo junto.

Se depois disso você ainda achar que não é pra você, o caminho continua aberto e eu mesmo te direciono.
```
- → se a aluna responder «Aceito a Ativação Hydra» vá para N107
- → se a aluna responder «Quero o dinheiro de volta» vá para N108

**N107** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144731` · x=18950, y=7078 · entra de: N106

```text
Aceito a Ativação Hydra
```
- → vá para N133

**N108** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144732` · x=18950, y=7328 · entra de: N106

```text
Quero o dinheiro de volta
```
- → vá para N152


### Rota D2 (Ramificação Direita)

**N109** · situação / gatilho de entrada (cor #f8d3af) · miro `144733` · x=20100, y=4485 · entra de: N005

```text
Situação: Aluno acha que precisa de outro produto para dar o start
```
- → vá para N110

**N110** · cabeçalho de rota · miro `144734` · x=20100, y=4815 · entra de: N109

```text
ROTA D2 · “Preciso comprar o upsell pra começar?”
```
- → (rótulo: «Mensagem:») vá para N111

**N111** · mensagem-script para a aluna (cor #e7e7e7) · miro `144736` · x=20100, y=5205 · entra de: N110

Rótulo acima do nó no board: «Mensagem:»

```text
Não precisa, [nome], pode ficar tranquilo 👊 Com a Máquina Hydra que você já tem, você já começa numa boa. Nada do que aparece depois é obrigatório pra dar o start.
```
- → (rótulo: «⬇️ Seguido de:») vá para N112

**N112** · mensagem-script para a aluna (cor #e7e7e7) · miro `144738` · x=20100, y=5532 · entra de: N111

Rótulo acima do nó no board: «⬇️ Seguido de:»

```text
E não é que o resto seja ruim, é que é passo pra depois. A Evolution, por exemplo, é um acelerador: ela encurta o caminho com tudo o que o Jeo disponibiliza lá dentro, pra quando você quiser ir mais rápido e mais longe lá na frente. No seu tempo, sem pressa nenhuma.

Agora o que importa é você começar com o que já tá na sua mão. Posso te montar esse começo?
```
- → vá para N113

**N113** · observação / instrução interna (sticky light_yellow) · miro `144739` · x=20150, y=5859 · entra de: N112

```text
✋ Não liberar upsell pago de graça, não puxar reembolso e não empurrar oferta para quem está sem verba. Aqui o trabalho é tirar o peso e colocar a pessoa para começar com o que já tem.
```
- → se a aluna responder «👊 Pode montar» vá para N114

**N114** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144751` · x=20150, y=6642 · entra de: N113

```text
👊 Pode montar
```
- → vá para N133


### Rota D3 (Ramificação Direita)

**N115** · situação / gatilho de entrada (cor #f8d3af) · miro `144752` · x=21300, y=4485 · entra de: N005, N146

```text
Situação: Respondeu algo mole tipo “deixa eu ver” ou “depois eu te falo”
```
- → vá para N116

**N116** · cabeçalho de rota · miro `144753` · x=21300, y=4815 · entra de: N115

```text
ROTA D3 · Enrolou ou não fechou o compromisso
```
- → (rótulo: «Mensagem (CTA secundário):») vá para N117

**N117** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `144755` · x=21300, y=5150 · entra de: N116

Rótulo acima do nó no board: «Mensagem (CTA secundário):»

```text
Tranquilo, [nome], sem compromisso nenhum ainda 💛

Então faz assim comigo: me responde só qual horário do dia é o seu (*de manhã*, *no almoço* ou *de noite*) que eu já monto o seu Dia 1 em cima do seu tempo e te mando.

Você olha, e se fizer sentido eu sigo contigo. Se não fizer, eu paro na hora e fico por aqui do mesmo jeito.
```
- → se a aluna responder «🌅 Manhã» vá para N118
- → se a aluna responder «☀️ Almoço» vá para N119
- → se a aluna responder «🌙 Noite» vá para N120

**N118** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144756` · x=21350, y=5561 · entra de: N117

```text
🌅 Manhã
```
- → vá para N133

**N119** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144757` · x=21350, y=5811 · entra de: N117

```text
☀️ Almoço
```
- → vá para N133

**N120** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144758` · x=21350, y=6061 · entra de: N117

```text
🌙 Noite
```
- → vá para N133


### Rota D4 (Ramificação Direita)

**N121** · situação / gatilho de entrada (cor #f8d3af) · miro `144759` · x=22500, y=4485 · entra de: N005

```text
Situação: Parou de responder durante a retenção
```
- → vá para N122

**N122** · cabeçalho de rota · miro `144760` · x=22500, y=4815 · entra de: N121

```text
ROTA D4 · Sumiu no meio da conversa
```
- → vá para N123

**N123** · observação / instrução interna (sticky red) · miro `144761` · x=22550, y=5064 · entra de: N122

```text
⚠️ Uma vez só, sem cobrança. Mesmo atendimento, mesma conversa aberta.
```
- → (rótulo: «Mensagem (reforço):») vá para N124

**N124** · mensagem-script para a aluna (cor #e7e7e7) · miro `144763` · x=22500, y=5811 · entra de: N123

Rótulo acima do nó no board: «Mensagem (reforço):»

```text
[nome], passei só pra te dizer que seu lugar no 7D continua aqui comigo, e que eu não te dei baixa 🙏

Quando você puder, me manda um *sim* e eu começo seu Dia 1 no mesmo dia. Se preferir esperar um pouco, também tá tudo bem, eu fico por aqui.
```
- → se a aluna responder «✅ Sim, bora» vá para N125

**N125** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144765` · x=22550, y=6204 · entra de: N124

```text
✅ Sim, bora
```
- → vá para N133


### Rota D5 (Ramificação Direita)

**N126** · situação / gatilho de entrada (cor #f8d3af) · miro `144766` · x=23700, y=4485 · entra de: N005

```text
Situação: Aluno relata sobrecarga, cansaço ou sofrimento
```
- → vá para N127

**N127** · cabeçalho de rota · miro `144767` · x=23700, y=4815 · entra de: N126

```text
ROTA D5 · Desabafo emocional
```
- → vá para N128

**N128** · observação / instrução interna (sticky red) · miro `144768` · x=23750, y=5085 · entra de: N127

```text
⚠️ Acolha de pessoa pra pessoa, sem promessa de dinheiro nem de salvação, e puxe pro mão na massa. Se ele mencionar explicitamente vontade de morrer, sumir ou se machucar, o assunto muda de prioridade: acolha com cuidado real, cite o CVV 188 com delicadeza (gratuito, 24 horas, alguém treinado pra ouvir) e sinalize pra um humano do time. Em risco agudo, para tudo, sem venda e sem próximo passo, só o cuidado.
```
- → (rótulo: «Mensagem (acolhimento):») vá para N129

**N129** · mensagem-script para a aluna (cor #e7e7e7) · miro `144770` · x=23700, y=5838 · entra de: N128

Rótulo acima do nó no board: «Mensagem (acolhimento):»

```text
[nome], obrigado por confiar e me contar isso 💛 Não vou tratar como detalhe e não vou te vir com frase pronta.

Você não precisa dar conta de tudo hoje. Só do próximo passo.
```
- → (rótulo: «⬇️ Seguido de (puxa pro mão na massa, sem promessa):») vá para N130

**N130** · mensagem-script para a aluna + pergunta/decisão (cor #e7e7e7) · miro `144789` · x=23700, y=6227 · entra de: N129

Rótulo acima do nó no board: «⬇️ Seguido de (puxa pro mão na massa, sem promessa):»

```text
Se você topar, eu faço o caminho mais leve possível contigo: um passo por dia, do tamanho que cabe no seu dia, e você só me responde com o print. Nada além disso.


Quer que eu monte assim?
```
- → se a aluna responder «💛 Quero, monta assim» vá para N131
- → se a aluna responder «🆘 Sinal de risco → ESCALAR» vá para N132

**N131** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144790` · x=23750, y=6640 · entra de: N130

```text
💛 Quero, monta assim
```
- → vá para N133

**N132** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144791` · x=23750, y=6890 · entra de: N130

```text
🆘 Sinal de risco → ESCALAR
```
- → vá para N156


### Ativação Hydra · bloco central (inclui Endpoint Verde)

**N133** · instrução interna (bloco de convergência) · miro `144793` · x=9450, y=15070 · entra de: N012, N020, N027, N036, N043, N050, N058, N066, N075, N084, N093, N099, N107, N114, N118, N119, N120, N125, N131

```text
Bloco central de convergência. Todas as rotas de retenção chegam aqui. É o mesmo acompanhamento de 7 dias da casa: na retenção ele é apresentado como *Ativação Hydra*. Não custa nada a mais e já está dentro do que o aluno comprou.
```
- → (rótulo: «⚠️ O diagnóstico é obrigatório ANTES da proposta:») vá para N134
- → (rótulo: «Plano dia a dia · TRÁFEGO PAGO (manda só depois que ele topar, ou se pedir o detalhe)») vá para N148
- → (rótulo: «Plano dia a dia · ORGÂNICO») vá para N149
- → (rótulo: «Se ele não tem verba nenhuma agora») vá para N150
- → (rótulo: «Linha do prazo · usar SÓ se ele já tiver puxado prazo ou garantia antes») vá para N151

**N134** · mensagem-script para a aluna (cor #dedaff) · miro `144795` · x=9650, y=15587 · entra de: N133

Rótulo acima do nó no board: «⚠️ O diagnóstico é obrigatório ANTES da proposta:»

```text
Achei seu cadastro aqui 👊 Agora me responde essa listinha rapidinho, pode ser em uma mensagem só, bem direto:


• Já conseguiu entrar na *área de membros*? Até que aula você foi?
• Já criou sua conta na *Payt* e pegou seu *link de venda do STR, MGV e PMJ*?
• Onde exatamente você travou? (se apareceu erro ou reprovação, me manda o print)
• Você quer ir de *tráfego pago* (Facebook e Instagram) ou de *orgânico* (TikTok)? Tem uma verba, mesmo pequena, pra anúncio agora, ou prefere começar sem investir?
• Quanto tempo por dia você consegue me dar?
• E numa palavra: como você tá se sentindo com isso hoje (animado, perdido, ansioso)?


Responde aí que com isso eu já monto seu plano.
```
- → (rótulo: «Abertura da oferta (a exclusividade entra aqui):») vá para N135

**N135** · mensagem-script para a aluna (cor #dedaff) · miro `144797` · x=9650, y=16280 · entra de: N134

Rótulo acima do nó no board: «Abertura da oferta (a exclusividade entra aqui):»

```text
Olha só o que eu vou fazer especificamente pra você, [nome].

Eu vou te dar *7 dias do meu tempo*, comigo acompanhando de perto e com o pessoal mais experiente daqui junto quando precisar. É o *Protocolo Diagnóstico 7D*, e eu não libero isso pra todo mundo que aparece nesse chat.
```
- → (rótulo: «⬇️ Por que não é pra todo mundo (a justificativa):») vá para N136

**N136** · mensagem-script para a aluna (cor #dedaff) · miro `144799` · x=9650, y=16701 · entra de: N135

Rótulo acima do nó no board: «⬇️ Por que não é pra todo mundo (a justificativa):»

```text
E vou te contar por que eu não faço isso sempre, pra você não achar que é frase de atendimento: porque é intensivo.

É próximo demais, é eu olhando o seu print, o seu número, a sua tela, todo dia. Não tem como eu fazer isso com muita gente ao mesmo tempo sem fazer mal feito, e eu não vou fazer mal feito com você.
```
- → (rótulo: «⬇️ Por que com ele sim (usar o que ele respondeu no diagnóstico):») vá para N137

**N137** · mensagem-script para a aluna (cor #dedaff) · miro `144801` · x=9650, y=17206 · entra de: N136

Rótulo acima do nó no board: «⬇️ Por que com ele sim (usar o que ele respondeu no diagnóstico):»

```text
Mas olhando o que você me contou aqui, [nome], o seu caso não é de desistir e nem de começar tudo de novo. É de *organização*.

Você tá com [o ponto exato onde ele travou, nas palavras dele] e falta alguém colocar isso na ordem certa e caminhar com você. Isso eu faço.
```
- → (rótulo: «⬇️ A lista objetiva dos 7 dias:») vá para N138

**N138** · mensagem-script para a aluna (cor #dedaff) · miro `144803` · x=9650, y=17658 · entra de: N137

Rótulo acima do nó no board: «⬇️ A lista objetiva dos 7 dias:»

```text
Nesses 7 dias, eu e você vamos:


• *Destravar seu acesso e liberar sua afiliação do STR, MGV e PMJ*, com seu link de venda na mão
• *Montar sua estrutura no ar*, no caminho que você escolheu (pago ou orgânico)
• *Ajustar seu criativo comigo*: você me manda quais vai utilizar e se fez a variação
• *Ler seus primeiros números juntos*, traduzido, sem termo difícil
• *Fechar o plano da semana seguinte*, escrito, pra você não acordar no dia 8 perdido


É acompanhamento próximo, sem enrolação, direto no que funciona pra *SUA* realidade. Não é aula nova, não é conteúdo novo, é execução com alguém do lado.
```
- → (rótulo: «⬇️ O que entra (bônus reais do protocolo):») vá para N139

**N139** · mensagem-script para a aluna (cor #dedaff) · miro `144805` · x=9650, y=18299 · entra de: N138

Rótulo acima do nó no board: «⬇️ O que entra (bônus reais do protocolo):»

```text
Pra ficar bem claro o que entra nesses 7 dias:


✅ *O Protocolo Diagnóstico 7D completo*: 7 dias de acompanhamento personalizado comigo, com plano dia a dia montado no seu ponto de partida
🎁 *Bônus 1 · Diagnóstico de entrada.* Antes de qualquer tarefa, eu descubro com você onde você tá travado de verdade
🎁 *Bônus 2 · Revisão das suas escolhas.* Você me manda, eu leio e te devolvo ajustado
🎁 *Bônus 3 · Leitura dos seus números comigo.* No pago, seus primeiros dados de campanha; no orgânico, o desempenho dos seus vídeos. Traduzido, do jeito que dá pra entender
🎁 *Bônus 4 · Curadoria de aula.* Eu te digo qual aula assistir agora e qual pode esperar
🎁 *Bônus 5 · Plano da semana 8.* No dia 7 eu não te solto: eu fecho com você o plano da semana seguinte, escrito


*Quanto custa:* nada. Zero. Já tá dentro do que você comprou.
```
- → (rótulo: «⬇️ CTA principal · o pedido de compromisso:») vá para N140

**N140** · mensagem-script para a aluna + pergunta/decisão (cor #dedaff) · miro `144807` · x=9650, y=19101 · entra de: N139

Rótulo acima do nó no board: «⬇️ CTA principal · o pedido de compromisso:»

```text
Mas eu preciso de um compromisso seu, [nome], e é sério.

Se eu separar esses 7 dias pra você, você se compromete a fazer o que eu te orientar, mesmo nos dias em que a preguiça bater e mesmo quando parecer chato?

Não precisa ser perfeito, não precisa ser rápido. Precisa ser feito.

Me responde só com um *sim* que eu já começo o seu *Dia 1* hoje 🚀
```
- → se a aluna responder «✅ SIM, bora começar o Dia 1» vá para N141
- → se a aluna responder «🤔 Deixa eu ver / depois eu te falo» vá para N146
- → se a aluna responder «❌ Prefiro seguir com o reembolso» vá para N147

**N141** · resposta da aluna (opção de saída; cor #adf0c7) · miro `144833` · x=9950, y=19538 · entra de: N140

```text
✅ SIM, bora começar o Dia 1
```
- → vá para N142

**N142** · situação / gatilho de entrada (cor #adf0c7) · miro `144837` · x=7050, y=20778 · entra de: N141

```text
Quando o aluno responde *sim* ao compromisso:
```
- → (rótulo: «Mensagem de confirmação:») vá para N143

**N143** · mensagem-script para a aluna (cor #e3f7ea) · miro `144839` · x=7050, y=21280 · entra de: N142

Rótulo acima do nó no board: «Mensagem de confirmação:»

```text
É isso, [nome]! 🔥 Anotado aqui: você é meu aluno de 7D a partir de agora, e eu não te solto nesses 7 dias.

Agora presta atenção só nisso: hoje você não precisa dar conta de tudo. Você precisa dar conta do Dia 1.
```
- → (rótulo: «⬇️ Seguido de (o Dia 1 concreto):») vá para N144

**N144** · mensagem-script para a aluna (cor #e3f7ea) · miro `144841` · x=7050, y=21630 · entra de: N143

Rótulo acima do nó no board: «⬇️ Seguido de (o Dia 1 concreto):»

```text
Seu *Dia 1* é esse: [tarefa do Dia 1, montada com o que ele respondeu no diagnóstico].

Faz e me manda o print aqui. Se aparecer qualquer tela estranha no caminho, me manda o print também que eu te digo o que fazer. Não trava sozinho, trava comigo 👊
```
- → (rótulo: «⬇️ P.S. de reforço (manda um pouco depois, sem cara de continuação de venda):») vá para N145

**N145** · mensagem-script para a aluna (cor #e3f7ea) · miro `144843` · x=7050, y=22034 · entra de: N144

Rótulo acima do nó no board: «⬇️ P.S. de reforço (manda um pouco depois, sem cara de continuação de venda):»

```text
Ah, [nome], uma última coisa: você não precisa chegar pronto pra começar. Não precisa saber mexer em nada, não precisa ter tempo sobrando, não precisa entender de anúncio.

Precisa só me responder aqui e fazer uma tarefinha por dia. O resto eu carrego com você 🐉
```
- Saída: nenhuma (fim deste caminho)

**N146** · resposta da aluna (opção de saída; cor #f8d3af) · miro `144834` · x=9950, y=19788 · entra de: N140

```text
🤔 Deixa eu ver / depois eu te falo
```
- → vá para N115

**N147** · resposta da aluna (opção de saída; cor #ffc6c6) · miro `144835` · x=9950, y=20038 · entra de: N140

```text
❌ Prefiro seguir com o reembolso
```
- → vá para N152

**N148** · mensagem-script para a aluna (cor #fff4d6) · miro `144826` · x=11600, y=15661 · entra de: N133

Rótulo acima do nó no board: «Plano dia a dia · TRÁFEGO PAGO (manda só depois que ele topar, ou se pedir o detalhe)»

```text
*Dia 1:* acesso destravado, conta na Payt criada e afiliação do STR, MGV e PMJ liberada, com seu link na mão
*Dia 2:* estrutura de anúncio montada comigo (página, gerenciador, conta de anúncio, pagamento)
*Dia 3:* pixel instalado e testado, que é o que faz o Facebook enxergar sua venda
*Dia 4:* criativo revisado. Você escolhe os criativos que vai começar, faz a variação e me manda
*Dia 5:* campanha no ar, com estrutura, nomenclatura e orçamento certinhos
*Dia 6:* eu leio os primeiros números com você, linha por linha, explicando o que cada um diz
*Dia 7:* ajuste feito e plano da semana seguinte montado
```
- Saída: nenhuma (fim deste caminho)

**N149** · mensagem-script para a aluna (cor #fff4d6) · miro `144828` · x=11600, y=16265 · entra de: N133

Rótulo acima do nó no board: «Plano dia a dia · ORGÂNICO»

```text
*Dia 1:* conta na Payt criada e afiliação do STR, MGV e PMJ liberada, com seu link de venda na mão
*Dia 2:* seu perfil de trabalho criado ou ajustado comigo (foto, @ e bio), separado da sua vida pessoal
*Dia 3:* nicho definido e roteiro do vídeo na fórmula da casa, a DSA (dor, solução, ação)
*Dia 4:* você escreve 3 ganchos e eu reviso um por um com você
*Dia 5:* seu primeiro vídeo publicado. Esse é o dia que muda tudo
*Dia 6:* seu link trabalhando nos lugares certos (comentário fixado, direct, e a bio quando ela abrir pra você)
*Dia 7:* eu leio com você o que aconteceu nos vídeos e monto o plano da sua semana seguinte
```
- Saída: nenhuma (fim deste caminho)

**N150** · mensagem-script para a aluna (cor #fff4d6) · miro `144830` · x=11600, y=16916 · entra de: N133

Rótulo acima do nó no board: «Se ele não tem verba nenhuma agora»

```text
E se hoje não dá pra separar nem um real pra anúncio, tranquilo, não trava nada.

Tem conteúdo lá dentro da área de membros ensinando a levantar uma graninha fazendo uns serviços e umas tarefas com IA, e eu monto seu 7D por esse caminho primeiro.

O plano é montado no seu momento, então pode andar mais rápido ou mais devagar que isso aí de cima. O combinado é um só: *você não fica sozinho nenhum dos 7 dias* 👊
```
- Saída: nenhuma (fim deste caminho)

**N151** · mensagem-script para a aluna (cor #fff4d6) · miro `144832` · x=11600, y=17614 · entra de: N133

Rótulo acima do nó no board: «Linha do prazo · usar SÓ se ele já tiver puxado prazo ou garantia antes»

```text
E fica tranquilo com o prazo: a garantia da sua compra é de *90 dias*, então me dar uma semana não te custa nada.
```
- Saída: nenhuma (fim deste caminho)


### Endpoint Vermelho · Reembolso

**N152** · situação / gatilho de entrada (cor #ffc6c6) · miro `144845` · x=11050, y=20778 · entra de: N013, N028, N037, N044, N051, N059, N067, N076, N086, N094, N100, N108, N147

```text
Quando o aluno mantém o pedido de reembolso:
```
- → vá para N153

**N153** · observação / instrução interna (sticky red) · miro `144860` · x=11350, y=21051 · entra de: N152

```text
⚠️ Depois do “quero mesmo”: NENHUMA nova tentativa de retenção. A conversa vira logística. Nunca condicione o direcionamento a mais perguntas, aulas assistidas ou justificativas. Tom cordial até o fim, SEM EMOJI: a última mensagem é a que vai pro print.
```
- → (rótulo: «Mensagem de direcionamento (script oficial):») vá para N154

**N154** · mensagem-script para a aluna (cor #fde8e7) · miro `144862` · x=11050, y=21938 · entra de: N153

Rótulo acima do nó no board: «Mensagem de direcionamento (script oficial):»

```text
Entendo e respeito sua decisão, [nome]!


Pra formalizar seu pedido de reembolso é assim: envia um e-mail para *suporte@maquinahydra.com.br* com seu pedido, escrevendo no assunto *“Reembolso”*.


O time financeiro processa e te retorna por lá. Siga o fluxo sem sobrecarregar a caixa de e-mail, ou seja, aguarde nossa devolutiva e a responda seguindo corretamente os dias e os pedidos. Novos envios de e-mail solicitando o estorno, prejudica o andamento do fluxo e podendo, inclusive, atrasar o processo!
```
- → (rótulo: «⬇️ Seguido de (fechamento cordial):») vá para N155

**N155** · mensagem-script para a aluna (cor #fde8e7) · miro `144864` · x=11050, y=22521 · entra de: N154

Rótulo acima do nó no board: «⬇️ Seguido de (fechamento cordial):»

```text
Se qualquer coisa travar nesse caminho, volta aqui que eu resolvo com você.

E fica combinado: se um dia quiser voltar, sua vaga é sua. Obrigado pela confiança até aqui.
```
- Saída: nenhuma (fim deste caminho)


### Escalação para humano

**N156** · situação / gatilho de entrada (cor #f8d3af) · miro `144866` · x=13000, y=20778 · entra de: N132

```text
Situação: casos que saem do roteiro
```
- → vá para N157

**N157** · instrução interna ao atendente (lista de escalação) · miro `144867` · x=13000, y=21159 · entra de: N156

```text
• Acesso comprado que realmente não existe no sistema
• Recurso oficial do Meta negado duas vezes
• Suspeita de fraude no pagamento
• Ameaça jurídica explícita
• Menção a risco de vida (citar o CVV 188 com delicadeza e sinalizar para um humano na hora)
• Qualquer caso que não caiba nos roteiros

Encaminhe e diga ao aluno que você encaminhou. Análise de campanha vai para o Fabrício Hochmüller, Gerente de Afiliados.
```
- Saída: nenhuma (fim deste caminho)

## 3. Itens soltos (sem conectores)

Nenhum sticky ou observação ficou solto: todos os 14 stickies estão ligados ao fluxo. Os 9 itens sem conector são títulos e cabeçalhos de seção:

- miro `032493` · forma #c6dcff · x=8050, y=1670

  ```text
  Retenção de Reembolso IA Suporte MGA
  ```
- miro `032494` · texto · x=7800, y=2176

  ```text
  Máquina Hydra de Ganhos Automáticos · Protocolo Diagnóstico 7D
  ```
- miro `032496` · texto · x=1400, y=2352

  ```text
  🟢 PONTO DE PARTIDA
  ```
- miro `032504` · texto · x=8400, y=4122

  ```text
  📋 RAMIFICAÇÃO ESQUERDA · As 12 objeções mais apresentadas
  ```
- miro `144721` · texto · x=19800, y=4122

  ```text
  📋 RAMIFICAÇÃO DIREITA · Objeções durante a retenção
  ```
- miro `144792` · texto · x=8700, y=14748

  ```text
  💎 ATIVAÇÃO HYDRA · Protocolo Diagnóstico 7D
  ```
- miro `144836` · texto · x=6850, y=20530

  ```text
  🟢 ENDPOINT VERDE · Ativação iniciada
  ```
- miro `144844` · texto · x=10850, y=20530

  ```text
  🔴 ENDPOINT VERMELHO · Reembolso
  ```
- miro `144865` · texto · x=12850, y=20530

  ```text
  🆘 ESCALAÇÃO · Casos para um humano do time
  ```

Observação: o cabeçalho "RAMIFICAÇÃO ESQUERDA · As 12 objeções mais apresentadas" fica sobre as Rotas 1–12 (x 3900–18100) e "RAMIFICAÇÃO DIREITA · Objeções durante a retenção" sobre D2–D5 (x 19800–23800). A Rota D1 (x 18900) fica entre os dois cabeçalhos, mas tem a cor laranja e o prefixo "D" da Ramificação Direita.

## 4. Pontos que dependem de humano

O fluxo foi escrito para um atendente que fala em primeira pessoa ("eu", "comigo") e acompanha a aluna por dias. Um bot que não envia mensagem proativa, não acompanha por dias e não consulta sistemas **não consegue cumprir** estes pontos:

1. **Localizar cadastro / conferir acesso (N003, N134, N105).** N003 pede nome, e-mail e CPF "pra eu localizar seu acesso"; N134 abre com "Achei seu cadastro aqui 👊"; N105 (Rota D1) afirma "o seu acesso está ativo aqui ... e o seu histórico do que você já abriu está registrado". Tudo isso exige consulta ao sistema (plataforma de acesso) por pessoa ou integração.
2. **O próprio Protocolo 7D inteiro (N133, N135–N140, N148–N150).** "7 dias do meu tempo, comigo acompanhando de perto e com o pessoal mais experiente daqui junto", "eu olhando o seu print, o seu número, a sua tela, todo dia", plano dia a dia (Dia 1 a Dia 7), revisão de criativos e de ganchos, leitura de números de campanha/vídeos, curadoria de aula, "Plano da semana 8" escrito. Acompanhamento diário por 7 dias = humano.
3. **Conferir prints e corrigir (N049, N056, N130, N134, N144).** "você faz, me manda o print e eu confiro. Se estiver errado, eu corrijo"; "me manda o print e eu te digo o que fazer"; "se apareceu erro ou reprovação, me manda o print".
4. **Montar o plano personalizado (N137, N144, N035, N074, N117, N150).** N144 tem o placeholder "[tarefa do Dia 1, montada com o que ele respondeu no diagnóstico]"; N137 tem "[o ponto exato onde ele travou, nas palavras dele]"; N035 e N117 pedem horário (manhã/almoço/noite) para "montar o seu plano em cima do seu tempo"; N074 manda adaptar o plano para aluno experiente; N150 monta o 7D pelo caminho sem verba (serviços e tarefas com IA).
5. **Mensagens enviadas depois, sem a aluna ter escrito (N145, N124).** N145 é um "P.S. de reforço (manda um pouco depois...)"; N124 (Rota D4, "Sumiu no meio da conversa") é um reforço enviado quando a aluna parou de responder ("Uma vez só, sem cobrança"). Ambos exigem envio proativo/agendado.
6. **Promessas de compromisso contínuo (N143, N130, N117, N124).** "eu não te solto nesses 7 dias", "O resto eu carrego com você", "eu já monto o seu Dia 1 ... e te mando", "eu começo seu Dia 1 no mesmo dia", "você não fica sozinho nenhum dos 7 dias".
7. **"Montar a estrutura com você" / ver o negócio rodando (N042, N098, N106).** Rotas 5, 12 e D1 prometem "eu monto sua estrutura com você" e "7 dias ... pra você ver o método funcionando na prática, comigo junto".
8. **Reembolso (N152–N155).** O bot só direciona: a aluna envia e-mail a *suporte@maquinahydra.com.br* com assunto "Reembolso" e "O time financeiro processa e te retorna por lá". A aprovação/processamento é humano. N155 promete "Se qualquer coisa travar nesse caminho, volta aqui que eu resolvo com você".
9. **Escalação (N132, N156, N157, N128).** Casos para "um humano do time": acesso comprado que não existe no sistema, recurso do Meta negado duas vezes, suspeita de fraude no pagamento, ameaça jurídica explícita, risco de vida (CVV 188 + sinalizar humano na hora), qualquer caso fora dos roteiros. "Análise de campanha vai para o Fabrício Hochmüller, Gerente de Afiliados." O bot precisa de um canal para encaminhar e deve dizer à aluna que encaminhou.
10. **Rota 12 (N098):** "E enquanto eu resolvo isso com você" — promete resolver a divergência com a VSL, sem script de resolução.

Não há menção no board a planilha nem a WhatsApp/contato externo; o único canal externo citado é o e-mail de reembolso.

## 5. Inconsistências e ambiguidades

1. **"12 rotas" vs. 17 saídas.** O sticky N005 diz "uma das 12 rotas da Ramificação Esquerda", mas tem 17 conectores: as 12 rotas + D1–D5. O cabeçalho da direita diz "Objeções durante a retenção", porém D1 (golpe), D2 (upsell), D3, D4 e D5 também saem direto do classificador inicial, antes de qualquer retenção.
2. **Rota 3 sem o "Passo 2B".** N025 pergunta se o que aperta é "a *falta desse valor de volta*" ou "a sensação de ... não te deu retorno". Só existe o conector "Passo 2A · Se for a sensação de não ter retorno" (→ N026). Não há conector para o caso "falta do valor de volta"; pela regra do sticky N024 ("Se ele mantiver o pedido, direciona na hora") o esperado seria ir direto ao Endpoint Vermelho (N152), mas isso não está desenhado.
3. **"SEM EMOJI" vs. bloco central.** Rota 3 (N024: "SEM EMOJI nesta rota inteira") e Rota D1 (N103: "SEM EMOJI nesta rota") convergem para a Ativação Hydra (N133), cujos scripts têm emojis (N134 "👊", N139 "✅ 🎁", N140 "🚀", N143 "🔥", N144 "👊", N145 "🐉"). Não fica claro se a proibição vale também para o bloco comum.
4. **Rota 3 depois do "Topo tentar assim".** N026 já promete o 7D "*sem você colocar mais um real* em anúncio" e com tarefas com IA; o bloco N133 segue com o diagnóstico genérico, que volta a perguntar sobre tráfego pago e verba (N134). Ambíguo se deve pular para a versão "sem verba" (N150).
5. **Laço possível na Rota D3.** N140 (CTA) → botão N146 "🤔 Deixa eu ver / depois eu te falo" → D3 (N115) → horário (Manhã/Almoço/Noite) → volta ao bloco N133, que refaz diagnóstico, oferta e o mesmo CTA; se a aluna responder "deixa eu ver" de novo, cai em D3 outra vez. Não há limite nem saída alternativa.
6. **Rotas sem saída de reembolso ou negativa.** D2 (N113) só tem "👊 Pode montar"; D3 (N117) só tem os três horários; D4 (N124) só tem "✅ Sim, bora" (nada para "continuou sem responder"); D5 só tem "Quero, monta assim" ou "Sinal de risco". Se a aluna pedir reembolso nessas rotas, o board não diz para onde ir (presumivelmente N152, mas não está desenhado).
7. **Rota D4 como "classificação".** "Parou de responder durante a retenção" sai do classificador da primeira resposta (N005), mas por definição não há resposta para classificar; é um evento de tempo, não uma rota de classificação.
8. **Rota 10 → Rota 5.** O botão "⏳ E quanto tempo eu tenho pra decidir?" (N085) aponta para a *Situação* da Rota 5 (N038), passando de novo pelo sticky N040. Coerente, mas note que a Rota 5 é a única que fala de prazo: o sticky N083 manda responder "90 dias, conforme a oferta" e o bloco central tem a "Linha do prazo" (N151), então o prazo aparece em três lugares.
9. **Nós de referência sem saída dentro do bloco central.** Os planos dia a dia (N148 pago, N149 orgânico), a versão sem verba (N150) e a linha do prazo (N151) saem do N133 mas não têm saída nem condição clara de quando entram na conversa, além dos rótulos ("manda só depois que ele topar, ou se pedir o detalhe"; "usar SÓ se ele já tiver puxado prazo ou garantia antes"). O N148 diz "manda só depois que ele topar", mas não há conector a partir do Endpoint Verde.
10. **Escalação só alcançável pela Rota D5.** O bloco de escalação (N156/N157) lista acesso inexistente, recurso do Meta negado, fraude no pagamento e ameaça jurídica, mas o único conector que chega a ele é "🆘 Sinal de risco → ESCALAR" (N132, Rota D5). A Rota D1 (golpe/acusação), onde ameaça jurídica é mais provável, não tem ligação com a escalação.
11. **Rota 12 sem tratamento da resposta.** N097 pede à aluna que conte o que entendeu diferente da VSL, mas o fluxo segue direto para a proposta (N098) sem ramo que responda ao conteúdo da queixa.
12. **Rótulo "Passo 1" sem conector de condição na Rota 3.** O sticky N024 diz "UMA oferta genuína, só se a conversa abrir espaço", mas o conector N025 → N026 é incondicional no desenho (só o rótulo "Passo 2A" indica a condição).
13. **Gênero.** Os scripts e instruções usam o masculino ("aluno", "ele", "Anotado aqui: você é meu aluno de 7D"), enquanto quem vai usar o bot fala em "aluna". Registrado só como observação; o texto acima está verbatim, sem ajuste.


## 6. Alterações feitas no board em 19/09/2026 (pedido da Letícia)

- 12 rotas x 17 saídas: TODAS as 17 saídas ficam no processo (Rotas 1 a 12 + D1 a D5). Foram revisadas pela Letícia e precisam ser usadas.
- D2, D4 e D5: nova saída "Prefiro seguir com o reembolso" → N152 (Endpoint Vermelho).
- D3: nova saída "Prefiro seguir com o reembolso" → N152; nova saída "Continua sem decidir" → mensagem de finalização → reativação 1 hora depois (uma vez só) → "Respondeu com o horário / sim" → N133 | "Prefiro seguir com o reembolso" → N152 | sem resposta: encerrar, sem novas mensagens automáticas.
  - Finalização: "Tranquilo, [nome], sem pressão nenhuma. Vou deixar sua vaga na *Ativação Hydra* separada aqui por enquanto. Quando decidir, é só me mandar um *sim* nessa conversa que eu monto seu Dia 1 na hora 👊"
  - Reativação (1h): "[nome], passando aqui rapidinho: sua vaga na *Ativação Hydra* continua separada 💛 Me responde só com o horário que é melhor pra você (*manhã*, *almoço* ou *noite*) que eu já deixo seu Dia 1 pronto. Se preferir não seguir agora, tudo bem também, é só me falar."
- D1: nova saída "Insiste na acusação de golpe" → mensagem sem emoji: "Entendo, [nome]. Pra que isso seja analisado com a seriedade que merece, peço que você formalize pelo nosso canal oficial: *suporte@maquinahydra.com.br*. Lá o time olha o seu caso junto com o seu cadastro e te responde por escrito." (fim)
- Gênero: sticky no topo. A maioria do público do MGA é homem; scripts podem ficar no masculino, e o bot adapta o gênero pelo nome da pessoa.

Observação técnica para o Lovable: o chat do bot só mostra mensagens quando a pessoa está com ele aberto. A reativação de 1 hora será exibida quando a pessoa voltar ao chat (ou precisa de um canal de envio, como e-mail, para chegar sem ela abrir). Decidir na etapa do Lovable.
