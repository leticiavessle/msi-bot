---
name: previa
description: Verifica a mudança atual, envia para o GitHub e diz como testar antes de publicar. Use quando a responsável pedir para testar, ver como ficou, gerar prévia ou enviar a mudança.
---

# Prévia

Objetivo: deixar a mudança pronta para ela testar, sem tocar no `main`.

1. Confira o ramo com `git status`. Se estiver no `main`, crie um ramo com nome curto e descritivo (`git switch -c ajuste-texto-boas-vindas`).
2. Rode `npm run check` (tipos, testes e build). Se algo falhar, corrija antes de continuar. Nunca altere ou remova um teste só para ele passar.
3. Se a mudança cair em algum caso de "Pare e chame o Thiago" do `CLAUDE.md`, avise e não siga para a publicação.
4. Faça o commit só dos arquivos da mudança, com mensagem em português dizendo o que muda para a aluna ou para a equipe. Nunca inclua `.env` nem planilhas de vendas.
5. `git push -u origin <ramo>`.
6. Abra o pull request se ainda não existir: `gh pr create --fill --base main`. Se já existir, o push atualiza.
7. Acompanhe com `gh pr checks --watch`. O check "Tipos, testes e build" precisa ficar verde.
8. Procure o link de prévia da hospedagem nos checks ou comentários do pull request (`gh pr view --json comments,statusCheckRollup`).
   - Se houver link, é nele que ela testa.
   - Se não houver (o bot ainda não foi publicado), o teste é local: suba o app com a configuração `msi-dev` e abra a porta 8080.

Resposta final, em linguagem simples:
- o que mudou;
- onde testar (link de prévia ou a prévia local);
- o que testar, em passos (ex.: "entre no chat, pergunte X, veja se aparece Y");
- lembrete: quando estiver bom, é só pedir `/publicar`.

A prévia usa o banco real: avise para testar com a conta de teste e não mexer em dados de alunas pelo painel.
