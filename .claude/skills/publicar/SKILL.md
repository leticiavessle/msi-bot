---
name: publicar
description: Junta ao main a mudança que já foi testada. Use quando a responsável disser que testou e pedir para publicar, subir ou colocar no ar.
---

# Publicar

Depois que o bot estiver no ar, publicar afeta as alunas na hora. Só siga se as três condições forem verdadeiras:

1. Existe um pull request aberto para o ramo atual (`gh pr view`). Se não existir, rode a `/previa` primeiro.
2. Ela confirmou nesta conversa que testou. Se não confirmou, pergunte.
3. `gh pr checks` está todo verde.

Se a mudança cair em algum caso de "Pare e chame o Thiago" do `CLAUDE.md`, não publique: explique o motivo e diga que o Thiago precisa aprovar.

Passos:

1. `gh pr merge --squash --delete-branch`
2. `git switch main` e `git pull`
3. Acompanhe a verificação do `main` com `gh run watch`. Se houver hospedagem ligada ao repositório, confirme pelo status do último commit (`gh api repos/{owner}/{repo}/commits/main/status`) que a publicação terminou.

Resposta final:
- se o bot já está no ar: o que entrou, que leva cerca de dois minutos para aparecer, e que `/desfazer` volta atrás;
- se ainda não está no ar: que a mudança está guardada no `main` e entra quando o Thiago publicar o bot.

Nunca use `git push --force` nem envie direto para o `main`.
