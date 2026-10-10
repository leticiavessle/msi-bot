import { useInfiniteQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { ChevronDown, Download, MessagesSquare, Search, Trash2 } from "lucide-react";
import {
  deleteConversation,
  exportConversations,
  searchConversations,
} from "@/lib/dr/admin-analytics.functions";
import { Avatar, EmptyState, Panel, buttonGhost, buttonPrimary, fieldClass } from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { ConversationMessages } from "@/components/admin/ConversationMessages";
import { conversationRowsToCsv, csvFileName } from "@/lib/dr/export-csv";
import { cn } from "@/lib/utils";

const PAGE = 50;

export function ConversationsPanel() {
  const search = useServerFn(searchConversations);
  const exportFn = useServerFn(exportConversations);
  const deleteFn = useServerFn(deleteConversation);
  const queryClient = useQueryClient();
  const [deleting, setDeleting] = useState<string | null>(null);
  const [term, setTerm] = useState("");
  const [from, setFrom] = useState("");
  const [to, setTo] = useState("");
  const [showEmpty, setShowEmpty] = useState(false);
  const [applied, setApplied] = useState({ term: "", from: "", to: "" });
  const [open, setOpen] = useState<string | null>(null);
  const [exporting, setExporting] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  const query = useInfiniteQuery({
    queryKey: ["admin-conversations", applied, showEmpty],
    initialPageParam: 0,
    queryFn: ({ pageParam }) =>
      search({
        data: {
          term: applied.term || null,
          from: applied.from || null,
          to: applied.to || null,
          includeEmpty: showEmpty,
          limit: PAGE,
          offset: pageParam,
        },
      }),
    getNextPageParam: (last, pages) => {
      const loaded = pages.reduce((n, p) => n + p.items.length, 0);
      return loaded < last.total && last.items.length > 0 ? loaded : undefined;
    },
  });
  const items = query.data?.pages.flatMap((p) => p.items) ?? [];
  const total = query.data?.pages[0]?.total ?? 0;

  async function runDelete(c: { id: string; name: string | null; email: string | null }) {
    const ok = window.confirm(
      `Apagar a conversa de ${c.name ?? "aluno sem nome"} (${c.email ?? "sem e-mail"})?\n\nA conversa e todas as mensagens serão apagadas e NÃO tem volta. O aluno e o acesso continuam.`,
    );
    if (!ok) return;
    setDeleting(c.id);
    setNotice(null);
    try {
      await deleteFn({ data: { conversationId: c.id } });
      if (open === c.id) setOpen(null);
      await queryClient.invalidateQueries({ queryKey: ["admin-conversations"] });
      await queryClient.invalidateQueries({ queryKey: ["admin-people"] });
      setNotice("Conversa apagada.");
    } catch {
      setNotice("Não consegui apagar a conversa. Tente novamente.");
    } finally {
      setDeleting(null);
    }
  }

  async function runExport(
    key: string,
    scope: string,
    input: { conversationId?: string | null; term?: string | null; from?: string | null; to?: string | null },
  ) {
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
            onKeyDown={(e) => e.key === "Enter" && setApplied({ term, from, to })}
            placeholder="Buscar por nome ou e-mail"
            className={`${fieldClass} w-full pl-9`}
          />
        </div>
        <input type="date" value={from} onChange={(e) => setFrom(e.target.value)} className={fieldClass} />
        <input type="date" value={to} onChange={(e) => setTo(e.target.value)} className={fieldClass} />
        <button type="button" onClick={() => setApplied({ term, from, to })} className={buttonPrimary}>
          Filtrar
        </button>
        <button
          type="button"
          disabled={exporting !== null}
          onClick={() =>
            runExport("all", applied.term || "todas", {
              term: applied.term || null,
              from: applied.from || null,
              to: applied.to || null,
            })
          }
          className={buttonGhost}
        >
          <Download className="size-4" />
          {exporting === "all" ? "Gerando…" : "Exportar CSV"}
        </button>
      </Panel>

      <div className="flex flex-wrap items-center justify-between gap-2 text-xs text-muted-foreground">
        <span>
          {query.isLoading
            ? "Carregando…"
            : `${total} conversa(s) ${showEmpty ? "no total" : "com mensagens"} · mostrando ${items.length}`}
        </span>
        <label className="inline-flex items-center gap-2">
          <input type="checkbox" checked={showEmpty} onChange={(e) => setShowEmpty(e.target.checked)} />
          Mostrar conversas vazias
        </label>
      </div>

      {notice ? <p className="text-xs text-muted-foreground">{notice}</p> : null}
      {query.isError ? <p className="text-xs text-destructive">Não consegui carregar as conversas.</p> : null}

      {!query.isLoading && items.length === 0 ? (
        <EmptyState
          icon={<MessagesSquare className="size-6" />}
          title="Nenhuma conversa encontrada"
          description="Ajuste a busca ou o intervalo de datas para ver o histórico dos alunos."
        />
      ) : null}

      {items.map((c) => (
        <Panel key={c.id}>
          <div className="flex flex-wrap items-center gap-2 pr-3">
            <div className="flex min-w-0 flex-1 items-center gap-3 px-4 py-3">
              <Avatar name={c.name ?? c.email} />
              <div className="min-w-0 flex-1">
                {c.hasProfile ? (
                  <>
                    <CopyText value={c.name ?? c.email} label="nome" className="text-sm font-medium" />
                    <div className="flex min-w-0">
                      <CopyText value={c.email} label="e-mail" className="text-[11px] text-muted-foreground" />
                    </div>
                  </>
                ) : (
                  <>
                    <p className="text-sm font-medium">Aluno sem cadastro</p>
                    <CopyText value={c.user_id} label="código" className="text-[11px] text-muted-foreground" />
                  </>
                )}
                <p className="text-[11px] text-muted-foreground">
                  {c.messageCount} mensagem(ns) · atualizada em {new Date(c.updated_at).toLocaleString("pt-BR")}
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
            </div>
            <button
              type="button"
              onClick={() => setOpen(open === c.id ? null : c.id)}
              className="inline-flex min-h-9 shrink-0 items-center gap-1.5 rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted"
            >
              {open === c.id ? "Fechar" : "Abrir"}
              <ChevronDown className={cn("size-3.5 transition-transform", open === c.id && "rotate-180")} />
            </button>
            <button
              type="button"
              disabled={exporting !== null}
              onClick={() => runExport(c.id, c.name ?? c.email ?? "conversa", { conversationId: c.id })}
              className="inline-flex min-h-9 shrink-0 items-center gap-1.5 rounded-xl border border-border px-3 text-xs font-medium transition-colors hover:bg-muted disabled:opacity-50"
            >
              <Download className="size-3.5" />
              {exporting === c.id ? "Gerando…" : "Exportar"}
            </button>
            <button
              type="button"
              disabled={deleting !== null}
              onClick={() => runDelete(c)}
              aria-label="Apagar conversa"
              className="inline-flex min-h-9 shrink-0 items-center gap-1.5 rounded-xl border border-destructive/40 px-3 text-xs font-medium text-destructive transition-colors hover:bg-destructive/10 disabled:opacity-50"
            >
              <Trash2 className="size-3.5" />
              {deleting === c.id ? "Apagando…" : "Apagar"}
            </button>
          </div>
          {open === c.id ? <ConversationMessages conversationId={c.id} /> : null}
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
