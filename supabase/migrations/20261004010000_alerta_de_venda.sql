-- MSI (04/10/2026): alerta de venda.
-- Quando a aluna pergunta preço, desconto, parcelamento ou como comprar um produto, o bot
-- continua respondendo "essa informação é com o time" e grava uma linha aqui para a aba
-- "Vendas" do painel. Mesmo modelo de access_alerts: só o servidor grava (service_role);
-- administradores leem e marcam como atendido.

create table public.sales_alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null,
  conversation_id uuid references public.conversations(id) on delete set null,
  trigger_text text not null,
  product public.product_type,
  status text not null default 'pending' check (status in ('pending', 'resolved')),
  resolved_by uuid,
  resolved_at timestamptz,
  created_at timestamptz not null default now()
);

create index sales_alerts_status_idx on public.sales_alerts using btree (status);
create index sales_alerts_user_idx on public.sales_alerts using btree (user_id, created_at desc);

alter table public.sales_alerts enable row level security;
create policy "Admins read sales alerts" on public.sales_alerts for select to authenticated using (public.has_role(auth.uid(), 'admin'));
create policy "Admins update sales alerts" on public.sales_alerts for update to authenticated using (public.has_role(auth.uid(), 'admin'));
