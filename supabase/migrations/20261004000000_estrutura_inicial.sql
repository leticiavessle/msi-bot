-- =====================================================================================
-- ESTRUTURA INICIAL DO BANCO (Supabase novo, fora do Lovable)
--
-- Reconstruída em 04/10/2026 a partir do banco do projeto "Jornada Hydra - ATIVO"
-- (leitura do catálogo pelo SQL editor do Lovable Cloud, sem dados de alunos) + as 18
-- migrações do código. Mesmas tabelas, colunas, índices, regras de segurança (RLS),
-- funções e pastas de arquivos, com estas diferenças, de propósito:
--   1. Produtos: o tipo product_type tem os 5 produtos da MSI ("principal", "top_demandas",
--      "cofre_pix", "mentoria", "vitalicia"), no lugar de start/elite/formacao/drdolar/mga/med/evolution.
--   2. O gatilho que cria a ficha da pessoa (perfil + memória + produtos) está LIGADO.
--      No MGA a função existia, mas o gatilho não: a memória do bot nunca foi gravada.
--      E quem cria conta sem estar em authorized_users NÃO ganha produto nenhum
--      (no MGA a função dava o produto "start" para qualquer conta).
--   3. As listas de tema/motivo/etapa do relatório (conversation_insights) não têm trava
--      no banco: quem confere é o código (src/oferta/relatorios.ts), para cada oferta ter as suas.
--   4. Saíram 2 tabelas sem uso no código (monitoring_sessions e stage_progress_events,
--      sobras de um projeto anterior).
--   5. As tarefas automáticas (pg_cron) ficam em supabase/agendamentos.sql, para rodar
--      depois de publicar o site (precisam do endereço final).
--
-- Como aplicar: Supabase › SQL Editor › colar este arquivo inteiro › Run
-- (ou: npx supabase db push, com o projeto ligado).
-- =====================================================================================

-- ---------- Extensões ----------
create extension if not exists pgcrypto with schema extensions;
create extension if not exists vector with schema extensions;
-- pg_cron e pg_net (tarefas automáticas) ficam em supabase/agendamentos.sql.

-- ---------- Tipos ----------
create type public.access_source as enum ('manual', 'import', 'webhook', 'seed', 'cademi', 'payt');
create type public.alert_status as enum ('pending', 'resolved', 'ignored');
create type public.app_role as enum ('admin', 'student');
create type public.document_status as enum ('pending', 'processing', 'approved', 'rejected', 'archived');
create type public.knowledge_base_type as enum ('official_editor_dr', 'real_questions', 'official_faq', 'refund_risk', 'elite', 'formation');
create type public.message_role as enum ('user', 'assistant');
-- As mesmas chaves de src/oferta/produtos.ts (PRODUCTS).
create type public.product_type as enum ('principal', 'top_demandas', 'cofre_pix', 'mentoria', 'vitalicia');
create type public.risk_level_type as enum ('low', 'medium', 'high', 'critical');
create type public.user_status as enum ('active', 'blocked', 'refunded', 'canceled');

-- ---------- Função genérica de updated_at ----------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
set search_path to 'public'
as $function$
begin
  new.updated_at = now();
  return new;
end;
$function$;

-- =====================================================================================
-- PESSOAS, PAPÉIS E ACESSO
-- =====================================================================================

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  name text,
  email text,
  avatar_url text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.user_roles (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  role public.app_role not null,
  created_at timestamptz not null default now(),
  unique (user_id, role)
);

create or replace function public.has_role(_user_id uuid, _role public.app_role)
returns boolean
language sql
stable security definer
set search_path to 'public'
as $function$
  select exists (select 1 from public.user_roles where user_id = _user_id and role = _role)
$function$;

-- Quem pode entrar: o login só por e-mail confere esta lista (compra pela Hubla/Payt/Cademí, planilha ou manual).
create table public.authorized_users (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  name text,
  role public.app_role not null default 'student',
  status public.user_status not null default 'active',
  product_access public.product_type[] not null default array['principal'::public.product_type],
  access_source public.access_source not null default 'manual',
  access_expires_at timestamptz,
  last_login_at timestamptz,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  product_origin text
);
comment on column public.authorized_users.product_origin is 'confirmado = produto veio da origem; padrao = produto padrão preenchido sem dado de produto; incerto = planilha antiga sem como saber';

create table public.user_products (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  product public.product_type not null,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  unique (user_id, product)
);

-- Precedência da Hubla: reembolso/chargeback/cancelamento lá impede Payt/Cademí de reativar o produto.
create table public.product_access_grants (
  id uuid primary key default gen_random_uuid(),
  email text not null,
  product public.product_type not null,
  source text,
  granted_at timestamptz,
  hubla_status text,
  hubla_status_at timestamptz,
  updated_at timestamptz not null default now(),
  unique (email, product)
);

create table public.access_sessions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  device_id text not null,
  user_agent text,
  ip text,
  ip_city text,
  ip_country text,
  started_at timestamptz not null default now(),
  last_seen_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  expires_at timestamptz,
  revoked_at timestamptz
);

create table public.audit_logs (
  id uuid primary key default gen_random_uuid(),
  admin_user_id uuid references auth.users(id) on delete set null,
  action text not null,
  target_user_id uuid references auth.users(id) on delete set null,
  target_email text,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- =====================================================================================
-- CONVERSAS E MEMÓRIA
-- =====================================================================================

create table public.conversations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  status text not null default 'open',
  last_message_at timestamptz,
  -- Atendimento humano: enquanto preenchido, o bot fica em silêncio nesta conversa.
  human_takeover_by uuid,
  human_takeover_name text,
  human_takeover_at timestamptz
);

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role public.message_role not null,
  content text not null,
  detected_intent text,
  diagnosis text,
  recommended_action text,
  created_at timestamptz not null default now(),
  -- attachments (cartões), refund_state (estado do 7D), refund_guard (auditoria da trava), human...
  metadata jsonb not null default '{}'::jsonb,
  model text,
  prompt_tokens integer,
  completion_tokens integer,
  total_tokens integer,
  cost_usd numeric(12,6)
);

create table public.student_memory (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null unique references auth.users(id) on delete cascade,
  current_stage text,
  portfolio_ready boolean,
  studio_account boolean,
  vacancies_applied integer not null default 0,
  tests_completed integer not null default 0,
  clients_count integer not null default 0,
  main_difficulties text,
  last_guidance text,
  recommended_action text,
  action_result text,
  dissatisfaction_signals text[] not null default '{}'::text[],
  risk_level public.risk_level_type not null default 'low',
  updated_at timestamptz not null default now(),
  journey_status text not null default 'unknown' check (journey_status in ('unknown', 'active', 'skipped', 'done')),
  journey_stage integer check (journey_stage is null or (journey_stage >= 1 and journey_stage <= 7)),
  stages_completed integer[] not null default '{}'::integer[],
  edit_device text,
  capcut_basic boolean,
  edits_finished integer,
  portfolio_link text,
  instagram_ready boolean,
  jobs_group boolean,
  applied_before boolean,
  attends_monitorias boolean,
  stage_started_at timestamptz,
  last_progress_at timestamptz,
  next_action text,
  current_difficulty text,
  stuck_reason text,
  last_evolution text,
  ia_need text,
  tool_searched text,
  ia_material_found boolean,
  ia_access_problem boolean,
  portfolio_drive_created boolean,
  portfolio_videos_selected boolean,
  portfolio_link_tested boolean,
  ia_module_watched boolean
);

create table public.student_memory_facts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  key text not null,
  value text not null,
  category text,
  confidence numeric not null default 0.8,
  source_conversation_id uuid references public.conversations(id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (user_id, key)
);

-- =====================================================================================
-- ALERTAS, RETENÇÃO (7D) E RELATÓRIOS
-- =====================================================================================

create table public.risk_alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  conversation_id uuid references public.conversations(id) on delete set null,
  risk_level public.risk_level_type not null,
  reason text,
  trigger_text text,
  status public.alert_status not null default 'pending',
  reviewed_by uuid references auth.users(id) on delete set null,
  created_at timestamptz not null default now(),
  resolved_at timestamptz,
  accept_origin text check (accept_origin is null or accept_origin in ('botão', 'digitado')),
  accept_text text,
  accept_node text,
  accept_reclassified boolean not null default false,
  from_retention boolean not null default false,
  whatsapp_sent_at timestamptz
);

create table public.access_alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  conversation_id uuid references public.conversations(id) on delete set null,
  trigger_text text not null,
  status text not null default 'pending',
  reopened boolean not null default false,
  resolved_by uuid,
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  from_retention boolean not null default false
);

create table public.retention_actions (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null,
  action text not null check (action in ('fechado', 'redirecionado')),
  reason text check (reason is null or reason in ('resolvida_chat', 'retida', 'nao_era_retencao', 'sem_resposta', 'outro')),
  reason_text text,
  destination text check (destination is null or destination in ('ativacao', 'acessos', 'humano')),
  reasons_snapshot text[] not null default '{}',
  acted_by uuid not null,
  acted_at timestamptz not null default now(),
  undone_at timestamptz,
  undone_by uuid
);

-- Só para relatório: nunca é lido pelo chat.
create table public.conversation_insights (
  id uuid primary key default gen_random_uuid(),
  conversation_id uuid not null references public.conversations(id) on delete cascade,
  user_id uuid not null,
  day date not null,
  topic text not null,
  refund_requested boolean not null default false,
  refund_reason text,
  refund_retained boolean not null default false,
  sentiment text not null check (sentiment in ('positivo', 'neutro', 'negativo')),
  resolved_by_bot boolean not null default false,
  needed_human boolean not null default false,
  repeated_question boolean not null default false,
  abandoned boolean not null default false,
  onboarding_stage text,
  stuck boolean not null default false,
  summary text check (summary is null or char_length(summary) <= 200),
  last_message_at timestamptz,
  classified_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (conversation_id, day)
);

create table public.daily_reports (
  id uuid primary key default gen_random_uuid(),
  dia date not null,
  edicao text not null check (edicao in ('08h', '17h')),
  html text not null,
  whatsapp jsonb,
  dados jsonb,
  whatsapp_status text,
  whatsapp_error text,
  whatsapp_sent_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (dia, edicao)
);

-- Senhas das tarefas automáticas (só o servidor lê).
create table public.job_tokens (
  name text primary key,
  token text not null default encode(extensions.gen_random_bytes(32), 'hex'),
  created_at timestamptz not null default now()
);
insert into public.job_tokens (name) values ('insights_classify'), ('push_reactivation') on conflict do nothing;

-- =====================================================================================
-- CONHECIMENTO (AULAS, MATERIAIS, CONFIGURAÇÃO)
-- =====================================================================================

-- Trechos das aulas. id = código da aula + número do trecho (ex.: V1.M01.A01-01).
-- O link e o nome oficial da aula ficam no trecho -01. product = chave do produto ou 'all'.
create table public.course_chunks (
  id text primary key,
  product text not null default 'all',
  level integer,
  module integer,
  lesson text,
  topic text,
  title text not null,
  content text not null,
  status text not null default 'approved',
  keywords text[] not null default '{}'::text[],
  source_type text default 'course_lesson',
  source_version text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.knowledge_documents (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  base_type public.knowledge_base_type not null,
  product public.product_type,
  storage_path text,
  source text,
  version integer not null default 1,
  status public.document_status not null default 'pending',
  approved boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.knowledge_chunks (
  id uuid primary key default gen_random_uuid(),
  document_id uuid not null references public.knowledge_documents(id) on delete cascade,
  product public.product_type,
  base_type public.knowledge_base_type not null,
  content text not null,
  page_number integer,
  metadata jsonb not null default '{}'::jsonb,
  embedding extensions.vector(1536),
  approved boolean not null default false,
  created_at timestamptz not null default now()
);

create table public.support_materials (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text,
  keywords text[] not null default '{}'::text[],
  product public.product_type,
  lesson_ref text,
  storage_path text,
  file_name text,
  file_size bigint,
  mime_type text,
  active boolean not null default true,
  created_by uuid references auth.users(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  slug text,
  aliases text[] not null default '{}'::text[],
  resource_type text not null default 'other',
  source_url text,
  download_url text,
  access_scope text[] not null default '{}'::text[],
  status text not null default 'approved',
  distribution_authorized boolean not null default true,
  copyright_owner text,
  risk_notice text,
  availability_status text,
  verified_at date,
  page_count integer,
  sha256 text,
  related_resource_id text,
  level integer,
  module integer,
  lesson_title text,
  notes text,
  contact_type text,
  contact_value text,
  commercial_offer boolean not null default false,
  price_display text,
  price_verified_at date,
  send_policy text,
  last_checked_at timestamptz,
  temporary_link boolean not null default false,
  folder_contents_verified text[] not null default '{}'::text[],
  version text,
  updated_by uuid
);

create table public.material_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  conversation_id uuid references public.conversations(id) on delete set null,
  query_text text not null,
  terms text[] not null default '{}'::text[],
  created_at timestamptz not null default now()
);

create table public.tool_links (
  id text primary key,
  name text not null,
  aliases text[] not null default '{}'::text[],
  category text,
  official_url text,
  status text not null default 'pending',
  modules integer[] not null default '{}'::integer[],
  course_use text,
  verified_at date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- Configurações livres (preço da IA por milhão de tokens, busca, mapa de produtos, pausa do classificador...).
create table public.assistant_config (
  key text primary key,
  value jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- IA com chave própria (a chave é criptografada no servidor; nenhum navegador lê esta tabela).
create table public.ai_settings (
  id boolean primary key default true check (id),
  provider text check (provider in ('openai', 'gemini')),
  model_chat text,
  model_tasks text,
  temperature numeric,
  openai_api_key text,
  openai_key_hint text,
  gemini_api_key text,
  gemini_key_hint text,
  active boolean not null default false,
  last_test_at timestamptz,
  last_test_error text,
  updated_by uuid,
  updated_by_name text,
  updated_at timestamptz not null default now()
);
comment on column public.ai_settings.openai_api_key is 'AES-GCM encrypted by the server (AI_SETTINGS_ENC_KEY); never readable by clients';
comment on column public.ai_settings.gemini_api_key is 'AES-GCM encrypted by the server (AI_SETTINGS_ENC_KEY); never readable by clients';
insert into public.ai_settings (id) values (true) on conflict do nothing;

create table public.ai_usage_log (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  provider text not null,
  model text,
  use text not null,
  input_tokens integer,
  output_tokens integer,
  latency_ms integer,
  error text
);

create table public.usage_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  event_name text not null,
  session_id uuid,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- =====================================================================================
-- NOTIFICAÇÕES E WEBHOOKS
-- =====================================================================================

create table public.push_subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  endpoint text not null unique,
  p256dh text not null,
  auth text not null,
  device text,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  last_used_at timestamptz
);

create table public.push_broadcasts (
  id uuid primary key default gen_random_uuid(),
  created_by uuid references auth.users(id),
  title text not null,
  body text not null,
  url text,
  audience text not null,
  audience_value text,
  devices_targeted integer not null default 0,
  devices_sent integer not null default 0,
  devices_failed integer not null default 0,
  created_at timestamptz not null default now()
);

create table public.webhook_events (
  id uuid primary key default gen_random_uuid(),
  provider text not null,
  event_type text not null,
  external_event_id text,
  payload jsonb not null default '{}'::jsonb,
  processed boolean not null default false,
  processing_error text,
  created_at timestamptz not null default now(),
  processed_at timestamptz
);

create table public.webhook_product_names (
  id uuid primary key default gen_random_uuid(),
  provider text not null,
  name text not null,
  mapped_to text,
  last_email text,
  pending_count integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (provider, name)
);

-- =====================================================================================
-- ÍNDICES (os mesmos do MGA)
-- =====================================================================================

create index access_alerts_status_idx on public.access_alerts using btree (status);
create index access_alerts_user_idx on public.access_alerts using btree (user_id, created_at desc);
create index access_sessions_user_idx on public.access_sessions using btree (user_id, last_seen_at desc);
create index access_sessions_last_seen_idx on public.access_sessions using btree (last_seen_at desc);
create index ai_usage_log_created_idx on public.ai_usage_log using btree (created_at desc);
create index audit_logs_created_idx on public.audit_logs using btree (created_at desc);
create index authorized_users_status_idx on public.authorized_users using btree (status);
create index authorized_users_product_origin_idx on public.authorized_users using btree (product_origin);
create index conversation_insights_day_idx on public.conversation_insights using btree (day);
create index conversation_insights_user_idx on public.conversation_insights using btree (user_id, day desc);
create index conversations_human_takeover_idx on public.conversations using btree (human_takeover_at) where (human_takeover_at is not null);
create index conversations_updated_idx on public.conversations using btree (updated_at desc);
create index conversations_user_updated_idx on public.conversations using btree (user_id, updated_at desc);
create index course_chunks_keywords_idx on public.course_chunks using gin (keywords);
create index course_chunks_product_status_idx on public.course_chunks using btree (product, status);
create index course_chunks_module_idx on public.course_chunks using btree (module);
create index knowledge_chunks_lookup_idx on public.knowledge_chunks using btree (base_type, product, approved);
create index knowledge_chunks_document_idx on public.knowledge_chunks using btree (document_id);
create index messages_created_idx on public.messages using btree (created_at desc);
create index messages_conversation_idx on public.messages using btree (conversation_id, created_at);
create index messages_cost_created_at_idx on public.messages using btree (created_at) where (cost_usd is not null);
create index push_subscriptions_user_idx on public.push_subscriptions using btree (user_id) where active;
create index retention_actions_conv_idx on public.retention_actions using btree (conversation_id, acted_at desc);
create index risk_alerts_status_idx on public.risk_alerts using btree (status, created_at desc);
create index risk_alerts_user_idx on public.risk_alerts using btree (user_id, created_at desc);
create index support_materials_aliases_idx on public.support_materials using gin (aliases);
create index support_materials_keywords_idx on public.support_materials using gin (keywords);
create index support_materials_product_idx on public.support_materials using btree (product) where active;
create unique index support_materials_slug_key on public.support_materials using btree (slug) where (slug is not null);
create index tool_links_aliases_idx on public.tool_links using gin (aliases);
create index usage_events_created_idx on public.usage_events using btree (created_at desc);
create index usage_events_user_idx on public.usage_events using btree (user_id, created_at desc);
create index user_products_user_id_idx on public.user_products using btree (user_id);
-- Idempotência dos webhooks: o mesmo evento nunca é processado duas vezes.
create unique index webhook_events_provider_external_idx on public.webhook_events using btree (provider, external_event_id) where (external_event_id is not null);

-- =====================================================================================
-- GATILHOS
-- =====================================================================================

create trigger access_sessions_set_updated_at before update on public.access_sessions for each row execute function public.set_updated_at();
create trigger assistant_config_set_updated_at before update on public.assistant_config for each row execute function public.set_updated_at();
create trigger authorized_users_set_updated_at before update on public.authorized_users for each row execute function public.set_updated_at();
create trigger conversations_set_updated_at before update on public.conversations for each row execute function public.set_updated_at();
create trigger course_chunks_set_updated_at before update on public.course_chunks for each row execute function public.set_updated_at();
create trigger daily_reports_set_updated_at before update on public.daily_reports for each row execute function public.set_updated_at();
create trigger knowledge_documents_set_updated_at before update on public.knowledge_documents for each row execute function public.set_updated_at();
create trigger profiles_set_updated_at before update on public.profiles for each row execute function public.set_updated_at();
create trigger student_memory_set_updated_at before update on public.student_memory for each row execute function public.set_updated_at();
create trigger memory_facts_set_updated_at before update on public.student_memory_facts for each row execute function public.set_updated_at();
create trigger support_materials_set_updated_at before update on public.support_materials for each row execute function public.set_updated_at();
create trigger tool_links_set_updated_at before update on public.tool_links for each row execute function public.set_updated_at();

-- Ficha da pessoa ao criar a conta: perfil, memória do bot e (se estiver na lista de compradores) papel e produtos.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path to 'public'
as $function$
declare
  auth_row public.authorized_users%rowtype;
  prod public.product_type;
begin
  insert into public.profiles (id, name, email)
  values (new.id, coalesce(new.raw_user_meta_data->>'name', new.raw_user_meta_data->>'full_name'), new.email)
  on conflict (id) do nothing;

  insert into public.student_memory (user_id) values (new.id)
  on conflict (user_id) do nothing;

  select * into auth_row from public.authorized_users where lower(email) = lower(new.email);

  if auth_row.id is not null then
    update public.authorized_users set last_login_at = now() where id = auth_row.id;

    if auth_row.role = 'admin' then
      insert into public.user_roles (user_id, role) values (new.id, 'admin')
      on conflict (user_id, role) do nothing;
    end if;

    foreach prod in array auth_row.product_access loop
      insert into public.user_products (user_id, product, active) values (new.id, prod, true)
      on conflict (user_id, product) do nothing;
    end loop;
  end if;
  -- Sem compra registrada: nenhum produto (o chat recusa quem não tem produto ativo).

  return new;
end;
$function$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- =====================================================================================
-- SEGURANÇA (RLS): mesmas regras do MGA
-- =====================================================================================

alter table public.access_alerts enable row level security;
alter table public.access_sessions enable row level security;
alter table public.ai_settings enable row level security;
alter table public.ai_usage_log enable row level security;
alter table public.assistant_config enable row level security;
alter table public.audit_logs enable row level security;
alter table public.authorized_users enable row level security;
alter table public.conversation_insights enable row level security;
alter table public.conversations enable row level security;
alter table public.course_chunks enable row level security;
alter table public.daily_reports enable row level security;
alter table public.job_tokens enable row level security;
alter table public.knowledge_chunks enable row level security;
alter table public.knowledge_documents enable row level security;
alter table public.material_requests enable row level security;
alter table public.messages enable row level security;
alter table public.product_access_grants enable row level security;
alter table public.profiles enable row level security;
alter table public.push_broadcasts enable row level security;
alter table public.push_subscriptions enable row level security;
alter table public.retention_actions enable row level security;
alter table public.risk_alerts enable row level security;
alter table public.student_memory enable row level security;
alter table public.student_memory_facts enable row level security;
alter table public.support_materials enable row level security;
alter table public.tool_links enable row level security;
alter table public.usage_events enable row level security;
alter table public.user_products enable row level security;
alter table public.user_roles enable row level security;
alter table public.webhook_events enable row level security;
alter table public.webhook_product_names enable row level security;

create policy "Admins read access alerts" on public.access_alerts for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admins update access alerts" on public.access_alerts for update to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy access_sessions_insert_own on public.access_sessions for insert to authenticated with check (auth.uid() = user_id);
create policy access_sessions_select_admin on public.access_sessions for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy access_sessions_select_own on public.access_sessions for select to authenticated using (auth.uid() = user_id);
create policy access_sessions_update_own on public.access_sessions for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy assistant_config_admin_all on public.assistant_config for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));

create policy audit_logs_admin_insert on public.audit_logs for insert to authenticated with check (public.has_role(auth.uid(), 'admin') and admin_user_id = auth.uid());
create policy audit_logs_admin_select on public.audit_logs for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy authorized_users_admin_all on public.authorized_users for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));

create policy "Admins read insights" on public.conversation_insights for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy conversations_insert_own on public.conversations for insert to authenticated with check (auth.uid() = user_id);
create policy conversations_select_admin on public.conversations for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy conversations_select_own on public.conversations for select to authenticated using (auth.uid() = user_id);
create policy conversations_update_own on public.conversations for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

create policy course_chunks_admin_all on public.course_chunks for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));
create policy course_chunks_select_entitled on public.course_chunks for select to authenticated using (
  status = 'approved' and (
    product = 'all' or exists (
      select 1 from public.user_products up
      where up.user_id = auth.uid() and up.active and up.product::text = course_chunks.product
    )
  )
);

create policy "Admins read reports" on public.daily_reports for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy "admins manage chunks" on public.knowledge_chunks for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));
create policy "admins manage documents" on public.knowledge_documents for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));

create policy material_requests_admin_select on public.material_requests for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy messages_select_admin on public.messages for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy messages_select_own on public.messages for select to authenticated using (auth.uid() = user_id);

create policy "Admins read grants" on public.product_access_grants for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy profiles_insert_own on public.profiles for insert to authenticated with check (auth.uid() = id);
create policy profiles_select_admin on public.profiles for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy profiles_select_own on public.profiles for select to authenticated using (auth.uid() = id);
create policy profiles_update_own on public.profiles for update to authenticated using (auth.uid() = id) with check (auth.uid() = id);

create policy "Admins veem os envios" on public.push_broadcasts for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Aluno vê as próprias inscrições" on public.push_subscriptions for select to authenticated using (auth.uid() = user_id);

create policy "Admins read retention actions" on public.retention_actions for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy risk_alerts_admin_select on public.risk_alerts for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy risk_alerts_admin_update on public.risk_alerts for update to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));

create policy student_memory_select_admin on public.student_memory for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy student_memory_select_own on public.student_memory for select to authenticated using (auth.uid() = user_id);
create policy memory_facts_select_admin on public.student_memory_facts for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy memory_facts_select_own on public.student_memory_facts for select to authenticated using (auth.uid() = user_id);

create policy support_materials_admin_all on public.support_materials for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));
create policy support_materials_select_entitled on public.support_materials for select to authenticated using (
  active and status = 'approved' and distribution_authorized and (
    (product is null and cardinality(access_scope) = 0)
    or (product is not null and exists (
      select 1 from public.user_products up
      where up.user_id = auth.uid() and up.active and up.product = support_materials.product
    ))
    or ('all' = any (access_scope))
    or exists (
      select 1 from public.user_products up
      where up.user_id = auth.uid() and up.active and up.product::text = any (support_materials.access_scope)
    )
  )
);

create policy tool_links_admin_all on public.tool_links for all to authenticated using (public.has_role(auth.uid(), 'admin')) with check (public.has_role(auth.uid(), 'admin'));
create policy tool_links_select_verified on public.tool_links for select to authenticated using (status in ('verified_official', 'verified_course_link'));

create policy usage_events_insert_own on public.usage_events for insert to authenticated with check (auth.uid() = user_id);
create policy usage_events_select_admin on public.usage_events for select to authenticated using (public.has_role(auth.uid(), 'admin'));

create policy user_products_select_own on public.user_products for select to authenticated using (auth.uid() = user_id);
create policy "users read own roles" on public.user_roles for select to authenticated using (user_id = auth.uid());

create policy webhook_events_admin_select on public.webhook_events for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admins read product names" on public.webhook_product_names for select to authenticated using (public.has_role(auth.uid(), 'admin'));

-- ---------- Permissões que o MGA endureceu além do RLS ----------
-- Conversas: sem apagar pelo navegador.
revoke all on public.conversations from anon;
revoke delete, truncate, references, trigger on public.conversations from authenticated;
grant select, insert, update on public.conversations to authenticated;
-- Mensagens e memória: o navegador só lê; quem escreve é o servidor.
revoke all on public.messages from anon;
revoke insert, update, delete, truncate, references, trigger on public.messages from authenticated;
grant select on public.messages to authenticated;
revoke all on public.student_memory from anon;
revoke insert, update, delete, truncate, references, trigger on public.student_memory from authenticated;
grant select on public.student_memory to authenticated;
-- Só o servidor: senhas de tarefas, chave e uso da IA.
revoke all on public.job_tokens from anon, authenticated;
revoke all on public.ai_settings from anon, authenticated;
revoke all on public.ai_usage_log from anon, authenticated;
grant all on public.job_tokens, public.ai_settings, public.ai_usage_log to service_role;

-- Funções com privilégio: não chamáveis pela API, exceto has_role (usada pelo painel).
revoke all on function public.handle_new_user() from public, anon, authenticated;
revoke all on function public.set_updated_at() from public, anon, authenticated;
revoke all on function public.has_role(uuid, public.app_role) from public, anon;
grant execute on function public.has_role(uuid, public.app_role) to authenticated;

-- =====================================================================================
-- FUNÇÕES DO PAINEL (contas feitas no banco, fuso America/Sao_Paulo)
-- =====================================================================================

create or replace function public.admin_list_conversations(
  _term text default null, _from date default null, _to date default null,
  _include_empty boolean default false, _user_id uuid default null,
  _limit int default 50, _offset int default 0)
returns table (id uuid, user_id uuid, title text, status text, created_at timestamptz,
  updated_at timestamptz, message_count bigint, name text, email text, has_profile boolean,
  refund_state jsonb, total_count bigint)
language plpgsql stable security definer set search_path = public as $$
begin
  if not public.has_role(auth.uid(), 'admin') then raise exception 'forbidden'; end if;
  return query
  with base as (
    select c.id, c.user_id, c.title, c.status, c.created_at, c.updated_at,
      (select count(*) from public.messages m where m.conversation_id = c.id) as message_count,
      p.name, p.email, (p.id is not null) as has_profile
    from public.conversations c
    left join public.profiles p on p.id = c.user_id
    where (_user_id is null or c.user_id = _user_id)
      and (_from is null or c.created_at >= _from::timestamptz)
      and (_to is null or c.created_at < (_to + 1)::timestamptz)
      and (_term is null or _term = '' or p.name ilike '%'||_term||'%' or p.email ilike '%'||_term||'%' or c.user_id::text = _term)
  ), filtered as (
    select * from base b where _include_empty or b.message_count > 0
  )
  select f.id, f.user_id, f.title, f.status, f.created_at, f.updated_at, f.message_count,
    f.name, f.email, f.has_profile,
    (select m.metadata->'refund_state' from public.messages m
       where m.conversation_id = f.id and m.role = 'assistant' and m.metadata ? 'refund_state'
       order by m.created_at desc limit 1),
    count(*) over ()
  from filtered f
  order by f.updated_at desc
  limit greatest(1, least(_limit, 200)) offset greatest(0, _offset);
end $$;

create or replace function public.admin_list_conversation_people(
  _term text default null, _limit int default 50, _offset int default 0)
returns table (user_id uuid, name text, email text, has_profile boolean, products text[],
  conversation_count bigint, first_at timestamptz, last_at timestamptz, total_count bigint)
language plpgsql stable security definer set search_path = public as $$
begin
  if not public.has_role(auth.uid(), 'admin') then raise exception 'forbidden'; end if;
  return query
  with g as (
    select c.user_id, count(*) as conversation_count, min(c.created_at) as first_at,
      max(greatest(c.updated_at, coalesce(c.last_message_at, c.updated_at))) as last_at
    from public.conversations c
    where exists (select 1 from public.messages m where m.conversation_id = c.id)
    group by c.user_id
  )
  select g.user_id, p.name, p.email, (p.id is not null),
    coalesce((select array_agg(up.product::text order by up.product::text) from public.user_products up
      where up.user_id = g.user_id and up.active), '{}'),
    g.conversation_count, g.first_at, g.last_at, count(*) over ()
  from g left join public.profiles p on p.id = g.user_id
  where _term is null or _term = '' or p.name ilike '%'||_term||'%' or p.email ilike '%'||_term||'%' or g.user_id::text = _term
  order by g.last_at desc
  limit greatest(1, least(_limit, 200)) offset greatest(0, _offset);
end $$;

revoke all on function public.admin_list_conversations(text,date,date,boolean,uuid,int,int) from public, anon;
revoke all on function public.admin_list_conversation_people(text,int,int) from public, anon;
grant execute on function public.admin_list_conversations(text,date,date,boolean,uuid,int,int) to authenticated;
grant execute on function public.admin_list_conversation_people(text,int,int) to authenticated;

create or replace function public.admin_overview_metrics()
returns jsonb language plpgsql stable security definer set search_path to 'public' as $$
declare
  tz constant text := 'America/Sao_Paulo';
  today_start timestamptz := date_trunc('day', now() at time zone tz) at time zone tz;
  d7_start timestamptz := (date_trunc('day', now() at time zone tz) - interval '6 days') at time zone tz;
  d30_start timestamptz := (date_trunc('day', now() at time zone tz) - interval '29 days') at time zone tz;
  r jsonb;
begin
  if coalesce(auth.role(), '') <> 'service_role' and not public.has_role(auth.uid(), 'admin') then
    raise exception 'forbidden';
  end if;
  select jsonb_build_object(
    'onlineNow', (select count(distinct user_id) from access_sessions where revoked_at is null and last_seen_at > now() - interval '2 minutes'),
    'activeToday', (select count(distinct user_id) from access_sessions where revoked_at is null and last_seen_at >= today_start),
    'active7d', (select count(distinct user_id) from access_sessions where revoked_at is null and last_seen_at >= d7_start),
    'active30d', (select count(distinct user_id) from access_sessions where revoked_at is null and last_seen_at >= d30_start),
    'messagesTodayUser', (select count(*) from messages where role = 'user' and created_at >= today_start),
    'messagesTodayBot', (select count(*) from messages where role = 'assistant' and created_at >= today_start),
    'conversationsToday', (select count(distinct conversation_id) from messages where role = 'user' and created_at >= today_start),
    'peopleToday', (select count(distinct user_id) from messages where role = 'user' and created_at >= today_start),
    'lastUserMessageAt', (select max(created_at) from messages where role = 'user'),
    'avgMessagesPerUser', (select coalesce(round(count(*)::numeric / nullif(count(distinct user_id), 0), 1), 0) from messages where role = 'user' and created_at >= d30_start),
    'returnRate', (select coalesce(round(100.0 * count(*) filter (where days > 1) / nullif(count(*), 0)), 0) from (
        select user_id, count(distinct (last_seen_at at time zone tz)::date) days from access_sessions
        where revoked_at is null and last_seen_at >= d30_start group by user_id) s),
    'totalUsers', (select count(*) from authorized_users),
    'activeUsers', (select count(*) from authorized_users where status = 'active'),
    'newUsers7d', (select count(*) from authorized_users where created_at >= d7_start),
    'atRisk', (select count(distinct user_id) from risk_alerts where status = 'pending'),
    'criticalAlerts', (select count(*) from risk_alerts where status = 'pending' and risk_level = 'critical'),
    'pendingAlertItems', (select count(*) from risk_alerts where status = 'pending')
  ) into r;
  return r;
end $$;

create or replace function public.admin_usage_series()
returns jsonb language plpgsql stable security definer set search_path to 'public' as $$
declare
  tz constant text := 'America/Sao_Paulo';
  d14 timestamptz := (date_trunc('day', now() at time zone tz) - interval '13 days') at time zone tz;
  d30 timestamptz := (date_trunc('day', now() at time zone tz) - interval '29 days') at time zone tz;
begin
  if coalesce(auth.role(), '') <> 'service_role' and not public.has_role(auth.uid(), 'admin') then
    raise exception 'forbidden';
  end if;
  return jsonb_build_object(
    'daily', (select coalesce(jsonb_agg(x order by x->>'day'), '[]') from (
      select jsonb_build_object('day', to_char((created_at at time zone tz)::date, 'YYYY-MM-DD'),
        'messages', count(*) filter (where role = 'user'), 'botMessages', count(*) filter (where role = 'assistant'),
        'users', count(distinct user_id) filter (where role = 'user')) x
      from messages where created_at >= d14 group by (created_at at time zone tz)::date) t),
    'hourly', (select jsonb_agg(jsonb_build_object('hour', h, 'count', coalesce(c, 0)) order by h) from generate_series(0, 23) h
      left join (select extract(hour from created_at at time zone tz)::int hr, count(*) c from messages
        where role = 'user' and created_at >= d30 group by 1) m on m.hr = h),
    'topics', (select coalesce(jsonb_agg(jsonb_build_object('intent', i, 'count', c) order by c desc), '[]') from (
      select coalesce(detected_intent, 'livre') i, count(*) c from messages where role = 'user' and created_at >= d30
      group by 1 order by 2 desc limit 10) t),
    'events', (select coalesce(jsonb_agg(jsonb_build_object('name', event_name, 'count', c) order by c desc), '[]') from (
      select event_name, count(*) c from usage_events where created_at >= d30 group by 1) t),
    'nextActions', (select coalesce(jsonb_agg(jsonb_build_object('name', next_action, 'count', c) order by c desc), '[]') from (
      select next_action, count(*) c from student_memory where next_action is not null and next_action <> '' group by 1 order by 2 desc limit 10) t)
  );
end $$;

revoke all on function public.admin_overview_metrics() from public, anon;
revoke all on function public.admin_usage_series() from public, anon;
grant execute on function public.admin_overview_metrics() to authenticated, service_role;
grant execute on function public.admin_usage_series() to authenticated, service_role;

create or replace function public.ai_usage_summary()
returns jsonb language plpgsql stable security definer set search_path = public as $$
declare
  tz constant text := 'America/Sao_Paulo';
  t0 timestamptz := date_trunc('day', now() at time zone tz) at time zone tz;
  t7 timestamptz := (date_trunc('day', now() at time zone tz) - interval '6 days') at time zone tz;
  tm timestamptz := date_trunc('month', now() at time zone tz) at time zone tz;
begin
  if coalesce(auth.role(), '') <> 'service_role' then raise exception 'forbidden'; end if;
  return (select coalesce(jsonb_agg(jsonb_build_object('period', p, 'use', u, 'calls', c, 'errors', e, 'input', i, 'output', o)), '[]') from (
    select p, use u, count(*) c, count(*) filter (where error is not null) e,
      coalesce(sum(input_tokens),0) i, coalesce(sum(output_tokens),0) o
    from ai_usage_log l
    cross join lateral (values ('hoje', t0), ('7d', t7), ('mes', tm)) v(p, s)
    where l.created_at >= v.s and l.created_at >= least(t7, tm)
    group by p, use) x);
end $$;
revoke all on function public.ai_usage_summary() from public, anon, authenticated;
grant execute on function public.ai_usage_summary() to service_role;

-- =====================================================================================
-- ARQUIVOS (Storage): 2 pastas privadas, como no MGA
-- =====================================================================================

insert into storage.buckets (id, name, public, file_size_limit)
values ('knowledge', 'knowledge', false, 50000000), ('uploads', 'uploads', false, 10000000)
on conflict (id) do nothing;

-- knowledge: documentos da base (só administradoras).
create policy knowledge_admin_all on storage.objects for all to authenticated
  using (bucket_id = 'knowledge' and public.has_role(auth.uid(), 'admin'))
  with check (bucket_id = 'knowledge' and public.has_role(auth.uid(), 'admin'));

-- uploads: prints que a pessoa manda no chat, numa pasta com o id dela (admin também lê).
create policy uploads_insert_own on storage.objects for insert to authenticated
  with check (bucket_id = 'uploads' and (storage.foldername(name))[1] = auth.uid()::text);
create policy uploads_select_own on storage.objects for select to authenticated
  using (bucket_id = 'uploads' and ((storage.foldername(name))[1] = auth.uid()::text or public.has_role(auth.uid(), 'admin')));
create policy uploads_delete_own on storage.objects for delete to authenticated
  using (bucket_id = 'uploads' and (storage.foldername(name))[1] = auth.uid()::text);
