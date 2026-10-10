import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { Check, ChevronDown, RotateCcw, ShoppingBag } from "lucide-react";
import { listSalesAlerts, setSalesAlertHandled } from "@/lib/dr/sales-alerts.functions";
import { EmptyState, Panel, StatusBadge, buttonGhost } from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { ConversationMessages } from "@/components/admin/ConversationMessages";
import { cn } from "@/lib/utils";

export function SalesAlertsPanel() {
  const qc = useQueryClient();
  const list = useServerFn(listSalesAlerts);
  const mark = useServerFn(setSalesAlertHandled);
  const [view, setView] = useState<"pending" | "resolved">("pending");
  const [open, setOpen] = useState<string | null>(null);
  const [busy, setBusy] = useState<string | null>(null);
  const { data, isLoading } = useQuery({
    queryKey: ["sales-alerts", view],
    queryFn: () => list({ data: { view } }),
    refetchInterval: 60_000,
  });
  const rows = data ?? [];

  async function act(userId: string, undo: boolean) {
    setBusy(userId);
    try {
      await mark({ data: { userId, undo } });
      await qc.invalidateQueries({ queryKey: ["sales-alerts"] });
      await qc.invalidateQueries({ queryKey: ["sales-alerts-count"] });
    } finally {
      setBusy(null);
    }
  }

  return (
    <div className="flex flex-col gap-4">
      <div className="flex gap-2">
        {(["pending", "resolved"] as const).map((v) => (
          <button key={v} type="button" onClick={() => setView(v)}
            className={cn("min-h-9 rounded-full border px-3.5 text-xs font-medium",
              view === v ? "border-primary bg-primary text-primary-foreground" : "border-border text-muted-foreground hover:bg-muted")}>
            {v === "pending" ? "Pendentes" : "Atendidas"}
          </button>
        ))}
      </div>
      <p className="text-xs text-muted-foreground">{isLoading ? "Carregando…" : `${rows.length} pessoa(s)`}</p>
      {!isLoading && rows.length === 0 ? (
        <EmptyState icon={<ShoppingBag className="size-6" />} title="Nenhuma pessoa aqui"
          description="Quem perguntar preço, desconto, parcelamento ou como comprar um produto aparece aqui automaticamente. O bot responde que essa informação é com o time." />
      ) : null}
      {rows.map((p, i) => (
        <Panel key={p.userId}>
          <div className="flex flex-wrap items-start gap-3 px-4 py-3">
            <span className="flex size-8 shrink-0 items-center justify-center rounded-full bg-muted text-sm font-semibold">{i + 1}</span>
            <div className="min-w-0 flex-1 space-y-1">
              <CopyText value={p.name ?? p.email ?? "Sem nome"} label="nome" className="text-sm font-medium" />
              <div className="flex min-w-0"><CopyText value={p.email} label="e-mail" className="text-[11px] text-muted-foreground" /></div>
              <div className="flex flex-wrap gap-1.5">
                <StatusBadge tone="info">perguntou sobre: {p.asked.length ? p.asked.join(", ") : "não disse qual produto"}</StatusBadge>
                <StatusBadge tone="neutral">já tem: {p.owned.length ? p.owned.join(", ") : "nenhum produto ativo"}</StatusBadge>
                <StatusBadge tone="neutral">{p.count} mensage{p.count === 1 ? "m" : "ns"}</StatusBadge>
              </div>
              <p className="rounded-xl border-l-2 border-primary/50 bg-muted px-3 py-2 text-xs italic">“{p.latestText}”</p>
              <p className="text-[11px] text-muted-foreground">
                {new Date(p.latestAt).toLocaleString("pt-BR")}
                {view === "resolved" && p.resolvedAt
                  ? ` · atendida em ${new Date(p.resolvedAt).toLocaleString("pt-BR")}${p.resolvedByName ? ` por ${p.resolvedByName}` : ""}`
                  : ""}
              </p>
            </div>
            <div className="flex flex-wrap gap-2">
              {view === "pending" ? (
                <button type="button" disabled={busy !== null} onClick={() => act(p.userId, false)} className={`${buttonGhost} min-h-9 px-3 text-xs`}>
                  <Check className="size-3.5" /> {busy === p.userId ? "…" : "Contato feito"}
                </button>
              ) : (
                <button type="button" disabled={busy !== null} onClick={() => act(p.userId, true)} className={`${buttonGhost} min-h-9 px-3 text-xs`}>
                  <RotateCcw className="size-3.5" /> {busy === p.userId ? "…" : "Desfazer"}
                </button>
              )}
              {p.conversationId ? (
                <button type="button" aria-label="Abrir conversa" onClick={() => setOpen(open === p.userId ? null : p.userId)}
                  className="flex size-9 items-center justify-center rounded-xl border border-border hover:bg-muted">
                  <ChevronDown className={cn("size-4 transition-transform", open === p.userId && "rotate-180")} />
                </button>
              ) : null}
            </div>
          </div>
          {open === p.userId && p.conversationId ? (
            <div className="border-t border-border/70 bg-muted/40 p-3"><ConversationMessages conversationId={p.conversationId} /></div>
          ) : null}
        </Panel>
      ))}
    </div>
  );
}
