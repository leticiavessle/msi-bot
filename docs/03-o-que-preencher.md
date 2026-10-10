# O que falta preencher para a nova oferta

> MSI: o conteúdo do MGA já foi trocado pelo da MSI em 04/10/2026. O que ainda falta está na seção 9 do
> `COMECE-AQUI.md`. O texto abaixo é o guia geral (vale para as próximas ofertas).

O projeto nasceu com o **conteúdo do MGA como modelo** (marcado com "⚠️ PREENCHER" em `src/oferta/`). Para virar a nova oferta, troque o conteúdo abaixo. O motor, as travas
e as restrições não mudam.

## O que eu preciso que você me passe

| # | O quê | Vai para |
|---|---|---|
| 1 | Nome do produto, nome do assistente, nome curto (ícone do celular), nome da equipe, nome do expert | `marca.ts` |
| 2 | Seu **system prompt** novo (identidade, missão, público, voz, exemplos) | `prompt/01-identidade-e-voz.md` |
| 3 | Produtos: quantos são e o nome de cada um (principal, upsell, mentoria/assinatura?) e como cada um aparece na compra (nome na Hubla/Payt/Cademí/Kiwify) | `produtos.ts` (+ banco, se mudar a quantidade) |
| 4 | Garantia (dias) e o texto oficial de preço (ou manter "é com o time") | `marca.ts › POLITICAS` |
| 5 | **Aulas:** número de níveis/módulos/aulas, nome de cada um, descrição, link de cada aula na área de membros, e as transcrições (no mesmo modelo dos .docx do MGA, com "Perguntas que esta aula responde" e "O que esta aula NÃO cobre") | `aulas.ts` + base `course_chunks` |
| 6 | Primeiras aulas (as que respondem "por onde eu começo?") e a sequência de primeiros passos | `aulas.ts`, `prompt/03-regras-da-oferta.md` |
| 7 | Links oficiais (cadastro em plataforma, materiais, comunidade por produto, WhatsApp do time, formulário do atendimento humano, e-mail de suporte) | `links.ts`, `produtos.ts` |
| 8 | Atalhos de execução que fazem sentido (no MGA: "não consegui criar conta na Payt") e os botões rápidos do chat | `atalhos.ts` |
| 9 | Respostas oficiais do suporte já validadas pela equipe (pode começar vazio) | `respostas-oficiais.ts` |
| 10 | **Textos do Protocolo 7D** da nova oferta (acolhimento, 17 rotas, proposta de acompanhamento, e-mail de reembolso), ou "manter a mesma lógica e adaptar o texto" | `protocolo-7d.ts` |
| 11 | Assunto técnico que nunca deve abrir o 7D (no MGA: anúncios/Meta) | `atalhos.ts` |
| 12 | Temas do relatório e etapas do onboarding (funil) | `relatorios.ts` |
| 13 | Logo/avatar, ícones do app, cores | `public/avatar.png`, `public/icons/`, `public/manifest.webmanifest`, `src/styles.css` |

## Arquivo por arquivo (src/oferta/)

- **`marca.ts`** — nomes, avatar, endereço do site, garantia, texto de preço, frase "não encontrei" e todos os
  textos das telas (boas-vindas, login, rodapé).
- **`produtos.ts`** — lista de produtos e rótulos; produto padrão; produto de assinatura; regras que
  transformam o nome da compra em produto; comunidade e formulário humano por produto.
  *Mudou a quantidade de produtos?* Mude também `product_type` na migração do banco e em
  `src/integrations/supabase/types.ts` (ou regenere os tipos).
- **`links.ts`** — e-mail de suporte, lista de links oficiais (texto do botão, quando mandar, se é só do servidor,
  se é só para um produto). O link `whatsapp_7d` é obrigatório (o 7D usa).
- **`aulas.ts`** — como se chama o nível mais alto ("Vitrine"), nome de cada nível, formato do link da aula,
  primeiras aulas.
- **`atalhos.ts`** — botões rápidos, respostas fixas de execução, casos do cartão humano, assunto técnico
  sem 7D, exceções do alerta de acesso.
- **`respostas-oficiais.ts`** — respostas validadas pela equipe.
- **`protocolo-7d.ts`** — todos os textos do 7D. Mantenha em cada rota de proposta um botão de aceite e um
  de recusa (o teste confere).
- **`vocabulario.ts`** — intenções detectadas e sinônimos da busca.
- **`relatorios.ts`** — categorias do relatório e nome do modelo de mensagem do WhatsApp.
- **`prompt/`** — os 4 blocos do prompt (veja `src/oferta/README.md`).

Depois de cada mudança: `npm run check` (confere tipos, testes e compilação).

## Base de aulas
O bot só responde conteúdo que estiver em `course_chunks`. Quando você me passar as transcrições, eu:
1. limpo e divido cada aula em trechos (como fiz para o MGA em `MGA - bot/base-aulas`);
2. gero o arquivo de importação com os ids no padrão `V1.M01.A01-01` e o link da aula no trecho `-01`;
3. importo no banco novo e rodo a prova de busca (perguntas reais → aula certa).
