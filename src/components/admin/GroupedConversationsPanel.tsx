import { useInfiniteQuery, useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { ChevronDown, Download, Search, UsersRound } from "lucide-react";
import {
  exportConversations,
  listConversationPeople,
  searchConversations,
} from "@/lib/dr/admin-analytics.functions";
import { Avatar, EmptyState, Panel, buttonGhost, buttonPrimary, fieldClass } from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { ConversationMessages } from "@/components/admin/ConversationMessages";
import { conversationRowsToCsv, csvFileName } from "@/lib/dr/export-csv";
import { PRODUCT_LABELS, type Product } from "@/lib/dr/config";
import { cn } from "@/lib/utils";

const PAGE = 50;
const fmt = (d: string | null) => (d ? new Date(d).toLocaleString("pt-BR") : "—");

export function GroupedConversationsPanel() {
  const peopleFn = useServerFn(listConversationPeople);
  const exportFn = useServerFn(exportConversations);
  const [term, setTerm] = useState("");
  const [applied, setApplied] = useState("");
  const [open, setOpen] = useState<string | null>(null);
  const [exporting, setExporting] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const query = useInfiniteQuery({
    queryKey: ["admin-people", applied],
    initialPageParam: 0,
    queryFn: ({ pageParam }) => peopleFn({ data: { term: applied || null, limit: PAGE, offset: pageParam } }),
    getNextPageParam: (last, pages) => {
      const loaded = pages.reduce((n, p) => n + p.items.length, 0);
      return loaded < last.total && last.items.length > 0 ? loaded : undefined;
    },
  });
  const items = query.data?.pages.flatMap((p) => p.items) ?? [];
  const total = query.data?.pages[0]?.total ?? 0;

  async function runExport(key: string, scope: string, input: { userId?: string; byPeople?: boolean; term?: string | null }) {
    setExporting(key);
    setNotice(null);
    try {
      const result = await exportFn({ data: input });
      if (result.rows.length === 0) {
        setNotice("Nenhuma mensagem para exportar.");
        return;
      }
      const { downloadCsv } = await import("@/lib/dr/export-csv");
      downloadCsv(csvFileName(scope), conversationRowsToCsv(result.rows));
      setNotice(`${result.conversations} conversa(s) e ${result.rows.length} mensagem(ns) exportadas.`);
    } catch {
      setNotice("Não consegui gerar a planilha. Tente novamente.");
    } finally {
      setExporting(null);
    }
  }

  return (
    <div className="flex flex-col gap-4">
      <Panel className="flex flex-wrap items-center gap-2 p-3">
        <div className="relative min-w-52 flex-1">
          <Search className="pointer-events-none absolute left-3 top-1/2 size-4 -translate-y-1/2 text-muted-foreground" />
          <input
            value={term}
            onChange={(e) => setTerm(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && setApplied(term)}
            placeholder="Buscar por nome ou e-mail"
            className={`${fieldClass} w-full pl-9`}
          />
        </div>
        <button type="button" onClick={() => setApplied(term)} className={buttonPrimary}>
          Filtrar
        </button>
        <button
          type="button"
          disabled={exporting !== null}
          onClick={() => runExport("all", applied ? `pessoas-${applied}` : "por-pessoa", { byPeople: true, term: applied || null })}
          className={buttonGhost}
        >
          <Download className="size-4" />
          {exporting === "all" ? "Gerando…" : "Exportar"}
        </button>
      </Panel>

      <p className="text-xs text-muted-foreground">
        {query.isLoading ? "Carregando…" : `${total} pessoa(s) com conversas · mostrando ${items.length} · ordem: atividade mais recente`}
      </p>
      {notice ? <p className="text-xs text-muted-foreground">{notice}</p> : null}
      {query.isError ? <p className="text-xs text-destructive">Não consegui carregar a lista.</p> : null}

      {!query.isLoading && items.length === 0 ? (
        <EmptyState icon={<UsersRound className="size-6" />} title="Ninguém encontrado" description="Ajuste a busca por nome ou e-mail." />
      ) : null}

      {items.map((p) => (
        <Panel key={p.userId}>
          <div className="flex flex-wrap items-center gap-2 pr-3">
            <div className="flex min-w-0 flex-1 items-center gap-3 px-4 py-3">
              <Avatar name={p.name ?? p.email} />
              <div className="min-w-0 flex-1">
                {p.hasProfile ? (
                  <>
                    <CopyText value={p.name ?? p.email} label="nome" className="text-sm font-medium" />
                    <div className="flex min-w-0">
                      <CopyText value={p.email} label="e-mail" className="text-[11px] text-muted-foreground" />
                    </div>
                  </>
                ) : (
                  <>
                    <p className="text-sm font-medium">Aluno sem cadastro</p>
                    <CopyText value={p.userId} label="código" className="text-[11px] text-muted-foreground" />
                  </>
                )}
                <p className="text-[11px] text-muted-foreground">
                  {p.products.map((x) => PRODUCT_LABELS[x as Product] ?? x).join(", ") || "sem produto"} ·{" "}
                  {p.conversationCount} conversa(s) · mais recente {fmt(p.lastAt)} · primeira {fmt(p.firstAt)}
                </p>
                {p.takeover ? (
                  <p className="mt-1 inline-flex max-w-full truncate rounded-full bg-primary px-2 py-0.5 text-[10px] font-semibold text-primary-foreground">
                    Em atendimento humano · {p.takeover.name} · desde {new Date(p.takeover.since).toLocaleString("pt-BR")}
                  </p>
                ) : null}
              </div>
            </div>
            <button
              type="button"
              onClick={() => setOpen(open === p.userId ? null : p.userId)}
              className="inline-flex min-h-9 shrink-0 items-center gap-1.5 rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted"
            >
              {open === p.userId ? "Fechar" : "Ver conversas"}
              <ChevronDown className={cn("size-3.5 transition-transform", open === p.userId && "rotate-180")} />
            </button>
            <button
              type="button"
              disabled={exporting !== null}
              onClick={() => runExport(p.userId, p.name ?? p.email ?? "pessoa", { userId: p.userId })}
              className="inline-flex min-h-9 shrink-0 items-center gap-1.5 rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted disabled:opacity-50"
            >
              <Download className="size-3.5" />
              {exporting === p.userId ? "Gerando…" : "Exportar tudo desta pessoa"}
            </button>
          </div>
          {open === p.userId ? <PersonConversations userId={p.userId} /> : null}
        </Panel>
      ))}

      {query.hasNextPage ? (
        <button
          type="button"
          disabled={query.isFetchingNextPage}
          onClick={() => query.fetchNextPage()}
          className={`${buttonGhost} self-center`}
        >
          {query.isFetchingNextPage ? "Carregando…" : `Carregar mais (${total - items.length} restantes)`}
        </button>
      ) : null}
    </div>
  );
}

function PersonConversations({ userId }: { userId: string }) {
  const search = useServerFn(searchConversations);
  const [open, setOpen] = useState<string | null>(null);
  const { data, isLoading } = useQuery({
    queryKey: ["admin-person-convs", userId],
    queryFn: () => search({ data: { userId, includeEmpty: true, limit: 200 } }),
  });
  const items = data?.items ?? [];
  return (
    <div className="flex flex-col gap-2 border-t border-border/70 bg-muted/30 p-3">
      {isLoading ? <p className="text-xs text-muted-foreground">Carregando conversas…</p> : null}
      {data && data.total > items.length ? (
        <p className="text-[11px] text-muted-foreground">
          Mostrando as {items.length} mais recentes de {data.total}. Use "Exportar tudo desta pessoa" para o histórico completo.
        </p>
      ) : null}
      {items.map((c) => (
        <div key={c.id} className="rounded-xl border border-border bg-surface">
          <button
            type="button"
            onClick={() => setOpen(open === c.id ? null : c.id)}
            className="flex w-full items-center gap-3 px-3 py-2 text-left"
          >
            <div className="min-w-0 flex-1">
              <p className="text-xs font-medium">{new Date(c.updated_at).toLocaleString("pt-BR")}</p>
              <p className="text-[11px] text-muted-foreground">
                {c.messageCount} mensagem(ns) · iniciada em {new Date(c.created_at).toLocaleString("pt-BR")}
              </p>
              {c.takeover ? (
                  <p className="mt-1 inline-flex max-w-full truncate rounded-full bg-primary px-2 py-0.5 text-[10px] font-semibold text-primary-foreground">
                    Em atendimento humano · {c.takeover.name} · desde {new Date(c.takeover.since).toLocaleString("pt-BR")}
                  </p>
                ) : null}
              {c.refundFlow ? (
                <p className="mt-1 inline-flex max-w-full truncate rounded-full border border-border px-2 py-0.5 text-[10px] font-medium text-muted-foreground">
                  7D: {c.refundFlow}
                </p>
              ) : null}
            </div>
            <ChevronDown className={cn("size-4 shrink-0 text-muted-foreground transition-transform", open === c.id && "rotate-180")} />
          </button>
          {open === c.id ? <ConversationMessages conversationId={c.id} /> : null}
        </div>
      ))}
    </div>
  );
}
