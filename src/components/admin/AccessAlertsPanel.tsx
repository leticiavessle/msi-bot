import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { Check, ChevronDown, KeyRound, MailPlus, RotateCcw } from "lucide-react";
import { listAccessAlerts, setAccessResent } from "@/lib/dr/access-alerts.functions";
import { EmptyState, Panel, StatusBadge, buttonGhost } from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { ConversationMessages } from "@/components/admin/ConversationMessages";
import { EntradaAlertsPanel } from "@/components/admin/EntradaAlertsPanel";
import { changeAuthorizedEmail, countEntradaAlertas } from "@/lib/dr/entrada-alertas.functions";
import { trocarEmailConfirmando } from "@/components/admin/trocarEmail";
import { EMAIL_RE } from "@/lib/dr/identificacao";
import { cn } from "@/lib/utils";

/** Aba Acessos: dificuldade na área de membros (conversa) e na entrada do bot (e-mail › CPF › nome › WhatsApp). */
export function AccessAlertsPanel() {
  const [secao, setSecao] = useState<"membros" | "entrada">("membros");
  const contarEntrada = useServerFn(countEntradaAlertas);
  const { data: entradaPendentes } = useQuery({
    queryKey: ["entrada-alertas", "count"],
    queryFn: () => contarEntrada(),
    refetchInterval: 60_000,
  });
  return (
    <div className="flex flex-col gap-4">
      <div className="inline-flex w-fit rounded-xl border border-border p-1">
        {(
          [
            ["membros", "Área de membros"],
            ["entrada", `Entrada no bot${entradaPendentes ? ` (${entradaPendentes})` : ""}`],
          ] as const
        ).map(([k, rotulo]) => (
          <button
            key={k}
            type="button"
            onClick={() => setSecao(k)}
            className={cn(
              "min-h-8 rounded-lg px-3 text-xs font-semibold",
              secao === k ? "bg-primary text-primary-foreground" : "text-muted-foreground hover:bg-muted",
            )}
          >
            {rotulo}
          </button>
        ))}
      </div>
      {secao === "membros" ? <MembrosAlerts /> : <EntradaAlertsPanel />}
    </div>
  );
}

function MembrosAlerts() {
  const qc = useQueryClient();
  const list = useServerFn(listAccessAlerts);
  const mark = useServerFn(setAccessResent);
  const trocar = useServerFn(changeAuthorizedEmail);
  const [erro, setErro] = useState<string | null>(null);
  const [view, setView] = useState<"pending" | "resolved">("pending");
  const [open, setOpen] = useState<string | null>(null);
  const [busy, setBusy] = useState<string | null>(null);
  const { data, isLoading } = useQuery({
    queryKey: ["access-alerts", view],
    queryFn: () => list({ data: { view } }),
    refetchInterval: 60_000,
  });
  const rows = data ?? [];

  /**
   * Acesso reenviado para OUTRO e-mail (ex.: a aluna trocou de e-mail na área de membros): troca o e-mail de
   * entrada no bot também, para ela entrar com o novo e continuar a conversa antiga.
   */
  async function reenviadoParaOutro(userId: string, emailAtual: string | null) {
    if (!emailAtual) return;
    const novo = window.prompt("Para qual e-mail o acesso foi reenviado? Ela vai passar a entrar no bot com ele.")?.trim().toLowerCase();
    if (!novo) return;
    if (!EMAIL_RE.test(novo)) return setErro("E-mail inválido.");
    setBusy(userId);
    setErro(null);
    try {
      const trocou =
        novo === emailAtual.toLowerCase() ||
        (await trocarEmailConfirmando((d) => trocar({ data: d }), { emailAtual, novoEmail: novo }));
      if (!trocou) return;
      await mark({ data: { userId, undo: false } });
      await qc.invalidateQueries({ queryKey: ["access-alerts"] });
      await qc.invalidateQueries({ queryKey: ["access-alerts-count"] });
    } catch (e) {
      setErro(e instanceof Error ? e.message : "Não consegui trocar o e-mail.");
    } finally {
      setBusy(null);
    }
  }

  async function act(userId: string, undo: boolean) {
    setBusy(userId);
    try {
      await mark({ data: { userId, undo } });
      await qc.invalidateQueries({ queryKey: ["access-alerts"] });
      await qc.invalidateQueries({ queryKey: ["access-alerts-count"] });
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
            {v === "pending" ? "Pendentes" : "Resolvidos"}
          </button>
        ))}
      </div>
      <p className="text-xs text-muted-foreground">{isLoading ? "Carregando…" : `${rows.length} pessoa(s)`}</p>
      {erro ? <p className="text-xs text-destructive">{erro}</p> : null}
      {!isLoading && rows.length === 0 ? (
        <EmptyState icon={<KeyRound className="size-6" />} title="Nenhuma pessoa aqui"
          description="Quem disser que não consegue entrar ou ver as aulas aparece aqui automaticamente." />
      ) : null}
      {rows.map((p, i) => (
        <Panel key={p.userId}>
          <div className="flex flex-wrap items-start gap-3 px-4 py-3">
            <span className="flex size-8 shrink-0 items-center justify-center rounded-full bg-muted text-sm font-semibold">{i + 1}</span>
            <div className="min-w-0 flex-1 space-y-1">
              <CopyText value={p.name ?? p.email ?? "Sem nome"} label="nome" className="text-sm font-medium" />
              <div className="flex min-w-0"><CopyText value={p.email} label="e-mail" className="text-[11px] text-muted-foreground" /></div>
              <div className="flex flex-wrap gap-1.5">
                {p.reopened && view === "pending" ? <StatusBadge tone="danger">voltou a reclamar</StatusBadge> : null}
                {p.fromRetention ? <StatusBadge tone="info">veio de Possíveis retenções</StatusBadge> : null}
                {p.conferirVia ? (
                  <StatusBadge tone="warning">
                    conferir identidade: entrou pelo {p.conferirVia === "whatsapp" ? "WhatsApp" : "nome"}
                  </StatusBadge>
                ) : null}
                <StatusBadge tone="neutral">{p.count} mensage{p.count === 1 ? "m" : "ns"}</StatusBadge>
                {p.authorized ? (
                  <StatusBadge tone={p.authStatus === "active" ? "success" : "warning"}>
                    autorizado{p.authStatus !== "active" ? ` (${p.authStatus})` : ""}
                  </StatusBadge>
                ) : <StatusBadge tone="danger">fora dos autorizados</StatusBadge>}
                {p.products.length ? <StatusBadge tone="neutral">{p.products.join(", ")}</StatusBadge> : null}
                {p.source ? <StatusBadge tone="neutral">via {p.source}</StatusBadge> : null}
                <StatusBadge tone="neutral">
                  1º acesso Cademí: {p.cademiFirstAccess ? new Date(p.cademiFirstAccess).toLocaleDateString("pt-BR") : "não registrado"}
                </StatusBadge>
              </div>
              <p className="rounded-xl border-l-2 border-primary/50 bg-muted px-3 py-2 text-xs italic">“{p.latestText}”</p>
              <p className="text-[11px] text-muted-foreground">
                {new Date(p.latestAt).toLocaleString("pt-BR")}
                {view === "resolved" && p.resolvedAt
                  ? ` · reenviado em ${new Date(p.resolvedAt).toLocaleString("pt-BR")}${p.resolvedByName ? ` por ${p.resolvedByName}` : ""}`
                  : ""}
              </p>
            </div>
            <div className="flex flex-wrap gap-2">
              {view === "pending" ? (
                <>
                  <button type="button" disabled={busy !== null} onClick={() => act(p.userId, false)} className={`${buttonGhost} min-h-9 px-3 text-xs`}>
                    <Check className="size-3.5" /> {busy === p.userId ? "…" : "Acesso reenviado"}
                  </button>
                  {p.authorized ? (
                    <button type="button" disabled={busy !== null} onClick={() => reenviadoParaOutro(p.userId, p.email)} className={`${buttonGhost} min-h-9 px-3 text-xs`}>
                      <MailPlus className="size-3.5" /> Reenviado para outro e-mail
                    </button>
                  ) : null}
                </>
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
