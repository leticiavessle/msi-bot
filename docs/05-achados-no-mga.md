# Achados no MGA (Jornada Hydra - ATIVO) durante a leitura

Levantamento de 04/10/2026, só leitura (código baixado + catálogo do banco). Nada foi alterado no MGA.
A última coluna mostra como ficou no projeto novo. Os marcados com 🔴 valem corrigir também no MGA.

| # | Achado | Efeito no MGA | No projeto novo |
|---|---|---|---|
| 🔴 1 | **A memória do aluno nunca é gravada.** A função que cria a ficha existe, mas o gatilho no banco não está ligado, e o código só *atualiza* uma ficha que não existe. `student_memory` tem **0 linhas** para 1.038 perfis. | O bot não lembra etapa, dificuldade nem próxima ação de ninguém; o painel mostra memória vazia. | Gatilho ligado + gravação com upsert. |
| 🔴 2 | **As notificações push não têm quem as exiba.** O `public/sw.js` (com o código da notificação) é substituído na compilação pelo service worker gerado, que não tem esse código. Conferido no site no ar (`/sw.js`). | Reativação do 7D, avisos de "Nova Ativação" para o time e envios do painel não aparecem como deveriam (no iPhone o sistema pode até cancelar a inscrição). | Código da notificação em `public/push-handler.js`, importado pelo service worker. |
| 🔴 3 | **Senha da tarefa de notificação escrita no código** (migração 0004: `?token=hydra_push_cron_...`). | Quem tiver acesso ao código consegue disparar a rotina de reativação. | Senhas das tarefas ficam só na tabela `job_tokens`; trocar a do MGA é recomendado. |
| 🔴 4 | **Cadastro aberto no Supabase do MGA** + o chat não confere se a pessoa tem produto. | Qualquer pessoa com a chave pública (que vai no site) cria conta pela API e conversa com o bot, gastando tokens. | Chat recusa quem não tem produto ativo; guia manda desligar o cadastro aberto. |
| 5 | **Login só com e-mail, sem senha.** Decisão de produto do MGA ("acesso simplificado"). | Quem souber o e-mail de uma compradora entra como ela. | Mantido igual (decisão sua). Se quiser, dá para pedir código por e-mail no primeiro acesso de cada aparelho. |
| 6 | **Todos os 1.207 trechos de aula estão como produto "all".** | O filtro por produto não filtra nada: se a base tiver aulas da Mentoria ou do Dólar, quem só tem o MGA também as recebe. | Igual (depende da base). Na importação nova, cada trecho leva o produto certo. |
| 7 | **`assistant_config` vazia.** | Preço da IA = 0, então a aba Custos mostra custo zero; ajustes de busca nunca usados. | Igual; preencher o preço por milhão de tokens em Admin › Custos. |
| 8 | Código de um projeto anterior ("Guia Start"/"Studio DR"/monitorias com o Jhow) ainda no projeto. | Sem efeito para alunas; confunde manutenção. | Removido (jornada, monitorias, respostas simuladas, imagem sem uso, login Google do Lovable). |
| 9 | Avatar do bot servido pelo endereço interno do Lovable (`/__l5e/assets-v1/...`). | Some quando sair do Lovable. | Avatar em `public/avatar.png`. |
| 10 | Pré-carregamento do app com ~14 MB (bibliotecas de código/diagramas do componente de mensagem). | Primeira abertura pesada no celular. | Igual por enquanto (dá para enxugar depois). |

## O que mais está pendente no MGA (dos seus documentos)
- Trocar a IA para a chave própria (pausado) — `MGA - bot/3-prompt-chaves-api.md`.
- Busca por sentido, porteiro e prompt em blocos — `MGA - bot/6-prompts-lovable-implementacao.md`.
- Externalização — `MGA - bot/7-externalizacao-jornada.md` (aguardando acesso ao GitHub/Cloudflare/plataformas).
  O código baixado hoje (`MGA - bot/codigo-lovable-original`) já cobre o passo 3 desse plano.
