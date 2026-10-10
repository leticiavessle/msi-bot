---
name: desfazer
description: Volta o projeto para como estava antes da última publicação. Use quando a responsável disser que algo quebrou depois de publicar, ou pedir para desfazer, reverter ou voltar atrás.
---

# Desfazer

1. `git switch main` e `git pull`.
2. Mostre as últimas publicações com `git log --oneline -5` e diga, em linguagem simples, qual delas será desfeita. Por padrão é a mais recente; confirme com ela antes de seguir.
3. Crie um ramo e reverta, sem apagar histórico:
   `git switch -c desfazer-<assunto>` e `git revert --no-edit <commit>`
4. Rode `npm run check`.
5. `git push -u origin <ramo>` e `gh pr create --fill --base main`.
6. Quando `gh pr checks --watch` ficar verde, `gh pr merge --squash --delete-branch`. Desfazer é urgente: não precisa esperar teste.
7. `git switch main` e `git pull`.

Resposta final: o que voltou a ser como antes e, se o bot já está no ar, que leva cerca de dois minutos para aparecer.

Limites, que precisam ser ditos a ela:
- Desfazer só volta o código. Mensagens já enviadas às alunas e dados já gravados no banco não voltam.
- Se a publicação desfeita tinha mudança de banco, avise o Thiago.

Nunca use `git reset --hard` nem `git push --force` para desfazer.
