-- =====================================================================================
-- MSI (09/10/2026): entrada no bot por e-mail › CPF › nome da compra › WhatsApp.
-- Plano: docs/plano-identificacao-e-membrium.md (Parte 1). Regras no código: src/lib/dr/identificacao.ts.
--
-- 1. authorized_users ganha os dados de reserva que chegam na compra (webhook ou planilha):
--    - cpf: só os 11 números (decisão de 09/10: a equipe vê o CPF completo no painel; a aluna nunca vê).
--    - telefone: só números, com o 55.
--    - nome_busca e telefone_busca: calculados pelo banco (não dá para gravar direto), para a busca.
--    - emails_anteriores: e-mails trocados pela equipe no painel (login, webhooks e planilha continuam achando).
-- 2. tentativas_entrada: cada tentativa da tela de entrada (limite de chutes) e cada entrada com sucesso
--    (por onde ela entrou, por aparelho: quem entrou pelo nome ou WhatsApp passa pela "dupla checagem").
-- 3. identificacao_alertas: aba Acessos › "Entrada no bot" do painel (com o CPF digitado, para a equipe procurar).
--    - nao_encontrada: nenhum dado achou a compra (o time procura e chama no WhatsApp digitado).
--    - email_diferente: entrou pelo CPF/nome/WhatsApp e tinha digitado outro e-mail (talvez trocou de e-mail).
-- 4. access_alerts ganha a "dupla checagem": quem entrou pelo nome ou WhatsApp e reclama de acesso.
--
-- Só o servidor grava (service_role); administradores leem e marcam como resolvido.
-- Pode rodar de novo sem erro (if not exists / drop if exists), inclusive por cima da 1ª versão (CPF em código).
-- =====================================================================================

-- ---------- Nome para comparar (igual a normalizarNome em src/lib/dr/identificacao.ts) ----------
-- Sem acento, minúsculo, só letras, sem "de/da/do/das/dos/e/d". A tabela de acentos é conferida pelo teste.
create or replace function public.normalizar_nome(t text)
returns text
language sql
immutable
parallel safe
set search_path to ''
as $function$
  select nullif(array_to_string(array(
    select p.w
    from regexp_split_to_table(
      regexp_replace(
        translate(
          lower(coalesce(t, '')),
          'áàâãäåāăąçćĉċčďéèêëēĕėęěĝğġģĥíìîïĩīĭįĵķĺļľñńņňóòôõöōŏőŕŗřśŝşšţťúùûüũūŭůűųŵýÿŷźżž',
          'aaaaaaaaacccccdeeeeeeeeegggghiiiiiiiijklllnnnnoooooooorrrssssttuuuuuuuuuuwyyyzzz'
        ),
        '[^a-z]+', ' ', 'g'
      ),
      ' '
    ) with ordinality as p(w, n)
    where p.w <> '' and p.w not in ('de', 'da', 'do', 'das', 'dos', 'e', 'd')
    order by p.n
  ), ' '), '')
$function$;

-- ---------- Dados de reserva no cadastro ----------
alter table public.authorized_users
  drop column if exists cpf_hash,
  drop column if exists cpf_final,
  add column if not exists cpf text check (cpf is null or cpf ~ '^[0-9]{11}$'),
  add column if not exists telefone text check (telefone is null or telefone ~ '^[0-9]{10,15}$'),
  add column if not exists emails_anteriores text[] not null default '{}',
  add column if not exists nome_busca text generated always as (public.normalizar_nome(name)) stored,
  -- Brasil: DDD + 8 últimos números (aceita com e sem o 9). Igual a chaveTelefone no código.
  add column if not exists telefone_busca text generated always as (
    case when telefone ~ '^55[0-9]{10,11}$' then substr(telefone, 3, 2) || right(telefone, 8) else telefone end
  ) stored;

comment on column public.authorized_users.cpf is 'CPF da compra, só números. A equipe vê no painel; a aluna nunca vê.';
comment on column public.authorized_users.emails_anteriores is 'E-mails trocados pela equipe no painel; login, webhooks e planilha continuam encontrando a pessoa por eles.';

create index if not exists authorized_users_cpf_idx on public.authorized_users using btree (cpf) where cpf is not null;
create index if not exists authorized_users_nome_busca_idx on public.authorized_users using btree (nome_busca) where nome_busca is not null;
create index if not exists authorized_users_telefone_busca_idx on public.authorized_users using btree (telefone_busca) where telefone_busca is not null;
create index if not exists authorized_users_emails_anteriores_idx on public.authorized_users using gin (emails_anteriores);

-- ---------- Tentativas e entradas ----------
create table if not exists public.tentativas_entrada (
  id uuid primary key default gen_random_uuid(),
  etapa text not null check (etapa in ('email', 'cpf', 'nome', 'whatsapp')),
  resultado text not null check (resultado in ('entrou', 'nao_encontrado')),
  -- Quando entrou: email | email_anterior | cpf | nome | whatsapp.
  via text check (via is null or via in ('email', 'email_anterior', 'cpf', 'nome', 'whatsapp')),
  user_id uuid references auth.users(id) on delete cascade,
  authorized_user_id uuid references public.authorized_users(id) on delete set null,
  device_id text,
  ip text,
  created_at timestamptz not null default now()
);

create index if not exists tentativas_entrada_device_idx on public.tentativas_entrada using btree (device_id, created_at desc);
create index if not exists tentativas_entrada_ip_idx on public.tentativas_entrada using btree (ip, created_at desc);
create index if not exists tentativas_entrada_user_idx on public.tentativas_entrada using btree (user_id, created_at desc) where user_id is not null;

alter table public.tentativas_entrada enable row level security;
drop policy if exists "Admins read tentativas_entrada" on public.tentativas_entrada;
create policy "Admins read tentativas_entrada" on public.tentativas_entrada for select to authenticated using (public.has_role(auth.uid(), 'admin'));

-- ---------- Avisos da entrada para o painel ----------
create table if not exists public.identificacao_alertas (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('nao_encontrada', 'email_diferente')),
  status text not null default 'pending' check (status in ('pending', 'resolved')),
  -- O que ela digitou.
  email_digitado text,
  cpf_digitado text,
  nome_digitado text,
  whatsapp_digitado text,
  -- email_diferente: por onde entrou e em qual cadastro.
  via text,
  authorized_user_id uuid references public.authorized_users(id) on delete set null,
  user_id uuid references auth.users(id) on delete set null,
  device_id text,
  ip text,
  tentativas integer not null default 1,
  observacao text,
  resolucao text,
  resolved_by uuid,
  resolved_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

-- 1ª versão (09/10) guardava o CPF em código: troca pelas colunas atuais.
alter table public.identificacao_alertas
  drop column if exists cpf_hash,
  drop column if exists cpf_final,
  add column if not exists cpf_digitado text;

create index if not exists identificacao_alertas_status_idx on public.identificacao_alertas using btree (status, updated_at desc);
create index if not exists identificacao_alertas_device_idx on public.identificacao_alertas using btree (device_id) where status = 'pending';
drop trigger if exists identificacao_alertas_set_updated_at on public.identificacao_alertas;
create trigger identificacao_alertas_set_updated_at before update on public.identificacao_alertas for each row execute function public.set_updated_at();

alter table public.identificacao_alertas enable row level security;
drop policy if exists "Admins read identificacao_alertas" on public.identificacao_alertas;
drop policy if exists "Admins update identificacao_alertas" on public.identificacao_alertas;
create policy "Admins read identificacao_alertas" on public.identificacao_alertas for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admins update identificacao_alertas" on public.identificacao_alertas for update to authenticated using (public.has_role(auth.uid(), 'admin'));

-- ---------- Dupla checagem nos alertas de acesso ----------
alter table public.access_alerts
  add column if not exists conferir_identidade boolean not null default false,
  add column if not exists entrada_via text;
comment on column public.access_alerts.conferir_identidade is 'Entrou no bot pelo nome ou WhatsApp: a equipe confere a identidade antes de mandar link de acesso.';
