-- =====================================================================================
-- TAREFAS AUTOMÁTICAS (rodar DEPOIS de publicar o site, uma vez)
--
-- As mesmas 2 tarefas do MGA:
--   - insights-classify-hourly: no minuto 5 de toda hora, classifica as conversas novas
--     (só para o relatório; nunca muda o chat).
--   - push-reativacao-7d: a cada 15 minutos, manda a notificação de reativação da Rota D3
--     (1 hora depois do "deixa eu ver"), uma vez só, para quem tem notificação ativa.
--
-- Diferença do MGA: nenhuma senha fica escrita aqui. As duas tarefas leem a senha da tabela
-- job_tokens (criada pela estrutura inicial) e o servidor confere a mesma tabela.
--
-- Antes de rodar: troque SEU-DOMINIO pelo endereço do site publicado (sem barra no fim).
-- Se der erro nas extensões, ative "pg_cron" e "pg_net" em Supabase › Database › Extensions.
-- =====================================================================================

create extension if not exists pg_cron;
create extension if not exists pg_net with schema extensions;

select cron.schedule(
  'insights-classify-hourly',
  '5 * * * *',
  $$
  select net.http_post(
    url := 'https://SEU-DOMINIO/api/public/insights/classify',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' || (select token from public.job_tokens where name = 'insights_classify')
    ),
    body := '{}'::jsonb
  );
  $$
);

select cron.schedule(
  'push-reativacao-7d',
  '*/15 * * * *',
  $$
  select net.http_post(
    url := 'https://SEU-DOMINIO/api/public/push/reactivation',
    headers := jsonb_build_object(
      'Content-Type', 'application/json',
      'Authorization', 'Bearer ' || (select token from public.job_tokens where name = 'push_reactivation')
    ),
    body := '{}'::jsonb
  );
  $$
);

-- Conferir:   select jobname, schedule, active from cron.job;
-- Histórico:  select * from cron.job_run_details order by start_time desc limit 20;
-- Desligar:   select cron.unschedule('push-reativacao-7d');
