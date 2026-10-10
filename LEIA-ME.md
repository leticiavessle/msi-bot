# MSI · Bot de suporte

A mesma estrutura do **Jornada Hydra - ATIVO** (o bot do MGA no Lovable), agora fora do Lovable, para
você montar a oferta MSI. Comece pelo [COMECE-AQUI.md](COMECE-AQUI.md).

## O que já está pronto
- **Código completo** do bot, do chat e do painel admin, copiado do Lovable e funcionando sem o Lovable
  (compila e gera o mesmo tipo de site que o Lovable publicava, na Cloudflare).
- **Todas as restrições do MGA** (no prompt e nas travas do servidor), incluindo o Protocolo 7D de reembolso.
- **Uma pasta só para a oferta** (`src/oferta/`): nome, produtos, links, aulas, textos do 7D e o prompt.
  Já com o conteúdo da MSI (trocado em 04/10/2026). O que ainda falta está na seção 9 do COMECE-AQUI.md.
- **Banco de dados** pronto para criar num Supabase novo (testado num Postgres).
- **121 testes automáticos** que conferem as travas (reembolso, aceite, links, prompt...).

## Onde escrever o seu system prompt
`src/oferta/prompt/01-identidade-e-voz.md` — as restrições entram sozinhas depois dele.

## Documentos
1. [Mapa do sistema](docs/01-mapa-do-sistema.md) — como tudo funciona, mensagem por mensagem.
2. [Restrições herdadas](docs/02-restricoes-herdadas.md) — tudo o que o bot não pode fazer, e onde está.
3. [O que preencher](docs/03-o-que-preencher.md) — o que eu preciso que você me passe.
4. [Publicar fora do Lovable](docs/04-publicar-fora-do-lovable.md) — Supabase + Cloudflare, passo a passo.
5. [Achados no MGA](docs/05-achados-no-mga.md) — problemas encontrados no MGA durante a leitura.

Referência: `docs/referencia-mga/` (documento de restrições v4, board do 7D, histórico do Lovable).
Código original do Lovable, intocado: `/Users/leticiavessle/MGA - bot/codigo-lovable-original`.

## Comandos (para mim)
```bash
npm install
npm run check
npm run dev
```
