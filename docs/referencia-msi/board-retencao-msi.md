# Board "Retenção de Reembolso IA Suporte MSI" → bot

Board no Miro: https://miro.com/app/board/uXjVHt4MHxo=/ (lido em 08/10/2026 pelo SDK do Miro na página, só leitura:
166 caixas, 196 ligações). Os textos estão, palavra por palavra, em `src/oferta/protocolo-7d.ts`, com o número da caixa
(`#n`) nos comentários. Se o board mudar, ler de novo e atualizar esse arquivo.

## Como o board virou fluxo

| Board | No bot |
|---|---|
| #105 abertura ("Oiie, [nome]! Recebi a sua solicitação…") | `N002_ACOLHIMENTO` (1ª frase) + `N004_DIAGNOSTICO` (resto) |
| Situação "não estou conseguindo resultado / não caiu PIX" #2 | Rota `1`; dúvida "🤔 Ainda Fiquei com Dúvida" → `1D` |
| Situação "não tenho tempo / rotina corrida" #17 | Rota `4`; dúvida "⏱️ Não Sei Se Cabe na Minha Rotina" → `4D` |
| Situação "não tenho tempo" #97 (2ª versão) | Rota `4B` (frase com "tempo" sem falar da rotina); dúvida → `4BD` |
| Situação "não era isso que eu esperava" #39 | Rota `11`; dúvida "🤷‍♀️ Acho Que Não É Pro Meu Perfil" → `11D` |
| Situação "comprei por impulso" #56 | Rota `2`; dúvida "😰 Não Sei Se Fiz a Escolha Certa" → `2D` |
| Situação "estou apertada financeiramente" #76 | Rota `3`; dúvida "⚡ Preciso de Dinheiro Rápido" → `3D` |
| Objeção prazo / medo do prazo vencer #126 | Rota `5` (também a pergunta hipotética "posso pedir depois?") |
| Objeção "não tenho certeza se vou conseguir aplicar" #131 | Rota `6` |
| Objeção "não sei fazer nada / sem habilidade" #141 | Rota `7` |
| Objeção "já tentei outras coisas" #147 | Rota `8` |
| Objeção "já conheço essas empresas e plataformas" #152 | Rota `9` |
| Objeção "e se eu não tiver resultado?" #157 | Rota `10` (a pergunta com "?" cai na Rota 5, regra hipotética) |
| "Cliente muda de ideia e quer continuar" #162 | Rota `MD` (vence a palavra "reembolso" da frase) → aceite direto |
| "Quebra de objeção geral com foco na Soffia" #115 ("usar em todos os casos") | Rota `SF` = 1º reenquadramento depois de uma recusa |
| Condição exclusiva de cada situação | `condicao` da rota (mensagens + botão de aceite e de recusa) |
| Condição geral #137–#139 (botões #140/#146) | `CONDICAO_GERAL` (objeções, Soffia e rotas sem condição própria) |
| "Espera responder" | `continuacao` da rota: o bot pergunta, espera a resposta e só então segue com os botões |
| Aceite #90 ("A sua virada começa AGORA!") | `N143_CONFIRMACAO` + `WHATSAPP_7D_MENSAGEM` (com o botão do WhatsApp) |
| E-mail #121 → #122 → #123 → #124 | `N154_REEMBOLSO` + `N155_FECHAMENTO` (só na 4ª recusa) |
| #122–#124 sem o e-mail | `COBRANCA_PRAZO` (quem diz que já mandou o pedido) |
| "Cliente insiste no reembolso após as tentativas" #166 | régua de 4 insistências do motor |

## Diferenças de propósito (confirmadas pela dona do produto em 08/10/2026)
1. **Régua de 4 insistências (restrição herdada do MGA).** No board, "❌ Prefiro Deixar Como Está" vai direto para o
   e-mail. No bot, a 1ª recusa recebe o argumento da Soffia, a 2ª o #129 ("quem está assumindo o risco sou eu"), a 3ª o
   #139 ("não seria mais inteligente testar?") e só a 4ª recebe o e-mail.
2. **O bot não fala como a Gabi.** Frases do board na 1ª pessoa da Gabi (história pessoal, "o método que eu montei",
   "meu filho", "sou mãe, empresária") foram para a 3ª pessoa ("a Gabi montou…"). Restrição herdada: o bot nunca finge
   ser a expert. "Comigo e com a minha equipe" ficou como está.
3. **Gênero:** adjetivos dirigidos à aluna têm a forma masculina ({a|o}) para alunos homens.
4. **#8** tinha um espaço vazio ("7 dias de  comigo"); foi preenchido com "Ativação Sócia Invisível".
5. **Situações que não estavam no board** (golpe D1, "preciso comprar outro produto" D2, indecisa/"deixa eu ver" D3,
   retomada D4, cansaço/emocional D5, "a divulgação prometia outra coisa" 12, risco de vida/CVV e ameaça jurídica):
   aprovadas e **acrescentadas ao board em 08/10/2026**, numa seção abaixo do "Quadro 1" ("Situações que o bot também
   trata…"), com os textos do bot, botões, setas e uma nota roxa com a regra das 4 recusas. Se a equipe mudar esses
   textos no board, atualizar `src/oferta/protocolo-7d.ts`.
6. No board, a recusa da dúvida "⏱️ Não Sei Se Cabe na Minha Rotina" (#28) liga direto no fim do e-mail (#124); no
   bot ela segue a régua como as outras recusas.
