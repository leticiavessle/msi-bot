import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { PRODUCTS, PRODUCT_LABELS, type Product } from "@/lib/dr/config";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { ArrowLeft, RefreshCw } from "lucide-react";
import {
  listProductNames,
  listWebhookEvents,
  mapProductName,
  previewCademiProducts,
  reprocessWebhookEvent,
} from "@/lib/dr/admin-users.functions";

function fmt(value: string) {
  return new Date(value).toLocaleString("pt-BR", { dateStyle: "short", timeStyle: "short" });
}

export function WebhooksPanel() {
  const listFn = useServerFn(listWebhookEvents);
  const reprocessFn = useServerFn(reprocessWebhookEvent);
  const queryClient = useQueryClient();
  const [page, setPage] = useState(0);
  const [onlyErrors, setOnlyErrors] = useState(false);
  const [provider, setProvider] = useState("");
  const [openId, setOpenId] = useState<string | null>(null);

  const { data, isLoading } = useQuery({
    queryKey: ["admin-webhooks", page, onlyErrors, provider],
    queryFn: () =>
      listFn({ data: { page, pageSize: 50, onlyErrors, ...(provider ? { provider } : {}) } }),
  });

  const reprocess = useMutation({
    mutationFn: (id: string) => reprocessFn({ data: { id } }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-webhooks"] }),
  });

  const rows = data?.rows ?? [];
  const total = data?.total ?? 0;
  const selected = rows.find((r) => r.id === openId) ?? null;

  if (selected) {
    return (
      <section className="flex flex-col gap-3">
        <button
          type="button"
          onClick={() => setOpenId(null)}
          className="inline-flex items-center gap-2 self-start text-sm font-medium text-primary"
        >
          <ArrowLeft className="size-4" /> Voltar à lista
        </button>
        <div className="rounded-2xl border border-border bg-surface p-4">
          <p className="text-sm font-semibold">
            {selected.provider} · {selected.eventType}
          </p>
          <p className="text-xs text-muted-foreground">
            {fmt(selected.createdAt)} · {selected.email ?? "sem e-mail"} ·{" "}
            {selected.product ?? "sem produto"} ·{" "}
            {selected.processed ? "processado" : "não processado"}
          </p>
          {selected.error ? (
            <p className="mt-1 text-xs text-destructive">{selected.error}</p>
          ) : null}
          <pre className="mt-3 max-h-[60vh] overflow-auto rounded-xl bg-muted p-3 text-[11px] whitespace-pre-wrap">
            {selected.payload}
          </pre>
        </div>
      </section>
    );
  }

  return (
    <section className="flex flex-col gap-3">
      <CademiCheck />
      <ProductMapping />
      <div className="flex flex-wrap items-center gap-3">
        <label className="inline-flex items-center gap-2 text-xs text-muted-foreground">
          <input
            type="checkbox"
            checked={onlyErrors}
            onChange={(e) => {
              setOnlyErrors(e.target.checked);
              setPage(0);
            }}
          />
          Só com erro
        </label>
        <select
          value={provider}
          onChange={(e) => {
            setProvider(e.target.value);
            setPage(0);
          }}
          className="min-h-9 rounded-xl border border-border bg-surface px-2 text-xs"
        >
          <option value="">Todos os provedores</option>
          <option value="hubla">Hubla</option>
          <option value="cademi">Cademí</option>
          <option value="payt">Payt</option>
          <option value="lastlink">LastLink</option>
        </select>
        <span className="text-xs text-muted-foreground">{total} evento(s)</span>
      </div>

      {isLoading ? <p className="text-sm text-muted-foreground">Carregando…</p> : null}
      {!isLoading && rows.length === 0 ? (
        <p className="text-sm text-muted-foreground">Nenhum evento registrado.</p>
      ) : null}

      <div className="flex flex-col gap-2">
        {rows.map((r) => (
          <div
            key={r.id}
            className="flex items-center gap-2 rounded-xl border border-border bg-surface px-3 py-2"
          >
            <button
              type="button"
              onClick={() => setOpenId(r.id)}
              className="flex-1 text-left transition-colors hover:opacity-80"
            >
              <p className="text-sm font-medium">
                {r.eventType} · {r.email ?? "sem e-mail"}
              </p>
              <p className="text-[11px] text-muted-foreground">
                {fmt(r.createdAt)} · {r.provider} · {r.product ?? "sem produto"} ·{" "}
                {r.processed ? "processado" : "não processado"}
                {r.error ? ` · erro: ${r.error}` : ""}
              </p>
            </button>
            {r.error ? (
              <button
                type="button"
                disabled={reprocess.isPending}
                onClick={() => reprocess.mutate(r.id)}
                className="inline-flex min-h-9 items-center gap-1 rounded-xl border border-border px-3 text-xs font-medium disabled:opacity-40"
              >
                <RefreshCw className="size-3.5" /> Reprocessar
              </button>
            ) : null}
          </div>
        ))}
      </div>

      <Pager page={page} total={total} pageSize={50} onChange={setPage} />
    </section>
  );
}

export function Pager({
  page,
  total,
  pageSize,
  onChange,
}: {
  page: number;
  total: number;
  pageSize: number;
  onChange: (page: number) => void;
}) {
  const pages = Math.max(1, Math.ceil(total / pageSize));
  if (pages <= 1) return null;
  return (
    <div className="flex items-center gap-2 text-xs">
      <button
        type="button"
        disabled={page === 0}
        onClick={() => onChange(page - 1)}
        className="min-h-9 rounded-xl border border-border px-3 disabled:opacity-40"
      >
        Anterior
      </button>
      <span className="text-muted-foreground">
        Página {page + 1} de {pages}
      </span>
      <button
        type="button"
        disabled={page + 1 >= pages}
        onClick={() => onChange(page + 1)}
        className="min-h-9 rounded-xl border border-border px-3 disabled:opacity-40"
      >
        Próxima
      </button>
    </div>
  );
}

const MAP_OPTIONS = [
  { value: "", label: "Escolher…" },
  ...PRODUCTS.map((p) => ({ value: p, label: PRODUCT_LABELS[p] })),
  { value: "ignore", label: "Ignorar" },
];

function ProductMapping() {
  const listFn = useServerFn(listProductNames);
  const mapFn = useServerFn(mapProductName);
  const queryClient = useQueryClient();
  const [notice, setNotice] = useState<string | null>(null);
  const [choice, setChoice] = useState<Record<string, string>>({});
  const { data } = useQuery({ queryKey: ["admin-product-names"], queryFn: () => listFn() });
  const save = useMutation({
    mutationFn: (v: { id: string; mappedTo: Product | "ignore" }) =>
      mapFn({ data: { ...v, reprocess: true } }),
    onSuccess: (r) => {
      setNotice(`Mapeado. ${r.reprocessed} evento(s) reprocessado(s), ${r.granted} liberado(s).`);
      queryClient.invalidateQueries({ queryKey: ["admin-product-names"] });
      queryClient.invalidateQueries({ queryKey: ["admin-webhooks"] });
    },
  });
  const rows = data ?? [];
  if (rows.length === 0) return null;
  const pending = rows.filter((r) => !r.mapped_to);

  return (
    <div className="rounded-2xl border border-border bg-surface p-4">
      {pending.length > 0 ? (
        <p className="mb-2 rounded-xl border border-primary/40 bg-primary/10 px-3 py-2 text-xs font-medium text-primary">
          ⚠️ Produto da Payt não mapeado: {pending.length} nome(s) aguardando. Liberação
          provisória ativa: cada compra entra como {PRODUCT_LABELS[PRODUCTS[0]]} com etiqueta "Payt provisório".
        </p>
      ) : null}
      <p className="text-sm font-semibold">Mapeamento de produtos</p>
      <div className="mt-2 flex flex-col gap-2">
        {rows.map((r) => (
          <div key={r.id} className="flex flex-wrap items-center gap-2 text-xs">
            <div className="min-w-0 flex-1">
              <p className="truncate font-medium">{r.name}</p>
              <p className="text-muted-foreground">
                {r.provider} · {r.last_email ?? "sem e-mail"} · {r.pending_count} pendente(s)
                {r.mapped_to ? ` · atual: ${r.mapped_to}` : " · não mapeado"}
              </p>
            </div>
            <select
              value={choice[r.id] ?? r.mapped_to ?? ""}
              onChange={(e) => setChoice((c) => ({ ...c, [r.id]: e.target.value }))}
              className="min-h-9 rounded-xl border border-border bg-surface px-2"
            >
              {MAP_OPTIONS.map((o) => (
                <option key={o.value} value={o.value}>
                  {o.label}
                </option>
              ))}
            </select>
            <button
              type="button"
              disabled={!(choice[r.id] ?? r.mapped_to) || save.isPending}
              onClick={() =>
                save.mutate({
                  id: r.id,
                  mappedTo: (choice[r.id] ?? r.mapped_to) as Product | "ignore",
                })
              }
              className="inline-flex min-h-9 items-center gap-1 rounded-xl border border-border px-3 font-medium disabled:opacity-40"
            >
              <RefreshCw className="size-3.5" /> Salvar e reprocessar
            </button>
          </div>
        ))}
      </div>
      {notice ? <p className="mt-2 text-xs text-muted-foreground">{notice}</p> : null}
    </div>
  );
}

const LABEL: Record<string, string> = PRODUCT_LABELS;

/** Confere se a Cademí já está mandando o produto. Só leitura. */
function CademiCheck() {
  const fn = useServerFn(previewCademiProducts);
  const { data, isLoading } = useQuery({ queryKey: ["cademi-product-check"], queryFn: () => fn() });
  return (
    <div className="rounded-xl border border-border bg-surface p-3 text-xs">
      <p className="text-sm font-medium">Produto da Cademí</p>
      {isLoading || !data ? (
        <p className="text-muted-foreground">Carregando…</p>
      ) : (
        <div className="mt-1 flex flex-col gap-1 text-muted-foreground">
          <p>
            Eventos que chegaram <b className="text-foreground">com produto</b>: {data.eventsWithProduct}
            {data.lastWithProduct ? ` (último em ${fmt(data.lastWithProduct)})` : " — a configuração ainda não pegou"}
          </p>
          <p>
            Eventos <b className="text-foreground">sem produto</b> nos últimos 7 dias: {data.missingLast7d}
            {data.lastMissing ? ` (último em ${fmt(data.lastMissing)})` : ""}
          </p>
          {data.pendingIds.length > 0 ? (
            <p>Códigos de produto da Cademí esperando mapeamento: {data.pendingIds.map((p) => p.name.replace(/^id:/, "")).join(", ")} (mapeie abaixo)</p>
          ) : null}
          <p>
            Prévia (nada foi alterado): {data.peopleWouldGain} pessoa(s) ganhariam produto
            {Object.keys(data.gains).length
              ? ` — ${Object.entries(data.gains).map(([p, n]) => `${LABEL[p] ?? p}: ${n}`).join(", ")}`
              : ""}
            . {data.peopleWithOtherProducts} têm hoje produto que a Cademí não mandou; ninguém perde acesso sem autorização.
          </p>
        </div>
      )}
    </div>
  );
}
