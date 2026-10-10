# Guia da responsável pelo bot da MSI

Você não precisa programar. Você descreve o que quer, o Claude faz, você testa e só então publica.
É o mesmo jeito de trabalhar do Jornada Hydra.

## Preparar o computador (uma vez só)

Se você já fez isso para o Jornada Hydra, pule para o passo 3.

1. Instale, nesta ordem e com as opções padrão: **Claude** para desktop (https://claude.com/download),
   **Git** (https://git-scm.com/downloads), **Node.js 22 LTS** (https://nodejs.org) e **GitHub CLI** (https://cli.github.com).
2. No Terminal, rode `gh auth login` (GitHub.com, HTTPS, responda **Y** na pergunta sobre credenciais do git, login pelo
   navegador).
3. No Claude, abra a aba **Code** e escolha a pasta deste projeto (`msi-bot`). Se a pasta ainda não existir no
   computador, rode antes no Terminal, dentro de Documentos: `gh repo clone leticiavessle/msi-bot`.
4. Na primeira conversa, peça: "atualize o projeto com o que está no GitHub e instale as dependências".

## O dia a dia

**1. Peça a mudança**, com suas palavras, uma de cada vez. Quanto mais concreto, melhor:

> Quando a aluna perguntar onde encontrar demandas, quero que o bot cite primeiro a 99Freelas.

> No painel, na aba Vendas, quero ver o WhatsApp da aluna ao lado do nome.

Pode mandar print da tela apontando o que quer mudar.

**2. Peça a prévia:** digite `/previa`. O Claude confere tudo, envia para o GitHub e diz onde testar.
Enquanto o bot não estiver no ar, o teste é na prévia que abre dentro do próprio Claude.

**3. Teste.** Se não ficou bom, diga o que ajustar e peça `/previa` de novo.

**4. Publique:** digite `/publicar`. Enquanto o bot não estiver no ar, isso guarda a mudança na versão oficial;
depois de publicado, em cerca de dois minutos está no ar para as alunas.

**5. Deu problema depois de publicar?** Digite `/desfazer`.

Comece uma conversa nova para cada assunto. Conversas longas com vários assuntos misturados confundem.

## Cuidados

- O teste usa os dados reais. Use a sua conta de teste e não altere dados de alunas pelo painel.
- `/desfazer` volta o código, mas não apaga mensagens que o bot já enviou.
- Se o Claude disser que precisa do Thiago (banco de dados, chaves, login, webhooks de compra, quem tem acesso ao bot),
  é isso mesmo: não insista para ele seguir. A mudança fica guardada esperando.
- Nunca cole senhas, chaves ou tokens na conversa. Planilhas de vendas não entram na pasta do projeto.

## Se travar

Copie a mensagem de erro e cole para o Claude perguntando "o que aconteceu e como resolvo?". Se ele não resolver em
duas tentativas, mande o print para o Thiago.
