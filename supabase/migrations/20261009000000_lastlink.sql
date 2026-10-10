-- MSI (09/10/2026): vendas pela LastLink.
-- Nova origem de acesso para quem comprou pela LastLink (aparece como "LastLink" no painel).
-- O webhook fica em /api/public/webhooks/lastlink?token=<WEBHOOK_SECRET_LASTLINK>.
alter type public.access_source add value if not exists 'lastlink';
