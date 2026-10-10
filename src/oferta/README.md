# Pasta da oferta

Tudo o que muda de uma oferta para outra está aqui. O resto do código (o "motor") lê estes arquivos.
Conteúdo da MSI (Método Sócia Invisível), trocado em 04/10/2026; o que ainda falta está marcado com **⚠️**
e listado na seção 9 do `COMECE-AQUI.md`.

| Arquivo | O que tem |
|---|---|
| `marca.ts` | Nomes, avatar, site, garantia, texto de preço, frase "não encontrei", textos das telas |
| `produtos.ts` | Produtos, nome de compra → produto, comunidade e atendimento humano por produto |
| `links.ts` | E-mail de suporte e links oficiais (viram botões) |
| `aulas.ts` | Nome dos níveis, formato do link da aula, primeiras aulas |
| `atalhos.ts` | Botões rápidos, respostas fixas, casos do cartão humano, assunto técnico sem 7D |
| `respostas-oficiais.ts` | Respostas validadas pela equipe |
| `protocolo-7d.ts` | Todos os textos da retenção de reembolso (17 rotas, proposta, aceite, e-mail) |
| `vocabulario.ts` | Intenções detectadas e sinônimos da busca |
| `relatorios.ts` | Categorias do relatório e modelo de mensagem do WhatsApp |
| `entrada.ts` | Textos da tela de entrada (e-mail › CPF › nome › WhatsApp) e da dupla checagem no chat |
| `prompt/` | Os 4 blocos do prompt da IA |

## O prompt

O servidor monta o prompt nesta ordem (a mesma do MGA):

1. **`prompt/01-identidade-e-voz.md`** — ✍️ **o seu system prompt** (quem é, para quem fala, como fala).
2. Aviso de prioridade (fixo): as restrições valem acima de tudo.
3. **`prompt/02-restricoes.md`** — as restrições herdadas do MGA (não precisa mexer).
4. **`prompt/03-regras-da-oferta.md`** — regras próprias do produto (primeiros passos, ordem de cadastro...).
5. Protocolo 7D "não é com você" (fixo).
6. Contexto da pessoa: nome, produtos, memória, intenções (o servidor preenche).
7. Trechos das aulas encontrados para a pergunta (o servidor preenche).
8. **`prompt/04-regras-tecnicas.md`** — regras técnicas de resposta (o servidor depende delas).
9. Formato da resposta em JSON (fixo).

Nos arquivos `.md`:
- Texto entre `<!--` e `-->` é anotação sua e **não vai para a IA**.
- `{{chave}}` é trocado pelo valor dos arquivos `.ts`:

| Chave | Vem de |
|---|---|
| `{{nome_assistente}}`, `{{nome_produto}}`, `{{nome_expert}}` | `marca.ts › MARCA` |
| `{{resposta_sou_humano}}` | `marca.ts › IDENTITY.humanCheck` |
| `{{garantia_dias}}`, `{{resposta_preco}}`, `{{frase_nao_encontrei}}` | `marca.ts › POLITICAS` |
| `{{nome_ativacao}}` | `protocolo-7d.ts › NOME_ATIVACAO` |
| `{{nome_comunidade}}` | `produtos.ts › COMUNIDADE.nome` |
| `{{rotulo_nivel}}`, `{{rotulo_nivel_minusculo}}`, `{{primeiras_aulas}}` | `aulas.ts` |
| `{{casos_atendimento_humano}}` | `atalhos.ts › CASOS_ATENDIMENTO_HUMANO` |
| `{{tabela_links}}` | `links.ts › OFFICIAL_LINKS` |

Depois de mexer: `npm run check`. O teste do prompt acusa `{{chave}}` que não existe, anotação que vazou e
restrição que sumiu.
