import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { Check, CheckCheck, ChevronDown, ShieldCheck } from "lucide-react";
import {
  listRiskAlertsByPerson,
  resolveRiskAlert,
  resolveRiskAlertsForPerson,
} from "@/lib/dr/admin-analytics.functions";
import {
  Avatar,
  EmptyState,
  Panel,
  StatusBadge,
  buttonGhost,
  riskTone,
} from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { cn } from "@/lib/utils";

const LEVELS = ["all", "medium", "high", "critical"] as const;
const STATUSES = ["pending", "resolved", "all"] as const;

function Filter({
  active,
  children,
  onClick,
}: {
  active: boolean;
  children: React.ReactNode;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        "min-h-9 rounded-full border px-3.5 text-xs font-medium transition-colors",
        active
          ? "border-primary bg-primary text-primary-foreground"
          : "border-border text-muted-foreground hover:bg-muted hover:text-foreground",
      )}
    >
      {children}
    </button>
  );
}

export function AlertsPanel() {
  const queryClient = useQueryClient();
  const list = useServerFn(listRiskAlertsByPerson);
  const resolve = useServerFn(resolveRiskAlert);
  const resolveAll = useServerFn(resolveRiskAlertsForPerson);
  const [level, setLevel] = useState<(typeof LEVELS)[number]>("all");
  const [status, setStatus] = useState<(typeof STATUSES)[number]>("pending");
  const [open, setOpen] = useState<string | null>(null);
  const [busy, setBusy] = useState<string | null>(null);

  const { data: people, isLoading } = useQuery({
    queryKey: ["admin-alerts", level, status],
    queryFn: () => list({ data: { level, status } }),
  });

  async function refresh() {
    await queryClient.invalidateQueries({ queryKey: ["admin-alerts"] });
    await queryClient.invalidateQueries({ queryKey: ["admin-overview"] });
  }

  async function act(key: string, fn: () => Promise<unknown>) {
    setBusy(key);
    try {
      await fn();
      await refresh();
    } finally {
      setBusy(null);
    }
  }

  const rows = people ?? [];

  return (
    <div className="flex flex-col gap-4">
      <div className="flex flex-wrap items-center gap-2">
        <span className="text-[11px] font-semibold uppercase tracking-wide text-muted-foreground">
          Nível
        </span>
        {LEVELS.map((l) => (
          <Filter key={l} active={level === l} onClick={() => setLevel(l)}>
            {l === "all" ? "todos" : l}
          </Filter>
        ))}
        <span className="ml-2 text-[11px] font-semibold uppercase tracking-wide text-muted-foreground">
          Status
        </span>
        {STATUSES.map((s) => (
          <Filter key={s} active={status === s} onClick={() => setStatus(s)}>
            {s}
          </Filter>
        ))}
      </div>

      <p className="text-xs text-muted-foreground">
        {isLoading ? "Carregando…" : `${rows.length} pessoa(s) · ${rows.reduce((n, p) => n + p.count, 0)} alerta(s)`}
      </p>

      {!isLoading && rows.length === 0 ? (
        <EmptyState
          icon={<ShieldCheck className="size-6" />}
          title="Nenhum alerta com esses filtros"
          description="Sinais de insatisfação e pedidos de reembolso aparecem aqui automaticamente."
        />
      ) : null}

      {rows.map((p) => (
        <Panel key={p.userId}>
          <div className="flex flex-wrap items-center gap-3 px-4 py-3">
            <Avatar name={p.name ?? p.email} />
            <div className="min-w-0 flex-1">
              <CopyText value={p.name ?? p.email ?? "Sem nome"} label="nome" className="text-sm font-medium" />
              <div className="flex min-w-0">
                <CopyText value={p.email} label="e-mail" className="text-[11px] text-muted-foreground" />
              </div>
              <p className="text-[11px] text-muted-foreground">
                {p.count} alerta(s){p.pendingCount ? ` · ${p.pendingCount} pendente(s)` : ""} · mais recente{" "}
                {new Date(p.latestAt).toLocaleString("pt-BR")}
              </p>
            </div>
            <StatusBadge tone={riskTone(p.topLevel)}>{p.topLevel}</StatusBadge>
            {p.pendingCount > 0 ? (
              <button
                type="button"
                disabled={busy !== null}
                onClick={() => act(`all-${p.userId}`, () => resolveAll({ data: { userId: p.userId } }))}
                className={`${buttonGhost} min-h-9 px-3 text-xs`}
              >
                <CheckCheck className="size-3.5" />
                {busy === `all-${p.userId}` ? "Resolvendo…" : "Resolver todos"}
              </button>
            ) : null}
            <button
              type="button"
              aria-label={open === p.userId ? "Fechar alertas" : "Ver alertas"}
              onClick={() => setOpen(open === p.userId ? null : p.userId)}
              className="flex size-9 items-center justify-center rounded-xl border border-border hover:bg-muted"
            >
              <ChevronDown className={cn("size-4 transition-transform", open === p.userId && "rotate-180")} />
            </button>
          </div>

          {open === p.userId ? (
            <div className="flex flex-col gap-2 border-t border-border/70 bg-muted/40 p-3">
              {p.alerts.map((a) => (
                <div key={a.id} className="rounded-xl border border-border bg-surface p-3">
                  <div className="flex flex-wrap items-center gap-2 text-[11px] text-muted-foreground">
                    <span>{new Date(a.created_at).toLocaleString("pt-BR")}</span>
                    <StatusBadge tone={riskTone(a.risk_level)}>{a.risk_level}</StatusBadge>
                    <span className="ml-auto">
                      {a.status !== "pending" ? (
                        <StatusBadge tone="success">
                          Resolvido{a.resolved_at ? ` em ${new Date(a.resolved_at).toLocaleDateString("pt-BR")}` : ""}
                        </StatusBadge>
                      ) : (
                        <button
                          type="button"
                          disabled={busy !== null}
                          onClick={() => act(a.id, () => resolve({ data: { id: a.id, status: "resolved" } }))}
                          className={`${buttonGhost} min-h-8 px-2.5 text-xs`}
                        >
                          <Check className="size-3.5" /> {busy === a.id ? "…" : "Resolver"}
                        </button>
                      )}
                    </span>
                  </div>
                  {a.reason ? <p className="mt-2 text-xs text-muted-foreground">{a.reason}</p> : null}
                  {a.trigger_text ? (
                    <p className="mt-2 rounded-xl border-l-2 border-primary/50 bg-muted px-3 py-2 text-xs italic">
                      “{a.trigger_text}”
                    </p>
                  ) : null}
                </div>
              ))}
            </div>
          ) : null}
        </Panel>
      ))}
    </div>
  );
}
