import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { Ban, Download, Plus, Trash2, Upload, X } from "lucide-react";
import {
  countPaytProvisional,
  deleteAuthorizedUser,
  revokeAllPaytProvisional,
  importAuthorizedUsers,
  listAuthorizedUsers,
  listLoginDenied,
  revokeAuthorizedUsersCsv,
  upsertAuthorizedUser,
} from "@/lib/dr/admin-users.functions";
import { StudentProfilePanel } from "./StudentProfilePanel";
import { CopyText } from "./CopyText";
import { Pager } from "./WebhooksPanel";
import { parseRevokeCsv, parseStudentsCsv, type SkippedRow } from "@/lib/dr/csv";
import { downloadCsv, toCsv } from "@/lib/dr/export-csv";
import { PRODUCTS, PRODUCT_LABELS, PRODUTO_PADRAO, type Product as ProductKey } from "@/lib/dr/config";

const STATUSES = ["active", "blocked", "refunded", "canceled"] as const;
const PAGE_SIZE = 50;
const ORIGIN_LABEL: Record<string, string> = {
  manual: "manual",
  import: "planilha",
  webhook: "compra Hubla",
  cademi: "Cademí",
  payt: "Payt",
  lastlink: "LastLink",
  seed: "inicial",
};

const PRODUCT_ORIGIN: Record<string, { label: string; hint: string; cls: string }> = {
  confirmado: { label: "produto confirmado", hint: "O produto veio da origem (Hubla, planilha com produto ou Cademí com produto).", cls: "border-online/40 text-online" },
  padrao: { label: `${PRODUCT_LABELS[PRODUTO_PADRAO]} por padrão`, hint: `A origem não mandou o produto; o sistema preencheu ${PRODUCT_LABELS[PRODUTO_PADRAO]} sozinho.`, cls: "border-destructive/40 text-destructive" },
  incerto: { label: "sem como saber", hint: "Planilha antiga: não dá para saber se o produto veio da planilha ou foi preenchido.", cls: "border-border text-muted-foreground" },
};

export function UsersPanel() {
  const queryClient = useQueryClient();
  const list = useServerFn(listAuthorizedUsers);
  const denied = useServerFn(listLoginDenied);
  const upsert = useServerFn(upsertAuthorizedUser);
  const remove = useServerFn(deleteAuthorizedUser);
  const importFn = useServerFn(importAuthorizedUsers);
  const revokeFn = useServerFn(revokeAuthorizedUsersCsv);

  const countPayt = useServerFn(countPaytProvisional);
  const revokePayt = useServerFn(revokeAllPaytProvisional);
  const [page, setPage] = useState(0);
  const [search, setSearch] = useState("");
  const [deniedSearch, setDeniedSearch] = useState("");
  const [showDenied, setShowDenied] = useState(false);
  const [paytOnly, setPaytOnly] = useState(false);
  const [productFilter, setProductFilter] = useState("");
  const [originFilter, setOriginFilter] = useState("");
  const [sourceFilter, setSourceFilter] = useState("");

  const { data, isLoading, isFetching } = useQuery({
    queryKey: ["admin-users", page, search, paytOnly, productFilter, originFilter, sourceFilter],
    queryFn: () =>
      list({
        data: {
          page,
          pageSize: PAGE_SIZE,
          search: search || undefined,
          paytProvisional: paytOnly || undefined,
          product: (productFilter || undefined) as never,
          productOrigin: (originFilter || undefined) as never,
          source: (sourceFilter || undefined) as never,
        },
      }),
    refetchInterval: 120_000,
  });

  const { data: paytCount } = useQuery({
    queryKey: ["admin-users", "payt-provisional-count"],
    queryFn: () => countPayt(),
    refetchInterval: 120_000,
  });

  const revokeAllPayt = useMutation({
    mutationFn: async () => {
      const n = paytCount?.count ?? 0;
      if (!window.confirm(`Desativar os ${n} aluno(s) "Payt provisório"? O cadastro fica guardado e dá para reativar depois.`)) {
        throw new Error("Revogação cancelada.");
      }
      return revokePayt();
    },
    onSuccess: async (res) => {
      setError(null);
      setSummary(`Payt provisório: ${res.revoked} acesso(s) desativado(s).`);
      setSkippedRows([]);
      await queryClient.invalidateQueries({ queryKey: ["admin-users"] });
    },
    onError: (e) => setError(e instanceof Error ? e.message : "Não consegui revogar."),
  });

  const { data: deniedRows } = useQuery({
    queryKey: ["admin-login-denied", deniedSearch],
    queryFn: () => denied({ data: { search: deniedSearch || undefined } }),
    enabled: showDenied,
  });

  const users = data?.rows ?? [];
  const total = data?.total ?? 0;

  const [openForm, setOpenForm] = useState(false);
  const [selected, setSelected] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [progress, setProgress] = useState<string | null>(null);
  const [summary, setSummary] = useState<string | null>(null);
  const [skippedRows, setSkippedRows] = useState<SkippedRow[]>([]);

  const [form, setForm] = useState({
    email: "",
    name: "",
    role: "student" as "student" | "admin",
    status: "active" as (typeof STATUSES)[number],
    products: [PRODUTO_PADRAO] as ProductKey[],
  });

  const invalidate = () => queryClient.invalidateQueries({ queryKey: ["admin-users"] });

  const save = useMutation({
    mutationFn: async () =>
      upsert({
        data: {
          email: form.email.trim(),
          name: form.name.trim() || null,
          role: form.role,
          status: form.status,
          products: form.products.length ? form.products : [PRODUTO_PADRAO],
        },
      }),
    onSuccess: async () => {
      setOpenForm(false);
      setError(null);
      setForm({ email: "", name: "", role: "student", status: "active", products: [PRODUTO_PADRAO] });
      await invalidate();
    },
    onError: (e) => setError(e instanceof Error ? e.message : "Não consegui salvar."),
  });

  const importCsv = useMutation({
    mutationFn: async (file: File) => {
      const parsed = parseStudentsCsv(await file.text());
      if (parsed.rows.length === 0) {
        throw new Error(
          "Não encontrei e-mails válidos no arquivo. Aceito o export (CSV) da Hubla, da Payt, da LastLink ou o formato email;nome;produtos.",
        );
      }
      // Planilha sem coluna de status do pagamento: não dá para saber quem pagou. Pergunta antes de liberar.
      const modo: "liberar" | "completar" =
        parsed.semStatus &&
        !window.confirm(
          `Essa planilha não tem coluna de status do pagamento. Liberar acesso para as ${parsed.rows.length} pessoa(s) da lista?\n\nOK = liberar acesso · Cancelar = só completar CPF, WhatsApp e nome de quem já tem cadastro`,
        )
          ? "completar"
          : "liberar";
      let created = 0;
      let updatedCount = 0;
      const ignored: SkippedRow[] = [...parsed.skippedRows];
      const refused: SkippedRow[] = [];
      for (let i = 0; i < parsed.rows.length; i += 200) {
        const batch = parsed.rows.slice(i, i + 200);
        setProgress(
          `Importando ${Math.min(i + batch.length, parsed.rows.length)} de ${parsed.rows.length}…`,
        );
        const res = await importFn({ data: { source: parsed.format, modo, rows: batch } });
        created += res.created;
        updatedCount += res.updated;
        ignored.push(...res.ignored);
        refused.push(...res.refused);
      }
      return { ...parsed, modo, created, updated: updatedCount, ignored, refused };
    },
    onSuccess: async (res) => {
      setError(null);
      setProgress(null);
      setSkippedRows([
        ...res.refused.map((r) => ({ ...r, reason: `recusado: ${r.reason}` })),
        ...res.ignored.map((r) => ({ ...r, reason: `ignorado: ${r.reason}` })),
      ]);
      const label =
        res.format === "hubla"
          ? "faturas Hubla"
          : res.format === "cademi"
            ? "alunos Cademí"
            : res.format === "planilha"
              ? "planilha com cabeçalho"
              : "CSV simples";
      const comCpf = res.rows.filter((r) => r.cpf).length;
      const comFone = res.rows.filter((r) => r.telefone).length;
      const colunas = res.colunas
        ? ` Colunas usadas: CPF = ${res.colunas.cpf ?? "não achei"} · WhatsApp = ${res.colunas.telefone ?? "não achei"}${res.colunas.status ? ` · status = ${res.colunas.status}` : ""}.`
        : "";
      setSummary(
        `Importação concluída (${label}${res.modo === "completar" ? ", só completar dados" : ""}): ${res.linesRead} linhas lidas · ${res.created} e-mails novos · ${res.updated} atualizados · ${res.ignored.length} ignorados · ${res.refused.length} recusados · ${comCpf} com CPF válido · ${comFone} com WhatsApp válido.${colunas}`,
      );
      await invalidate();
    },
    onError: (e) => {
      setProgress(null);
      setSummary(null);
      setSkippedRows([]);
      setError(e instanceof Error ? e.message : "Não consegui importar.");
    },
  });

  const revokeCsv = useMutation({
    mutationFn: async (file: File) => {
      const parsed = parseRevokeCsv(await file.text());
      if (parsed.rows.length === 0) throw new Error("Não encontrei e-mails válidos (colunas email,motivo).");
      if (!window.confirm(`Desativar o acesso de até ${parsed.rows.length} e-mail(s)? Dá para reverter depois pelo painel.`)) {
        throw new Error("Revogação cancelada.");
      }
      let revoked = 0;
      const notFound: string[] = [];
      const inactive: string[] = [];
      for (let i = 0; i < parsed.rows.length; i += 400) {
        const batch = parsed.rows.slice(i, i + 400);
        setProgress(`Revogando ${Math.min(i + batch.length, parsed.rows.length)} de ${parsed.rows.length}…`);
        const res = await revokeFn({ data: { rows: batch } });
        revoked += res.revoked;
        notFound.push(...res.notFound);
        inactive.push(...res.alreadyInactive);
      }
      return { revoked, notFound, inactive, invalid: parsed.invalid, lines: parsed.rows.length };
    },
    onSuccess: async (res) => {
      setError(null);
      setProgress(null);
      setSkippedRows([
        ...res.notFound.map((email) => ({ email, reason: "não encontrado" })),
        ...res.inactive.map((email) => ({ email, reason: "já estava inativo" })),
      ]);
      setSummary(
        `Revogação concluída: ${res.lines} e-mails lidos · ${res.revoked} desativados · ${res.notFound.length} não encontrados · ${res.inactive.length} já estavam inativos · ${res.invalid} linhas inválidas.`,
      );
      await invalidate();
    },
    onError: (e) => {
      setProgress(null);
      setError(e instanceof Error ? e.message : "Não consegui revogar.");
    },
  });

  if (selected) {
    return <StudentProfilePanel userId={selected} onBack={() => setSelected(null)} />;
  }

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-wrap items-center gap-2">
        <button
          type="button"
          onClick={() => setOpenForm((v) => !v)}
          className="inline-flex min-h-10 items-center gap-2 rounded-xl bg-primary px-3 text-sm font-semibold text-primary-foreground"
        >
          {openForm ? <X className="size-4" /> : <Plus className="size-4" />}
          {openForm ? "Cancelar" : "Novo aluno"}
        </button>
        <label className="inline-flex min-h-10 cursor-pointer items-center gap-2 rounded-xl border border-border px-3 text-sm font-medium">
          <Upload className="size-4" />
          Importar CSV
          <input
            type="file"
            accept=".csv,text/csv"
            className="hidden"
            onChange={(e) => {
              const file = e.target.files?.[0];
              if (file) importCsv.mutate(file);
              e.target.value = "";
            }}
          />
        </label>
        <label className="inline-flex min-h-10 cursor-pointer items-center gap-2 rounded-xl border border-destructive/40 px-3 text-sm font-medium text-destructive">
          <Ban className="size-4" />
          Revogar acesso por CSV
          <input
            type="file"
            accept=".csv,text/csv"
            className="hidden"
            onChange={(e) => {
              const file = e.target.files?.[0];
              if (file) revokeCsv.mutate(file);
              e.target.value = "";
            }}
          />
        </label>
        <input
          value={search}
          onChange={(e) => {
            setSearch(e.target.value);
            setPage(0);
          }}
          placeholder="Buscar por e-mail, nome ou WhatsApp"
          className="min-h-10 flex-1 rounded-xl border border-border bg-background px-3 text-sm"
        />
      </div>

      <div className="flex flex-wrap items-center gap-2">
        <button
          type="button"
          onClick={() => {
            setPaytOnly((v) => !v);
            setPage(0);
          }}
          className={`min-h-9 rounded-full border px-3 text-xs font-medium ${
            paytOnly ? "border-primary bg-primary text-primary-foreground" : "border-border text-muted-foreground"
          }`}
        >
          Payt provisório ({paytCount?.count ?? 0})
        </button>
        {paytOnly ? (
          <button
            type="button"
            disabled={revokeAllPayt.isPending || (paytCount?.count ?? 0) === 0}
            onClick={() => revokeAllPayt.mutate()}
            className="inline-flex min-h-9 items-center gap-2 rounded-xl border border-destructive/40 px-3 text-xs font-medium text-destructive disabled:opacity-50"
          >
            <Ban className="size-4" />
            {revokeAllPayt.isPending ? "Revogando…" : "Revogar todos"}
          </button>
        ) : null}
      </div>

      {progress ? <p className="text-xs text-muted-foreground">{progress}</p> : null}
      {summary ? (
        <div className="flex flex-col gap-2 rounded-xl border border-border bg-surface p-3">
          <p className="text-xs">{summary}</p>
          {skippedRows.length > 0 ? (
            <>
              <button
                type="button"
                onClick={() =>
                  downloadCsv(
                    `ignorados-${new Date().toISOString().slice(0, 10)}.csv`,
                    toCsv(
                      ["email", "motivo"],
                      skippedRows.map((r) => [r.email, r.reason]),
                    ),
                  )
                }
                className="inline-flex min-h-9 w-fit items-center gap-2 rounded-xl border border-border px-3 text-xs font-medium"
              >
                <Download className="size-4" /> Baixar lista de ignorados
              </button>
              <div className="max-h-40 overflow-auto text-[11px] text-muted-foreground">
                {skippedRows.slice(0, 200).map((r, i) => (
                  <p key={`${r.email}-${i}`}>
                    {r.email} — {r.reason}
                  </p>
                ))}
              </div>
            </>
          ) : null}
        </div>
      ) : null}
      {error ? <p className="text-xs text-destructive">{error}</p> : null}

      {openForm ? (
        <section className="grid gap-3 rounded-2xl border border-border bg-surface p-4 md:grid-cols-2">
          <input
            value={form.email}
            onChange={(e) => setForm({ ...form, email: e.target.value })}
            placeholder="E-mail do aluno"
            className="min-h-10 rounded-xl border border-border bg-background px-3 text-sm"
          />
          <input
            value={form.name}
            onChange={(e) => setForm({ ...form, name: e.target.value })}
            placeholder="Nome"
            className="min-h-10 rounded-xl border border-border bg-background px-3 text-sm"
          />
          <select
            value={form.role}
            onChange={(e) => setForm({ ...form, role: e.target.value as "student" | "admin" })}
            className="min-h-10 rounded-xl border border-border bg-background px-3 text-sm"
          >
            <option value="student">Aluno</option>
            <option value="admin">Administrador</option>
          </select>
          <select
            value={form.status}
            onChange={(e) =>
              setForm({ ...form, status: e.target.value as (typeof STATUSES)[number] })
            }
            className="min-h-10 rounded-xl border border-border bg-background px-3 text-sm"
          >
            {STATUSES.map((s) => (
              <option key={s} value={s}>
                {s}
              </option>
            ))}
          </select>
          <div className="flex flex-wrap gap-2 md:col-span-2">
            {PRODUCTS.map((p) => {
              const on = form.products.includes(p);
              return (
                <button
                  key={p}
                  type="button"
                  onClick={() =>
                    setForm({
                      ...form,
                      products: on ? form.products.filter((x) => x !== p) : [...form.products, p],
                    })
                  }
                  className={`min-h-9 rounded-full border px-3 text-xs font-medium ${
                    on
                      ? "border-primary bg-primary text-primary-foreground"
                      : "border-border text-muted-foreground"
                  }`}
                >
                  {PRODUCT_LABELS[p]}
                </button>
              );
            })}
          </div>
          <button
            type="button"
            disabled={save.isPending}
            onClick={() => save.mutate()}
            className="min-h-10 rounded-xl bg-primary text-sm font-semibold text-primary-foreground disabled:opacity-50 md:col-span-2"
          >
            {save.isPending ? "Salvando…" : "Salvar aluno"}
          </button>
        </section>
      ) : null}

      <div className="flex flex-wrap gap-2">
        <select aria-label="Filtrar por produto" className="rounded-xl border border-border bg-surface px-2 py-1.5 text-xs" value={productFilter} onChange={(e) => { setProductFilter(e.target.value); setPage(0); }}>
          <option value="">Todos os produtos</option>
          {PRODUCTS.map((p) => (
            <option key={p} value={p}>
              {PRODUCT_LABELS[p]}
            </option>
          ))}
        </select>
        <select aria-label="Filtrar por confirmação do produto" className="rounded-xl border border-border bg-surface px-2 py-1.5 text-xs" value={originFilter} onChange={(e) => { setOriginFilter(e.target.value); setPage(0); }}>
          <option value="">Confirmado ou padrão</option>
          <option value="confirmado">Só produto confirmado</option>
          <option value="padrao">Só {PRODUCT_LABELS[PRODUTO_PADRAO]} por padrão</option>
          <option value="incerto">Só sem como saber</option>
        </select>
        <select aria-label="Filtrar por origem" className="rounded-xl border border-border bg-surface px-2 py-1.5 text-xs" value={sourceFilter} onChange={(e) => { setSourceFilter(e.target.value); setPage(0); }}>
          <option value="">Todas as origens</option>
          <option value="webhook">Hubla</option>
          <option value="cademi">Cademí</option>
          <option value="payt">Payt</option>
          <option value="lastlink">LastLink</option>
          <option value="import">Planilha</option>
          <option value="manual">Manual</option>
        </select>
      </div>

      <p className="text-xs text-muted-foreground">
        {isLoading || isFetching ? "Carregando…" : `${total} aluno(s) autorizado(s)`}
      </p>

      <div className="flex flex-col gap-2">
        {!isLoading && users.length === 0 ? (
          <p className="text-sm text-muted-foreground">Nenhum aluno encontrado.</p>
        ) : null}
        {users.map((u) => (
          <article
            key={u.id}
            className="flex items-center gap-3 rounded-xl border border-border bg-surface px-3 py-2"
          >
            <span
              className={`size-2 shrink-0 rounded-full ${u.online ? "bg-online" : "bg-muted-foreground/40"}`}
              aria-label={u.online ? "online" : "offline"}
            />
            <div className="min-w-0 flex-1 select-text">
              <div className="flex min-w-0 items-center gap-1">
                <CopyText value={u.displayName ?? u.email} label="nome" className="text-sm font-medium" />
              </div>
              <div className="flex min-w-0 items-center gap-1">
                <CopyText value={u.email} label="e-mail" className="text-[11px] text-muted-foreground" />
              </div>
              <p className="truncate text-[11px] text-muted-foreground">
                {u.status} ·{" "}
                {(u.product_access ?? [])
                  .map((p) => PRODUCT_LABELS[p as ProductKey] ?? p)
                  .join(", ") || "sem produto"}{" "}
                · {ORIGIN_LABEL[u.access_source] ?? u.access_source} · {u.messages} msgs · risco{" "}
                {u.risk}
              </p>
              {u.product_origin && PRODUCT_ORIGIN[u.product_origin] ? (
                <span
                  title={PRODUCT_ORIGIN[u.product_origin]!.hint}
                  className={`mt-0.5 inline-flex rounded-full border px-2 py-0.5 text-[10px] font-medium ${PRODUCT_ORIGIN[u.product_origin]!.cls}`}
                >
                  {PRODUCT_ORIGIN[u.product_origin]!.label}
                </span>
              ) : null}
            </div>
            {u.userId ? (
              <button
                type="button"
                onClick={() => u.userId && setSelected(u.userId)}
                className="inline-flex min-h-9 shrink-0 items-center rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted"
              >
                Ver ficha
              </button>
            ) : null}
            <button
              type="button"
              onClick={async () => {
                await remove({ data: { email: u.email } });
                await invalidate();
              }}
              aria-label="Remover acesso"
              className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-destructive"
            >
              <Trash2 className="size-4" />
            </button>
          </article>
        ))}
      </div>

      <Pager page={page} total={total} pageSize={PAGE_SIZE} onChange={setPage} />

      <section className="rounded-2xl border border-border bg-surface p-4">
        <button
          type="button"
          onClick={() => setShowDenied((v) => !v)}
          className="text-sm font-semibold"
        >
          Tentativas recusadas {showDenied ? "▾" : "▸"}
        </button>
        {showDenied ? (
          <div className="mt-3 flex flex-col gap-2">
            <input
              value={deniedSearch}
              onChange={(e) => setDeniedSearch(e.target.value)}
              placeholder="Buscar por e-mail"
              className="min-h-10 rounded-xl border border-border bg-background px-3 text-sm"
            />
            {(deniedRows ?? []).length === 0 ? (
              <p className="text-xs text-muted-foreground">Nenhuma tentativa recusada.</p>
            ) : null}
            {(deniedRows ?? []).map((r) => (
              <p key={r.id} className="text-[11px] text-muted-foreground">
                {new Date(r.createdAt).toLocaleString("pt-BR")} · {r.email ?? "sem e-mail"} ·{" "}
                {r.reason}
              </p>
            ))}
          </div>
        ) : null}
      </section>
    </div>
  );
}
