# Base de aulas da MSI — gerada em 2026-10-04

Gerada por `python3 scripts/gerar_base.py "MSI - CLAUDE DOCS" base-aulas` a partir das fichas .docx.

- Aulas na base: **117**
- Trechos: **519**
- Palavras por trecho: mediana 128, mínimo 42, máximo 399 (teto 400)
- Arquivos .docx lidos: 123 (5 vazios e 1 repetido ficaram fora)
- "Pontos a validar" tirados do texto do bot: **620** (lista completa no fim deste relatório)
- Tokens estimados para indexar tudo: ~103.369

## Conferência automática

- OK: ids únicos
- OK: toda aula tem trecho -01
- OK: todo trecho -01 tem o link da aula no texto
- OK: nenhum link fora do trecho -01
- OK: nenhum link com ?preview ou query string
- OK: nenhum 'Pontos a validar' no texto do bot
- OK: nenhuma orientação de pedido de reembolso no texto do bot
- OK: nenhum trecho acima de 400 palavras
- OK: todo trecho tem produto mapeado

## Como importar em `course_chunks`

Cada linha de `chunks.jsonl` traz primeiro as colunas da tabela: `id`, `product`, `level` (vitrine), `module`, `lesson` (código — nome da aula, ex.: `V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona`; o cartão usa o nome depois do " — "), `topic` (seção), `title` (nome da aula), `content`, `status`, `keywords` (grafias_extras), `source_type`, `source_version`. Os outros campos (`section`, `words`, `lesson_link`, `source_file`...) são só para conferência e devem ser ignorados na importação.

- O link da aula aparece só no `content` (e no campo `lesson_link`) do trecho `-01`.
- O texto de cada trecho começa com o endereço (vitrine › módulo › aula › seção), como no MGA.

## Aulas e trechos por vitrine e módulo

| Vitrine | Produto | Módulo | Nome do módulo | Aulas na base | Trechos | Link do módulo | Fora da base |
|---|---|---|---|---|---|---|---|
| 1 | principal | 01 | Primeiro acesso? Clique aqui / Sua primeira vitória | 1 | 5 | /member/1/1 | — |
| 1 | principal | 02 | O Despertar | 3 | 12 | /member/1/2 | A04 vazia |
| 1 | principal | 03 | Rota da Liberdade | 4 | 16 | /member/1/3 | — |
| 1 | principal | 04 | Anatomia das Demandas Lucrativas | 5 | 22 | /member/1/4 | — |
| 1 | principal | 05 | Como Ganhar Mais Trabalhando Menos | 5 | 30 | /member/1/5 | — |
| 1 | principal | 06 | Descobrindo as Habilidades que Você Já Possui | 4 | 25 | /member/1/6 | — |
| 1 | principal | 07 | O Mapa das Demandas Online | 6 | 29 | /member/1/7 | — |
| 1 | principal | 08 | Faturando com Demandas na Prática | 6 | 33 | /member/1/8 | — |
| 1 | principal | 09 | Transformando Opinião em Lucro | 12 | 60 | /member/1/9 | — |
| 1 | principal | 10 | O Universo das Demandas Digitais | 7 | 28 | /member/1/10 | — |
| 1 | principal | 11 | Liberdade Financeira com as Demandas | 5 | 20 | /member/1/11 | sem ficha: A05, A06 |
| 1 | principal | 12 | Desbravando as Demandas | 4 | 16 | /member/1/12 | — |
| 1 | principal | 13 | O Radar Digital das Demandas Lucrativas | 4 | 14 | /member/1/13 | A01 vazia |
| 1 | principal | 14 | Lucrando com a WePink | 2 | 8 | /member/1/14 | A03 vazia |
| 1 | principal | 15 | Performance Magnética | 2 | 9 | /member/1/15 | — |
| 1 | principal | 16 | Habilidades que Vendem | 1 | 4 | /member/1/16 | — |
| 1 | principal | 17 | ESTRATÉGIA INVISÍVEL DOS AVATARES | 0 | 0 | — | pasta sem nenhuma ficha |
| 2 | principal | 01 | Revelando Talentos Invisíveis | 2 | 9 | /member/2/18 | — |
| 2 | principal | 02 | Comunicação Viral: O Código da Persuasão Digital | 7 | 26 | /member/2/19 | — |
| 2 | principal | 03 | Pocket Studio: Hollywood no Seu Bolso | 10 | 40 | /member/2/20 | A06 vazia; arquivo `03 - Geometria Visual_ O Segredo dos Enquadramentos Virais.docx` repetido; sem ficha: A03 |
| 2 | principal | 04 | Conquistando o Digital: Dominando o Algoritmo | 6 | 31 | /member/2/21 | — |
| 2 | principal | 05 | Máquina de Receita Recorrente 2.0 | 5 | 19 | /member/2/22 | — |
| 2 | principal | 06 | Multiplicando Seu Tempo | 4 | 15 | /member/2/23 | A02 vazia |
| 2 | principal | 07 | UGC Monetizando Sua Autenticidade | 9 | 39 | /member/2/24 | — |
| 3 | principal | 01 | Passaporte da Prosperidade | 1 | 3 | /member/3/25 | — |
| 3 | principal | 02 | Multiplicando Resultados com Demandas Lucrativas | 2 | 6 | /member/3/26 | — |

| Vitrine | Aulas | Trechos |
|---|---|---|
| 1 | 71 | 331 |
| 2 | 43 | 179 |
| 3 | 3 | 9 |
| **Total** | **117** | **519** |

## Trechos por tipo

| Tipo | O que é | Trechos |
|---|---|---|
| conteudo | Demais seções de conteúdo da aula | 136 |
| visao_geral | Trecho -01 (nome oficial, onde fica, link, resumo) e continuação do resumo | 117 |
| faq | "Pontos para o suporte" da ficha | 117 |
| procedimento | Seções "Procedimento..." | 115 |
| exercicio | Exercício, missão, tarefa, teste | 34 |

## Mapeamento das seções da ficha

Títulos de seção (Título 2) encontrados nas fichas e o que foi feito com cada um:

| Seção na ficha | Vezes | Vai para o bot? |
|---|---|---|
| Resumo | 117 | sim, no trecho -01 (Resumo) |
| Pontos para o suporte | 117 | sim, trecho "faq" (tópico FAQ) |
| Pontos a validar | 117 | não — notas internas não confirmadas |
| Procedimento: passo a passo | 38 | sim, trecho "procedimento" |
| Procedimento: o que a aluna deve fazer | 19 | sim, trecho "procedimento" |
| Exercício prático | 11 | sim, trecho "exercicio" |
| Pontos principais | 8 | sim, trecho "conteudo" (tópico = título da seção) |
| Missão até a próxima aula | 7 | sim, trecho "exercicio" |
| Dicas para usar com as aulas anteriores | 7 | sim, trecho "conteudo" (tópico = título da seção) |
| Procedimento | 7 | sim, trecho "procedimento" |
| Vantagens × pontos de atenção (segundo a aula) | 5 | sim, trecho "conteudo" (tópico = título da seção) |
| Missão prática | 3 | sim, trecho "exercicio" |
| Tarefa prática | 3 | sim, trecho "exercicio" |
| Dicas do PDF | 3 | sim, trecho "conteudo" (tópico = título da seção) |
| Plano de crescimento | 2 | sim, trecho "conteudo" (tópico = título da seção) |
| Procedimento: como se destacar | 2 | sim, trecho "procedimento" |
| Dicas de uso | 2 | sim, trecho "conteudo" (tópico = título da seção) |
| Dicas de ouro | 2 | sim, trecho "conteudo" (tópico = título da seção) |
| O que a próxima aula promete | 2 | sim, trecho "conteudo" (tópico = título da seção) |
| Pontos principais da história | 2 | sim, trecho "conteudo" (tópico = título da seção) |
| Tarefa prática (para hoje) | 2 | sim, trecho "exercicio" |
| Fontes | 2 | não — lista de fontes externas (pesquisa da ficha) |
| Informações externas sobre o Workana (para conferência) | 1 | não — informação de fora da aula, para conferência |
| Informações externas sobre o 99Freelas (para conferência) | 1 | não — informação de fora da aula, para conferência |
| Exercício sugerido (a aula não propõe) | 1 | não — a própria ficha diz que a aula não propõe |
| outros 102 títulos de conteúdo que aparecem uma vez só (ex.: "Os 14 hacks", "Sofia: o que é") | 102 | sim, trecho "conteudo" (tópico = título da seção) |
| outros 41 títulos começados por "Procedimento" que aparecem uma vez só | 41 | sim, trecho "procedimento" |
| outros 8 títulos de exercício/missão/tarefa que aparecem uma vez só | 8 | sim, trecho "exercicio" |

Também ficam fora do bot: o parágrafo de metadado, as grafias_extras (viram `keywords`), a linha de navegação (vira o endereço do trecho), notas soltas da ficha antes da primeira seção e referências internas do tipo "ver os pontos a validar" (lista em "Ajustes automáticos no texto").

## Anomalias nas fichas e nas pastas

1. Arquivo vazio, sem nenhum texto (fica fora da base): `Vitrine 1 - Método Sócia Invisível/MÓDULO 13 - O Radar Digital das Demandas Lucrativas  /01 - O Código das Demandas no FREELANCER.docx`
2. Arquivo vazio, sem nenhum texto (fica fora da base): `Vitrine 1 - Método Sócia Invisível/MÓDULO 14 -  LUCRANDO COM A WEPINK/03 - Domine as Demandas Lucrativas da Wepink.docx`
3. Arquivo vazio, sem nenhum texto (fica fora da base): `Vitrine 1 - Método Sócia Invisível/MÓDULO 2 - O DESPERTAR/04 - Destruindo Crenças que Te Mantêm Pobre.docx`
4. Arquivo vazio, sem nenhum texto (fica fora da base): `Vitrine 2 - BÔNUS I - Skills das Sub Demandas/MÓDULO 03 - Pocket Studio Hollywood no Seu Bolso /06 - CapCut Pro_ Fábrica de Virais.docx`
5. Arquivo vazio, sem nenhum texto (fica fora da base): `Vitrine 2 - BÔNUS I - Skills das Sub Demandas/MÓDULO 06 - Multiplicando Seu Tempo - configurar por produto/02 - Engenharia de Hábitos_ Automatizando Performance.docx`
6. Os 5 arquivos vazios são o mesmo documento em branco (arquivos idênticos).
7. Pasta sem nenhuma ficha: `Vitrine 1 - Método Sócia Invisível/MÓDULO 17 - ESTRATÉGIA INVISÍVEL DOS AVATARES`
8. Vitrine 1 Módulo 11: não há ficha das aulas 05, 06 (existem: 01, 02, 03, 04, 07)
9. Vitrine 2 Módulo 03: não há ficha das aulas 03 (existem: 01, 02, 04, 05, 06, 07, 08, 09, 10, 11, 12)
10. V2.M03.A02: o arquivo `Vitrine 2 - BÔNUS I - Skills das Sub Demandas/MÓDULO 03 - Pocket Studio Hollywood no Seu Bolso /03 - Geometria Visual_ O Segredo dos Enquadramentos Virais.docx` tem o metadado da mesma aula que `Vitrine 2 - BÔNUS I - Skills das Sub Demandas/MÓDULO 03 - Pocket Studio Hollywood no Seu Bolso /02 - Dominando a Iluminação Sem Equipamentos Caros.docx` (conteúdo idêntico). Ficou só o primeiro; a aula do nome do arquivo ficou sem ficha.
11. V1.M01.A01: aula diverge — arquivo sem número no nome (`Quem é a Gabriela e por que ela entende sua realidade.docx`); usado aula "01" do metadado
12. V1.M01.A01: título diverge — nome do arquivo "Quem é a Gabriela e por que ela entende sua realidade" × metadado "AULA DE BOAS VINDAS V2 FINAL" (título usado na base: "Aula de Boas-Vindas")
13. V2.M03.A02: aula diverge — arquivo 03 (`03 - Geometria Visual_ O Segredo dos Enquadramentos Virais.docx`) × metadado aula "02"
14. V2.M03.A07: título diverge — nome do arquivo "Cortes Perfeitos_ Ritmo e Fluxo de Edição no CapCut" × metadado "CapCut do Zero: Dominando os Primeiros Passos" (título usado na base: "CapCut do Zero: Dominando os Primeiros Passos")
15. V2.M04.A01: título diverge — nome do arquivo "Conquistando o Digital_ Dominando o Algoritmo" × metadado "Anatomia das Redes" (título usado na base: "Anatomia das Redes")
16. V2.M07.A04: título diverge — nome do arquivo "Produção Inteligente_ Máxima Qualidade, Mínimo Equipamento" × metadado "Propostas que Fecham Contratos" (título usado na base: "Propostas que Fecham Contratos")
17. V3.M02.A01: título diverge — nome do arquivo "Descobrindo o Mundo UpWork" × metadado "Estratégias de Alta Performance no 99Freelas" (título usado na base: "Estratégias de Alta Performance no 99Freelas")
18. Vitrine: pasta Vitrine 2 × metadado vitrine "07" em 44 aulas. O id usa o número da pasta (que é o mesmo do link /member/N/...). Ver "Decisões tomadas sem certeza".
19. Vitrine: pasta Vitrine 3 × metadado vitrine "08" em 3 aulas. O id usa o número da pasta (que é o mesmo do link /member/N/...). Ver "Decisões tomadas sem certeza".
20. Os links das fichas são por MÓDULO, não por aula: todas as aulas de um módulo têm o mesmo link (25 links diferentes para 117 aulas; ex.: /member/1/4 serve às 5 aulas do Módulo 04). O cartão da aula vai abrir a página do módulo. Se a área de membros tiver link por aula, é preciso trocar nas fichas.
21. V1.M01.A01: link com parâmetro de pré-visualização/consulta `https://alunos.demandasinvisiveis.com/member/1/1?preview=true` (gravado sem: `https://alunos.demandasinvisiveis.com/member/1/1`)
22. Vitrine 1: o nome de arquivo "Quem é a Gabriela e por que ela entende sua realidade" se repete em aulas diferentes — Módulo 01 arquivo sem número (metadado: "AULA DE BOAS VINDAS V2 FINAL"); Módulo 02 arquivo 01 (metadado: "Quem é a Gabriela e por que ela entende sua realidade")
23. Vitrine 2: o nome de arquivo "Cortes Perfeitos_ Ritmo e Fluxo de Edição no CapCut" se repete em aulas diferentes — Módulo 03 arquivo 07 (metadado: "CapCut do Zero: Dominando os Primeiros Passos"); Módulo 03 arquivo 08 (metadado: "Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut")
24. Vitrine 2: o nome de arquivo "Produção Inteligente_ Máxima Qualidade, Mínimo Equipamento" se repete em aulas diferentes — Módulo 07 arquivo 04 (metadado: "Propostas que Fecham Contratos"); Módulo 07 arquivo 05 (metadado: "Produção Inteligente: Máxima Qualidade, Mínimo Equipamento")
25. Vitrine 3: o nome de arquivo "Descobrindo o Mundo UpWork" se repete em aulas diferentes — Módulo 01 arquivo 01 (metadado: "Descobrindo o Mundo UpWork"); Módulo 02 arquivo 01 (metadado: "Estratégias de Alta Performance no 99Freelas")
26. Vitrine 2: nome da pasta "BÔNUS I - Skills das Sub Demandas" × nome no metadado "I BÔNUS - Skill's das Demandas Lucrativas" (na base ficou o nome da linha de navegação da ficha).
27. Vitrine 3: nome da pasta "BÔNUS II - Missão Dólar Rápido" × nome no metadado "II BÔNUS: Missão Dólar Rápido" (na base ficou o nome da linha de navegação da ficha).
28. Vitrine 2 Módulo 06: o nome do módulo no metadado traz uma nota de configuração ("Multiplicando Seu Tempo - configurar por produto"). Na base ficou sem a nota.
29. Vitrine 2 Módulo 06: o nome do módulo na pasta traz uma nota de configuração ("MÓDULO 06 - Multiplicando Seu Tempo - configurar por produto"). Na base ficou sem a nota.
30. A expert aparece como "Gabriela Vittorino/Vitorino" (não Soares) no texto ou nas grafias de: V1.M02.A01, V1.M02.A02, V3.M01.A01. Confirmar o nome que o bot deve usar.
31. Nenhuma aula ficou sem link (todas as fichas com texto têm `link_area_membros`).
32. V1.M10.A06: nota da ficha fora das seções (não vai para o bot) — ⚠️ O título fala em "follow-up", mas o conteúdo é outro: são 10 hacks para começar a vender serviços de R$ 20 na Vinte Pila. O conteúdo de follow-up está na Aula 07. Os títulos das duas aulas parecem trocados.
33. V1.M10.A07: nota da ficha fora das seções (não vai para o bot) — ⚠️ Os títulos das Aulas 06 e 07 parecem trocados. Esta aula ("Hacks Avançados") ensina follow-up, e a Aula 06 ("O Poder do Follow-up") traz os hacks para vender. Ver os pontos a validar.
34. V1.M06.A01: nota da ficha fora das seções (não vai para o bot) — No PDF, o título desta aula é "Aula 1: Mapeando Seus Superpoderes Cotidianos".
35. V1.M06.A02: nota da ficha fora das seções (não vai para o bot) — No PDF, o título desta aula é "Transformando Habilidades em Linguagem de Mercado".
36. V1.M06.A03: nota da ficha fora das seções (não vai para o bot) — No PDF, o título desta aula é "Seu Diferencial como Vantagem Competitiva", com o subtítulo "Como usar suas habilidades naturais para prosperar no mercado digital".
37. V1.M06.A04: nota da ficha fora das seções (não vai para o bot) — No PDF, o título desta aula é "Criando Seu Primeiro Portfólio com o que Você Já Fez", com o subtítulo "Como criar seu portfólio e começar do zero no mercado digital".
38. V2.M06.A04: nota da ficha fora das seções (não vai para o bot) — ⚠️ O título informado é igual ao da Aula 03. O conteúdo desta aula é outro: fazer mais com menos e acompanhamento inteligente de projetos. Ver os pontos a validar.
39. V2.M06.A04: nota da ficha fora das seções (não vai para o bot) — Metadado titulo_observacao: Título idêntico ao da Aula 03. O conteúdo é 'Fazer mais com menos + acompanhamento inteligente de projetos'. Conferir o título correto.
40. V2.M07.A09: nota da ficha fora das seções (não vai para o bot) — ⚠️ O título é "Certificação UGC", mas o arquivo enviado é o "MÓDULO 07 – MATERIAL COMPLEMENTAR": um guia de estudo e consulta, sem nenhum conteúdo sobre certificação. Ver os pontos a validar.
41. Aulas que são material em PDF ou com duração fora do padrão: V1.M06.A01 (PDF (21 páginas)); V1.M06.A02 (PDF (29 páginas)); V1.M06.A03 (PDF (18 páginas)); V1.M06.A04 (PDF (19 páginas)); V2.M04.A02 (PDF (9 páginas)); V2.M07.A01 (PDF (6 páginas)); V2.M07.A02 (PDF (6 páginas)); V2.M07.A03 (PDF (5 páginas)); V2.M07.A04 (PDF (5 páginas)); V2.M07.A05 (PDF (5 páginas)); V2.M07.A06 (PDF (7 páginas)); V2.M07.A07 (PDF (6 páginas)); V2.M07.A08 (PDF (informado) — o arquivo enviado é transcrição de fala, provavelmente vídeo); V2.M07.A09 (PDF (57 páginas))
42. Gravação cita nome de outro produto ("Mentoria Projetos Remunerados (MPR)"), não Método Sócia Invisível: V1.M10.A01, V1.M10.A02, V1.M11.A01, V1.M11.A02, V1.M11.A03, V1.M12.A01, V1.M12.A02, V1.M13.A04, V3.M01.A01, V3.M02.A01
43. Gravação cita nome de outro produto ("Estratégia MPI"), não Método Sócia Invisível: V1.M14.A02
44. Gravação cita nome de outro produto ("Método GV"), não Método Sócia Invisível: V1.M02.A01, V1.M03.A01, V1.M03.A03

## Decisões tomadas sem certeza (confirmar)

- V1.M01.A01: título "Aula de Boas-Vindas" (metadado "AULA DE BOAS VINDAS V2 FINAL" e título da ficha "Aula de Boas-Vindas (V2 Final)": "V2 FINAL" é marca de versão do arquivo de vídeo; o nome do arquivo .docx ("Quem é a Gabriela...") é cópia do título da V1.M02.A01. Confirmar o nome oficial na área de membros.)
- V2.M05.A02: título "Personal Branding: Tornando-se a Primeira Opção Anterior" → "Personal Branding: Tornando-se a Primeira Opção" (tirado o "Anterior" que veio do botão da área de membros; a própria ficha aponta o erro em série no módulo)
- V2.M05.A03: título "Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel Anterior" → "Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel" (tirado o "Anterior" que veio do botão da área de membros; a própria ficha aponta o erro em série no módulo)
- V2.M05.A04: título "Automação de Processos: Otimizando Tempo e Aumentando Lucro Anterior" → "Automação de Processos: Otimizando Tempo e Aumentando Lucro" (tirado o "Anterior" que veio do botão da área de membros; a própria ficha aponta o erro em série no módulo)
- V2.M06.A04: título "Gestão Inteligente: Produtividade e Prazos" (o metadado repete o título da Aula 03 ("Arquitetura de Projetos: Do Caos à Execução") e a própria ficha pede para conferir (titulo_observacao). Usado o nome do arquivo .docx, que bate com o conteúdo (fazer mais com menos + acompanhamento de prazos). Confirmar na área de membros.)
- Número da vitrine: as fichas da Vitrine 2 dizem `vitrine: "07"` e as da Vitrine 3 `vitrine: "08"`. Usei o número da pasta (1, 2, 3), que é o mesmo do link (/member/2/..., /member/3/...) e o da regra de produto (Vitrine 1, 2 e 3 → principal). Com o metadado, as vitrines 7 e 8 não teriam produto e o script pararia. Para mudar: `NUMERO_DA_VITRINE = "metadado"` no script (e mapear 7 e 8 em `PRODUTO_POR_VITRINE`).
- Módulo e aula: usei sempre os números do metadado (batem com as pastas; só divergem nos casos listados em "Anomalias").
- Nome oficial da aula = Título 1 da ficha (igual ao metadado `titulo`, só com aspas/travessões arrumados), exceto as correções acima. Nas aulas em que o nome do arquivo .docx diverge do metadado (lista em "Anomalias"), ficou o metadado.
- Nomes de vitrine e de módulo vêm da linha de navegação da ficha ("Método Sócia Invisível › Módulo 04 – Anatomia das Demandas Lucrativas"), que tira as maiúsculas e o "- configurar por produto" do Módulo 06 da Vitrine 2.
- "Pontos para o suporte" entram no bot (são as perguntas e respostas da ficha, como o FAQ do MGA), como um trecho por seção (dividido se passar de 400 palavras), com tópico "FAQ" para a palavra "suporte" não puxar esses trechos em toda pergunta.
- Seções "Informações externas ... (para conferência)" e "Fontes" ficam fora do bot (não são conteúdo de aula e a própria ficha pede conferência). Frases "Segundo fonte externa..." dentro das seções que entram também saíram. Tudo isso está na lista de "Pontos a validar" de cada aula.
- "Exercício sugerido (a aula não propõe)" ficou fora (a ficha diz que não é da aula). "Exercício sugerido (implícito na aula)" entrou.
- Avisos de cautela escritos dentro das seções que entram (ex.: "⚠️ Não verificado" nas afirmações sobre a WePink, "Não dizer que é completamente gratuita") foram mantidos: reduzem risco de promessa.
- Referências internas das fichas do tipo "v07 M02 A07" viraram "Vitrine 2, Módulo 02, Aula 07".
- Grafias que a ficha marca como erro de transcrição de outra frase (ex.: "instabilidade" por "estabilidade") e nomes de pessoas de casos/depoimentos NÃO viraram palavras-chave (piorariam a busca). Ficam listados em `revisar-grafias.md`.
- Conteúdo sobre reembolso dentro das aulas (V1.M02.A02 e V1.M02.A03) foi mantido como está na ficha; ver "Temas sensíveis".
- Os "Pontos para o suporte" trazem 38 linhas escritas para a equipe, em 32 aulas (ex.: "Confirmar o procedimento com a equipe antes de responder", "Não dizer que é completamente gratuita"). Entraram como estão: orientam a IA a não afirmar o que a aula não garante. Se preferir, a dona do produto pode reescrever essas linhas como resposta pronta.

## Ajustes no app para esta base (situação em 04/10/2026)

- Feito: `LESSON_URL_RE` (aulas.ts) aceita as duas áreas de membros (demandasinvisiveis e sociasuprema).
- Feito: `NOMES_DOS_NIVEIS` (aulas.ts) com as Vitrines 1 a 4; produto `top_demandas` já existe no banco.
- Feito: `lesson` vai no formato `código — nome da aula`, que é o que o motor usa para o nome no cartão.
- Falta: `PRIMEIRAS_AULAS` (aulas.ts). Sugestão: `V1.M01.A01`, `V1.M02.A01`, `V1.M02.A02` (a V1.M02.A04 está vazia).
- O prompt (02-restricoes.md) proíbe informar preço de produto. As aulas citam preços de ferramentas de terceiros (lista abaixo); se a regra valer também para elas, o bot vai se recusar a repetir esses valores.

## Preço, desconto, cupom e parcelamento

Busca feita em todo o texto que vai para o bot (R$, US$, €, dólar, desconto, cupom, parcela, "12x de", à vista, checkout, mensalidade, /mês) e classificada pelo nome do produto citado na mesma linha.

### Produtos da própria Gabriela (MSI, Top Demandas Accelerator, Cofre PIX Relâmpago, Mentoria Sócia Suprema, Sócia Vitalícia)

- Nenhuma aula cita preço, desconto, cupom ou parcelamento desses produtos. Os nomes Top Demandas, Cofre PIX, Sócia Suprema e Sócia Vitalícia não aparecem em nenhuma ficha. A política "essa informação é com o time" não conflita com a base.

### Ferramentas e plataformas de terceiros (conteúdo de aula)

- **V1.M01.A01** (Aula de Boas-Vindas):
  - V1.M01.A01-01: Aula de abertura do método. Não traz conteúdo técnico: funciona como um mapa de primeiros passos. A aluna é orientada a (1) entrar no grupo de alunas no WhatsApp, (2) conhecer a...
  - V1.M01.A01-02: 7. (Opcional) Garantir um plano da Soffia com desconto, pelo link do Plano Premium abaixo da aula.
  - V1.M01.A01-04: | Plano trimestral (3 meses) | R$ 197,00 à vista ou 12x de R$ 19,00* | ~R$ 100 de desconto sobre ~R$ 300 no mensal |
  - V1.M01.A01-04: | Plano anual (12 meses) | R$ 697,00 à vista ou 12x de R$ 69,00 | Economia de mais de R$ 400. Menos de R$ 2/dia. Recomendado na aula. |
  - V1.M01.A01-04: - Os planos com desconto são apresentados como condição exclusiva desta aula.
  - V1.M01.A01-05: - "A Soffia é paga?" Os primeiros 30 dias são grátis, contados a partir da ativação, com cartão cadastrado. Depois custa R$ 97/mês, ou a aluna pode escolher o plano trimestral o...
- **V1.M07.A03** (O Ciclo da Realização: Como Receber):
  - V1.M07.A03-04: - "Preciso pagar o 99Freelas?" Não para começar. O plano gratuito dá 10 conexões (propostas) por mês. Os planos PRO (R$ 49,90) e PREMIUM (R$ 89,90) são opcionais.
- **V1.M08.A03** (O Ciclo da Realização: Como Receber):
  - V1.M08.A03-02: - Ou um valor mínimo, como R$ 600 ou R$ 1.500. Nesse caso, o Workana espera juntar esse valor antes de transferir.
- **V1.M08.A04** (Mapeamento Inteligente: Identificando Demandas Lucrativas):
  - V1.M08.A04-03: - "Por que vou receber menos do que cobrei?" O Workana desconta o custo do serviço. No exemplo da aula, R$ 100 de R$ 500 (20%). O valor líquido aparece na tela antes de enviar.
- **V1.M09.A06** (Transforme Cliques em Dinheiro com GrabPoints):
  - V1.M09.A06-04: | Saque a partir de US$ 3, bom para iniciantes | Poucas pesquisas disponíveis no Brasil: exige paciência |
  - V1.M09.A06-05: - "Qual o valor mínimo para sacar?" Segundo a aula, US$ 3. Confirmar no site, porque o valor pode mudar.
- **V1.M09.A07** (AttaPoll na Prática: Como Lucrar com Pesquisas no Celular):
  - V1.M09.A07-02: 6. Sacar pelo PayPal a partir de US$ 3.
  - V1.M09.A07-05: - "O que é o AttaPoll?" Um app de pesquisas pagas para Android e iOS. A aluna responde pesquisas e saca por PayPal a partir de US$ 3.
  - V1.M09.A07-05: - "Qual o saque mínimo?" Segundo a aula, US$ 3, via PayPal. A aluna precisa de conta PayPal. Confirmar o valor atual no app.
- **V1.M09.A08** (Ganhos Diretos via PIX: Descubra o Falaí):
  - V1.M09.A08-01: A aula apresenta o Falaí (grafado "Fala.i" na transcrição), uma plataforma 100% brasileira de pesquisas remuneradas. O grande diferencial: pagamento em reais, via Pix, instantân...
- **V1.M09.A09** (Ganhe em Dólares com o Voissy):
  - V1.M09.A09-01: É uma aula curta que apresenta o Voissy (falado "Voice" na gravação), um aplicativo de pesquisas remuneradas para Android e iOS. Ele conecta consumidores de todo o Brasil a empr...
  - V1.M09.A09-02: 6. Trocar os pontos por dinheiro via PayPal ao atingir o mínimo de US$ 4.
  - V1.M09.A09-04: - "O que é o Voissy?" Um app de pesquisas pagas em dólar (Android e iOS). Saque via PayPal a partir de US$ 4, segundo a aula.
- **V1.M09.A10** (Como Lucrar com Pesquisas e Missões Criativas na MeSeems):
  - V1.M09.A10-01: A aula apresenta a MeSeems (falada "Missense" na gravação), uma plataforma de pesquisas que funciona como uma rede social: tem feed com enquetes e debates, missões extras, siste...
- **V1.M09.A12** (Ysense: O Clássico das Pesquisas Remuneradas):
  - V1.M09.A12-01: A aula apresenta o ySense (falado "iSense" na gravação), descrito como referência em pesquisas remuneradas. Além de pesquisas, ele oferece tarefas simples, ofertas pagas, bônus ...
  - V1.M09.A12-06: - "Qual o saque mínimo? Em que moeda paga?" Não repetir "€ 10 em euros" sem conferir. Orientar a aluna a consultar a página de saques da própria plataforma.
- **V1.M10.A01** (O Código das Demandas no Vinte Pila):
  - V1.M10.A01-01: É a abertura do Módulo 10, que apresenta uma terceira plataforma de freela: o Vinte Pila. É uma plataforma nacional em que a própria aluna publica os seus serviços (chamados de ...
  - V1.M10.A01-06: - "O que é o Vinte Pila?" Uma plataforma brasileira em que você publica os seus serviços (a partir de R$ 20) e os clientes contratam e pagam pelo próprio site.
- **V1.M10.A03** (O Ciclo da Realização: Como Receber):
  - V1.M10.A03-03: - "Quando recebo?" Ver a Aula 05 deste módulo: saque mínimo de R$ 80, processado às quartas-feiras para pedidos feitos até terça.
- **V1.M10.A05** (Mapeamento Inteligente: Identificando Demandas Lucrativas):
  - V1.M10.A05-01: Regras de saque importantes: mínimo de R$ 80 e processamento às quartas-feiras para pedidos feitos até terça-feira.
  - V1.M10.A05-02: - extrato de transações, com tudo o que foi recebido e os descontos da plataforma.
  - V1.M10.A05-02: | Saldo mínimo para sacar | R$ 80 |
  - V1.M10.A05-03: - "Como envio proposta na Vinte Pila?" Abrir a oportunidade › "Fazer uma proposta" › valor (mínimo R$ 20) e prazo › Enviar.
  - V1.M10.A05-03: - "Não consigo sacar." Verificar se o saldo é de pelo menos R$ 80.
  - V1.M10.A05-03: - "Quanto a plataforma desconta?" O desconto aparece no extrato de transações. A aula não diz o percentual.
- **V1.M10.A06** (Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos):
  - V1.M10.A06-01: A aula ensina 10 "hacks" para gerar as primeiras vendas com microsserviços, usando a lógica da Vinte Pila: começar pequeno (R$ 20) para ganhar confiança, experiência e reputação...
  - V1.M10.A06-04: - "Que serviço eu ofereço na Vinte Pila?" Algo simples que você já sabe fazer, com problema e prazo claros. Exemplo: "Organizo sua lista de contatos em planilha em 24 h por R$ 20."
- **V1.M12.A04** (Cadastro Inteligente de Demandas):
  - V1.M12.A04-02: 6. Valor. O padrão da plataforma é R$ 20. A aula sugere começar com valor baixo para construir o perfil e depois cobrar mais conforme a complexidade.
- **V3.M02.A01** (Estratégias de Alta Performance no 99Freelas):
  - V3.M02.A01-01: É uma aula com gravação de tela. Anuncia "uma dica rapidinha" sobre 99Freelas e Workana, mas só mostra o 99Freelas. A "dica" é assinar um plano pago. Compara os planos Básico (g...
  - V3.M02.A01-03: - "Preciso pagar o 99Freelas?" Não é obrigatório. O plano gratuito tem 10 conexões por mês. Esta aula recomenda o Pro (R$ 49,90) para ter mais conexões, receber mais rápido (4 d...
- **V3.M02.A02** (O Código da Excelência no Workana):
  - V3.M02.A02-02: | | Grátis | Plano de entrada (R$ 21,90/mês) | Profissional / Explorer |
  - V3.M02.A02-02: 1. Sequência recomendada: plano de R$ 21,90 (teste, "investimento não tão alto") › Profissional ou Explorer quando estiver lucrando › trimestral, que "compensa bastante" quando ...
  - V3.M02.A02-03: - "Preciso pagar o Workana?" Não é obrigatório. O plano grátis tem 2 contatos por semana, 1 projeto em andamento e 1 saque por mês. A aula sugere o plano de entrada de R$ 21,90/...

Atenção: na V1.M01.A01 os planos da Sofia (trimestral e anual) são apresentados como "condição exclusiva desta aula", com link de Plano Premium abaixo do vídeo. Tratei como ferramenta de terceiro, como combinado; confirmar se a Sofia não é vendida pela própria Gabriela.

### Valores que são exemplo de precificação ou de ganho citado na aula (não são preço de produto)

81 linhas, em 32 aulas: V1.M01.A01, V1.M02.A01, V1.M03.A01, V1.M03.A04, V1.M05.A01, V1.M05.A02, V1.M05.A03, V1.M05.A04, V1.M05.A05, V1.M06.A01, V1.M06.A02, V1.M06.A04, V1.M07.A03, V1.M07.A05, V1.M07.A06, V1.M08.A04, V1.M08.A05, V1.M08.A06, V1.M09.A02, V1.M09.A04, V1.M09.A08, V1.M09.A10, V1.M10.A01, V1.M10.A04, V1.M10.A05, V1.M10.A06, V1.M11.A07, V1.M12.A04, V1.M13.A04, V1.M13.A05, V3.M02.A01, V3.M02.A02.

## Temas sensíveis no texto que vai para o bot

Reembolso, garantia e cancelamento são do Protocolo 7D (servidor). Estas linhas das aulas falam disso; o prompt já proíbe a IA de orientar reembolso, mas vale a dona do produto revisar:

- **V1.M09.A02** (O Poder da Sua Opinião):
  - V1.M09.A02-03: | Presencial | Cliente oculto, teste de produtos, auditorias, visitas a estabelecimentos | Dinheiro, reembolso de compras ou produtos grátis | "ProductTube", "Vid", convites exclusivos |
- **V1.M11.A03** (Fazendo Demandas Mobile: App GETNINJAS):
  - V1.M11.A03-03: - "Gastei moedas e o cliente não respondeu / não fechou." Isso pode acontecer. Orientar a aluna a escolher bem os pedidos antes de liberar e a entrar em contato rápido. Para reembolso de moedas, só...

A aula V1.M02.A02 diz que o prazo de reembolso é de 7 dias: confirmar com `garantia` em `src/oferta/marca.ts`.

## Pontos a validar (620), aula por aula

Notas internas das fichas, NÃO confirmadas. Nenhuma delas entrou no texto do bot. Junto ficam as seções "Informações externas" e "Fontes" e as notas soltas. Nomes de alunas citadas aparecem como [nome].

### V1.M04.A01 — Demandas Cash: Como e Por Que Funciona? (5)

- Tipo: foi informado como procedimento, mas é uma aula conceitual, sem passos.
- ⚠️ A definição de "demanda" diverge entre as aulas:
  - Na Aula de Boas-Vindas (M01), a demanda é descrita como dar a sua opinião de consumidora real para grandes empresas. A Sofia acha as demandas, monta a fila e preenche os cadastros.
  - Aqui, as subdemandas são descritas de forma genérica, parecida com freelancer: "criar algo, organizar informações, execução direta".
  - Na Aula 04 do M03, aparece o exemplo "enviar propostas".
  - Vale definir uma definição oficial única para o suporte usar, porque alunas podem se confundir sobre o que vão fazer de fato.
- "Demandas Cash": o termo do título não aparece na gravação.
- Promessa de retorno rápido: a aula fala em "gerar renda de forma prática e rápida" e "resultados ágeis". Vale o mesmo cuidado de compliance das aulas anteriores.
- Gênero: a aula abre com "Seja muito bem-vindo" e usa "preso", com público feminino.

### V1.M04.A02 — As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE (3)

- ⚠️ Modelo de trabalho é de freelancer: esta aula fala em cliente e contratante, escopo, precificação, negociação de valor e feedback. Esse é o modelo de prestação de serviço freelancer. Ele não combina com o que a Aula de Boas-Vindas descreve: dar opinião de consumidora real para grandes empresas, com a Sofia achando e preenchendo as demandas. Nesse modelo não há prazo negociado, escopo nem preço definido pela aluna. Reforça a necessidade de uma definição oficial do que é "demanda" (ver a Aula 01 deste módulo).
- Pode ser gravação reaproveitada de uma oferta de freelancer ou microserviços. Se for, alunas podem estranhar o conteúdo, e o suporte deve estar preparado.
- Frase truncada no fim: "você pode perder a oportunidade de prejudicar a sua imagem" é erro de fala ou transcrição. O sentido é "perder oportunidades e prejudicar a sua imagem".

### V1.M04.A03 — Vantagens de Realizar as Demandas (4)

- Tipo: aula conceitual. O "procedimento" se resume a duas dicas.
- ⚠️ De novo o modelo freelancer: "quanto quer cobrar", "comece com valores competitivos", "fidelizar pessoas" e "cobrar mais pelo seu trabalho" pressupõem que a aluna define os próprios preços. Isso é incompatível com o modelo de opinião de consumidora e Sofia da Aula de Boas-Vindas. É o mesmo ponto das Aulas 01 e 02 deste módulo.
- ⚠️ Promessa de ganho: "você pode começar a ganhar dinheiro já no primeiro dia". Somada ao "Pix em 24 horas" do M01, é uma promessa de prazo. A Aula 03 do M03 diz que o tempo depende da aluna. Alinhar o discurso.
- Erros de transcrição: "treitibilidade" (é flexibilidade) e "personagem fixo" (é funcionário fixo).

### V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona (3)

- ⚠️ Esta é a dúvida mais provável do suporte ("quando recebo?"), e a aula responde com o modelo freelancer: negociar valor, prazo e forma com quem contratou. No modelo da Aula de Boas-Vindas (opinião de consumidora com a Sofia), o pagamento provavelmente é feito pela plataforma ou empresa da pesquisa, com regras próprias como valor mínimo para saque e prazo de liberação. Vale criar uma resposta oficial sobre como e quando o dinheiro cai no modelo real.
- Numeração repetida: a aula tem dois "Quarto" (meios de pagamento e organização financeira).
- Erros de transcrição que mudam o sentido: "FIX" (é Pix), "mérito de pagamento" (é método), "restante após o emprego" (é após a entrega), "garantir que você tenha instabilidade" (é estabilidade). Na reserva financeira, "eu fiz… para cobrir as suas despesas" provavelmente é "faça uma reserva".

### V1.M04.A05 — Tudo que você aprendeu (4)

- Item que não estava na Aula 02: a revisão cita "misturar o pessoal com o profissional" entre os erros a evitar, mas isso não aparece na Aula 02. Lá, o 5º erro é "sumir durante o processo".
- Suporte 24x7: a promessa aparece de novo. Ver as Aulas 02 e 03 do Módulo 03.
- "Você já tem todo o conhecimento necessário": a aula diz que a aluna já pode colocar em prática, mas o Módulo 04 não ensinou onde encontrar nem como executar uma demanda. Se isso vier no Módulo 05, tudo bem. Se não, é uma lacuna.
- Modelo freelancer: a revisão reforça o conteúdo das Aulas 01 a 04 (prazos, feedback, cobrança), com o mesmo descompasso em relação ao modelo de opinião de consumidora com a Sofia do M01.

### V1.M05.A01 — Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda (5)

- Título diferente da gravação: o título diz "Dupla Jornada", mas a gravação sempre fala em "dupla renda".
- ⚠️ Terceira definição de "demanda": aqui, subdemanda = serviço freelancer para empresas (planilhas, textos, social media, agenda, ligações), com precificação feita pela aluna. Isso confirma o descompasso com a Aula de Boas-Vindas (opinião de consumidora com a Sofia). É o ponto mais urgente de alinhamento do curso.
- ⚠️ Valor por demanda: R$ 150 por demanda é um valor de serviço freelancer. Se o modelo real for de pesquisas e opiniões, os valores tendem a ser muito menores, e a conta cria uma expectativa irreal.
- Público: a aula assume uma aluna CLT. Alunas desempregadas ou donas de casa podem não se identificar, mas o conteúdo vale para elas também.
- Erros de transcrição: "pequenas promoções" (provavelmente "pequenas tarefas") e "R$ 450 desde 4 semanas" (é "vezes 4 semanas").

### V1.M05.A02 — Auditoria de Tempo: Descobrindo Suas Horas Perdidas (5)

- Prazo da auditoria diferente: o Passo 1 fala em 7 dias, mas a missão final pede 3 dias. Definir qual vale ou explicar que 3 dias é a versão mínima.
- ⚠️ Depoimentos com valores (R$ 2.000, R$ 5.000 e R$ 7.500/mês): a aula apresenta [nome], [nome] e [nome] como "mulheres reais" da mentoria. Se forem casos ilustrativos, isso gera risco de publicidade enganosa. Se forem reais, é bom ter comprovação arquivada.
- Estimativas de ganho: "R$ 300 a R$ 400 por mês" com 4 h/semana e "em um mês pode estar ganhando mais do que quem é CLT". Esta aula dá uma estimativa menor que a da aula anterior (R$ 1.800/mês), e as duas contas não batem entre si.
- Modelo freelancer: os exemplos de tarefas (e-mails, planilhas, redes sociais, apresentações) seguem a definição da Aula 01 do M05, diferente do modelo de opinião de consumidora com a Sofia do M01.
- Erro de transcrição: "mesmo que seja 30 minutos por mês" deve ser "por dia" (a conta de 6 h/semana só fecha assim).

### V1.M05.A03 — A Arte de Fazer Mais Trabalhando Menos (3)

- ⚠️ Promessas de ganho:
  - [nome] com R$ 3.200/mês em 6 h/semana. Isso dá cerca de R$ 133/hora, bem acima da aula anterior (R$ 300–400/mês com 4 h/semana).
  - "30 horas por mês podem gerar 800, 1.000, 3.000, 5.000 reais, até mais".
  - As contas do módulo não são consistentes entre si, e os casos são apresentados como reais. Vale revisar o compliance.
- Números da [nome] que não fecham: "R$ 3.200 com 6 horas por semana" e "2 horas por dia viraram mais R$ 1.800/mês" descrevem jornadas diferentes (6 h/semana contra cerca de 14 h/semana).
- Erros de transcrição: "produtividade para homem de executivos" (é "homens executivos"), "no trabalho certeiro" (provavelmente "no trabalho CLT"), "liberar e assinar em semana" (trecho truncado, conferir no vídeo) e "mulher próxima" (é "mulher próspera").

### V1.M05.A04 — SOS Sobrecarga: Como Identificar e Resolver (4)

- Tema sensível: a aula fala de ansiedade, burnout e depressão. Vale definir um protocolo de acolhimento no suporte, com orientação para buscar ajuda profissional, para quando uma aluna relatar algo assim.
- Estatística sem fonte: "90% das mulheres que começam com subdemandas sofrem sobrecarga".
- Promessa de ganho: [nome] com R$ 2.800 extras no primeiro mês, com 4 h/dia. Mesmo cuidado de compliance das aulas anteriores.
- Erros de transcrição: "burnou", "imprefinir" (é "prevenir"), "subir demandas" (é "subdemandas"), "mãe só" (é "mãe solo") e "compromissos sociais necessários" (pelo contexto, é "desnecessários").

### V1.M05.A05 — Liberdade Planejada: Construindo Sua Saída do CLT (5)

- ⚠️ Critérios pressupõem o modelo freelancer: "pessoas fixas que te contratam", "5 pessoas que podem te recomendar", "8 pessoas ativas" e "precificar os seus trabalhos" só fazem sentido para prestação de serviço. No modelo de opinião de consumidora com a Sofia (M01), não há clientes fixos nem recomendações. É o mesmo ponto das aulas anteriores sobre a definição de "demanda".
- Conflito com o título do M03 A01: esta aula é bem cautelosa sobre sair do CLT, enquanto o título "Como eu saí do CLT para faturar mais de 3 milhões em 12 meses" vende a saída como algo rápido. Alinhar o discurso.
- Estatística sem fonte: "o sonho de 90% das mulheres CLT".
- Frase truncada: "até ter certeza absoluta que a sua renda própria está…" (provavelmente "está estável").
- Erro de transcrição: "Ou te dar um teste" é "Vou te dar um teste".

### V1.M08.A01 — O Código das Demandas no Workana (5)


Seção "Informações externas sobre o Workana (para conferência)" (fora do bot):

Segundo levantamento em fonte externa (setembro/2026,Freelas em Crise (https://www.freelasemcrise.com.br/blog/taxas-plataformas-hotmart-upwork-workana)). Confirmar no site oficial, porque os valores mudam:
| Plano | Mensalidade | Comissão sobre projetos | Conexões (propostas) |
|---|---|---|---|
| Básico | Gratuito | ~20% | Quantidade limitada por mês |
| PLUS | ~R$ 49/mês | ~10% | Mais conexões |
| PRO | ~R$ 99/mês | ~7% | Ilimitadas |
- Recebimento: o pagamento fica em custódia até o cliente aprovar a entrega e costuma ser liberado alguns dias depois.
- ⚠️ "Completamente gratuita" não é exato: o cadastro é gratuito, mas há comissão sobre os projetos e o plano gratuito tem conexões limitadas. É o mesmo problema da Aula 01 do M07 com o 99Freelas.
- ⚠️ Promessa de ganho: "mulheres que começaram ganhando R$ 500/mês e hoje faturam R$ 3 mil, R$ 5 mil, algumas até R$ 10 mil" e "milhares de mulheres já vivem através da Workana". São afirmações sem comprovação.
- "Avaliar produtos" de novo: o exemplo de avaliar produtos de uma marca por 3 meses repete a ideia de "opinião de consumidora" do M01, mas isso não é um tipo de projeto típico do Workana. As demais oportunidades citadas (conteúdo, dados, suporte administrativo) são coerentes com a plataforma.
- Nome da plataforma: a gravação diz "Orkana" nas primeiras menções e "Workana" depois. Pode ser erro de transcrição ou de pronúncia. Conferir no vídeo, porque a aluna pode pesquisar o nome errado.
- Título × módulo: o título do módulo é "Faturando com Demandas na Prática", mas esta aula é só introdutória.
Fontes:Freelas em Crise – Taxas das plataformas em 2026 (https://www.freelasemcrise.com.br/blog/taxas-plataformas-hotmart-upwork-workana) ·HostGator – Workana: o que é e como usar (https://www.hostgator.com.br/blog/workana/)

### V1.M08.A02 — Construindo Sua Vitrine Digital no Workana (5)

- ⚠️ Falta o cadastro dos dados de recebimento: a aula do 99Freelas (M07 A02) mostrava a conta bancária. Esta não mostra como configurar o recebimento no Workana. É uma dúvida certa no suporte.
- ⚠️ Conflito com o Bônus 02 (M07 A06): aquela aula recomendava "migrar os melhores contratantes para atendimento direto", e esta mostra o aviso do Workana de que compartilhar contato leva a bloqueio. Reforça a necessidade de revisar aquele trecho.
- Preço por hora sem orientação: a aluna precisa definir um valor sem nenhuma referência nesta aula.
- Foto mencionada só de passagem: a aula diz "já adicionou uma foto", mas não mostra onde.
- Nome da plataforma: a gravação alterna entre "Workana" e "Orkana", como na Aula 01.

### V1.M08.A03 — O Ciclo da Realização: Como Receber (6)

- ⚠️ Promessa "hoje mesmo você já consegue fazer algum projeto e receber por ele": não é realista. É preciso ser escolhida por um cliente, entregar e ter a entrega aprovada, e o pagamento fica em custódia até a aprovação. Depois ainda segue a frequência de saque escolhida (semanal, início ou meio do mês). Recomendo ajustar o discurso.
- Custos e prazos dos meios de saque: "Mercado Pago sem custo e em 24 h" e "PayPal 2%" vêm da gravação. Conferir no Workana, porque as condições mudam. Isso também não inclui a comissão do Workana sobre cada projeto (ver a Aula 01 deste módulo).
- Terceira opção de saque: a aula cita 3 opções, mas só descreve duas. Identificar a terceira (por exemplo, transferência bancária).
- Mesmo título da Aula 03 do M07: as duas aulas se chamam "O Ciclo da Realização: Como Receber". Esta cumpre o título; a do M07 falava só de planos.
- Resolve a lacuna da Aula 02 deste módulo, que não mostrava o cadastro de recebimento.
- Nome: a gravação diz "Orkana" de novo.

### V1.M08.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas (4)

- ✅ Confirma a taxa do Workana: a própria tela mostra 20% de custo do serviço. Isso contradiz a Aula 01 deste módulo ("completamente gratuita"). Ajustar o discurso daquela aula.
- ⚠️ Exemplo arriscado para iniciantes: o projeto mostrado é a tradução de uma notificação extrajudicial para o inglês, um documento jurídico que exige fluência e precisão. A aula faz uma proposta com prazo de 1 dia, na hora, sem falar em qualificação. Pode incentivar a aluna a pegar trabalhos que não domina, contra o que diz o próprio Bônus 02 ("nunca aceite demandas fora da sua área"). Sugiro usar um exemplo mais simples (entrada de dados, assistente virtual) ou acrescentar uma ressalva.
- Copiar e colar proposta: a aula mostra a reutilização de um texto de "atendente" para "tradução". Está certo desde que a aluna adapte de verdade. Vale reforçar isso para não contradizer o Bônus 02.
- Nome: a gravação diz "Orkana" de novo.

### V1.M08.A05 — Bônus 1: Precificação Inteligente para Ganhar Mais (7)

- ⚠️ Tensão com o público iniciante: a aula sugere cobrar R$ 600 por um closet ou "no mínimo R$ 2.500" por um escritório e aumentar 20% já na próxima proposta. Isso choca com:
  - o Hack 13 do Bônus 02 (M07): começar por demandas pequenas e baratas;
  - o Mês 1 desta mesma aula: cobrar o preço atual para construir portfólio;
  - a realidade de quem ainda não tem avaliações nas plataformas.
- Vale deixar explícito que a precificação por valor vale depois das primeiras avaliações.
- "Mentalidade de empregada": a expressão pode soar pejorativa para alunas que são ou foram empregadas domésticas, parte do público citado no curso. Sugiro revisar.
- Exemplos presenciais de novo: closet, casa e escritório. Não combinam com o trabalho remoto no Workana e no 99Freelas. Faltam exemplos de precificação de serviços digitais (entrada de dados, social media, assistente virtual).
- Cálculos de "valor entregue" inflados: "R$ 9.000 de valor" por um closet ou "R$ 36.500" por um escritório partem de premissas arbitrárias, como o valor da hora do cliente. Servem como raciocínio, mas não devem ser apresentados ao cliente como fato.
- Conflito com a Aula 02 deste módulo: o Workana pede preço por hora no perfil, e esta aula condena cobrar por hora. Orientar como preencher esse campo.
- Erros de transcrição: "eu não apenas desorganizo" (é "organizo"), "prêmio" (é "premium"), "manual de acompanhamento" (provavelmente "manual + acompanhamento"), "competir para o preço" (é "por preço").

### V1.M08.A06 — Bônus 2: Hacks Avançados para o Workana (7)

- ⚠️ Fusos horários errados (Hack 2): os horários sugeridos não batem com a realidade.
  - Argentina, Uruguai e Paraguai estão no mesmo fuso de Brasília ou muito perto dele. Não faz sentido separá-los por turno, e 19h–22h (sugerido para Uruguai e Paraguai) é fora do horário comercial lá também.
  - México e Colômbia estão 2 a 3 horas atrás de Brasília: 8h em Brasília são 5h ou 6h lá.
  - Chile fica entre 0 e 1 hora de diferença.
  - Sugiro corrigir: para México e Colômbia, a tarde de Brasília é o melhor período.
- ⚠️ Depoimentos "adaptados" (Hack 9): o exemplo "[nome], México" é um depoimento inventado. Orientar a aluna a "adaptar depoimentos" ou a criar provas sociais de clientes que não existem é enganoso, prejudica a reputação e pode violar as regras da plataforma. É o mesmo problema dos bônus do M07. Recomendo reformular: usar só depoimentos reais, traduzidos.
- Estereótipos por nacionalidade (Hacks 3, 10 e 14): "mexicanos formais, argentinos diretos, colombianos calorosos, chilenos técnicos" e "brasileiros entregam qualidade superior" são generalizações que podem soar ofensivas para o cliente. Vale suavizar para algo como "observe o tom do anúncio e espelhe".
- Serviços presenciais no exterior: "revisão trimestral presencial" e organização de casas para clientes em outro país não são viáveis para quem mora no Brasil. Os exemplos continuam presos ao nicho de organização doméstica.
- Afirmações sem fonte: "o algoritmo do Workana funciona em espanhol", "latinos valorizam o jeitinho brasileiro", "US$ 200 ≈ R$ 1.000". Esta última depende do câmbio; a aula já ressalva isso.
- Nome: a gravação chama o Workana de "Orkana" e o 99Freelas de "99 Freelance" o tempo todo.
- Erro de transcrição: "Pensione sua disponibilidade" é "Posicione".

### V1.M09.A01 — Como Lucrar com Pesquisas Reais (5)

- ✅ Finalmente conecta com a Aula de Boas-Vindas: este módulo trata de opinião e pesquisas, o modelo descrito no M01 ("dar sua opinião de consumidora real"). Porém, só aparece no Módulo 09, depois de 4 módulos no modelo freelancer (M04 a M08). Sugestão: deixar claro, no M01 ou num mapa do curso, que o método tem dois caminhos: freelancer (99Freelas e Workana) e pesquisas (M09). Explicar também onde a Sofia entra.
- Conflito com a Aula de Boas-Vindas: o M01 diz que a Sofia "encontra as demandas e preenche os cadastros". Se o M09 ensinar a aluna a se cadastrar e responder pesquisas manualmente, alinhar os dois discursos.
- Estatística sem fonte: "90% das pessoas são rejeitadas".
- "Centenas de mulheres estão transformando suas vidas": afirmação sem comprovação, mas mais moderada que as de outros módulos.
- Tipo: foi informado como procedimento, mas é uma aula introdutória.

### V1.M09.A02 — O Poder da Sua Opinião (7)

- 🚨 "Ajustar dados estratégicos não é mentir": a aula orienta a aluna a "ajustar" informações de perfil (quantas TVs tem, se tem carro, se viaja, se compra online) para parecer uma "consumidora ativa e relevante" e ser mais escolhida. Isso é declarar dados falsos:
  - viola os termos de uso das plataformas de pesquisa, que normalmente exigem respostas verdadeiras;
  - leva a bloqueio de conta e perda dos pontos ou saldo acumulados;
  - contradiz a própria aula, que no primeiro pilar manda "ser sempre autêntica" e alerta que inconsistências levam a bloqueio.
- Recomendo remover ou reescrever esse trecho com urgência. Uma alternativa honesta: preencher o perfil de forma completa e verdadeira e marcar interesses amplos em categorias que de fato consome.
- Nomes de plataformas duvidosos: "Atapow" (provavelmente AttaPoll), "Respondente" (provavelmente Respondent), "Falaí", "Missense", "ProductTube", "Vid" e "Vento" precisam ser conferidos no vídeo e na lista oficial. Se a aluna pesquisar o nome errado, pode cair em sites falsos.
- Pilar faltando: a aula anuncia 4 pilares, mas só fala 3 (pula o 2º).
- Pesquisas presenciais: cliente oculto e auditorias exigem deslocamento. Isso contrasta com a promessa de trabalho 100% de casa, e vale mencionar.
- Relação com a Sofia (M01): a Boas-Vindas diz que a Sofia "preenche cadastros" e "monta a fila do dia". Esta aula ensina a aluna a fazer tudo manualmente. Alinhar.
- Erros de transcrição: "suas dadas pessoais" (é "seus dados"), "comete os cadastros" (é "complete").

### V1.M09.A03 — O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades (4)

- ⚠️ "Variar os dispositivos para mostrar atividade legítima": em muitas plataformas, acessos de vários dispositivos ou mudanças frequentes de aparelho e IP podem acionar sistemas antifraude. Não há base para dizer que isso "mostra legitimidade". Sugiro remover ou suavizar: "você pode usar o dispositivo que for mais confortável".
- ⚠️ "Abrir pesquisas mesmo sem concluir": em muitas plataformas, abandonar pesquisas conta negativamente no histórico, porque aumenta a taxa de desistência. Conferir as regras das plataformas indicadas e revisar a orientação.
- Coerência com a Aula 02: esta aula reforça a coerência e a veracidade. Ela diz que os critérios demográficos não são algo que se controla, o que é bom. Mas a frase final, "quanto mais alinhado o seu perfil estiver com o que o mercado busca, mais chances", pode ser lida como incentivo a ajustar dados, como na Aula 02. Reforçar que o perfil deve ser verdadeiro.
- Erros de transcrição: "boot" (é "bot"), "cópia disponível" (provavelmente "cota disponível").

### V1.M09.A04 — Ganhos Reais com Pesquisas: A Estratégia Oculta (7)

- 🚨 CRÍTICO: incentivo a declarar dados falsos. A aula diz "estratégia não é enganar", mas logo depois orienta a:
  - tratar renda, profissão, hábitos e estilo de vida como "ajustáveis" e "definir quem você pode ser dentro do mercado";
  - valorizar "CEP de áreas nobres" e "perfis de gestão com renda de R$ 5 a 10 mil";
  - "sempre marcar que é responsável pelas compras da casa", mesmo que não seja.
- Na prática, é mentir no cadastro. Isso:
  - viola os termos de uso das plataformas de pesquisa, que exigem informações verdadeiras;
  - leva a bloqueio de conta e perda do saldo ou dos pontos, justamente o que a Aula 03 alerta;
  - prejudica as empresas que pagam pela pesquisa com base num público real;
  - expõe a marca a reclamações e questionamentos.
- É o mesmo problema da Aula 02, agora mais explícito. Recomendo reescrever a Parte 4 com prioridade máxima: perfil completo e verdadeiro, destacando hábitos reais de consumo.
- Contradição interna: "Mentir ou inventar informações compromete sua credibilidade e pode eliminar você do mercado" aparece na mesma aula que manda ajustar renda e profissão.
- Frase confusa sobre renda: "quantas pessoas que ganham acima de R$ 20 mil por mês responderiam pesquisas que pagam R$ 1 ou R$ 2 por mês? Mas eu sou uma dessas pessoas." Pode passar a impressão de que a Gabriela ganha mais de R$ 20 mil por mês, e o "R$ 1 ou 2 por mês" provavelmente era "por pesquisa". Revisar.
- Relato de ganho modesto: R$ 200 a R$ 300 por mês é realista e ajuda a calibrar expectativas. Mas destoa das promessas de outros módulos, como os R$ 7.800 da [nome] no M06 e os "até R$ 10 mil" do M08.
- Erros de transcrição: "mais acentos" (é "mais aceitos"), "boot" (é "bot"), "compras a casa" (é "da casa").

### V1.M09.A05 — Como Transformar Suas Opiniões em Renda Consistente (4)

- Links das plataformas: confirmar onde ficam e quais são. A aula não cita nomes. Conferir se são as mesmas plataformas da Aula 02 (GrabPoints, AttaPoll etc.) e se algum link é de indicação (afiliado). Se for, avaliar se isso deve ser informado às alunas.
- "Grupos e comunidades compartilham filtros": não fica claro o que são "filtros". Se forem respostas prontas para passar pelas perguntas de triagem, isso configura dar informação falsa, o mesmo problema das Aulas 02 e 04. Confirmar o que circula nos grupos.
- Aula de transição: o conteúdo é introdutório. As plataformas propriamente ditas vêm nas aulas seguintes.
- Erro de transcrição: "se inscrever com o Estratégia" (é "com estratégia"). "Os sucessos estão nos detalhes" (é "o sucesso está nos detalhes").

### V1.M09.A06 — Transforme Cliques em Dinheiro com GrabPoints (5)

- ⚠️ "Concluir ofertas… até realizar compras online": algumas "ofertas" exigem gastar dinheiro ou assinar serviços, às vezes com cobrança recorrente depois do período grátis. Para o público do curso, em busca de renda, isso pode gerar prejuízo. Recomendo acrescentar um aviso: evitar ofertas que exigem pagamento, cartão ou assinatura. Isso também está alinhado ao "nunca forneça dados de cartão" da Aula 04.
- Baixar aplicativos: avisar a aluna para desinstalar os apps que não usar e prestar atenção às permissões pedidas.
- Dados da plataforma: saque mínimo de US$ 3, meios de resgate e disponibilidade no Brasil vêm da gravação. Conferir no site do GrabPoints.
- Link de indicação: se o link oferecido na área de membros for de indicação da Gabriela ou do método, a própria aula mostra que isso gera pontos para quem indica. Avaliar se isso deve ser informado às alunas.
- Sem valores de ganho: a Gabriela diz ter tido "ganhos reais", sem números. Não prometer valores no suporte.

### V1.M09.A07 — AttaPoll na Prática: Como Lucrar com Pesquisas no Celular (4)

- Nome falado errado: a gravação diz "Atapal" o tempo todo. Uma aluna que pesquisar esse nome na loja de apps pode não achar o app ou cair num app falso. Vale uma legenda ou um texto de apoio com o nome AttaPoll e o link oficial.
- Dados do app: saque mínimo, meio de pagamento, "pagamentos pontuais" e "suporte rápido" vêm da gravação. Conferir no app.
- Indicação com porcentagem dos ganhos: se o link da área de membros for de indicação do método, avaliar se isso deve ser informado às alunas (mesmo ponto da aula do GrabPoints).
- Sem valores de ganho: a Gabriela cita "ganhos reais" sem números. Não prometer valores no suporte.

### V1.M09.A08 — Ganhos Diretos via PIX: Descubra o Falaí (5)

- ⚠️ Nome e endereço oficial: a transcrição traz "Fala.i", e a Aula 02 traz "Falaí". Confirmar o nome e o site oficial e colocá-los como texto de apoio na aula, para a aluna não cair em sites parecidos.
- ⚠️ Relato de "mais de R$ 200 em um único dia": é um valor alto para pesquisas remuneradas e destoa dos próprios pontos de atenção da aula ("valores baixos", "nem sempre há pesquisas") e da Aula 04 (R$ 200 a R$ 300 por mês no começo). Pode criar expectativa irreal. Sugiro contextualizar (por exemplo, se foi uma entrevista ou pesquisa VIP) ou remover.
- Regras de saque não informadas: a aula diz "pagamento instantâneo", mas não fala de valor mínimo nem de dados exigidos para o Pix. Conferir.
- Programa de indicações: mesmo ponto das aulas do GrabPoints e do AttaPoll. Se o link oferecido for de indicação do método, avaliar se isso deve ser informado às alunas.
- Erro de transcrição: "recebi um pique de mais de 200 reais" provavelmente é "um Pix de mais de 200 reais".

### V1.M09.A09 — Ganhe em Dólares com o Voissy (4)

- ⚠️ "Use o CEP no cadastro": a orientação ficou incompleta ou ambígua na transcrição. Se no vídeo for algo como "use um CEP de determinada região" para receber mais pesquisas, é o mesmo problema de dados falsos das Aulas 02 e 04 (lá, "CEP de áreas nobres abrem mais portas"). Conferir no vídeo. A orientação correta é informar o CEP verdadeiro.
- Nome falado errado: a gravação diz "Voice" o tempo todo, mas o título diz Voissy. A aluna pode buscar "Voice" na loja e não encontrar o app, ou instalar outro. Vale uma legenda ou texto de apoio com o nome e o link oficial. Na Aula 02, o app pode ter aparecido como "Vento".
- Dados do app: saque mínimo de US$ 4 e pagamento via PayPal vêm da gravação. Conferir no app.
- Gênero: "você está pronto", "você ser avisado". O público é feminino.

### V1.M09.A10 — Como Lucrar com Pesquisas e Missões Criativas na MeSeems (5)

- Nome falado errado: a gravação diz "Missense" o tempo todo, mas o nome é MeSeems. Vale uma legenda ou texto de apoio com o nome e o link oficial.
- Dica das 17h: a regra "sacar às 17h em ponto" vem da gravação e pode ter mudado, pois costuma estar ligada a um estoque diário de recompensas. Conferir na plataforma antes de repassar como regra.
- Loja de recompensas: conferir as opções atuais (Pix, recarga, livros) e o valor mínimo de troca.
- Missão "convidar amigos": mesmo ponto das aulas do GrabPoints, AttaPoll e Falaí. Se houver link de indicação do método, avaliar se isso deve ser informado às alunas.
- Erro de transcrição: "picks" é Pix.

### V1.M09.A11 — Como Ser um Agente Secreto do Consumo na Modatta (5)

- ⚠️ Compartilhamento de dados pessoais: a aula afirma que "a privacidade é garantida". É uma afirmação absoluta sobre um serviço de terceiros. Sugiro:
  - trocar por algo como "segundo a plataforma, os dados são criptografados e anonimizados";
  - orientar a aluna a ler a política de privacidade, entender quais dados cada conexão libera e saber que pode revogar o acesso (direito previsto na LGPD);
  - lembrar que conectar redes sociais pode dar acesso a informações de terceiros, como amigos e contatos.
- Título pode confundir: "agente secreto do consumo" sugere cliente oculto, mas a Modatta funciona com compartilhamento de dados e missões, não com visitas presenciais.
- Nome falado errado: a gravação diz "Modata". Vale uma legenda ou texto de apoio com o nome e o link oficial.
- Dados do app: pagamento via Pix, pontos de boas-vindas e o processo de validação vêm da gravação. Conferir no app.
- Gênero: "ganha sendo você mesmo". O público é feminino.

### V1.M09.A12 — Ysense: O Clássico das Pesquisas Remuneradas (6)

- ⚠️ Moeda e saque mínimo provavelmente incorretos: a aula diz que o ySense paga em euros, com saque mínimo de € 10. Fontes externas de 2026 apresentam os valores em dólares (US$) e citam mínimos diferentes por método. Por exemplo,The Budget Diet (https://www.thebudgetdiet.com/is-ysense-legit) fala em US$ 25 para PayPal e US$ 15 para gift cards. Conferir na página oficial de saques e corrigir a aula ou incluir um texto de apoio.
- ⚠️ "Ofertas pagas rendem mais que pesquisas": assim como no GrabPoints (Aula 06), muitas "ofertas" pedem cadastro com cartão, assinatura ou compra. Recomendo um aviso para evitar ofertas que exigem pagamento ou cartão.
- "O câmbio multiplica os seus ganhos": é verdade que o valor em moeda estrangeira vira mais reais, mas há taxas de conversão (do PayPal, por exemplo). Evitar passar a ideia de ganho maior "de graça".
- Indicação com comissão: mesmo ponto das outras plataformas. Se o link da área de membros for de indicação do método, avaliar se isso deve ser informado às alunas.
- Nome falado errado: a gravação diz "iSense".
- Erros de transcrição: "cartões preparos" (é "pré-pagos"), "pesquisas imuneradas" (é "remuneradas").
Fontes:The Budget Diet – Is ySense legit? (https://www.thebudgetdiet.com/is-ysense-legit) ·SwiftSalary – ySense (2026) (https://www.swiftsalary.com/platform/ysense/)

### V1.M01.A01 — Aula de Boas-Vindas (3)

- Parcela do plano trimestral (12x de R$ 19,00): é possível erro de transcrição.
- A aula não diz se o teste de 30 dias passa automaticamente para a cobrança de R$ 97/mês. Confirmar a regra de renovação e cancelamento.
- A aula fala em "Pix nas próximas 24 horas". É uma promessa de resultado, com atenção se for usada em respostas do suporte.

### V1.M10.A01 — O Código das Demandas no Vinte Pila (5)

- ⚠️ Nome de outro produto na gravação: a aula fala várias vezes em "mentoria projetos remunerados", e não em Método Sócia Invisível. Parece gravação reaproveitada de outra oferta, o mesmo padrão do "Método GV" em módulos anteriores. As alunas podem estranhar.
- Taxas e recebimento não informados: a aula não diz quanto o Vinte Pila cobra sobre cada venda nem como e quando o dinheiro é liberado e sacado. Conferir no site da plataforma. Nas outras plataformas, a taxa gira em torno de 20%, e isso pesa num serviço de R$ 20.
- "Respostas automáticas em WhatsApp": é um serviço mais técnico (configurar automações) do que os outros exemplos. Conferir se alguma aula ensina isso.
- Promessa: "muitas executivas começam com R$ 20 e em poucos meses oferecem pacotes muito maiores" é uma afirmação sem comprovação, mas moderada.
- Erros de transcrição: "Jigs" (é "gigs"), "projetos e munerados" (é "remunerados"), "Você já está à por estar aqui" (trecho truncado).

### V1.M10.A02 — Construindo Sua Vitrine Digital no Vinte Pila (6)

- ⚠️ Falta o passo principal: publicar o serviço (gig). A Aula 01 prometeu que esta aula ensinaria a "criar uma oferta de serviço estratégica" e a "montar uma bio que chama atenção". Esta aula só mostra o cadastro e o perfil básico. Sem publicar um serviço, a aluna não aparece para os clientes. Resolvido na Aula 04 deste módulo (Cadastro Inteligente de Demandas), que mostra "Criar serviço".
- "Parceira de oportunidade": confirmar se existe parceria comercial entre o método e a Vinte Pila, como afiliação ou comissão, e se isso deve ser informado às alunas.
- Endereço no cadastro: a plataforma pede o endereço completo. Isso está alinhado ao cadastro de uma plataforma de pagamento, mas vale lembrar a aluna de só fornecer esses dados no site oficial.
- Taxas e prazo de repasse: a aula não informa a comissão da Vinte Pila nem quando o dinheiro cai na conta.
- Outro produto na gravação: a aula menciona de novo a "Mentoria Projetos Remunerados" (transcrita como "Projetos Enumerados").
- Aula emendada: a gravação junta duas partes ("nessa próxima aula como configurar seu perfil… de onde a gente parou?").

### V1.M10.A03 — O Ciclo da Realização: Como Receber (3)

- Aula repetida: o conteúdo é o mesmo da Parte 3 da Aula 02 deste módulo. A única informação nova é o alerta de que o erro não pode ser corrigido. Avaliar se vale unificar as duas.
- "Não tem como consertar depois": confirmar com a Vinte Pila se é isso mesmo ou se o suporte da plataforma consegue alterar. Essa é uma dúvida provável no suporte.
- O título promete "Como Receber", mas a aula só mostra o cadastro bancário. O saque aparece na Aula 05 deste módulo (mínimo de R$ 80, processado às quartas-feiras). Nenhuma das duas aulas diz quando o pagamento é liberado (depois da entrega? depois da aprovação do cliente?) nem qual é a taxa da plataforma.

### V1.M10.A04 — Cadastro Inteligente de Demandas (5)

- ✅ Cobre a lacuna da Aula 02 deste módulo, que não mostrava como publicar o serviço.
- Título pouco claro: "Cadastro Inteligente de Demandas", mas o conteúdo é criar serviço + buscar oportunidades. Algo como "Como Conseguir Microprojetos na Vinte Pila" seria mais claro.
- Limite de propostas: a aula não diz quantas propostas cada oportunidade aceita. Conferir na plataforma.
- Próxima aula: promete ensinar a "enviar uma proposta direto para o contratante". Conferir se é diferente da Opção 2 desta aula.
- Taxa da plataforma: continua sem informação sobre quanto a Vinte Pila desconta de cada venda.

### V1.M10.A05 — Mapeamento Inteligente: Identificando Demandas Lucrativas (6)

- ✅ Completa a Aula 03 ("Como Receber"), que não explicava o fluxo de saque.
- ⚠️ Saque mínimo de R$ 80 × serviços de R$ 20: com serviços de R$ 20, e já com os descontos da plataforma, a aluna precisa de pelo menos 4 a 5 vendas para sacar a primeira vez. Vale deixar isso claro para não gerar frustração.
- Proposta sem descrição: a aula diz que "não precisa fazer uma proposta mesmo", só valor e prazo. Isso contradiz a importância dada à proposta no Bônus 01 do M07. Se a plataforma permitir mensagem, vale recomendar uma mensagem curta e personalizada pelo chat.
- Taxa da plataforma: a aula mostra que existem "descontos da plataforma", mas não informa o percentual. Conferir e documentar.
- Título repetido: "Mapeamento Inteligente: Identificando Demandas Lucrativas" é o mesmo título do M07 A04 e do M08 A04, mas aqui o conteúdo é proposta + saque. Um título como "Proposta, Conversa e Saque na Vinte Pila" seria mais claro.
- Regras de saque sujeitas a mudança: o mínimo de R$ 80 e o processamento às quartas vêm da gravação. Conferir na plataforma.

### V1.M10.A06 — Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos (5)

- ⚠️ Títulos trocados com a Aula 07: o título promete ensinar follow-up, mas a aula traz hacks para começar a vender. O conteúdo de follow-up está na Aula 07, cujo título é "Hacks Avançados para o Vinte Pila". Os títulos das Aulas 06 e 07 estão invertidos. Sugiro trocá-los na área de membros.
- ⚠️ "Me chama no privado" (Hack 3): divulgar nas redes e levar a conversa para o privado pode fazer a venda acontecer fora da plataforma, sem a proteção de pagamento da Vinte Pila. Pode também ir contra as regras dela, como vimos no Workana (M08 A02). Sugiro orientar a divulgar o link do serviço na Vinte Pila em vez de "me chama no privado".
- Pacotes com desconto × precificação por valor: "3 revisões por R$ 50" e "5 planilhas por R$ 100" são pacotes com preço unitário menor. Faz sentido no começo, mas contrasta com o Bônus 1 do M08, em que o pacote serve para aumentar o valor. Deixar claro que é uma estratégia inicial.
- Gênero: "eu fico super grato", "Supremo", "comprometido". O público é feminino.
- Erros de transcrição: "lista de contados" (é "contatos"), "eu sei ditar rápido" (é "digitar"), "Agora que você já sabe o que pode aparecer" (é "oferecer"), "Poste essa oferta do Vinte Pila" (é "no Vinte Pila").

### V1.M10.A07 — Bônus: Hacks Avançados para o Vinte Pila (6)

- ⚠️ Títulos trocados: o conteúdo desta Aula 07 corresponde ao título da Aula 06 ("O Poder do Follow-up: Como Transformar Silêncio em Contratos"), e vice-versa. Sugiro trocar os títulos na área de membros. O nome do arquivo ("MOD 10 – AULA 5") também não bate com a numeração.
- ⚠️ "Variar o canal" (e-mail, WhatsApp, ligação): dentro da Vinte Pila, do Workana e do 99Freelas, a aluna normalmente não tem o contato externo do cliente, e trocar contatos pode levar a bloqueio (aviso do Workana, M08 A02). Nas plataformas, o follow-up deve ser feito pelo chat da própria plataforma. A dica de variar o canal vale só para clientes diretos.
- Intervalos diferentes entre as aulas: aqui, 2 a 3 dias. No M07, 48 h. No M08, 48 h e depois 1 semana. São próximos, mas vale padronizar.
- Estatística sem fonte: "80% das vendas e contratações acontecem depois do quinto contato".
- Gênero: "sem ser invasivo", "comprometido". O público é feminino.
- Erros de transcrição: "falô-lô" (é "follow-up"), "transformar oportunidades encontradas" (provavelmente "em contratos").

### V1.M11.A01 — O Código das Demandas no GETNINJAS (6)

- ⚠️ Custo para acessar clientes não mencionado: a aula diz que a aluna "tem acesso aos pedidos e pode entrar em contato". Segundo o blog oficial do GetNinjas, o cadastro e a visualização dos pedidos são gratuitos, mas é necessário comprar moedas para liberar o contato dos clientes e responder pedidos. O preço varia conforme o tipo de serviço e a região. Em compensação, não há comissão: o valor fica 100% com o profissional. Para um público que busca renda e tem pouco dinheiro, isso precisa estar claro, porque a aluna pode gastar em moedas e não fechar nenhum serviço.
- ⚠️ Pagamento direto = mais risco de calote: como o pagamento não passa pela plataforma, não há custódia. Vale orientar a aluna a combinar tudo por escrito e considerar pagamento parcial antecipado (como na Aula 04 do M04, Ciclo de Pagamento).
- Perfil da plataforma: o GetNinjas é bem conhecido por serviços presenciais (reformas, aulas, eventos, beleza etc.). A aula destaca serviços digitais. Conferir se há volume de pedidos de suporte administrativo e serviços digitais para quem trabalha de casa.
- Nome de outro produto: a gravação fala de novo em "Mentoria Projetos Remunerados" (transcrita como "Imunerados").
- Nome da plataforma transcrito errado: "Netlinx" e "agatininhas". Conferir no vídeo se a pronúncia está clara.
- Promessa: "se destacar logo nas primeiras semanas" e "faturamento rápido". Moderar.
Fonte:Blog GetNinjas – O GetNinjas é pago ou gratuito? (https://blog.getninjas.com.br/o-getninjas-e-pago-ou-gratuito/)

### V1.M11.A02 — Construindo Sua Vitrine Digital no GETNINJAS (6)

- Título × conteúdo: o título promete "Construindo Sua Vitrine", mas a aula mostra só o cadastro. Não há edição de perfil, descrição, foto nem serviços oferecidos. Conferir se isso aparece em outra aula do módulo.
- Categorias presenciais em destaque: a tela de categorias mostra muitas opções presenciais (reforma, serviços domésticos, eventos, beleza, automóveis). Vale orientar a aluna a escolher categorias compatíveis com trabalho remoto, que é a proposta do curso.
- Subcategoria "profitagem": erro de transcrição. Conferir no vídeo qual subcategoria foi mostrada.
- Custo das moedas: a aula não menciona. Ver o ponto a validar da Aula 01 deste módulo.
- Nome de outro produto: a gravação fala de novo em "mentoria Projetos Remunerados" (transcrita como "Imunerados") e chama o GetNinjas de "parceira de oportunidades". Confirmar se há parceria comercial.
- Erro de transcrição: "procurar um único projeto" provavelmente é "procurar microprojetos". "CMPJ" é CNPJ.

### V1.M11.A03 — Fazendo Demandas Mobile: App GETNINJAS (5)

- ⚠️ Custo das moedas sem orientação: a aula mostra que liberar pedido custa moedas e incentiva a comprar mais "para ter mais chance de fechar", mas não informa preços e não orienta como escolher bem os pedidos para não gastar à toa. Para o público do curso, isso é um risco de prejuízo. Sugiro acrescentar: começar com poucos pedidos, escolher os que combinam com as suas habilidades, conferir o custo em moedas antes de liberar e responder rápido. Confirma o ponto levantado na Aula 01 deste módulo, que não mencionava esse custo.
- "Exclusividade" não explicada: a opção aparece na tela, mas a aula não diz o que é nem quanto custa.
- Depoimentos da loja de apps: a aula lê avaliações do app ("nunca fiquei parado", "conquistei liberdade financeira"). São avaliações de terceiros e não devem virar promessa de resultado.
- Mais uma sigla de outro produto: "Mentoria MPR" (Mentoria Projetos Remunerados).
- Texto confuso no final: "todos os outros pedidos aqui, que a gente já viu ali na próxima aula".

### V1.M11.A04 — O Ciclo da Realização: Como Receber (5)

- ⚠️ Risco de calote não mencionado: a aula apresenta a falta de intermediação só como vantagem ("sem taxa", "recebe no mesmo dia"). Não diz que, sem intermediação, não há proteção contra calote. A dica dos 50% ajuda, mas vale explicitar o risco e acrescentar: combinar por escrito e entregar o final só depois de receber.
- ⚠️ Incentivo à compra de moedas: "vamos investir aí nas moedas, compensa bastante", com base em avaliações da loja de apps. É uma promessa implícita de retorno. Para o público do curso, recomendo tom mais cauteloso (ver a Aula 03 deste módulo).
- Exemplo mais técnico: o pedido mostrado é edição de vídeo para YouTube (10 a 30 min), que exige habilidade e ferramentas específicas. Conferir se o curso ensina isso ou se o exemplo deveria ser mais simples.
- Frase confusa na transcrição: "para falar com um profissional que está ali pedindo" deveria ser "cliente".
- Coerência com a Aula 04 do M04: a recomendação de 50%/50% está alinhada ao "pagamento por etapas" do Ciclo de Pagamento (M04 A04). Bom ponto de consistência.

### V1.M11.A07 — Bônus: Hacks Avançados para o GETNINJAS (8)

- ✅ Hack 1 é importante: é a primeira vez que o módulo orienta a não gastar moedas à toa. Vale destacar esse hack logo na Aula 03, que mostra a compra de moedas sem esse cuidado.
- ⚠️ Mensagens-modelo com experiência inventada: os templates dizem "sou especialista", "já ajudei outras pessoas a resolverem problemas parecidos" e "tenho experiência nesse tipo de trabalho e garanto qualidade". Para uma iniciante, essas frases são falsas. É o mesmo problema dos bônus dos M07 e M08. Orientar a adaptar à realidade: por exemplo, "estou começando e vou me dedicar ao seu projeto".
- ⚠️ Escassez artificial (Hack 7): "as vagas são limitadas", quando não são, é falsa urgência. Pode ser vista como prática enganosa. Sugiro trocar por algo verdadeiro, como "posso começar hoje".
- Recursos da plataforma a confirmar: a aula afirma que o GetNinjas permite fazer perguntas antes de enviar proposta (Hack 3), reativar contatos antigos (Hack 6) e ver tendências por região (Hack 11). A Aula 03 mostrou que o contato com o cliente só é liberado depois de gastar moedas. Conferir se esses recursos existem no app atual.
- Horários de maior movimento: afirmação sem fonte. Tratar como dica.
- Aulas 05 e 06 do módulo: ainda não foram documentadas. Conferir se existem e enviá-las.
- Erros de transcrição: "GetNinhas" (é GetNinjas), "ticket manager" (é "ticket médio"), "E sou com uma promoção especial, porque você faz" (trecho confuso, provavelmente "estou com uma promoção especial para você").
- Gênero: "familiarizado", "comprometido". O público é feminino.

### V1.M12.A01 — O Código das Demandas no VINTE CONTO (5)

- 🚨 Reputação da plataforma: no Reclame Aqui, a Vinte Conto aparece sem reputação definida, com poucas reclamações, 0% de taxa de resposta, empresa não verificada, e queixas de atraso em pagamentos e saques e falta de canais de atendimento (consulta em setembro/2026). Há ainda uma reclamação intitulada "Vinte Conto prejudica clientes e freelancers". O volume é pequeno, mas a Aula 04 do M09 manda justamente checar a reputação antes de se cadastrar. Recomendo avaliar se vale manter esta plataforma no curso ou acrescentar um alerta.
- ⚠️ Modelo de funcionamento divergente: a aula diz que empresas publicam projetos e a aluna se candidata. Um guia externo descreve o Vinteconto como marketplace em que a freelancer publica os seus serviços (a partir de R$ 20, com extras), com taxa de 12% por serviço e pagamento liberado 7 dias depois da conclusão, além de cobrança de R$ 5 para destacar o anúncio. Conferir no site oficial qual é o modelo atual.
- ⚠️ Promessa de ganho: "muitas executivas conseguiram os primeiros lucros em menos de uma semana" e "pagamento rápido" contrastam com o prazo de segurança de 7 dias citado externamente. A própria aula modera ("talvez você não fature milhares na primeira semana"), o que é positivo.
- ⚠️ Aula de outro curso/ordem diferente: a gravação diz "na última aula, você conheceu a primeira plataforma secreta, a Workana" ("Orkana"), mas no Método Sócia Invisível a aula anterior é o bônus do GetNinjas (M11), e o Workana está no M08. Mais um sinal de gravação reaproveitada da "Mentoria Projetos Remunerados", citada de novo aqui.
- Nome parecido com o Vinte Pila (M10): as alunas podem confundir Vinte Conto com Vinte Pila. Vale um aviso.
Fontes:Reclame Aqui – Vinte Conto (https://www.reclameaqui.com.br/empresa/vinte-conto/) ·Reclame Aqui – "Vinte Conto prejudica clientes e freelancers" (https://www.reclameaqui.com.br/vinte-conto/vinte-conto-prejudica-clientes-e-freelancers_BzCWLPLjvBdvegfI/) ·Desafios e Sucesso – Vinteconto: guia (https://desafiosesucesso.com.br/vinteconto-guia/)

### V1.M12.A02 — Construindo Sua Vitrine Digital no VINTE CONTO (4)

- ⚠️ Contradição com a Aula 01 deste módulo: a Aula 01 disse que "as empresas postam projetos e você se candidata". Esta aula mostra o contrário: a aluna publica os serviços e o cliente vem até ela. Esta versão bate com a descrição externa da plataforma (ver a Aula 01). Corrigir o discurso da Aula 01.
- Reputação da plataforma: ver o alerta da Aula 01 deste módulo (Reclame Aqui: sem reputação, 0% de resposta, queixas de atraso em saques).
- Taxas e prazo de pagamento não informados: segundo fonte externa, a taxa é de 12% por serviço e o pagamento é liberado 7 dias depois. Conferir no site e informar as alunas.
- Nome de outro produto: a gravação fala em "mentoria Projetos Remunerados" (transcrita como "Imunerados").

### V1.M12.A03 — O Ciclo da Realização: Como Receber (4)

- ⚠️ Falta a aula de cadastrar os serviços: esta aula começa dizendo "agora que a gente já aprendeu a se cadastrar e também a cadastrar os nossos microprojetos", mas a Aula 02 terminou prometendo esse conteúdo para a aula seguinte, que é esta, e ele não aparece aqui. Parece faltar uma aula (ou ela está em outra posição) sobre como publicar os serviços no Vinte Conto. Sem isso, a aluna não aparece para os clientes.
- Taxa e prazo vagos: "pode acontecer de cobrarem… pode acontecer deles nem cobrarem". O suporte precisa de uma informação certa. Conferir no site a taxa e o prazo de liberação.
- Reputação da plataforma: ver o alerta da Aula 01 deste módulo, com queixas de atraso em saques no Reclame Aqui. É relevante justamente para esta aula de recebimento.
- Nome do arquivo da transcrição: veio como "original (1)", sem o título da aula. Conferir se é mesmo a transcrição correta.

### V1.M12.A04 — Cadastro Inteligente de Demandas (5)

- Ordem das aulas: esta aula deveria vir antes da Aula 03 (Como Receber), que começa dizendo que a aluna "já aprendeu a cadastrar os microprojetos". Sugestão: trocar a ordem das Aulas 03 e 04.
- "Divulgação constante" sem explicação: a aula diz que o segredo é divulgar, mas não ensina como divulgar o serviço (redes sociais, grupos, link do perfil). Conferir se isso aparece em outra aula.
- Exemplo de preço confuso: "R$ 20 por cliente que você atenda no WhatsApp" não deixa claro se é por atendimento, por dia ou por mês. Um exemplo mais objetivo evitaria dúvidas.
- Descrição copiada das "notas": a aula cola um texto pronto sem mostrá-lo. Vale disponibilizar esse modelo de descrição como material de apoio.
- Taxa e reputação: ver as Aulas 01 e 03 deste módulo.

### V1.M13.A02 — Construindo Sua Vitrine Digital no FREELANCER (5)

- Orientação de foto divergente: esta aula pede foto com rosto visível, sorrindo e bem iluminada, mas a Aula 04 deste módulo diz "uma foto qualquer mesmo". Padronizar pela orientação desta aula.
- Descrição pronta: a aula cola um texto do bloco de notas sem mostrá-lo. Vale disponibilizar um modelo como material de apoio.
- Idioma "inglês": orientar a aluna a só marcar idiomas que realmente domina, porque clientes podem cobrar isso.
- Frase confusa: "eu quero trabalhar, que é pra gente poder contratar as nossas empresas" provavelmente é "para as empresas nos contratarem".
- Ordem das aulas: esta aula termina dizendo que a próxima mostra "como encontrar os microprojetos", mas isso está na Aula 04. A Aula 03 trata de completar os dados para saque.

### V1.M13.A03 — O Ciclo da Realização: Como Receber (5)

- ⚠️ Aula 02 do módulo não documentada: a transcrição enviada para "Construindo Sua Vitrine Digital no FREELANCER" era a do Vinte Conto. Falta a transcrição correta, ou o vídeo publicado está errado. Esta aula pressupõe que a aluna já criou a conta.
- Título × conteúdo: o título promete "Como Receber", mas a aula só libera o saque ao completar os dados. O meio de saque (PayPal, transferência) e as taxas ficam para a aula seguinte.
- Abertura desencontrada: a aula começa dizendo que vai "configurar o perfil para deixá-lo mais atrativo", mas na prática trata de dados cadastrais para saque.
- Complementa a Aula 01: a Aula 01 dá a entender que o site é em inglês, mas esta mostra que dá para usar em português. Isso ajuda a responder "preciso saber inglês?".
- Nome de outro produto: a gravação fala de novo em "Mentoria Projetos Remunerados".

### V1.M13.A04 — Mapeando as Melhores Demandas para o Seu Perfil (9)

- ⚠️ "Patrocinar a oferta" e "melhorias" são pagos: a aula apresenta essas opções como "tudo isso a Freelancer te dá", sem dizer que custam dinheiro. Orientar a aluna a não pagar por destaques no início.
- ⚠️ Exemplo contradiz a Aula 01: a Aula 01 diz que não é preciso inglês fluente, mas o projeto mostrado exige "bom inglês falado" para acompanhar reuniões. Sugiro usar um exemplo em português, ou deixar claro que a aluna deve filtrar por idioma e evitar projetos que exigem inglês falado se não tiver essa habilidade.
- "Uma foto qualquer mesmo": contradiz as orientações anteriores (Hack 1 do Bônus 02, M07), que pedem foto profissional. Corrigir.
- "Prazo sempre o menor possível": pode levar a aluna a prometer prazos que não consegue cumprir. A Aula 02 do M04 alerta contra isso. Sugiro "o menor prazo que você consegue cumprir com qualidade".
- PDF de propostas: a aula cita "um PDF aí na aula". Confirmar se o material está anexado.
- Recebimento prometido não aparece: a Aula 03 disse que "na próxima aula" mostraria como preencher os dados de recebimento, mas esta aula trata de busca e propostas. Conferir onde está o cadastro do meio de saque (PayPal, banco).
- Aula 02 ainda faltando: ver a Aula 03 deste módulo.
- Taxas do Freelancer.com: continuam sem menção. Ver a Aula 01.
- Erros de transcrição: "chat EPT" (é ChatGPT), "conselho de esclarecimento" (trecho confuso).

### V1.M13.A05 — Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas (4)

- ⚠️ Storytelling com histórias prontas: os exemplos ("recentemente ajudei uma mulher com um negócio de doces…", "uma pessoa encontrou uma conta prestes a vencer…") são narrados em primeira pessoa, como se fossem da aluna. Uma iniciante que copiar essas histórias estará inventando provas sociais, o mesmo problema dos bônus dos M07, M08 e M11. Reforçar: usar só histórias reais.
- Conteúdo genérico no módulo do Freelancer.com: a aula não cita a plataforma do módulo (internacional, em dólar). Os preços estão em reais e vários exemplos são presenciais (costura, sachê perfumado, manutenção de roupas). Avaliar se ela se encaixa melhor em outro módulo.
- Serviços que exigem habilidade técnica: identidade visual, vídeo com narração e PDF interativo. Conferir se o curso ensina algo sobre isso, ou se remete ao bônus Skills das Subdemandas.
- Erros de transcrição: "por 150 meses" (é "R$ 150 por mês"), "cup" (é "mockup"), "contos da casa" (é "contas da casa"), "renovar o wear da roupa" (trecho confuso), "algo tipo simples" (provavelmente "um logotipo simples").

### V1.M14.A01 — O Chamado Rosa: Conheça o Mundo Wepink (5)

- 🚨 Existe um canal oficial de renda com a WePink para pessoa física? Segundo um guia externo (Adoro Cupom (https://adorocupom.com/blog/revendedora-wepink-como-comecar-fazer-seu-cadastro-e-evitar-golpes/)), não existe programa oficial de revenda porta a porta ou por catálogo para pessoas físicas. A marca vende direto ao consumidor, e os caminhos oficiais seriam atacado para lojistas com CNPJ e franquias, com investimento alto. O mesmo guia alerta para golpes que usam o nome da WePink: falsas vagas de home office, taxas de cadastro e kits com descontos irreais. Antes de publicar o módulo, confirmar com a WePink qual modelo as próximas aulas ensinam (programa de afiliados oficial, revenda informal etc.) e se ele é autorizado pela marca.
- ⚠️ Uso do nome da marca e da Virginia Fonseca: a aula usa a marca e a imagem pessoal da Virginia para vender a "oportunidade". Sem autorização, isso pode sugerir parceria ou endosso que não existem e gerar risco jurídico (uso de marca e de imagem). Confirmar se há autorização.
- Promessa implícita: "se eu consegui, você também consegue" e "abre portas para mulheres como você" sugerem que a marca oferece renda às mulheres. Precisa estar alinhado ao que o módulo de fato ensina.
- Tipo: foi informado como procedimento, mas é uma aula motivacional, sem passos.
- Erro de transcrição: "pegar as redes da sua vida" é "pegar as rédeas".
Fonte:Adoro Cupom – Revendedora WePink: como começar e evitar golpes (https://adorocupom.com/blog/revendedora-wepink-como-comecar-fazer-seu-cadastro-e-evitar-golpes/)

### V1.M14.A02 — Por Dentro da Máquina Rosa: Como Funciona a Wepink (5)

- 🚨 Afirmações sobre uma empresa terceira sem comprovação: a aula garante, em nome da WePink, que ela oferece trabalho a iniciantes, paga "certinho e dentro do prazo", tem campanhas anônimas e oferece recorrência. Não encontrei confirmação pública de um programa de microprojetos pagos da WePink para pessoas físicas. A fonte da Aula 01 diz que não há programa oficial de revenda e alerta para golpes que usam o nome da marca. Se essas afirmações não forem verdadeiras, o curso pode estar fazendo promessa falsa em nome de outra empresa, com risco jurídico e de reclamações. Recomendo confirmar diretamente com a WePink antes de manter o módulo como está.
- Falta explicar o que é o "microprojeto WePink": criar conteúdo (UGC)? Avaliar produtos? Divulgar como afiliada? Sem isso, o suporte não consegue responder à dúvida básica.
- Uso de marca e imagem: mesmo ponto da Aula 01. Usar o nome da WePink e da Virginia Fonseca para apresentar uma "parceria" pode sugerir um endosso que não existe.
- Sigla de outro produto: a gravação chama o curso de "Estratégia MPI" e "mentoria".
- Tipo: foi informado como procedimento, mas a aula é apresentação, sem passos concretos.

### V1.M15.A01 — Magnetismo Natural (2)

- Finalidade do módulo: a aula fala em vídeos para "mensagens curtas, opiniões ou experiências" e "aproveitar uma oportunidade que apareceu", mas não diz como isso gera renda. Pode ser conteúdo UGC, depoimentos, vídeos para marcas ou propostas em vídeo (como no Freelancer.com, M13 A04). Conferir nas próximas aulas e deixar claro na abertura.
- Conteúdo sólido: as técnicas são práticas e não fazem promessas de ganho, o que contrasta positivamente com outros módulos.

### V1.M15.A02 — Conexão Instantânea (3)

- Finalidade do módulo ainda não explicada: assim como na Aula 01, a aula não diz em que tipo de trabalho o vídeo será usado para gerar renda (UGC, depoimentos, propostas em vídeo etc.). Conferir nas próximas aulas.
- "Hipnotizar quem está assistindo": expressão de efeito. Não há problema, mas é exagerada.
- Erros de transcrição: "monótoma" (é "monótona"), "fique com a mão na reta" (é "coluna reta"), "parecer perfeito" (é "perfeita").

### V1.M16.A01 — As Habilidades Mais Procuradas e Como Se Destacar (6)

- ⚠️ "Revisão sem grande domínio da língua, com ChatGPT": oferecer revisão de textos sem dominar o português, dependendo só do ChatGPT, pode gerar entregas com erro e avaliações ruins. Recomendo reforçar que a aluna precisa conferir o resultado e só oferecer o que consegue garantir.
- ⚠️ "Tradução com conhecimento básico": traduções feitas com conhecimento básico tendem a ter erros. O próprio curso alerta, nos bônus, a não aceitar demandas fora da sua área. Sugiro ressalva.
- Exemplo de descrição com experiência inventada: "revisora com experiência em textos acadêmicos e profissionais" pode levar iniciantes a declarar uma experiência que não têm. Mesmo ponto dos bônus anteriores.
- Plataformas não ensinadas: a aula cita Fiverr e Upwork, que não têm módulo no curso (até onde foi documentado).
- "Módulos complexos": provavelmente "módulos completos". Conferir quais módulos ensinam essas habilidades (Skills das Subdemandas?).
- Erros de transcrição: "orkana" (é Workana), "20 ponto" (provavelmente Vinte Conto), "fiver" (é Fiverr), "informação específica" (provavelmente "formação específica").

### V1.M02.A01 — Quem é a Gabriela e por que ela entende sua realidade (4)

- Tipo da aula: foi informado como procedimento, mas o conteúdo é uma história pessoal sem passos práticos. Sugiro reclassificar como apresentação ou história.
- Nome do produto na gravação: a aula diz "Seja muito bem-vindo ao Método GV" e se refere ao produto como "Mentoria". O nome oficial é Método Sócia Invisível. Parece ser uma gravação reaproveitada de outra oferta, e o suporte deve estar preparado se alguma aluna estranhar.
- Gênero: a abertura diz "bem-vindo", mas o público do método é feminino.
- Resultado citado: "os primeiros 5 mil que fiz com a internet" é um relato de resultado pessoal. Evitar usar como promessa em respostas do suporte.

### V1.M02.A02 — A tribo das Supremas (6)

- Tipo da aula: foi informado como procedimento, mas o conteúdo é de mentalidade e apresentação, sem passos práticos.
- Título e texto não batem: o título fala em "Tribo das Supremas", mas a gravação usa "Círculo das Supremas".
- Liberação em 24 horas: a aula afirma que todo o conteúdo é liberado 24 horas após a decisão. Confirmar se a área de membros realmente tem essa liberação gradual, porque isso gera dúvidas no suporte.
- Reembolso na aula: a gravação oferece reembolso de forma explícita ("eu devolvo todo o seu dinheiro"). Alinhar com a política de reembolso e com o time de retenção.
- Grafia do sobrenome: nesta aula aparece "Vitorino"; na aula anterior, "Vittorino". Definir a grafia oficial.
- Público: a aula fala em "transformar o seu conhecimento em impacto e renda", que é um discurso mais de infoproduto do que de demandas. Pode ser mais uma gravação reaproveitada de outra oferta.

### V1.M02.A03 — A Decisão (6)

- ⚠️ Texto do pedido de reembolso: a gravação manda a aluna escrever "não quero mais esse curso, não quero que Deus seja meu sócio" ao pedir reembolso. Isso coloca uma condição religiosa no reembolso. Esse tipo de condição pode ser contestado pelo CDC (direito de arrependimento de 7 dias, sem exigências), gerar reclamações e expor a marca. Recomendo que o suporte nunca exija essa frase e processe o reembolso normalmente, e que vocês avaliem editar esse trecho do vídeo.
- Alunas não cristãs ou sem religião: a aula condiciona o sucesso a convidar Deus como sócio ("se você não convidar… você não vai prosperar"; "eu não quero você aqui"). Definir uma resposta padrão acolhedora para quem não se identificar com isso.
- Liberação das próximas aulas em 24 horas: esta aula e a Aula 02 falam em liberar o conteúdo depois da decisão. Confirmar se a plataforma tem essa liberação gradual. Se não tiver, vai gerar confusão.
- Comentários: confirmar se a área de membros tem campo de comentários abaixo da aula.
- Outros produtos na gravação: "você não está criando um roteiro qualquer" e "comunidade que mais forma mulheres e homens supremos" parecem vir de outra oferta ou gravação reaproveitada.
- Trecho truncado: a passagem do jovem rico ficou incompleta na transcrição ("e diz, Então Jesus responde,"), sem a fala citada.

### V1.M03.A01 — Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas (6)

- Tipo: foi informado como procedimento, mas esta aula é só história e motivação.
- ⚠️ Título não confere com a gravação:
  - A transcrição não menciona "3 milhões em 12 meses".
  - A transcrição não fala em sair do CLT. Ela diz que a Gabriela parou de trabalhar para cuidar do filho. (Na Aula 02 do Módulo 02, quem saiu do CLT foi o marido.)
  - Revisar o título ou garantir que a promessa tenha respaldo.
- Promessas de ganho: "não só R$ 200 por dia, mas muito mais" e o "3 milhões" do título são promessas de resultado. Atenção a compliance e às políticas de anúncio.
- Nome do produto: a gravação usa de novo "método GV", mesmo problema da Aula 01 do Módulo 02.
- "Vender sem investimentos exorbitantes": o verbo "vender" soa como outra oferta (infoproduto ou afiliado), não como demandas. É mais um indício de gravação reaproveitada.
- "FIFA": provável erro de transcrição na lista de tentativas. Conferir no vídeo.

### V1.M03.A02 — A Trilha da Sua Liberdade (4)

- Tipo: a aula é principalmente de mentalidade. O "procedimento" se resume às orientações de rotina e ao uso pelo celular.
- ⚠️ Suporte 24/7: a aula promete suporte no WhatsApp "24 horas por dia, 7 dias por semana, incluindo finais de semana e feriados". A Aula de Boas-Vindas diz "a gente responde rapidinho e todos os dias". Confirmar se o atendimento é realmente 24 horas. Se não for, a promessa vai gerar reclamações.
- "Baixa a versão web do seu celular": a frase é confusa, porque versão web não se baixa, se acessa pelo navegador. Se houver uma ferramenta específica (a Sofia, por exemplo), vale deixar isso claro numa aula ou num material de apoio.
- Gancho da próxima aula: a aula termina prometendo mostrar "o que você está perdendo dando voz às suas inseguranças", o que sugere mais uma aula de mentalidade antes da parte prática.

### V1.M03.A03 — Quanto custa NÃO começar hoje (5)

- Tipo: a aula é de mentalidade. O "procedimento" se resume ao exercício de visualização e à decisão de começar.
- Suporte 24/7: a promessa se repete, agora como "suporte individual no WhatsApp, 24 horas por dia, 7 dias na semana". Confirmar se é real (ver também a Aula 02 deste módulo).
- Prazo de resultado: esta aula não dá prazo. Já a Aula de Boas-Vindas fala em "Pix nas próximas 24 horas". Vale alinhar o discurso.
- Nome do produto: a gravação usa "método do GV" de novo.
- Erros de transcrição a conferir: "bumbi" e "não tenho básico".

### V1.M03.A04 — Home Office Master & Produtividade Inteligente (3)

- "Enviar 20 propostas": o exemplo parece de freelancer ou de outra oferta. Não fica claro se "propostas" se aplica às demandas do método. Vale conferir se o termo aparece nas aulas práticas.
- Gênero: a aula começa com "Seja muito bem-vindo", como em aulas anteriores.
- Erros de transcrição: "por bens" (é "por vez") e "escreva os que eu proposto" (é "escreva o seu propósito").

### V1.M06.A01 — A Mentira que Contaram Sobre Suas Habilidades (4)

- Título diferente: na área de membros, "A Mentira que Contaram Sobre Suas Habilidades". No PDF, "Mapeando Seus Superpoderes Cotidianos". Padronizar.
- ⚠️ Escopo das "demandas" ampliado ainda mais: o Círculo 1 sugere serviços presenciais (chef, babá, paisagista, designer de interiores, personal organizer) e o Círculo 5 sugere coaching e consultoria. Isso vai além do trabalho remoto pela internet prometido nas aulas anteriores e do modelo de opinião de consumidora com a Sofia (M01). Alunas podem ficar confusas sobre o que o método ensina de fato.
- Promessa de ganho: [nome] com R$ 7.800/mês, apresentada como "história real". Mesmo cuidado de compliance das aulas anteriores.
- Tabelas de preço sem fonte (personal organizer, chef, babá etc.): conferir se os valores ainda correspondem ao mercado ou deixar claro que são apenas referências.

### V1.M06.A02 — Traduzindo a Rotina para o Mercado Digital (5)

- Título diferente: na área de membros, "Traduzindo a Rotina para o Mercado Digital". No PDF, "Transformando Habilidades em Linguagem de Mercado", e a capa tem o erro de digitação "Transformanfo".
- ⚠️ Títulos profissionais: o material incentiva a aluna a se apresentar como "chef particular", "especialista em limpeza profissional" e a chamar o cuidado de crianças de "educação infantil". Vale acrescentar um aviso para não usar títulos de profissões regulamentadas (psicóloga, nutricionista, enfermeira, pedagoga etc.). A Aula 01 também cita "psicóloga, enfermeira" como papéis da mãe.
- Promessas de ganho: [nome] com R$ 10.500/mês e os valores de R$ 150/h e R$ 250 por consultoria. Mesmo cuidado de compliance.
- Casos com o mesmo nome: no M05 A02 existe outra "[nome]", mãe solo e recepcionista. Aqui a [nome] é organizadora de ambientes. Pode parecer inconsistente para a aluna.
- Escopo das demandas: o material sugere de novo serviços presenciais (visitas domiciliares, consultoria presencial, chef, confeitaria), o que vai além do "mercado digital" do título e do modelo com a Sofia do M01.

### V1.M06.A03 — O Seu Inventário de Ouro (4)

- Título diferente: na área de membros, "O Seu Inventário de Ouro". No PDF, "Seu Diferencial como Vantagem Competitiva". O nome "inventário" sugere um exercício de listagem que o material não tem.
- Tipo: foi informado como procedimento, mas o material é conceitual, sem passos nem missão. Sugestão: acrescentar um exercício, por exemplo "marque de 1 a 5 cada diferencial e anote um exemplo real seu", para fazer jus ao título "Inventário".
- Estereótipos de gênero: o material atribui empatia, intuição e multitarefa às mulheres em geral. Isso combina com o tom do curso, mas vale revisar se a abordagem está alinhada com a comunicação da marca.
- Sem promessa de ganho: diferente das aulas anteriores, este material não cita valores. Só diz que "a renda cresceu significativamente".

### V1.M06.A04 — Como Empacotar o que Você Sabe (5)

- Título diferente: na área de membros, "Como Empacotar o que Você Sabe". No PDF, "Criando Seu Primeiro Portfólio com o que Você Já Fez", com a grafia "portifólio".
- ⚠️ Bônus "Skills das Sub Demandas": o PDF promete esse bônus com certificado a todas as alunas. Confirmar se ele existe, se está liberado para todas ou só para quem comprou algum upsell, e onde fica na área de membros. É uma pergunta certa no suporte.
- ⚠️ Portfólio com clientes fictícios: é uma prática legítima para treinar. Mas o exemplo do case traz números de resultado (+40% de seguidores, engajamento de 2% para 8%). Vale orientar a aluna a identificar trabalhos fictícios como "projeto de estudo" e a não inventar métricas, para não enganar clientes.
- Modelo freelancer confirmado: design, social media e organização de eventos reforçam que o conteúdo trata de prestação de serviço, e não do modelo de opinião de consumidora com a Sofia (M01).
- Promessa de "trabalhar ainda esta semana": anunciada para a próxima aula.

### V1.M07.A01 — O Código das Demandas no 99Freelas (5)


Seção "Informações externas sobre o 99Freelas (para conferência)" (fora do bot):

Segundo levantamento em fonte externa (setembro/2026,Wise (https://wise.com/br/blog/99freelas-como-funciona)). Confirmar no site oficial antes de usar no suporte, porque os valores mudam:
| Plano | Mensalidade | Taxa sobre projetos | Observação |
|---|---|---|---|
| Gratuito | R$ 0 | ~20% | Número limitado de propostas por mês (~10) |
| Pro | ~R$ 49,90/mês | ~15% | — |
| Premium | ~R$ 89,90/mês | ~10% | Assinantes veem projetos novos antes (primeiras 24 h) |
- Recebimento: a pessoa entrega o trabalho, o cliente confirma e libera o pagamento, e o 99Freelas transfere o valor para uma conta bancária brasileira cadastrada, num prazo que depende do plano.
- ⚠️ "Totalmente gratuita" não é exato: o cadastro é gratuito, mas existe taxa de intermediação sobre os ganhos e planos pagos que dão vantagem, como acesso antecipado aos projetos. Isso gera frustração e reclamação quando a aluna descobre. Recomendo ajustar o discurso.
- ⚠️ Os exemplos de demanda podem não bater com a plataforma: o 99Freelas é voltado a projetos freelancer (design, textos, programação, marketing, assistência virtual etc.). Tarefas como "avaliar produtos", "testar aplicativos" e "responder pesquisas" são mais típicas de plataformas de pesquisa e microtarefas. "Interagir em redes sociais" pode ferir as regras das redes sociais e da própria plataforma, se for engajamento pago. Conferir o que de fato se encontra no 99Freelas.
- Modelo agora explícito: esta aula confirma o modelo freelancer em marketplace. Isso explica os Módulos 04 a 06 (prazos, clientes, precificação, portfólio), mas conflita com a Aula de Boas-Vindas, em que a Sofia "encontra as demandas das maiores empresas e preenche cadastros" e a aluna só "dá a opinião de consumidora". Definir como a Sofia se relaciona com o 99Freelas, se é que se relaciona.
- Gênero: a aula abre com "Seja bem-vindo".
- Erro de transcrição: "numa sua independência financeira" é "rumo à sua independência financeira".
Fontes:Wise – 99Freelas: como funciona (https://wise.com/br/blog/99freelas-como-funciona) ·99Freelas – Como funciona (https://www.99freelas.com.br/como-funciona)

### V1.M07.A02 — Construindo Sua Vitrine Digital no 99Freelas (5)

- Nome da plataforma falado errado: a gravação diz "99 Freelance" várias vezes, mas o nome correto é 99Freelas. Se a aluna pesquisar "99 Freelance" no Google, pode cair em outro site. Vale corrigir com legenda ou texto de apoio.
- Interface pode ter mudado: os nomes de botões ("Quero trabalhar", "Cadastre-se", "Contas") seguem a gravação. Se o 99Freelas atualizar o site, a aula fica desatualizada. Revisar periodicamente.
- "Narradora" no exemplo de título: é um serviço diferente de tudo o que o curso ensinou até aqui. Pode confundir.
- Termo "mentoria": a gravação chama o método de "mentoria". É o mesmo padrão das aulas do M02.
- Taxas e saque: a aula não explica a taxa da plataforma nem o prazo de recebimento. Ver a Aula 01 deste módulo.

### V1.M07.A03 — O Ciclo da Realização: Como Receber (8)

- ⚠️ Título não confere com o conteúdo: o título diz "Como Receber", mas a aula só fala dos planos. O recebimento aparece na Aula 02 (conta bancária), sem explicar o fluxo de liberação, a taxa ou o prazo.
- ⚠️ Ordem das aulas invertida: a aula diz "agora que você já sabe procurar trabalho e enviar propostas", mas a busca de projetos só é ensinada na Aula 04 deste módulo. A Aula 02 terminava prometendo esse conteúdo para a aula seguinte. Sugestão: trocar a ordem das Aulas 03 e 04.
- ⚠️ "Enviar propostas" continua sem aula: nem esta aula nem a Aula 04 mostram como montar e enviar a proposta (texto, valor e prazo). É o passo que leva ao primeiro pagamento.
- Taxa da plataforma não mencionada: além da mensalidade, o 99Freelas cobra uma taxa sobre cada projeto (cerca de 20% no plano gratuito, menor nos pagos, segundo fonte externa; ver a Aula 01 deste módulo). A aula não fala disso, e as alunas podem se surpreender com o valor recebido.
- Número de conexões contraditório: esta aula diz 10 conexões no plano gratuito, mas a Aula 04 diz 20. Conferir no site e padronizar.
- Informação sujeita a mudança: os preços e as quantidades de conexões seguem a gravação. Conferir periodicamente no site do 99Freelas.
- Despedida: "Beijo, uma executiva" provavelmente é erro de transcrição. Conferir no vídeo.
- Nome: a gravação diz "99Freelance" de novo.

### V1.M07.A04 — Mapeamento Inteligente: Identificando Demandas Lucrativas (6)

- ⚠️ Número de conexões contraditório: esta aula diz "20 conexões por mês", mas a Aula 03 diz que o plano gratuito tem 10 conexões. Conferir o valor atual no 99Freelas e padronizar.
- ⚠️ Ordem das aulas invertida: esta aula ensina a procurar projetos, mas a Aula 03 já dizia "agora que você já sabe procurar trabalho". A Aula 02 terminava prometendo exatamente este conteúdo para a aula seguinte. Sugestão: trocar a ordem das Aulas 03 e 04.
- ⚠️ Continua faltando "como enviar a proposta": a aula mostra como buscar, avaliar e perguntar, mas não mostra como montar e enviar a proposta (texto, valor e prazo). É o passo decisivo para conseguir o primeiro projeto. Conferir se isso aparece em aulas seguintes.
- "Freelancer Pro será ensinado nas outras aulas": conferir se alguma aula explica isso. A Aula 03 só lista os planos.
- Frase ambígua: "Se você se candidatou, você pode fazer perguntas". No 99Freelas, perguntas costumam poder ser feitas antes da candidatura. Conferir.
- Nome: a gravação alterna entre "99 frilas" e "99 filas".

### V1.M07.A05 — Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" (6)

- ⚠️ Prova social, escassez e autoridade para iniciantes: a aula dá frases prontas como "semana passada entreguei um serviço similar para uma consultoria de RH", "trabalho com no máximo 3 demandas por mês" e "já passei pela frustração de ter um negócio". A maior parte das alunas ainda não tem esse histórico. Se copiarem as frases, estarão fazendo afirmações falsas para clientes, com risco de reputação, avaliação negativa e de desrespeitar as regras da plataforma. Recomendo um aviso explícito: usar só provas reais (inclusive projetos de estudo, identificados como tal) e adaptar os exemplos à própria realidade.
- Prazo incoerente no exemplo de design: o processo descrito (briefing em 1–2 dias, primeira versão em 3–5, revisões em 2–3) soma de 6 a 10 dias, mas o prazo informado é "2 dias úteis".
- Serviço presencial no exemplo principal: a proposta completa é de organização residencial presencial (análise da casa, treinamento da família). Isso não combina com o 99Freelas nem com o trabalho remoto que o curso promete. Um exemplo digital (assistente virtual, entrada de dados, social media) seria mais coerente com o módulo.
- Nomes de bônus confusos: esta aula se chama "Bônus 01", mas cita outro "bônus 1, Skills das Subdemandas". Padronizar a nomenclatura e confirmar onde o Skills das Subdemandas fica na área de membros.
- Resolve a lacuna das Aulas 03 e 04: esta aula cobre como escrever a proposta, mas não mostra na tela onde clicar para enviá-la no 99Freelas, nem como a proposta consome conexões. Vale um trecho curto de tela.
- "Supremas" no exemplo: o texto de proposta cita "uma das supremas", termo interno do curso. A aluna não deve usar esse termo com clientes.

### V1.M07.A06 — Bônus 02: Hacks Avançados para o 99Freelas (7)

- ⚠️ "Migrar os melhores contratantes para atendimento direto": a aula recomenda, no fim, levar os clientes para fora da plataforma. Plataformas como o 99Freelas costumam proibir nos termos de uso a troca de contato e o pagamento por fora, e podem suspender a conta. Confirmar nos termos do 99Freelas e, se for o caso, reformular esse trecho ou acrescentar uma ressalva ("só depois do projeto concluído e dentro das regras da plataforma").
- ⚠️ Prova social inventada, de novo: a aula diz "nunca minta sobre sua experiência", mas os exemplos ("já organizei mais de 50 ambientes", "semana passada organizei o escritório de uma advogada, +40% de produtividade") são frases que uma iniciante não pode usar com verdade. É o mesmo problema do Bônus 01: reforçar que os exemplos devem ser adaptados à realidade de cada aluna.
- Horários "nobres" e "algoritmo por palavras-chave": são apresentados como fatos, sem fonte. Tratar como dicas.
- Contradição de preço: o Hack 5 (cobrar entre os mais caros) e o Hack 13 (no início, pegar demandas de valor baixo) podem confundir. O plano de crescimento resolve a contradição (mês 1 barato, mês 4 valor real), mas vale deixar isso explícito.
- Exemplos presenciais de novo: organização de closet, escritório e casa, com material físico no orçamento. Não combinam com a proposta de trabalho 100% online no 99Freelas.
- Promessa de ganho: [nome] com "mais de R$ 4 mil por mês" só pelo 99Freelas.
- Erros de transcrição: "sua inscrição" (é "sua descrição"), "resultado que você entregue", "você repede" (é "repete") e "explique o seu progresso" (é "processo").

### V2.M05.A01 — Construindo Relacionamentos que Geram Indicações (5)

- Indicações em plataformas de freelancer: muitos clientes das alunas vêm de plataformas (Workana, 99Freelas etc.). Vale lembrar que levar o cliente para fora da plataforma ou combinar pagamento por fora pode violar os termos delas. Pedir indicação é ok; desviar o pagamento, não.
- "Bônus inesperado": é uma boa prática. Orientar a não comprometer o prazo ou a margem com extras.
- Pouca relação com o título do módulo: o módulo se chama "Máquina de Receita Recorrente", mas esta aula trata de indicações e networking. Isso é coerente como primeiro passo, mas a recorrência (contratos mensais, retenção) deve vir nas próximas aulas. Conferir.
- Gênero inconsistente: abre com "Seja muito bem-vindo", mas o resto da aula é no feminino ("vamos juntas", "sozinha", "lembrada").
- Erros de transcrição: "Ofereça valor, cria bem, inclusive as oportunidades vão surgir" (provavelmente "ofereça valor, crie vínculos e as oportunidades vão surgir"). "O primeiro ponto que você precisa entender é ninguém cresce sozinha" (falta o ":").

### V2.M05.A02 — Personal Branding: Tornando-se a Primeira Opção (5)

- ⚠️ Título com erro: "Tornando-se a Primeira Opção Anterior". O "Anterior" parece um erro de digitação ou de cadastro. A aula fala só em "a primeira opção". Conferir o título na área de membros.
- Depoimentos e resultados reais: a aula pede "resultados que alcançou ou depoimentos". Reforçar que devem ser reais e autorizados. A própria aula diz que personal branding "não é criar uma imagem falsa", o que é coerente com os alertas da v07 M02 A04 e da M04 A04.
- Portfólio de trabalhos de clientes: ao mostrar "exemplos reais do seu trabalho", verificar se o cliente autoriza a divulgação, sobretudo em trabalhos feitos por plataformas ou sob confidencialidade.
- Gênero: a aula é quase toda no feminino ("boa", "profissional"), mas tem um "Pra ser lembrado".
- Erros de transcrição:
  - "profissional prêmio" (é "premium");
  - "não é sobre ser excelente" (o sentido é "não é só sobre ser excelente");
  - "vou deixar pra vocês assim" (é o plural; trecho truncado).

### V2.M05.A03 — Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel (5)

- ⚠️ Título com "Anterior" de novo: "Da Primeira Venda ao Cliente Fiel Anterior". É a segunda aula seguida com essa palavra sobrando no fim do título (ver a v07 M05 A02). Parece um erro de cadastro em série no módulo. Conferir os títulos na área de membros.
- ⚠️ Recorrência × plataformas de freelancer: propor contrato mensal fora da plataforma a um cliente que veio do Workana, 99Freelas, GetNinjas etc. pode violar os termos delas. Orientar a fazer a recorrência dentro da plataforma (quando ela permite contratos contínuos) ou só com clientes captados por conta própria. É o mesmo alerta da v07 M05 A01.
- Falta o "como precificar e formalizar" o contrato mensal: a aula sugere o acompanhamento, mas não diz como montar o pacote (escopo, quantidade de entregas, valor, forma de pagamento, combinado por escrito). É uma lacuna provável no suporte. Conferir se as próximas aulas cobrem isso.
- Gênero inconsistente: "seja sempre educada", "pronta" e "lembrada" estão no feminino, mas há "você está comprometido".
- Erros de transcrição: "o que foi culminado" (2 vezes; é "combinado"). "Apresenta sua ideia e o acompanhamento contínuo" (provavelmente "de acompanhamento contínuo").

### V2.M05.A04 — Automação de Processos: Otimizando Tempo e Aumentando Lucro (7)

- ⚠️ Aula sem ferramentas concretas: o título promete automação, mas a aluna termina sem saber qual app usar. Isso tende a gerar muitas dúvidas no suporte. Sugiro incluir uma lista de ferramentas recomendadas (gratuitas e simples) no material ou na descrição da aula. Os exemplos da tabela acima são sugestão da documentação e precisam ser aprovados pela equipe antes de virar resposta padrão.
- ⚠️ "Propostas automáticas" nas plataformas de freelancer: se a aluna entender como enviar propostas em massa ou por robô no Workana, 99Freelas etc., isso pode violar os termos e prejudicar a reputação (propostas genéricas). As aulas de plataformas ensinam propostas personalizadas. Esclarecer que a automação vale para modelos e respostas rápidas, não para disparo automático.
- Recibos × nota fiscal: "ferramentas que geram recibos automaticamente" é ok para controle, mas dependendo do cliente (empresa) pode ser exigida nota fiscal, por exemplo como MEI. Vale um alerta ou um link para o conteúdo sobre formalização, se houver.
- Dados de clientes: ferramentas de formulário e de arquivos vão guardar dados pessoais de clientes. Orientar sobre cuidado básico (acesso restrito, não compartilhar links públicos), por conta da LGPD.
- "Anterior" no título: é a terceira aula seguida do Módulo 05 com essa palavra sobrando (ver a A02 e a A03). Confirmar e corrigir em lote.
- Linguagem: neutra, quase sem marcação de gênero. Está ok.
- Erros de transcrição:
  - "chatboots" (é "chatbots");
  - "recebos" (é "recibos");
  - "liberando seu tempo para que realmente faz diferença" (é "para o que");
  - "Se perder tempo respondendo mensagens ou organizar documentos" (é "Se perde… ou organizando").

### V2.M05.A05 — Certificação (7)

- ⚠️ Como apresentar o certificado ao cliente: a aula chama o certificado de "selo" e de "formação" e diz que ele "abre portas automaticamente". Recomendo orientar a aluna a descrevê-lo com precisão, por exemplo: "concluí o treinamento [nome] sobre [tema]". Não deve ser apresentado como diploma, curso técnico ou certificação reconhecida (MEC ou órgão de classe), o que não é. Exagerar o peso do certificado para clientes pode ser visto como propaganda enganosa e prejudicar a reputação da aluna.
- ⚠️ Falta o passo a passo do certificado: é a quarta aula de certificação sem explicar onde e como emitir. Definir o procedimento e incluí-lo em todas.
- "Chegamos à nossa última aula": pode se referir ao último módulo do bônus. Confirmar se o I BÔNUS termina no Módulo 05 ou se há mais módulos.
- PDF de resumo: as certificações dos M02, M03 e M04 citam um PDF na descrição. Esta não. Conferir se existe e, se existir, incluir a menção.
- "Transformar a sua vida", "transformar toda a sua realidade": é linguagem motivacional ampla. Não chega a ser promessa de ganho, mas convém não reforçar.
- Linguagem: usa o feminino ("pronta", "certificada"). Está ok.
- Erros de transcrição: "Estou pronta para te ajudar e alcançar" (é "a alcançar"). "conclui" (é "concluí").

### V2.M01.A01 — Encontrando Suas Skills Ocultas (4)

- Conteúdo repetido: o tema é muito parecido com o M06 A01 ("A Mentira que Contaram Sobre Suas Habilidades", 5 círculos). Avaliar se vale referenciar um ao outro.
- Nome do bônus: aparece como "Skill's das Demandas Lucrativas" (vitrine), "Skills das Subdemandas" (M06 A04, M07 A05) e "bônus 1". Padronizar. O apóstrofo em "Skill's" também está incorreto.
- Certificado: o M06 A04 diz que este bônus traz "treinamentos práticos com certificado". Confirmar se existe certificado e como a aluna o obtém.
- Tom religioso: a aula usa referências a Deus, como as aulas do M02. Coerente com o curso, mas vale lembrar no suporte que alunas de outras crenças podem estranhar.

### V2.M01.A02 — DNA de Talentos: Enxergando Além do Óbvio (3)

- Conteúdo parecido com o M06: complementa o M06 A01 (5 círculos) e o M06 A02 (linguagem de mercado). Avaliar se vale referenciar.
- Tom religioso: mantém as referências a Deus da Aula 01.
- Erro de transcrição: "Te espero já nos próximos segundos" provavelmente é "nos próximos módulos" ou "na próxima aula".

### V2.M02.A01 — Por que suas palavras não vendem (e como mudar isso hoje) (4)

- Nome do módulo divergente: o M07 A05 indica "bônus 1, Skills das Subdemandas, módulo 2, Dominando a Arte da Comunicação Simples", mas o módulo se chama "Comunicação Viral: O Código da Persuasão Digital". Ajustar a referência no M07.
- História pessoal: "há uns 3 anos eu estava quebrada, sem dinheiro para comprar um pão francês". Conferir se é coerente com a história da Gabriela contada no M02 e no M03 (dificuldade em 2022, começo nas subdemandas). Se for outra professora, identificar.
- Estatísticas sem fonte: "99% das pessoas cometem o mesmo erro" e "você já está na frente de 90% da concorrência".
- Erro de transcrição: "assistir um filme sem legenda e não entender cada piada" deve ser "e entender cada piada".

### V2.M02.A02 — A Persona – Quem você está tentando convencer? (3)

- Exemplo voltado para vender infoproduto: a persona "[nome]" e a "transformação" descrita (liberdade de não depender de ninguém) são típicas de quem vende curso de renda extra, e não de quem oferece serviços como freelancer, que é o foco do curso. Vale incluir um exemplo de persona de cliente de serviço (empreendedora, pequena empresa) para a aluna aplicar nas propostas.
- Aula sem exercício explícito: a aula explica os 3 pontos, mas não pede formalmente que a aluna escreva a própria persona. O passo a passo acima foi deduzido do conteúdo.
- Erro de transcrição: "sentam orgulho" é "sintam orgulho".

### V2.M02.A03 — A Grande Ideia – O que faz alguém parar tudo pra te ouvir (4)

- Nível avançado para o público: "grande ideia", Mike Palmer, SCAMPER e testes A/B são conceitos de copywriting profissional. Para iniciantes que vão escrever propostas curtas em plataformas de freela, falta um exemplo aplicado a esse contexto. Sugiro incluir um.
- "Cópia": na transcrição, "copy" (texto de vendas) aparece como "cópia". Pode confundir as alunas. Vale padronizar o termo como "copy" ou "texto de vendas".
- Gênero: "esteja aberto", "se estiver sozinho", "tá pronto". O público é feminino.
- Erros de transcrição: "público alto" (é "público-alvo"), "dados demográficos, valem!" (trecho confuso).

### V2.M02.A04 — Os Gatilhos que Movem Pessoas (4)

- ✅ Esta aula corrige vários pontos de outros módulos: ela condena escassez falsa, urgência inventada e prova social exagerada. Isso contradiz diretamente o Bônus 01 do M07 ("trabalho com no máximo 3 demandas por mês"), o Bônus do M11 ("as vagas são limitadas") e o Hack 9 do M08 Bônus 2 (depoimento "[nome], México"). Sugestão: usar esta aula como referência para corrigir aqueles trechos.
- ⚠️ Exemplos de prova social com valores: "[nome] saiu de 3 mil para 15 mil em seis meses" e "[nome] vendeu 8 mil em uma semana" são apresentados como histórias reais. Se forem ilustrativos, contradizem a própria lição da aula. Confirmar se são reais e se há autorização para citá-los.
- Exemplos voltados para venda de curso: "limito em 50 alunos por turma" e "vale mais do que muito curso por aí" são de quem vende infoproduto. Para a aluna freelancer, falta adaptar os exemplos a propostas e serviços.
- Erros de transcrição: "planinhos" (provavelmente "planilhas"), "vale mais do que muito o curso por aí" (é "muito curso por aí").

### V2.M02.A05 — Estratégias que Conectam: O Caminho para Resultados Reais (3)

- ⚠️ Storytelling com "situação fictícia": a aula permite contar "uma situação fictícia, mas realista". Isso conflita com a Aula 04 deste módulo ("os gatilhos só funcionam se forem verdadeiros") e pode reforçar o problema de prova social inventada apontado em outros módulos. Sugiro deixar claro: histórias fictícias só como exemplo ilustrativo identificado, nunca como depoimento ou caso real.
- Faltam exemplos aplicados: as técnicas são explicadas de forma genérica. Um exemplo completo (uma proposta de freela escrita com AIDA, por exemplo) ajudaria a aluna a aplicar.
- Erros de transcrição: "Storyline" (é "storytelling"), "Cicla para Cautio-Action" (é "Call to Action"), "Em segunda" (é "Em seguida").

### V2.M02.A06 — Onde usar tudo isso pra fazer dinheiro (6)

- ⚠️ Exemplos com afirmações que a aluna pode não ter:
  - "uma dica rápida que aumentou as minhas vendas em 50%" (transcrito como "vidas");
  - "você sabia que 90% das pessoas…", uma estatística sem fonte usada como gancho;
  - "ex-funcionária pública" no modelo de bio.
- Se copiados ao pé da letra, viram dados e resultados inventados, o que contradiz a Aula 04 deste módulo ("o melhor gatilho é a honestidade"). Reforçar que os exemplos devem ser adaptados com informações verdadeiras.
- Mensagens de WhatsApp não solicitadas: abordar pessoas no privado para vender pode ser visto como spam e, conforme o caso, esbarrar na LGPD. Sugiro orientar a falar só com quem demonstrou interesse ou já é contato.
- Exemplo de bio na área de saúde: "ajudo pessoas estressadas a dormirem melhor" é uma promessa ligada à saúde. Para uma aluna sem formação, é melhor evitar esse tipo de promessa.
- Exemplos de quem vende curso: "você tem interesse no meu curso?" é de infoproduto. Adaptar para serviços.
- Erros de transcrição: "curte uma história" (é "conte"), "aos pontos" (é "aos poucos"), "minhas vidas" (é "minhas vendas").

### V2.M02.A07 — Certificação (4)

- ⚠️ Falta o passo a passo do certificado: a aula diz que a aluna "está recebendo o seu certificado", mas não mostra onde nem como emitir ou baixar. Isso deve gerar dúvidas no suporte. Definir: o certificado é emitido automaticamente pela plataforma ao concluir 100% das aulas? Por módulo ou pelo bônus inteiro? Em nome de quem e com qual carga horária?
- Certificado por módulo: esta aula sugere um certificado por módulo. O M06 A04 fala em "treinamentos práticos com certificado". Conferir se o Módulo 01 do bônus também tem certificado.
- E-book: confirmar se o arquivo está mesmo anexado na descrição da aula.
- Erros de transcrição: "a primeira favela de muitas conquistas" (é "a primeira de muitas conquistas"), "em algumas horas comece" (provavelmente "em seguida comece").

### V2.M03.A01 — O Estúdio Secreto do Seu Smartphone (2)

- Relação com o Módulo 15 do Método: "Performance Magnética" (M15) trata de como se comunicar em vídeo, e este módulo trata da parte técnica. Vale cruzar as referências.
- Erros de transcrição: "180p" (é 1080p), "modo de grage" (é grade), "pilha de livro ou qualquer coisa que a gente vai deixar o celular firme" (trecho truncado).

### V2.M03.A02 — Dominando a Iluminação Sem Equipamentos Caros (3)

- ⚠️ Risco de incêndio nos improvisos: colocar papel na frente de lâmpada e lâmpada dentro de caixa de papelão coberta com pano pode superaquecer e pegar fogo, especialmente com lâmpadas incandescentes ou halógenas. Recomendo acrescentar um aviso: usar apenas lâmpadas de LED (que esquentam pouco), manter distância entre a lâmpada e o papel ou pano, não deixar ligado sem supervisão e desligar depois do uso.
- Erro na transcrição: "iluminando aquelas sombras duras" provavelmente é "eliminando aquelas sombras duras".
- Fechamento: "tem muito mais indo por aí" (é "vindo por aí").

### V2.M03.A04 — Apps que Transformam Amadores em Profissionais (5)

- Versões gratuitas têm limites: CapCut, Canva, Lightroom e Photoshop têm recursos premium pagos, e alguns podem exigir conta ou ter limitações na versão grátis. Vale avisar para a aluna não se surpreender.
- Direitos autorais de música: ao editar vídeos para clientes ou para uso comercial, nem toda música disponível nos apps pode ser usada livremente. Vale um aviso para usar trilhas liberadas para uso comercial.
- "Audio Lab": confirmar o nome e o link do app recomendado. Há apps com nomes parecidos, e o disponível pode variar entre Android e iOS.
- Formato do Instagram: a aula fala em "quadrado ou vertical". Hoje o padrão do Instagram é o vertical (reels, stories e feed em 4:5). Atualizar.
- Erros de transcrição: "intuitível" (é "intuitivo"), "realças" (é "realces"), "inesejados" (é "indesejados"), "cortar partes necessárias" (provavelmente "desnecessárias").

### V2.M03.A05 — Transformando Fotos em Conteúdo Magnético (2)

- Sem pontos sensíveis: aula técnica, que consolida as Aulas 01 a 04.
- Erros de transcrição: "CapTouch" (é CapCut), "luz mais suave que quente" (provavelmente "suave e quente"), "Com a luz suave, deixe a foto…" (provavelmente "A luz suave deixa a foto…"), "proximidade leveza" (falta "e").

### V2.M03.A07 — CapCut do Zero: Dominando os Primeiros Passos (5)

- Mudança de professor: esta aula é dada por Rafael, e não pela Gabriela. Vale apresentá-lo, porque as alunas podem estranhar.
- "Músicas da marca": o professor diz que são "as músicas baixadas no seu dispositivo". No CapCut, essa seção costuma reunir músicas licenciadas para uso comercial. Conferir, porque isso se relaciona ao alerta de direitos autorais da Aula 06.
- Interface pode mudar: nomes de abas e posições ("Eu", "Toque para entrar", "Novo projeto") seguem a gravação. O CapCut atualiza a interface com frequência. Revisar periodicamente.
- Gênero: "Sejam muito bem-vindos", "pessoal", "galera". O público é feminino.
- Erros de transcrição: "conexão de conto" (é "de conta"), "colocar um Rios" (provavelmente "um Reels"), "Pintura de ar" e "efeitos de ar" (provavelmente "efeitos de corpo" ou similar; conferir no vídeo).

### V2.M03.A08 — Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut (4)

- Música e direitos autorais: a aula adiciona uma música da biblioteca sem comentar a licença. Ver o alerta da Aula 06 deste módulo.
- Numeração interna: o professor chama esta de "segunda aula" e a próxima de "aula 3". No módulo são as Aulas 07, 08 e 09. Vale ajustar a fala ou o título para não confundir.
- Gênero e linguagem: "pessoal", "galera". Detalhe menor.
- Transcrição truncada: "pra que vocês tenham um processo de edição que vocês tenham essa consistência de passar pra algum outro editor" ficou confuso. O sentido é que um processo padronizado facilita até passar o projeto para outro editor.

### V2.M03.A09 — Impacto Visual: Texto, Legendas e Efeitos que Engajam (4)

- ⚠️ Título promete "Legendas", mas a aula não ensina legendas: só mostra texto livre. As legendas automáticas, importantes porque muita gente assiste sem som (Aula 06), aparecem apenas citadas na Aula 07. Ajustar o título ou incluir o passo a passo das legendas.
- Aula longa e pouco editada: a gravação tem muitos trechos de tentativa e erro ("vamos ver aqui… não ficou legal"). Vale editar para deixar mais objetiva, ou incluir marcadores de tempo por tema (sincronizar, transições, texto, cor).
- Numeração interna: o professor chama esta de "aula 3". No módulo é a Aula 09.
- Erros de transcrição: "liberdade geológica" (é "geográfica"), "pedefinição" (é "predefinição"), "Trem Zoom" (provavelmente "Tremor/Zoom"), "Pra no lado eu gosto de adicionar um pouco" (provavelmente "Granulação eu gosto de adicionar um pouco"), "uma cor pinhosa" (trecho confuso).

### V2.M03.A10 — Toque Final: Finalização, Exportação e Recapitulando Tudo (9)

- ⚠️ Legendas automáticas não ensinadas: o professor reconhece que não mostrou as legendas automáticas ("precisam de alguém falando") e diz que "é o mesmo princípio do texto". Como o título da Aula 09 promete legendas e elas são essenciais para vídeos assistidos sem som, vale incluir um passo a passo de legendas automáticas.
- Templates pagos "como inspiração": recriar à mão um template da versão paga é aceitável como inspiração, mas copiar idêntico um layout de terceiro para entregar a cliente pode ser problema. Reforçar o "usar com responsabilidade" do professor.
- Remover o encerramento do CapCut: a aula sugere cortar o trecho final ou a marca do app. Conferir nos termos de uso atuais do CapCut se isso é permitido na versão gratuita, sobretudo em vídeos para clientes.
- Direitos autorais de músicas e efeitos sonoros: vale o mesmo alerta da Aula 06. Conferir a licença antes de usar em vídeos comerciais.
- Fechamento do módulo: pelo conteúdo (recapitulação e tour final), esta parece ser a última aula do Módulo 03. Confirmar.
- Aula longa e pouco editada: como na Aula 09, há muitos trechos de tentativa e erro. Vale editar ou incluir marcadores de tempo.
- Numeração interna: "Sejam muito bem-vindos ao A4" (aula 4 do professor). No módulo é a Aula 10.
- Erros de transcrição: "Desde que frames" (é "desde keyframes"), "dei um notch" (provavelmente "dei um norte" ou "um panorama"), "semar essas demandas curtas" (provavelmente "somar essas demandas curtas"), "Destabilização" (é "Estabilização"), "Retrofaz" (provavelmente um efeito "retrô").
- Gênero: "Sejam muito bem-vindos". O público é feminino.

### V2.M03.A11 — Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut (6)

- ✅ Resolve a lacuna das legendas apontada nas Aulas 09 e 10. Vale citar esta aula no fim da Aula 10 ou ajustar o título da Aula 09.
- Revisão obrigatória da legenda: a aula mostra a correção, mas não enfatiza. Para vídeos de cliente, erro de legenda pega mal. Reforçar "sempre revisar antes de entregar".
- Modelos e direitos: modelos costumam trazer música embutida. Vale o mesmo alerta de direitos autorais da Aula 06 para uso comercial. Os modelos pagos aparecem de novo "para se inspirar", como na Aula 10.
- Ordem do módulo: a Aula 10 parecia fechar o módulo, mas esta aula continua o conteúdo. Confirmar se há mais aulas no Módulo 03.
- Gênero: "Oi, oi pessoal", "Espero que vocês tenham entendido". Detalhe menor.
- Erros de transcrição:
  - "editar o Steam dela" (é "estilo");
  - "essa montra" (é "Montserrat");
  - "feijelinho" (palavra do vídeo de exemplo, provavelmente um ingrediente; não afeta o conteúdo);
  - "essa aula bons vai ficando por aqui" (é "essa aula bônus").

### V2.M03.A12 — Certificação (7)

- ⚠️ Falta o passo a passo do certificado: como na v07 M02 A07, a aula fala da certificação, mas não mostra onde nem como emitir ou baixar. Definir: o certificado é emitido automaticamente ao concluir 100% das aulas? Por módulo ou pelo bônus inteiro? Qual carga horária?
- PDF na descrição: confirmar se o arquivo está mesmo anexado à descrição da aula.
- Texto quase igual ao da v07 M02 A07: as duas aulas de certificação são muito parecidas. Não é um problema, mas uma aluna que fizer os dois módulos seguidos pode notar a repetição.
- "Conhecimentos que muitas pessoas passam anos tentando descobrir": é um exagero leve, aceitável num tom motivacional.
- "Transformar isso em uma fonte de renda": é uma menção genérica, sem promessa de ganho. Está ok.
- Gênero: a aula usa o feminino ("preparada", "pronta"), mas tem um "profissional de verdade, alguém", que é neutro. Está ok.
- Transcrição: sem erros relevantes.

### V2.M04.A01 — Anatomia das Redes (6)

- Conteúdo genérico e sem dados: as descrições das redes e do algoritmo estão corretas no geral, mas são simplificadas. Os algoritmos mudam com frequência. Vale revisar periodicamente e evitar afirmações absolutas como "têm um desempenho incrível".
- Áudios em alta e direitos: usar "músicas ou áudios em alta" do TikTok é ok dentro do app, mas, em conteúdo para clientes ou anúncios, vale o mesmo alerta de direitos autorais da v07 M03 A06.
- Pedir curtida ou compartilhamento: chamadas como "curta e compartilhe" são comuns. Pedidos muito insistentes ("engagement bait") podem ser penalizados por algumas plataformas, como o Facebook. Vale sugerir CTAs mais naturais, como uma pergunta que puxe comentário.
- Tipo da aula: é mais conceito + exercício do que procedimento.
- Gênero: usa o feminino ("bem-vinda"). Está ok.
- Transcrição: "Já o Facebook, esses acompanhados de imagens…" provavelmente é "posts acompanhados de imagens". Não há outros erros relevantes.

### V2.M04.A02 — Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia (8)

- ⚠️ Título × exercício: o título promete "30 posts em 1 dia", mas o PDF não mostra como chegar a 30. O exercício pede 5 conteúdos. Vale ajustar o título ou incluir um exemplo de como 5 temas × formatos viram 30 posts.
- ⚠️ "Reposte conteúdos que não performaram bem": é uma dica arriscada se for entendida como republicar o mesmo arquivo. As plataformas, sobretudo o Instagram e o TikTok, tendem a reduzir o alcance de conteúdo duplicado ou não original. Recomendo reformular para "republique com um novo gancho, nova capa ou nova edição", e não o mesmo vídeo idêntico.
- Classificação dos algoritmos simplificada: colocar o Instagram como algoritmo "de preferência" (quem você segue) está desatualizado em parte. Os Reels e o Explorar funcionam por sugestão, para quem não segue a conta. O YouTube também considera inscrições. Vale suavizar, por exemplo: "o feed prioriza quem você segue; Reels e Explorar sugerem conteúdo novo".
- "Cada conteúdo é avaliado de forma isolada": é uma simplificação. O histórico da conta também pesa. Evitar apresentar isso como regra absoluta.
- "Twitter": a rede hoje se chama X. Atualizar o nome.
- AIDA › Ação: a aula resume a ação como "curtir, comentar ou compartilhar". Na copy, a ação costuma ser o próximo passo desejado (chamar no direct, clicar no link). Conferir se a v07 M02 (copy) traz uma definição diferente, para manter coerência.
- Duração: a aula não tem vídeo. Confirmar que é intencional na área de membros.
- Linguagem: usa o feminino ("que você é ativa"). Está ok.

### V2.M04.A03 — Copywriting, Hashtags e SEO para Redes Sociais (7)

- ⚠️ Hashtags × busca por palavra-chave: o Instagram tem dado cada vez menos peso às hashtags e mais às palavras-chave na legenda, no nome e no texto do vídeo (SEO social). Também houve mudanças recentes na quantidade de hashtags permitidas ou recomendadas por post. Conferir as regras atuais e ajustar a orientação "monte listas grandes" para algo como "poucas hashtags relevantes + palavras-chave na legenda".
- Faixa "10 mil a 500 mil usos": é uma regra de bolso comum, sem fonte oficial. Apresentar como referência, não como regra.
- CTA "urgente": urgência real é ok. Evitar falsa urgência, coerente com o alerta sobre escassez inventada da v07 M02 A04.
- Coerência com o Módulo 02 e a Aula 02: aqui a etapa Ação do AIDA é "CTA claro", o que está mais correto que a versão da M04 A02 (só curtir, comentar e compartilhar). Vale alinhar os dois materiais.
- Repetição de conteúdo: headline, gatilhos, storytelling e AIDA já foram vistos no Módulo 02. Vale citar o módulo para quem quiser se aprofundar.
- Gênero inconsistente: "Seja muito bem-vindo" e "seja objetivo" no masculino, mas "ser encontrada" no feminino. O público é feminino.
- Erros de transcrição:
  - "CEO social" (é "SEO social");
  - "púlsula" (é "bússola");
  - "seguem enrolando o feed" (é "rolando");
  - "Storyline" (é "storytelling");
  - "Atenção para a pessoa com uma headline forte" (é "Atenção: pare a pessoa…");
  - "textos que realmente se convertem" (sobra o "se");
  - "O segredo é o equilíbrio, para escolher estrategicamente" (trecho confuso).

### V2.M04.A04 — Criando Reels, Stories e TikToks que Vendem (8)

- ⚠️ Depoimentos e resultados reais: o funil pede "resultados ou depoimento de cliente". Reforçar que devem ser reais e autorizados, nunca inventados. A aula não fala isso, e há o histórico de prova social inventada sinalizado em outras aulas (v07 M02 A04).
- "Garantir sua vaga" e urgência: usar só quando houver limite real de vagas. Coerente com o alerta sobre escassez falsa.
- Áudios em alta e uso comercial: em conteúdo de perfil comercial ou cliente, parte dos áudios virais pode não estar liberada. Vale o mesmo alerta de direitos autorais da v07 M03 A06.
- "Usar áudios virais faz o algoritmo entregar mais": é uma crença comum, mas não é garantia. Suavizar.
- Horários genéricos: "manhã, almoço, início da noite" é uma referência ampla. O melhor horário depende do público de cada conta. Indicar os insights do perfil (próxima aula).
- "Reels do TikTok": a fala ou a transcrição juntou as duas coisas. O correto é "Reels e TikTok".
- "Mas pra realizar" provavelmente é "pra viralizar". "Time" foi usado no sentido de "timing" (horário).
- Gênero: usa o feminino ("bem-vinda", "ativa", "clara"). Está ok.

### V2.M04.A05 — Analytics e Otimização: Lendo os Dados como um Profissional (6)

- ⚠️ Exemplo de teste A/B contradiz a regra: a aula manda testar uma variável por vez, mas o exemplo muda duas: o formato (carrossel × vídeo) e o conteúdo (benefícios × depoimentos). Ajustar o exemplo, por exemplo: o mesmo vídeo com dois ganchos diferentes, ou o mesmo carrossel com dois CTAs.
- Falta o "onde clicar": a aula é teórica e não mostra onde acessar os insights. É preciso ter conta profissional (comercial ou criador de conteúdo) no Instagram ou no TikTok. Vale incluir uma tela ou um passo a passo.
- Nomenclatura atualizada: o Instagram passou a destacar "Visualizações" em vez de "Impressões" nos insights. Conferir os nomes atuais das métricas para que a aluna ache o que a aula descreve.
- Depoimentos reais: o exemplo usa um "vídeo curto com depoimentos". Reforçar que devem ser reais e autorizados (ver a v07 M04 A04).
- Título no masculino: "como um Profissional". A fala usa "como uma profissional". Detalhe menor.
- Erros de transcrição: "ajustar e ajustar a estratégia" (provavelmente "testar e ajustar"), "analisa e alcance interações" (é "analisa o alcance, as interações").

### V2.M04.A06 — Certificação (6)

- ⚠️ Falta o passo a passo do certificado: é a terceira aula de certificação sem explicar onde e como emitir. Definir o procedimento e incluí-lo em todas.
- Desafio × certificado: deixar claro se o certificado depende de concluir o desafio, ou se é só da conclusão das aulas.
- "30 posts em 1 dia": a recapitulação repete a promessa do título da Aula 02, que não ensina a chegar a 30 (ver a v07 M04 A02).
- PDF na descrição: confirmar se o arquivo está anexado. Lembrando que a Aula 02 do módulo já é, ela própria, um PDF.
- Gênero inconsistente: quase toda a aula usa o feminino ("pronta", "encontrada"), mas tem um "garantir que você está pronto".
- Erros de transcrição:
  - "CEO social" (é "SEO");
  - "storylines" (é "storytelling");
  - "carrocéis" (é "carrosséis");
  - "headlines**,** magnéticas" (é "headlines magnéticas");
  - "como utilizar o seu perfil" (provavelmente "otimizar");
  - "estrutura para aprender a atenção" (é "prender");
  - "Você evoluiu muito**?**" (é uma afirmação).

### V2.M06.A01 — Matriz de Prioridades: Focando no que Realmente Importa (6)

- ⚠️ Nome do módulo com anotação interna: "Multiplicando Seu Tempo - configurar por produto". O trecho "configurar por produto" parece nota de configuração que vazou para o nome. Conferir na área de membros. No cabeçalho deste documento usei só "Multiplicando Seu Tempo".
- Sobreposição com o Método: a auditoria de tempo já aparece no v01 M05 (Mindset da Dupla Jornada / Auditoria de Tempo). Vale referência cruzada para manter a coerência.
- "Delegar" para quem trabalha sozinha: a maioria das alunas não tem para quem delegar. A aula só cita "dizer não". Vale sugerir alternativas: agrupar tarefas, horários fixos para mensagens, respostas rápidas automáticas (v07 M05 A04).
- "Todo mundo tem as mesmas 24 horas": a frase pode soar desconsiderada para o público de dupla jornada (mães, CLT + casa). Considerar suavizar.
- Gênero: "Seja bem-vindo". O público é feminino.
- Erros de transcrição: "geralmente pode ser delegadas" (é "podem"). "Escolher uma tarefa… e comece" (concordância).

### V2.M06.A03 — Arquitetura de Projetos: Do Caos à Execução (7)


Seção "Exercício sugerido (a aula não propõe)" (fora do bot):

Aplicar o planejamento reverso a um projeto próprio (por exemplo, uma entrega para cliente): definir a data final › listar os marcos › atribuir prazos com margem › chegar ao primeiro passo de hoje.
- ⚠️ Promessa não cumprida: a aula abre dizendo que vai mostrar "como encontrar oportunidades nesse nicho" (gestão de projetos como serviço), mas não fala disso: nenhuma plataforma, tipo de cliente ou serviço. Conferir se a próxima aula cobre. Senão, ajustar a abertura.
- Foco em "equipe" × aluna solo: a aula fala em "guiar sua equipe", "equipe de vendas treinada", "quem faz o quê". A maioria das alunas trabalha sozinha. Vale mostrar como aplicar o método a projetos próprios ou de clientes, por exemplo uma entrega de freelancer com várias etapas.
- "Fase 2": a aula se diz o início da "fase 2", mas o módulo não apresenta fases. Confirmar a estrutura (fase 1 = A01 e A02 sobre tempo e hábitos; fase 2 = gestão de projetos?) e, se for o caso, explicar na abertura do módulo.
- Sem exercício prático: diferente das aulas anteriores, esta não propõe tarefa. A documentação sugere um exercício (acima), que precisa ser aprovado.
- Margem de 5 › 7 dias: é uma regra de bolso. Funciona bem para prazos prometidos a clientes. Ok.
- Linguagem: neutra. Ok.
- Erros de transcrição:
  - "Lançamento, os marcos seriam" (é "Num lançamento, os marcos seriam");
  - "a margem da segurança" (é "de");
  - "Como a reunião de alinhamento" (é "como, por exemplo, a reunião").

### V2.M06.A04 — Gestão Inteligente: Produtividade e Prazos (7)

- ⚠️ Título repetido: o título informado é idêntico ao da Aula 03 ("Arquitetura de Projetos: Do Caos à Execução"). Provável erro de cadastro. Sugestão: "Fazer Mais com Menos: Acompanhamento e Pivotagem". Por isso o arquivo foi salvo com outro slug (v07-m06-a04-fazer-mais-com-menos).
- ⚠️ Escopo para freelancer: a parte de escopo é muito útil para as alunas. Vale reforçar o lado prático: registrar o escopo por escrito antes de começar e tratar pedidos extras como novo orçamento. Coerente com a lacuna sobre formalização apontada na v07 M05 A03.
- Ainda centrado em equipe: "liderar equipes", "delegar", "reuniões de revisão". Como na A03, a maioria das alunas trabalha sozinha. Mostrar como aplicar ao projeto de um cliente (os pontos de controle viram checkpoints com o cliente).
- "Encontrar oportunidades nesse nicho": a promessa feita na A03 (gestão de projetos como serviço) também não aparece aqui.
- Sem exercício prático: a aula não propõe tarefa.
- Gênero inconsistente: "Seja muito bem-vindo" no masculino, mas "si mesma", "sozinha" e "estratégica" no feminino.
- Erros de transcrição:
  - "descopo" (é "escopo");
  - "no meio de caminhos" (é "no meio do caminho");
  - "se você liderar" (é "se você lidera");
  - "sempre encontre uma forma" (é "sempre encontra").

### V2.M06.A05 — Certificação em Gestão Integrada de Tempo e Projetos (9)

- ✅ Primeira indicação de onde emitir o certificado: "aqui, abaixo dessa aula". Conferir se o botão ou link está mesmo lá e se o mesmo vale para os Módulos 02, 03, 04 e 05. As documentações dessas certificações receberam uma nota com essa pista. Se for igual, incluir a frase nas outras aulas de certificação.
- "Certificado oficial": é o mesmo alerta da v07 M05 A05. Evitar que a aluna apresente o certificado como diploma ou certificação reconhecida. Descrevê-lo como certificado de conclusão do treinamento.
- Nome da certificação: a fala diz "certificação em gestão integrada de tempo e liderança", mas o título diz "tempo e projetos". Alinhar.
- Projeto final × certificado: a aula sugere uma sequência (projeto › certificado), mas não diz se a emissão depende de concluir o projeto. Esclarecer.
- "Na sua empresa": como nas A03 e A04, a aula supõe que a aluna lidera algo numa empresa. Sugerir exemplos do contexto das alunas (projeto de cliente, rotina da casa).
- Nome do módulo com "- configurar por produto" (ver a v07 M06 A01).
- PDF de resumo: não mencionado, como na M05 A05.
- Linguagem: usa o feminino ("pronta"). Está ok.
- Erros de transcrição:
  - "a criação em poofers estratégicos para improvisos" (é "a criação de buffers estratégicos para imprevistos");
  - "para avaliar e a sua evolução" (sobra o "e");
  - "aplicar um projeto real" (é "aplicar num/em um").

### V2.M07.A01 — UGC: Entendendo o Negócio por Trás do Conteúdo (7)

- ⚠️ "Parecidos com depoimentos reais" × transparência: UGC é publicidade paga. Vale orientar a aluna a:
  - não afirmar ser cliente se não usou o produto, nem relatar resultados que não teve, sobretudo em saúde, beleza, emagrecimento e finanças;
  - lembrar que a identificação do conteúdo como publicidade segue as regras do CONAR (Guia de Publicidade por Influenciadores Digitais).
- Do contrário, o "depoimento" pode configurar propaganda enganosa. É coerente com os alertas sobre prova social inventada (v07 M02 A04, M04 A04). Esta orientação vem do meu conhecimento geral, sem pesquisa feita agora. Vale confirmar com o jurídico antes de usar como resposta padrão.
- ⚠️ "Sem se expor": a aluna não precisa postar no próprio perfil, mas em geral aparece no vídeo (rosto e voz), e o vídeo é usado em anúncios da marca, às vezes com grande alcance. Esclarecer isso. Também vale citar que existe contrato e licença de uso de imagem (por quanto tempo, em quais canais), assunto que as próximas aulas deveriam cobrir.
- "Mercado consolidado e em alta" e "falta mão de obra qualificada": são afirmações sem fonte. Ok como motivação, mas evitar transformá-las em promessa de que vai haver trabalho.
- Tipo da aula: é conceitual, não procedimento.
- Gênero: "já está pronto para começar" (mensagem final) no masculino. O público é feminino.
- Aula em PDF: é o segundo PDF do bônus, depois da v07 M04 A02. Confirmar que não há vídeo.

### V2.M07.A02 — Ecossistema UGC: Onde Encontrar Marcas que Pagam (6)

- ⚠️ A MIS se apresenta como plataforma de influenciadores: o site oficial descreve a MIS como "a maior plataforma de recrutamento de micro e nano influenciadores da América Latina". Se parte das campanhas exigir postar no próprio perfil ou ter número mínimo de seguidores, isso contradiz a Aula 01 ("sem postar, sem seguidores, sem engajamento"). Recomendo testar o app e documentar:
  - se existem campanhas só de UGC (entrega sem postagem);
  - os requisitos (seguidores, idade, CPF/CNPJ);
  - como e quando o pagamento é feito.
- ⚠️ Dependência de uma única plataforma: o PDF trata a MIS como "a" fonte de campanhas. Existem outras plataformas de UGC no Brasil (por exemplo Bloomer, BrandLovrs, The Creator, Creatify; não avaliadas aqui). Vale citar alternativas, para a aluna não ficar sem saída se a MIS não tiver campanhas para o perfil dela.
- "Mandar direct não funciona": é uma afirmação absoluta. Prospecção ativa pode funcionar com pequenas marcas. Pode-se suavizar para "não é o caminho mais fácil para começar".
- Falta o pós-candidatura: o PDF não explica o que acontece depois (aprovação, envio do produto, entrega do vídeo, revisões, pagamento). Conferir se a Aula 03 cobre.
- Transparência e contrato: valem os alertas da v07 M07 A01 (vídeo em estilo depoimento, uso de imagem).
- Nome da plataforma: "MIS" pode ser transcrito ou buscado como "Miss" ou "M.I.S.". Registrado nas grafias.

Seção "Fontes" (fora do bot):

- MIS – site oficial (https://mis-app.com/)
- MIS - Marketing de Influência – App Store (https://apps.apple.com/br/app/mis-marketing-de-influ%C3%AAncia/id1586854761)
- Noovid – 5 alternativas ao MIS (https://noovid.com/top-5-alternativas-ao-mis-em-2025/)
- Bloomer (https://www.bloomer.pro/) ·The Creator (https://thecreator.com.br/) ·Creatify (https://creatify.com.br/)

### V2.M07.A03 — Vitrine Criativa: Construindo Portfólio que Vende Sozinho (7)

- ⚠️ Portfólio com produtos de marcas sem parceria: gravar vídeos com produtos de casa é uma prática comum de portfólio. Vale orientar a:
  - deixar claro, quando necessário, que são vídeos de demonstração, e não trabalhos contratados pela marca;
  - não fingir parceria com a marca;
  - evitar alegações de resultado (especialmente skincare e cabelo) que não teve.
- Coerente com os alertas de transparência da v07 M07 A01.
- "Portfólio que vende sozinho": o título é forte. O PDF não promete contratação, mas vale não criar expectativa de que o portfólio garante campanhas.
- Falta definir quantidade e variedade: o PDF não diz quantos vídeos nem a duração de cada um. É uma dúvida provável no suporte.
- Link do Canva: orientar a gerar o link de visualização (não de edição) e a conferir se os vídeos tocam pelo link no celular.
- Pós-candidatura ainda sem cobertura: como apontado na A02, o processo depois da candidatura (aprovação, entrega, pagamento) ainda não foi explicado. Conferir as próximas aulas.
- Erro de diagramação no PDF: "em Começa", texto solto na página 2, sobra de outro título. Corrigir o arquivo.

### V2.M07.A04 — Propostas que Fecham Contratos (6)

- ⚠️ Mensagem genérica × personalização: o modelo do PDF é igual para qualquer campanha. As aulas de plataformas de freelancer do Método (99Freelas, Workana) ensinam propostas personalizadas, mostrando que leu o briefing. Sugiro acrescentar ao modelo uma frase específica da campanha, por exemplo: "Já uso produtos de skincare e posso mostrar a rotina de manhã, como pede o briefing". Isso também cumpre o "mostre que entendeu o que foi solicitado", que o próprio PDF pede.
- Preço e pagamento ausentes: o módulo ainda não explicou se as campanhas da MIS têm valor fixo ou se a criadora propõe o preço, nem como e quando recebe. É uma lacuna importante para o suporte. Conferir as próximas aulas.
- Botão "Aplicar": conferir se o nome ainda é esse no app atual da MIS.
- "Propostas que fecham contratos": o título promete fechamento. Vale lembrar que nem toda candidatura é aceita e que volume e constância de candidaturas importam.
- Sem orientação sobre recusas e acompanhamento: o PDF não diz o que fazer se não houver resposta (quantas candidaturas por dia, quando melhorar o portfólio). É uma provável dúvida no suporte.
- Linguagem: neutra. Está ok.

### V2.M07.A05 — Produção Inteligente: Máxima Qualidade, Mínimo Equipamento (6)

- Conflito aparente com o Módulo 03: o M03 ensina efeitos, transições, filtros e correção de cor. Aqui a orientação é evitar efeitos. Não é uma contradição de fato (UGC tem estilo próprio), mas vale explicitar: "Para UGC, use só cortes, ritmo e legenda. Os efeitos do M03 são para outros tipos de conteúdo."
- Áudio não é mencionado: em vídeo falado, o som limpo pesa tanto quanto a imagem. Sugerir ambiente silencioso e gravar perto do celular. Sem microfone, ainda dentro do "mínimo equipamento".
- Legendas: muitas campanhas pedem legenda. O PDF não cita. Ver as legendas automáticas da v07 M03 A11.
- Briefing da marca acima do estilo: "sem perfeição" não significa ignorar o briefing (duração, formato 9:16, pontos obrigatórios a falar). Reforçar que o vídeo deve seguir o briefing da campanha (v07 M07 A02).
- Música no vídeo UGC: se a aluna adicionar música, vale o alerta de direitos autorais da v07 M03 A06, porque o vídeo vai para anúncio da marca. Em geral, é melhor entregar sem música, salvo pedido da marca. Esta é uma sugestão da documentação.
- Linguagem: usa o feminino ("uma amiga"). Está ok.

### V2.M07.A06 — Lucro Recorrente com Mesmo Conteúdo (7)

- ⚠️ Título × conteúdo: "Lucro Recorrente" sugere clientes ou receita mensal, mas a aula trata de pacotes, direitos de uso e tabela de preços. Não há estratégia de recorrência (por exemplo, pacotes mensais com a mesma marca). Ajustar o título ou incluir esse tópico, que conversa com a v07 M05 A03.
- ⚠️ Negociação × plataforma MIS: a A02 diz que na MIS não é preciso "convencer ou se vender" e que a campanha já traz briefing e quantidade de vídeos. Esta aula supõe negociação direta (propor pacote, ajustar valor para anúncios). Esclarecer em que contexto isso se aplica: dentro da MIS (é possível negociar?) ou com marcas contatadas diretamente.
- Direitos de uso, faltam detalhes: além de "orgânico × pago", contratos de UGC costumam definir:
  - prazo de uso (30, 90 dias, perpétuo);
  - canais de veiculação;
  - exclusividade (não gravar para concorrentes);
  - se a marca pode editar o vídeo.
- Vale um checklist básico e a recomendação de combinar tudo por escrito.
- Ainda sem valores de referência: este é o terceiro PDF do módulo sem nenhuma faixa de preço. É provavelmente a dúvida nº 1 do suporte. Recomendo a equipe definir uma faixa de referência aprovada ou um método para a aluna pesquisar.
- Página duplicada: a "Conclusão" aparece duas vezes no PDF (páginas 6 e 7). Corrigir o arquivo.
- Gênero: "garante que você seja remunerado" no masculino. O público é feminino.

### V2.M07.A07 — Do Zero ao Sucesso: Seu PIX com UGC (7)

- ⚠️ "Seu PIX" no título, mas o pagamento nunca é explicado: o módulo inteiro (A01 a A07) não mostra como a aluna recebe: se a MIS paga, por qual meio (PIX?), em quanto tempo, se há taxa ou necessidade de CPF/CNPJ. O título desta aula reforça a expectativa. É uma lacuna crítica para o suporte. Testar o app e documentar.
- "Do zero ao sucesso" e "veja os resultados": é linguagem de promessa. Não há números, mas, somada ao "seu PIX", cria expectativa de ganho garantido. O próprio PDF reconhece que no início pode não haver resposta, o que é bom manter em destaque.
- "Quem só assiste ao curso": o tom pode soar culpabilizante para quem não teve resultado. Atenção em respostas de suporte e reembolso.
- Dependência exclusiva da MIS: o plano inteiro passa pela MIS. Ver a v07 M07 A02 sobre confirmar se a plataforma aceita UGC sem seguidores e sobre citar alternativas.
- Sem certificação: diferente dos Módulos 02 a 06, o M07 não tem aula de certificação, ou ela não foi enviada. Confirmar.
- Página duplicada: a "Conclusão" aparece duas vezes (páginas 5 e 6), como na A06. Corrigir o arquivo.
- Atualizações nas aulas anteriores: esta aula responde a duas dúvidas antes abertas: quantidade de vídeos no portfólio (A03) e frequência de candidaturas (A04). As documentações dessas aulas foram atualizadas.

### V2.M07.A08 — BÔNUS: Clube das Testadoras Secretas (8)

- 🚨 "Liberdade financeira" com produtos grátis: a aula repete várias vezes que testar produtos é "um caminho para conquistar mais liberdade financeira", "novas fontes de renda" e "o primeiro passo para a sua liberdade financeira". Mas os programas citados enviam produtos, não pagam. Isso cria expectativa enganosa de renda e tende a gerar reclamações e pedidos de reembolso. Recomendo reformular como "economizar, conhecer marcas e praticar avaliações e conteúdo (UGC)".
- ⚠️ Programas a verificar:
  - Home Tester Club: ativo no Brasil (site hometesterclub.com/br). Ok.
  - The Insiders Brasil: ativo (theinsidersnet.com/pt-br). Há reclamações de usuárias sobre não receber produtos. Ok, com expectativa ajustada.
  - BzzAgent: os registros de campanhas no Brasil que encontrei são de 2016 e 2017. Confirmar se ainda opera no Brasil antes de manter na aula.
  - Programas da Nivea, Philips e Nestlé: não verifiquei. Confirmar se existem e se os links da descrição funcionam.
- Formato: o cadastro informa "PDF", mas o arquivo enviado é transcrição de fala (provavelmente vídeo). Conferir o formato e a duração reais.
- Divulgação nas redes: quando o programa pede postagem do produto recebido gratuitamente, isso pode exigir identificação de publicidade ou permuta (CONAR). A aula não menciona.
- Dados pessoais: os programas pedem endereço e dados detalhados. Orientar a se cadastrar só nos sites oficiais (há muitos golpes de "amostra grátis").
- "Oceano azul de oportunidades": linguagem exagerada.
- Gênero inconsistente: fala em "mulheres como você" e "selecionada", mas também "seja específico", "interessado", "seja honesto".
- Erros de transcrição:
  - "Denxiders" (é "The Insiders");
  - "Tapuera" (é "Tupperware");
  - "Vic" (é "Vichy");
  - "BuzzAgent" (nome oficial "BzzAgent");
  - "uma enorme de produtos" (falta "variedade");
  - "ser independente de ninguém" (é "não depender de ninguém").

Seção "Fontes" (fora do bot):

- Home Tester Club Brasil (https://www.hometesterclub.com/br/pt)
- The Insiders – campanha Pampers (pt-br) (https://www.theinsidersnet.com/pt-br/campaigns/info/10955/novapamperspremiumcare.htm)
- Reclame Aqui – The Insiders Brasil (https://www.reclameaqui.com.br/the-insiders-brasil/nao-tem-base-para-enviarem-produtos_6UuSBVsXUmk7A7nR/)
- Meio & Mensagem – BzzAgent (https://www.meioemensagem.com.br/ultimas-noticias/para-bzzagent-todos-somos-influenciadores)
- BzzAgent Brasil – campanha de 2016 (blog) (https://kitchenfordummies.com/2016/08/14/chegou-por-aqui-bzz-agent-brasil-campanha-nutry/)

### V2.M07.A09 — Certificação UGC (9)

- ⚠️ Título × arquivo: a aula se chama "Certificação UGC", mas o arquivo é o material complementar, sem texto de certificação nem instrução de emissão. Confirmar se:
  - (a) é este mesmo o arquivo da aula, e o título deveria ser "Material Complementar";
  - (b) existe uma aula de certificação separada;
  - (c) o certificado é emitido abaixo deste PDF.
- ⚠️ Páginas de outro módulo no PDF: há páginas com conteúdo do Módulo 06 misturadas: o sumário "FASE 01 – GESTÃO DE TEMPO PESSOAL (Matriz de Prioridades, Engenharia de Hábitos, Dashboard Pessoal)" e o bloco "QUANDO ALGO SAI DO PLANO: PIVOTAR". São sobras de outro material. Remover. Isso também sugere que o Módulo 06 tem um material complementar semelhante e explica a "fase 2" citada na v07 M06 A03.
- ⚠️ Modelo de candidatura diz "Tenho experiência": para iniciantes, a frase é falsa e contradiz o próprio guia ("nada de pedir desculpa por estar começando" não é o mesmo que inventar experiência). Sugerir: "Crio vídeos autênticos de UGC e adoraria participar…". Também diverge do modelo do PDF da A04 ("Entrego em X dias"). Vale unificar.
- ⚠️ Promessa de PIX: "Faça no seu ritmo, com consistência, e o primeiro PIX vai chegar. E, a partir dele, tudo muda." Soa como garantia de ganho. E o módulo continua sem explicar como o pagamento acontece (ver a v07 M07 A07).
- "Sem aparecer": o guia diz que você não precisa "aparecer". Os vídeos de UGC em geral mostram a criadora. Ver a v07 M07 A01.
- Nomes errados no PDF: "Best Agent" (é BzzAgent) e "Densigners Brasil" (é The Insiders Brasil). Corrigir. O aviso "confirme sempre no site oficial" é bom e deve ficar.
- Melhorias em relação às aulas: o guia já corrige algumas lacunas apontadas antes. Inclui a ação prática por aula, deixa o celular "firme e estável", define pacotes de 2, 3 ou 5 vídeos, traz a estrutura de avaliação e um aviso sobre disponibilidade dos programas. A frase das testadoras é mais honesta que a da aula ("você fica com o produto"), mas o guia mantém "oportunidades extras".
- Erros de diagramação:
  - hifenização quebrada ("re‐ cebe", "organiza‐ do", "portfó‐ lio", "cuida‐ do", "experi‐ mentar");
  - sumário com o número "05" repetido (Produção e Lucro Recorrente);
  - a seção "Produção Inteligente" reaproveita o subtítulo da A04 ("Candidatar-se não é pedir uma oportunidade…").
- Linguagem: usa o feminino ("perfeita", "escolhida", "Obrigada!"). Está ok.

### V3.M01.A01 — Descobrindo o Mundo UpWork (6)

- 🚨 Nome de outro produto na gravação: "Seja bem-vinda a mais uma aula da nossa mentoria Projetos Remunerados" (transcrito como "Imunerados"). A aluna comprou o Método Sócia Invisível, e este é o bônus Missão Dólar Rápido. Mais uma ocorrência do problema recorrente de nomes de outros produtos nas gravações. Pode gerar desconfiança ("comprei outra coisa?"). Regravar ou cortar a frase.
- ⚠️ Upwork × Freelancer: o título é "Descobrindo o Mundo Upwork", mas a Gabriela diz que vai mostrar "a plataforma Freelancer". São plataformas diferentes. O Freelancer.com já é ensinado no v01 M13. Confirmar qual plataforma o bônus ensina e ajustar o título ou a fala.
- ⚠️ "Sem precisar falar inglês": plataformas internacionais operam em inglês (projetos, propostas, conversas com clientes). Dá para usar tradutor, mas afirmar que não precisa de inglês pode gerar frustração. Sugiro "mesmo sem ser fluente, com a ajuda de tradutores".
- Promessa de ganho: "Isso não é promessa mágica, é realidade pra quem decide se comprometer". O tom é aceitável, mas "aumentar sua renda em moeda forte" junto com o nome "Dólar Rápido" cria expectativa de ganho rápido. Atenção ao discurso nas próximas aulas.
- Tipo da aula: é abertura motivacional, não procedimento.
- Erros de transcrição:
  - "Projetos Imunerados" e "microprojetos imunerados" (é "Remunerados");
  - "estar disposta e aprender" (é "disposta a aprender").

### V3.M02.A01 — Estratégias de Alta Performance no 99Freelas (8)

- 🚨 Promessa de retorno garantido: "você pagando esse plano com certeza você já vai ter um retorno ali imediato e já vai receber de volta esses R$ 49,90" e "você vai conseguir fazer entre 1 a 10 projetos por dia". Isso é promessa de resultado financeiro: incentiva a aluna a gastar com base numa garantia que não existe. Risco de reclamação e reembolso, e de responsabilização. Recomendo cortar ou reformular ("o plano dá mais conexões; o retorno depende de propostas bem feitas").
- 🚨 Nome de outro produto: "Mais uma aula do projetos remunerados". É a mesma ocorrência da v08 M01 A01.
- ⚠️ Bônus "Dólar" ensinando plataforma em real: o II Bônus se chama Missão Dólar Rápido, mas esta aula é sobre o 99Freelas, que é brasileiro e paga em reais, e já é ensinado no v01 M07. Conferir o propósito do módulo.
- ⚠️ Workana anunciada e não mostrada: "uma dica sobre as plataformas 99 frilas e a Orkana", mas só o 99Freelas aparece. Atualização: a Workana é mostrada na Aula 02 deste módulo. Basta ajustar a abertura ("nesta aula, o 99Freelas; na próxima, a Workana").
- Inconsistências com o v01 M07: o plano gratuito tem 10 conexões aqui e no v01 M07 A03, mas 20 no v01 M07 A04. O preço do Premium não é dito aqui (o v01 M07 cita R$ 89,90). Conferir os valores atuais no site e padronizar todos os materiais.
- Preços sujeitos a mudança: os valores seguem a gravação. Conferir periodicamente.
- "Minha executiva": é um tratamento de outra marca ou produto? Conferir.
- Erros de transcrição:
  - "Orkana" (é "Workana");
  - "99 frilas" (é "99Freelas");
  - "nessa nessa base que a gente não consegue ver" (trecho truncado: no plano básico não dá para ver o valor médio).

### V3.M02.A02 — O Código da Excelência no Workana (6)

- 🚨 Promessa de resultado: "eu tenho certeza que agora, colocando tudo isso em prática, você vai fechar muitos projetos e começar a mudar a sua realidade" e "cada projeto que você fechar, você já está pagando o valor do Workana rapidinho, sem nenhuma desvantagem". É o mesmo problema da v08 M02 A01: incentivo a gastar com garantia implícita de retorno. Recomendo reformular.
- ⚠️ Pedido de depoimento de faturamento: "Eu te espero aí com o seu depoimento, me contando que você já conseguiu faturar muito." Depoimentos coletados assim podem virar prova social de marketing. Garantir que sejam reais e autorizados (ver os alertas da v07 M02 A04).
- ⚠️ Planos divergentes entre os materiais: esta aula cita um plano de R$ 21,90 e os planos "Profissional" e "Explorer". A documentação do v01 M08 A01 (fonte externa de setembro/2026) lista Básico (grátis), PLUS (~R$ 49) e PRO (~R$ 99). Os nomes e os preços não batem. Conferir no site oficial os planos atuais e padronizar. O nome do plano de R$ 21,90 saiu como "benigno" na transcrição; conferir no vídeo.
- Bônus "Dólar" com conteúdo repetido: como na A01, o conteúdo (Workana) já é ensinado no v01 M08. O único conteúdo novo é a comparação de planos. Conferir o propósito do módulo.
- "Minha executiva": tratamento que também aparece na A01. Conferir se é de outro produto.
- Erros de transcrição:
  - "Worcana" (é "Workana");
  - "benigno" (nome do plano incerto);
  - "o Worcana, ele já começa" (concordância);
  - "você vai estar a altura" (é "à altura").

## Ajustes automáticos no texto

Pedaços tirados das seções que entram no bot porque apontavam para "Pontos a validar", para seções que ficaram fora ou para fontes externas:

- **V1.M04.A01**: “(Ver o ponto a validar sobre a definição.)”
- **V1.M04.A03**: “Sofia”
- **V1.M04.A04**: “(Ver o ponto a validar sobre o modelo real.)”
- **V1.M08.A01**: “Ver os pontos a validar.” · “(ver abaixo)”
- **V1.M08.A02**: “Ver o ponto a validar abaixo.”
- **V1.M08.A03**: “(ver os pontos a validar)”
- **V1.M08.A06**: “⚠️ Ver os pontos a validar: esses horários estão errados.” · “⚠️ Ver os pontos a validar.” · “sem a correção abaixo”
- **V1.M09.A02**: “Ver os pontos a validar.” · “(ver abaixo)”
- **V1.M09.A03**: “⚠️ Ver os pontos a validar.” · “⚠️ Ver os pontos a validar.”
- **V1.M09.A04**: “ver os pontos a validar.” · “⚠️ Ver os pontos a validar.” · “Ver o ponto crítico abaixo.”
- **V1.M09.A06**: “(ver os pontos a validar)”
- **V1.M09.A09**: “(ver os pontos a validar)”
- **V1.M09.A10**: “⚠️ Ver os pontos a validar.”
- **V1.M09.A11**: “Ver os pontos a validar.”
- **V1.M09.A12**: “(ver os pontos a validar)” · “(ver os pontos a validar)” · “Ver o ponto a validar abaixo e orientar”
- **V1.M01.A01**: “Sofia” · “Sofia” · “Sofia” · “Sofia” · “Sofia” · “Sofia” · “Sofia” · “Sofia”
- **V1.M10.A05**: “Ver os pontos a validar.”
- **V1.M10.A06**: “⚠️ Ver os pontos a validar.”
- **V1.M10.A07**: “⚠️ Ver os pontos a validar.”
- **V1.M11.A01**: “(ver os pontos a validar)” · “Ver o ponto a validar.”
- **V1.M11.A07**: “⚠️ Ver os pontos a validar.”
- **V1.M12.A01**: “⚠️ Ver os pontos a validar: fontes externas descrevem outro modelo.” · “Ver os pontos a validar (informações externas) e confirmar no site oficial.” · “Ver o alerta de reputação abaixo.”
- **V1.M12.A03**: “Segundo fonte externa, é de cerca de 12% por serviço.” · “Segundo fonte externa, o valor é liberado 7 dias depois da conclusão do serviço.” · “Ver o alerta de reputação na Aula 01 deste módulo.”
- **V1.M13.A04**: “⚠️ Ver os pontos a validar.”
- **V1.M13.A05**: “⚠️ Ver os pontos a validar.”
- **V1.M14.A01**: “Ver os pontos a validar.” · “(ver abaixo)”
- **V1.M02.A01**: “Gabi Vittorino” · “Gabi Vittorino”
- **V1.M02.A02**: “decidir entre pedir reembolso (prazo de 7 dias) ou aceitar uma condição proposta pela mentora e entrar” · “Gabriela Vitorino” · “- Opção A: pedir reembolso dentro de 7 dias.” · “Opção B:” · “- "Posso pedir reembolso?" A própria aula cita a garantia de 7 dias. Seguir a política oficial de reembolso.” · “(ver abaixo)”
- **V1.M02.A03**: “Se não quiser fazer isso, deve pedir reembolso pelo WhatsApp.” · “Caminho A (seguir no método):” · “- Caminho B (sair): ir ao WhatsApp do suporte e escrever "solicitar reembolso".” · “- "Como peço reembolso?" A aula orienta escrever "solicitar reembolso" no WhatsApp do suporte. Seguir a política oficial de reembolso: garantia de 7 dias, citada na Aula 02.” · “Ver os pontos a validar e definir uma resposta padrão.” · “(ver abaixo)”
- **V1.M03.A01**: “Sofia”
- **V1.M03.A02**: “Ver o ponto a validar abaixo.”
- **V1.M06.A04**: “Ver o ponto a validar abaixo.”
- **V1.M07.A01**: “Ver os pontos a validar.” · “(ver abaixo)”
- **V1.M07.A03**: “(ver os pontos a validar)”
- **V1.M07.A04**: “(ver os pontos a validar)”
- **V1.M07.A05**: “Ver o ponto a validar abaixo.” · “Ver o ponto a validar sobre esse bônus (também citado no M06 A04).” · “- "Onde fica o Skills das Subdemandas?"”
- **V1.M07.A06**: “(Ver os pontos a validar.)” · “Ver o ponto a validar abaixo.”
- **V2.M05.A04**: “(ver os pontos a validar)” · “Ver os pontos a validar.”
- **V2.M05.A05**: “Ver os pontos a validar sobre como descrever o certificado.”
- **V2.M02.A01**: “Ver o ponto a validar.”
- **V2.M02.A04**: “⚠️ Ver os pontos a validar.”
- **V2.M02.A05**: “(ver os pontos a validar)”
- **V2.M02.A06**: “Ver o ponto a validar sobre mensagens não solicitadas.”
- **V2.M02.A07**: “(ver os pontos a validar)” · “(ver abaixo)”
- **V2.M03.A02**: “ver os pontos a validar.” · “⚠️ Segurança:”
- **V2.M03.A04**: “(ver abaixo)”
- **V2.M03.A10**: “Ver o ponto a validar.”
- **V2.M03.A12**: “(ver os pontos a validar)”
- **V2.M04.A02**: “Ver os pontos a validar antes de recomendar.” · “- "Meu post não teve alcance, posso repostar?"”
- **V2.M04.A03**: “Ver também o ponto a validar sobre limites.”
- **V2.M04.A05**: “Ver os pontos a validar: a aula não mostra onde ficam.”
- **V2.M06.A03**: “Ver os pontos a validar.”
- **V2.M06.A05**: “Ver os pontos a validar.”
- **V2.M07.A02**: “Ver os pontos a validar.”
- **V2.M07.A04**: “Ver os pontos a validar.” · “Ver os pontos a validar.”
- **V2.M07.A06**: “Ver os pontos a validar.”
- **V2.M07.A07**: “Ver os pontos a validar.”
- **V2.M07.A08**: “Ver os pontos a validar sobre o discurso de "liberdade financeira".”
- **V3.M01.A01**: “Gabriela Vitorino” · “Ver os pontos a validar: em plataformas internacionais, o inglês básico (ou um tradutor) é necessário para ler projetos e se comunicar com clientes.” · “Ver os pontos a validar e as próximas aulas.” · “Ver os pontos a validar.”
- **V3.M02.A01**: “Ver os pontos a validar.”

## Aulas

| Aula | Título | Trechos | Produto | Duração | Link |
|---|---|---|---|---|---|
| V1.M04.A01 | Demandas Cash: Como e Por Que Funciona? | 6 | principal | 2:46 | https://alunos.demandasinvisiveis.com/member/1/4 |
| V1.M04.A02 | As Leis das Demandas Lucrativas: O que PODE e o que NÃO PODE | 5 | principal | 7:08 | https://alunos.demandasinvisiveis.com/member/1/4 |
| V1.M04.A03 | Vantagens de Realizar as Demandas | 4 | principal | 5:16 | https://alunos.demandasinvisiveis.com/member/1/4 |
| V1.M04.A04 | Ciclo de Pagamento: O que é e Como Funciona | 3 | principal | 4:09 | https://alunos.demandasinvisiveis.com/member/1/4 |
| V1.M04.A05 | Tudo que você aprendeu | 4 | principal | 4:07 | https://alunos.demandasinvisiveis.com/member/1/4 |
| V1.M05.A01 | Mindset da Dupla Jornada: Como Mulheres estão Multiplicando sua Renda | 4 | principal | 5:24 | https://alunos.demandasinvisiveis.com/member/1/5 |
| V1.M05.A02 | Auditoria de Tempo: Descobrindo Suas Horas Perdidas | 6 | principal | 7:09 | https://alunos.demandasinvisiveis.com/member/1/5 |
| V1.M05.A03 | A Arte de Fazer Mais Trabalhando Menos | 7 | principal | 7:21 | https://alunos.demandasinvisiveis.com/member/1/5 |
| V1.M05.A04 | SOS Sobrecarga: Como Identificar e Resolver | 7 | principal | 5:58 | https://alunos.demandasinvisiveis.com/member/1/5 |
| V1.M05.A05 | Liberdade Planejada: Construindo Sua Saída do CLT | 6 | principal | 4:42 | https://alunos.demandasinvisiveis.com/member/1/5 |
| V1.M08.A01 | O Código das Demandas no Workana | 6 | principal | 3:57 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M08.A02 | Construindo Sua Vitrine Digital no Workana | 4 | principal | 1:55 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M08.A03 | O Ciclo da Realização: Como Receber | 3 | principal | 1:51 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M08.A04 | Mapeamento Inteligente: Identificando Demandas Lucrativas | 3 | principal | 2:41 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M08.A05 | Bônus 1: Precificação Inteligente para Ganhar Mais | 10 | principal | 8:05 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M08.A06 | Bônus 2: Hacks Avançados para o Workana | 7 | principal | 7:27 | https://alunos.demandasinvisiveis.com/member/1/8 |
| V1.M09.A01 | Como Lucrar com Pesquisas Reais | 4 | principal | 4:31 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A02 | O Poder da Sua Opinião | 6 | principal | 5:52 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A03 | O Jogo do Algoritmo: Domine as Regras e Multiplique Suas Oportunidades | 6 | principal | 4:17 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A04 | Ganhos Reais com Pesquisas: A Estratégia Oculta | 6 | principal | 6:54 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A05 | Como Transformar Suas Opiniões em Renda Consistente | 4 | principal | 3:03 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A06 | Transforme Cliques em Dinheiro com GrabPoints | 5 | principal | 2:39 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A07 | AttaPoll na Prática: Como Lucrar com Pesquisas no Celular | 5 | principal | 2:47 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A08 | Ganhos Diretos via PIX: Descubra o Falaí | 5 | principal | 2:54 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A09 | Ganhe em Dólares com o Voissy | 4 | principal | 1:50 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A10 | Como Lucrar com Pesquisas e Missões Criativas na MeSeems | 5 | principal | 3:01 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A11 | Como Ser um Agente Secreto do Consumo na Modatta | 4 | principal | 2:49 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M09.A12 | Ysense: O Clássico das Pesquisas Remuneradas | 6 | principal | 3:21 | https://alunos.demandasinvisiveis.com/member/1/9 |
| V1.M01.A01 | Aula de Boas-Vindas | 5 | principal | 11:24 | https://alunos.demandasinvisiveis.com/member/1/1 |
| V1.M10.A01 | O Código das Demandas no Vinte Pila | 6 | principal | 4:01 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A02 | Construindo Sua Vitrine Digital no Vinte Pila | 4 | principal | 2:35 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A03 | O Ciclo da Realização: Como Receber | 3 | principal | 0:53 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A04 | Cadastro Inteligente de Demandas | 4 | principal | 2:07 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A05 | Mapeamento Inteligente: Identificando Demandas Lucrativas | 3 | principal | 2:13 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A06 | Bônus: O Poder do Follow-up: Como Transformar Silêncio em Contratos | 4 | principal | 5:08 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M10.A07 | Bônus: Hacks Avançados para o Vinte Pila | 4 | principal | 5:34 | https://alunos.demandasinvisiveis.com/member/1/10 |
| V1.M11.A01 | O Código das Demandas no GETNINJAS | 5 | principal | 4:03 | https://alunos.demandasinvisiveis.com/member/1/11 |
| V1.M11.A02 | Construindo Sua Vitrine Digital no GETNINJAS | 4 | principal | 1:57 | https://alunos.demandasinvisiveis.com/member/1/11 |
| V1.M11.A03 | Fazendo Demandas Mobile: App GETNINJAS | 3 | principal | 2:42 | https://alunos.demandasinvisiveis.com/member/1/11 |
| V1.M11.A04 | O Ciclo da Realização: Como Receber | 4 | principal | 1:29 | https://alunos.demandasinvisiveis.com/member/1/11 |
| V1.M11.A07 | Bônus: Hacks Avançados para o GETNINJAS | 4 | principal | 7:36 | https://alunos.demandasinvisiveis.com/member/1/11 |
| V1.M12.A01 | O Código das Demandas no VINTE CONTO | 5 | principal | 3:45 | https://alunos.demandasinvisiveis.com/member/1/12 |
| V1.M12.A02 | Construindo Sua Vitrine Digital no VINTE CONTO | 4 | principal | 1:09 | https://alunos.demandasinvisiveis.com/member/1/12 |
| V1.M12.A03 | O Ciclo da Realização: Como Receber | 3 | principal | 1:09 | https://alunos.demandasinvisiveis.com/member/1/12 |
| V1.M12.A04 | Cadastro Inteligente de Demandas | 4 | principal | 4:24 | https://alunos.demandasinvisiveis.com/member/1/12 |
| V1.M13.A02 | Construindo Sua Vitrine Digital no FREELANCER | 4 | principal | 2:41 | https://alunos.demandasinvisiveis.com/member/1/13 |
| V1.M13.A03 | O Ciclo da Realização: Como Receber | 3 | principal | 1:58 | https://alunos.demandasinvisiveis.com/member/1/13 |
| V1.M13.A04 | Mapeando as Melhores Demandas para o Seu Perfil | 3 | principal | 6:21 | https://alunos.demandasinvisiveis.com/member/1/13 |
| V1.M13.A05 | Venda PRO: Estratégias Avançadas para Lucrar Mais com Demandas | 4 | principal | 7:24 | https://alunos.demandasinvisiveis.com/member/1/13 |
| V1.M14.A01 | O Chamado Rosa: Conheça o Mundo Wepink | 4 | principal | 1:22 | https://alunos.demandasinvisiveis.com/member/1/14 |
| V1.M14.A02 | Por Dentro da Máquina Rosa: Como Funciona a Wepink | 4 | principal | 2:14 | https://alunos.demandasinvisiveis.com/member/1/14 |
| V1.M15.A01 | Magnetismo Natural | 5 | principal | 5:32 | https://alunos.demandasinvisiveis.com/member/1/15 |
| V1.M15.A02 | Conexão Instantânea | 4 | principal | 5:12 | https://alunos.demandasinvisiveis.com/member/1/15 |
| V1.M16.A01 | As Habilidades Mais Procuradas e Como Se Destacar | 4 | principal | 6:36 | https://alunos.demandasinvisiveis.com/member/1/16 |
| V1.M02.A01 | Quem é a Gabriela e por que ela entende sua realidade | 4 | principal | 4:56 | https://alunos.demandasinvisiveis.com/member/1/2 |
| V1.M02.A02 | A tribo das Supremas | 4 | principal | 5:57 | https://alunos.demandasinvisiveis.com/member/1/2 |
| V1.M02.A03 | A Decisão | 4 | principal | 11:01 | https://alunos.demandasinvisiveis.com/member/1/2 |
| V1.M03.A01 | Como eu saí do CLT para faturar mais de 3 Milhões em 12 meses com as Demandas | 5 | principal | 5:43 | https://alunos.demandasinvisiveis.com/member/1/3 |
| V1.M03.A02 | A Trilha da Sua Liberdade | 4 | principal | 3:54 | https://alunos.demandasinvisiveis.com/member/1/3 |
| V1.M03.A03 | Quanto custa NÃO começar hoje | 4 | principal | 5:28 | https://alunos.demandasinvisiveis.com/member/1/3 |
| V1.M03.A04 | Home Office Master & Produtividade Inteligente | 3 | principal | 6:20 | https://alunos.demandasinvisiveis.com/member/1/3 |
| V1.M06.A01 | A Mentira que Contaram Sobre Suas Habilidades | 6 | principal | PDF (21 páginas) | https://alunos.demandasinvisiveis.com/member/1/6 |
| V1.M06.A02 | Traduzindo a Rotina para o Mercado Digital | 8 | principal | PDF (29 páginas) | https://alunos.demandasinvisiveis.com/member/1/6 |
| V1.M06.A03 | O Seu Inventário de Ouro | 5 | principal | PDF (18 páginas) | https://alunos.demandasinvisiveis.com/member/1/6 |
| V1.M06.A04 | Como Empacotar o que Você Sabe | 6 | principal | PDF (19 páginas) | https://alunos.demandasinvisiveis.com/member/1/6 |
| V1.M07.A01 | O Código das Demandas no 99Freelas | 5 | principal | 3:22 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V1.M07.A02 | Construindo Sua Vitrine Digital no 99Freelas | 4 | principal | 2:28 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V1.M07.A03 | O Ciclo da Realização: Como Receber | 4 | principal | 0:44 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V1.M07.A04 | Mapeamento Inteligente: Identificando Demandas Lucrativas | 3 | principal | 2:21 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V1.M07.A05 | Bônus 01: Como Mandar Propostas Irresistíveis: Como Garantir o "Sim" | 7 | principal | 8:42 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V1.M07.A06 | Bônus 02: Hacks Avançados para o 99Freelas | 6 | principal | 8:15 | https://alunos.demandasinvisiveis.com/member/1/7 |
| V2.M05.A01 | Construindo Relacionamentos que Geram Indicações | 4 | principal | 2:50 | https://alunos.demandasinvisiveis.com/member/2/22 |
| V2.M05.A02 | Personal Branding: Tornando-se a Primeira Opção | 4 | principal | 2:34 | https://alunos.demandasinvisiveis.com/member/2/22 |
| V2.M05.A03 | Funil de Clientes Recorrentes: Da Primeira Venda ao Cliente Fiel | 4 | principal | 3:08 | https://alunos.demandasinvisiveis.com/member/2/22 |
| V2.M05.A04 | Automação de Processos: Otimizando Tempo e Aumentando Lucro | 4 | principal | 2:45 | https://alunos.demandasinvisiveis.com/member/2/22 |
| V2.M05.A05 | Certificação | 3 | principal | 1:33 | https://alunos.demandasinvisiveis.com/member/2/22 |
| V2.M01.A01 | Encontrando Suas Skills Ocultas | 3 | principal | 5:02 | https://alunos.demandasinvisiveis.com/member/2/18 |
| V2.M01.A02 | DNA de Talentos: Enxergando Além do Óbvio | 6 | principal | 4:52 | https://alunos.demandasinvisiveis.com/member/2/18 |
| V2.M02.A01 | Por que suas palavras não vendem (e como mudar isso hoje) | 4 | principal | 1:56 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A02 | A Persona – Quem você está tentando convencer? | 4 | principal | 4:40 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A03 | A Grande Ideia – O que faz alguém parar tudo pra te ouvir | 4 | principal | 5:01 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A04 | Os Gatilhos que Movem Pessoas | 4 | principal | 4:15 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A05 | Estratégias que Conectam: O Caminho para Resultados Reais | 4 | principal | 4:50 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A06 | Onde usar tudo isso pra fazer dinheiro | 3 | principal | 4:19 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M02.A07 | Certificação | 3 | principal | 2:59 | https://alunos.demandasinvisiveis.com/member/2/19 |
| V2.M03.A01 | O Estúdio Secreto do Seu Smartphone | 4 | principal | 4:05 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A02 | Dominando a Iluminação Sem Equipamentos Caros | 4 | principal | 4:29 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A04 | Apps que Transformam Amadores em Profissionais | 4 | principal | 6:01 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A05 | Transformando Fotos em Conteúdo Magnético | 4 | principal | 4:21 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A07 | CapCut do Zero: Dominando os Primeiros Passos | 4 | principal | 13:45 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A08 | Cortes Perfeitos: Ritmo e Fluxo de Edição no CapCut | 5 | principal | 12:34 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A09 | Impacto Visual: Texto, Legendas e Efeitos que Engajam | 4 | principal | 28:00 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A10 | Toque Final: Finalização, Exportação e Recapitulando Tudo | 4 | principal | 21:09 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A11 | Automatização Inteligente: Legendas Automáticas e Biblioteca do CapCut | 3 | principal | 4:25 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M03.A12 | Certificação | 4 | principal | 3:28 | https://alunos.demandasinvisiveis.com/member/2/20 |
| V2.M04.A01 | Anatomia das Redes | 7 | principal | 4:02 | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M04.A02 | Fábrica de Conteúdo: Produzindo 30 Posts em 1 Dia | 5 | principal | PDF (9 páginas) | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M04.A03 | Copywriting, Hashtags e SEO para Redes Sociais | 5 | principal | 4:13 | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M04.A04 | Criando Reels, Stories e TikToks que Vendem | 5 | principal | 4:26 | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M04.A05 | Analytics e Otimização: Lendo os Dados como um Profissional | 5 | principal | 3:13 | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M04.A06 | Certificação | 4 | principal | 2:29 | https://alunos.demandasinvisiveis.com/member/2/21 |
| V2.M06.A01 | Matriz de Prioridades: Focando no que Realmente Importa | 4 | principal | 1:56 | https://alunos.demandasinvisiveis.com/member/2/23 |
| V2.M06.A03 | Arquitetura de Projetos: Do Caos à Execução | 4 | principal | 2:13 | https://alunos.demandasinvisiveis.com/member/2/23 |
| V2.M06.A04 | Gestão Inteligente: Produtividade e Prazos | 4 | principal | 4:30 | https://alunos.demandasinvisiveis.com/member/2/23 |
| V2.M06.A05 | Certificação em Gestão Integrada de Tempo e Projetos | 3 | principal | 1:49 | https://alunos.demandasinvisiveis.com/member/2/23 |
| V2.M07.A01 | UGC: Entendendo o Negócio por Trás do Conteúdo | 7 | principal | PDF (6 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A02 | Ecossistema UGC: Onde Encontrar Marcas que Pagam | 4 | principal | PDF (6 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A03 | Vitrine Criativa: Construindo Portfólio que Vende Sozinho | 4 | principal | PDF (5 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A04 | Propostas que Fecham Contratos | 4 | principal | PDF (5 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A05 | Produção Inteligente: Máxima Qualidade, Mínimo Equipamento | 4 | principal | PDF (5 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A06 | Lucro Recorrente com Mesmo Conteúdo | 3 | principal | PDF (7 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A07 | Do Zero ao Sucesso: Seu PIX com UGC | 4 | principal | PDF (6 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A08 | BÔNUS: Clube das Testadoras Secretas | 4 | principal | PDF (informado) — o arquivo enviado é transcrição de fala, provavelmente vídeo | https://alunos.demandasinvisiveis.com/member/2/24 |
| V2.M07.A09 | Certificação UGC | 5 | principal | PDF (57 páginas) | https://alunos.demandasinvisiveis.com/member/2/24 |
| V3.M01.A01 | Descobrindo o Mundo UpWork | 3 | principal | 1:07 | https://alunos.demandasinvisiveis.com/member/3/25 |
| V3.M02.A01 | Estratégias de Alta Performance no 99Freelas | 3 | principal | 3:49 | https://alunos.demandasinvisiveis.com/member/3/26 |
| V3.M02.A02 | O Código da Excelência no Workana | 3 | principal | 2:35 | https://alunos.demandasinvisiveis.com/member/3/26 |
