import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { getConversationMessages } from "@/lib/dr/admin-users.functions";
import {
  listActivationQueue,
  listPossibleRetentions,
  listClosedRetentions,
  closeRetention,
  undoRetentionClose,
  redirectRetention,
  markActivationAttended,
} from "@/lib/dr/activation-queue.functions";
import { ConversationMessages } from "@/components/admin/ConversationMessages";
import { CopyText } from "@/components/admin/CopyText";
import { cn } from "@/lib/utils";
import { Panel, PanelHeader } from "@/components/admin/ui";
import { NOME_ATIVACAO } from "@/oferta/protocolo-7d";

type Row = Awaited<ReturnType<typeof listActivationQueue>>[number];

const GROUPS = [
  { key: "24", title: "Mais de 24 horas sem atendimento", min: 24 },
  { key: "4", title: "Mais de 4 horas", min: 4 },
  { key: "2", title: "Mais de 2 horas", min: 2 },
  { key: "0", title: "Recentes (menos de 2 horas)", min: 0 },
] as const;

function waited(ms: number) {
  const m = Math.floor(ms / 60000);
  if (m < 60) return `${m} min`;
  const h = Math.floor(m / 60);
  if (h < 24) return `${h}h ${m % 60}min`;
  return `${Math.floor(h / 24)}d ${h % 24}h`;
}

function Conversation({ id }: { id: string }) {
  const fn = useServerFn(getConversationMessages);
  const { data, isLoading } = useQuery({
    queryKey: ["admin-conv-msgs", id],
    queryFn: () => fn({ data: { conversationId: id } }),
  });
  if (isLoading) return <p className="text-xs text-muted-foreground">Carregando…</p>;
  return (
    <div className="max-h-80 space-y-2 overflow-y-auto rounded-lg border border-border/70 bg-background p-3">
      {(data ?? []).map((m) => (
        <div key={m.id} className="text-xs">
          <span className="font-semibold">{m.role === "user" ? "Aluno" : "Bot"}:</span>{" "}
          <span className="whitespace-pre-wrap text-muted-foreground">{m.content}</span>
        </div>
      ))}
    </div>
  );
}

export function ActivationQueuePanel() {
  const [tab, setTab] = useState<"accepted" | "retention">("accepted");
  return (
    <div className="flex flex-col gap-3">
      <div className="flex gap-2">
        {(
          [
            ["accepted", "Aceitaram"],
            ["retention", "Possíveis retenções"],
          ] as const
        ).map(([k, label]) => (
          <button
            key={k}
            type="button"
            onClick={() => setTab(k)}
            className={cn(
              "min-h-9 rounded-full border px-4 text-xs font-medium",
              tab === k
                ? "border-primary bg-primary text-primary-foreground"
                : "border-border text-muted-foreground hover:bg-muted",
            )}
          >
            {label}
          </button>
        ))}
      </div>
      {tab === "accepted" ? <AcceptedQueue /> : <RetentionList />}
    </div>
  );
}

const REASON_LABELS: Record<string, string> = {
  resolvida_chat: "Resolvida no chat",
  retida: "Retida",
  nao_era_retencao: "Não era retenção",
  sem_resposta: "Sem resposta da aluna",
  outro: "Outro",
};
const DEST_LABELS = { ativacao: `${NOME_ATIVACAO} (Aceitaram)`, acessos: "Acessos", humano: "Atendimento humano" } as const;

function RetentionList() {
  const [view, setView] = useState<"open" | "closed">("open");
  return (
    <div className="flex flex-col gap-3">
      <div className="flex gap-2">
        {(
          [
            ["open", "Abertos"],
            ["closed", "Fechados"],
          ] as const
        ).map(([k, label]) => (
          <button
            key={k}
            type="button"
            onClick={() => setView(k)}
            className={cn(
              "min-h-8 rounded-full border px-3 text-xs font-medium",
              view === k ? "border-primary bg-primary text-primary-foreground" : "border-border text-muted-foreground hover:bg-muted",
            )}
          >
            {label}
          </button>
        ))}
      </div>
      {view === "open" ? <OpenRetentions /> : <ClosedRetentions />}
    </div>
  );
}

type RetRow = Awaited<ReturnType<typeof listPossibleRetentions>>[number];

function RowActions({ r, onDone }: { r: RetRow; onDone: () => void }) {
  const closeFn = useServerFn(closeRetention);
  const redirectFn = useServerFn(redirectRetention);
  const [mode, setMode] = useState<null | "close" | "redirect">(null);
  const [reason, setReason] = useState("resolvida_chat");
  const [text, setText] = useState("");
  const [dest, setDest] = useState<keyof typeof DEST_LABELS>("ativacao");
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  async function run(fn: () => Promise<unknown>) {
    setBusy(true);
    setErr(null);
    try {
      await fn();
      setMode(null);
      onDone();
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Não deu certo.");
    } finally {
      setBusy(false);
    }
  }
  const base = { conversationId: r.conversationId, userId: r.userId, reasons: r.reasons };
  return (
    <div className="w-full">
      <div className="flex gap-2">
        <button type="button" onClick={() => setMode(mode === "close" ? null : "close")} className="rounded-lg border border-border px-3 py-1.5 hover:bg-muted">
          Fechar
        </button>
        <button type="button" onClick={() => setMode(mode === "redirect" ? null : "redirect")} className="rounded-lg border border-border px-3 py-1.5 hover:bg-muted">
          Redirecionar
        </button>
      </div>
      {mode === "close" ? (
        <div className="mt-2 flex flex-wrap items-center gap-2">
          <select value={reason} onChange={(e) => setReason(e.target.value)} className="min-h-8 rounded-lg border border-border bg-background px-2">
            {Object.entries(REASON_LABELS).map(([k, v]) => (
              <option key={k} value={k}>{v}</option>
            ))}
          </select>
          {reason === "outro" ? (
            <input value={text} onChange={(e) => setText(e.target.value)} maxLength={300} placeholder="Motivo" className="min-h-8 rounded-lg border border-border bg-background px-2" />
          ) : null}
          <button
            type="button"
            disabled={busy || (reason === "outro" && !text.trim())}
            onClick={() => run(() => closeFn({ data: { ...base, reason: reason as never, reasonText: text.trim() || undefined } }))}
            className="rounded-lg bg-primary px-3 py-1.5 font-medium text-primary-foreground disabled:opacity-50"
          >
            Confirmar fechamento
          </button>
        </div>
      ) : null}
      {mode === "redirect" ? (
        <div className="mt-2 flex flex-wrap items-center gap-2">
          <select value={dest} onChange={(e) => setDest(e.target.value as keyof typeof DEST_LABELS)} className="min-h-8 rounded-lg border border-border bg-background px-2">
            {Object.entries(DEST_LABELS).map(([k, v]) => (
              <option key={k} value={k}>{v}</option>
            ))}
          </select>
          <button
            type="button"
            disabled={busy}
            onClick={() => run(() => redirectFn({ data: { ...base, destination: dest } }))}
            className="rounded-lg bg-primary px-3 py-1.5 font-medium text-primary-foreground disabled:opacity-50"
          >
            Confirmar
          </button>
          {dest === "humano" ? <span className="text-muted-foreground">O bot para de responder nessa conversa até "Devolver ao bot".</span> : null}
        </div>
      ) : null}
      {err ? <p className="mt-1 text-destructive">{err}</p> : null}
    </div>
  );
}

function OpenRetentions() {
  const listFn = useServerFn(listPossibleRetentions);
  const qc = useQueryClient();
  const [open, setOpen] = useState<string | null>(null);
  const { data, isLoading } = useQuery({
    queryKey: ["possible-retentions"],
    queryFn: () => listFn(),
    refetchInterval: 120_000,
  });
  const rows = data ?? [];
  const refresh = () => {
    void qc.invalidateQueries({ queryKey: ["possible-retentions"] });
    void qc.invalidateQueries({ queryKey: ["closed-retentions"] });
    void qc.invalidateQueries({ queryKey: ["activation-queue"] });
  };
  return (
    <Panel>
      <PanelHeader
        title="Possíveis retenções"
        hint={isLoading ? "Carregando…" : `${rows.length} em aberto (fechados não contam) · últimos 14 dias · não entra no contador`}
      />
      <ul className="flex flex-col gap-2 p-4">
        {!isLoading && rows.length === 0 ? <p className="text-xs text-muted-foreground">Ninguém aqui.</p> : null}
        {rows.map((r) => (
          <li key={r.conversationId} className="rounded-xl border border-border/70">
            <div className="flex flex-wrap items-center gap-x-4 gap-y-2 p-3 text-xs">
              <div className="min-w-0">
                <CopyText value={r.name ?? r.email ?? "Sem nome"} label="nome" className="text-sm font-semibold" />
                <CopyText value={r.email} label="e-mail" className="text-muted-foreground" />
              </div>
              <span className="text-muted-foreground">{new Date(r.lastAt).toLocaleString("pt-BR")}</span>
              {r.returned ? (
                <span className="rounded-full bg-destructive px-2 py-0.5 text-[10px] font-medium text-destructive-foreground">voltou a escrever</span>
              ) : null}
              <button
                type="button"
                onClick={() => setOpen(open === r.conversationId ? null : r.conversationId)}
                className="ml-auto rounded-lg border border-border px-3 py-1.5 hover:bg-muted"
              >
                {open === r.conversationId ? "Fechar conversa" : "Ver conversa"}
              </button>
              <div className="flex w-full flex-wrap gap-1.5">
                {r.reasons.map((why) => (
                  <span key={why} className="rounded-full border border-border px-2 py-0.5 text-[10px] font-medium">{why}</span>
                ))}
              </div>
              {r.sample ? <p className="w-full italic text-muted-foreground">“{r.sample}”</p> : null}
              <RowActions r={r} onDone={refresh} />
            </div>
            {open === r.conversationId ? <ConversationMessages conversationId={r.conversationId} /> : null}
          </li>
        ))}
      </ul>
    </Panel>
  );
}

function ClosedRetentions() {
  const listFn = useServerFn(listClosedRetentions);
  const undoFn = useServerFn(undoRetentionClose);
  const qc = useQueryClient();
  const [from, setFrom] = useState("");
  const [to, setTo] = useState("");
  const [reason, setReason] = useState("todos");
  const [open, setOpen] = useState<string | null>(null);
  const [busy, setBusy] = useState<string | null>(null);
  const { data, isLoading } = useQuery({ queryKey: ["closed-retentions"], queryFn: () => listFn() });
  const rows = (data ?? []).filter((r) => {
    const day = new Date(r.closedAt).toLocaleDateString("sv-SE", { timeZone: "America/Sao_Paulo" });
    return (!from || day >= from) && (!to || day <= to) && (reason === "todos" || r.reason === reason);
  });
  async function undo(id: string) {
    setBusy(id);
    try {
      await undoFn({ data: { actionId: id } });
      await qc.invalidateQueries({ queryKey: ["closed-retentions"] });
      await qc.invalidateQueries({ queryKey: ["possible-retentions"] });
    } finally {
      setBusy(null);
    }
  }
  return (
    <Panel>
      <PanelHeader title="Fechados" hint={isLoading ? "Carregando…" : `${rows.length} de ${(data ?? []).length}`} />
      <div className="flex flex-wrap items-center gap-2 border-b border-border/70 px-4 py-3 text-xs">
        <label className="flex items-center gap-1">De <input type="date" value={from} onChange={(e) => setFrom(e.target.value)} className="min-h-8 rounded-lg border border-border bg-background px-2" /></label>
        <label className="flex items-center gap-1">Até <input type="date" value={to} onChange={(e) => setTo(e.target.value)} className="min-h-8 rounded-lg border border-border bg-background px-2" /></label>
        <select value={reason} onChange={(e) => setReason(e.target.value)} className="min-h-8 rounded-lg border border-border bg-background px-2">
          <option value="todos">Todos os motivos</option>
          {Object.entries(REASON_LABELS).map(([k, v]) => (
            <option key={k} value={k}>{v}</option>
          ))}
        </select>
      </div>
      <ul className="flex flex-col gap-2 p-4">
        {!isLoading && rows.length === 0 ? <p className="text-xs text-muted-foreground">Nada aqui.</p> : null}
        {rows.map((r) => (
          <li key={r.actionId} className="rounded-xl border border-border/70">
            <div className="flex flex-wrap items-center gap-x-4 gap-y-1 p-3 text-xs">
              <div className="min-w-0">
                <CopyText value={r.name ?? r.email ?? "Sem nome"} label="nome" className="text-sm font-semibold" />
                <CopyText value={r.email} label="e-mail" className="text-muted-foreground" />
              </div>
              <span className="rounded-full border border-border px-2 py-0.5 text-[10px] font-medium">
                {r.reason ? REASON_LABELS[r.reason] : "-"}{r.reasonText ? `: ${r.reasonText}` : ""}
              </span>
              <span className="text-muted-foreground">
                Fechado por {r.closedBy ?? "-"} em {new Date(r.closedAt).toLocaleString("pt-BR")}
              </span>
              <div className="ml-auto flex gap-2">
                <button type="button" onClick={() => setOpen(open === r.actionId ? null : r.actionId)} className="rounded-lg border border-border px-3 py-1.5 hover:bg-muted">
                  {open === r.actionId ? "Fechar conversa" : "Ver conversa"}
                </button>
                <button type="button" disabled={busy === r.actionId} onClick={() => undo(r.actionId)} className="rounded-lg border border-border px-3 py-1.5 hover:bg-muted disabled:opacity-50">
                  Desfazer
                </button>
              </div>
            </div>
            {open === r.actionId ? <ConversationMessages conversationId={r.conversationId} /> : null}
          </li>
        ))}
      </ul>
    </Panel>
  );
}

function AcceptedQueue() {
  const listFn = useServerFn(listActivationQueue);
  const markFn = useServerFn(markActivationAttended);
  const qc = useQueryClient();
  const [open, setOpen] = useState<string | null>(null);
  const [busy, setBusy] = useState<string | null>(null);
  const [origin, setOrigin] = useState<"todos" | "botão" | "digitado">("todos");
  const [term, setTerm] = useState("");
  const { data } = useQuery({
    queryKey: ["activation-queue"],
    queryFn: () => listFn(),
    refetchInterval: 60_000,
  });
  const now = Date.now();
  const all = data ?? [];
  const q = term.trim().toLowerCase();
  const rows = all.filter(
    (r) =>
      (origin === "todos" || r.origin === origin) &&
      (!q || (r.name ?? "").toLowerCase().includes(q) || (r.email ?? "").toLowerCase().includes(q)),
  );
  const grouped = GROUPS.map((g, i) => ({
    ...g,
    rows: rows.filter((r) => {
      const h = (now - new Date(r.acceptedAt).getTime()) / 3600000;
      const upper = i === 0 ? Infinity : GROUPS[i - 1]!.min;
      return h >= g.min && h < upper;
    }),
  }));

  async function attend(r: Row) {
    setBusy(r.id);
    try {
      await markFn({ data: { alertId: r.id } });
      qc.setQueryData<Row[]>(["activation-queue"], (current) =>
        current?.filter((item) => item.id !== r.id),
      );
      await qc.invalidateQueries({ queryKey: ["activation-queue"] });
    } finally {
      setBusy(null);
    }
  }

  return (
    <Panel>
      <PanelHeader
        title="Aceitaram - aguardando atendimento"
        hint={`${all.length} pessoa(s) na fila${rows.length !== all.length ? ` · ${rows.length} no filtro` : ""}`}
      />
      <div className="flex flex-wrap items-center gap-2 border-b border-border/70 px-4 py-3">
        {(["todos", "botão", "digitado"] as const).map((o) => (
          <button
            key={o}
            type="button"
            onClick={() => setOrigin(o)}
            className={cn(
              "min-h-8 rounded-full border px-3 text-xs font-medium",
              origin === o ? "border-primary bg-primary text-primary-foreground" : "border-border text-muted-foreground hover:bg-muted",
            )}
          >
            {o === "todos" ? "Todos" : o === "botão" ? "Botão" : "Digitado"}
          </button>
        ))}
        <input
          value={term}
          onChange={(e) => setTerm(e.target.value)}
          placeholder="Buscar por nome ou e-mail"
          className="ml-auto min-h-8 w-full max-w-xs rounded-lg border border-border bg-background px-3 text-xs sm:w-64"
        />
      </div>
      <div className="flex flex-col gap-4 p-4">
        {grouped.map((g) => (
          <section key={g.key}>
            <h4 className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-muted-foreground">
              {g.title} · {g.rows.length}
            </h4>
            {g.rows.length === 0 ? (
              <p className="text-xs text-muted-foreground">Ninguém aqui.</p>
            ) : (
              <ul className="flex flex-col gap-2">
                {g.rows.map((r) => (
                  <li key={r.id} className="rounded-xl border border-border/70 p-3">
                    <div className="flex flex-wrap items-center gap-x-4 gap-y-1 text-xs">
                      <span className="text-sm font-semibold">{r.name ?? "Sem nome"}</span>
                      <span className="text-muted-foreground">{r.email ?? "-"}</span>
                      <span>Produto: {r.product}</span>
                      <span>Rota {r.route}{r.node ? ` · ${r.node}` : ""}</span>
                      <span className="rounded-full border border-border px-2 py-0.5 text-[10px] font-medium">
                        {r.fromRetention ? "veio de Possíveis retenções" : r.origin === "digitado" ? (r.reclassified ? "aceite digitado (reclassificado)" : "digitado") : "botão"}
                      </span>
                      <span>SIM: {new Date(r.acceptedAt).toLocaleString("pt-BR")}</span>
                      <span
                        className={cn(
                          "rounded-full border px-2 py-0.5 text-[10px] font-medium",
                          r.whatsappClickedAt ? "border-primary text-primary" : "border-border text-muted-foreground",
                        )}
                      >
                        {!r.whatsappSentAt
                          ? "WhatsApp: link não enviado"
                          : r.whatsappClickedAt
                            ? `WhatsApp: enviado · clicou ${new Date(r.whatsappClickedAt).toLocaleString("pt-BR")}`
                            : "WhatsApp: enviado · ainda não clicou"}
                      </span>
                      <span className="font-medium text-primary">
                        esperando há {waited(now - new Date(r.acceptedAt).getTime())}
                      </span>
                      <div className="ml-auto flex gap-2">
                        {r.conversationId ? (
                          <button
                            type="button"
                            onClick={() => setOpen(open === r.id ? null : r.id)}
                            className="rounded-lg border border-border px-3 py-1.5 hover:bg-muted"
                          >
                            {open === r.id ? "Fechar conversa" : "Ver conversa"}
                          </button>
                        ) : null}
                        <button
                          type="button"
                          disabled={busy === r.id}
                          onClick={() => attend(r)}
                          className="rounded-lg bg-primary px-3 py-1.5 font-medium text-primary-foreground disabled:opacity-50"
                        >
                          Atendida
                        </button>
                      </div>
                    </div>
                    {r.origin === "digitado" && r.acceptText ? (
                      <p className="mt-2 text-xs italic text-muted-foreground">“{r.acceptText}”</p>
                    ) : null}
                    {open === r.id && r.conversationId ? (
                      <div className="mt-3">
                        <Conversation id={r.conversationId} />
                      </div>
                    ) : null}
                  </li>
                ))}
              </ul>
            )}
          </section>
        ))}
      </div>
    </Panel>
  );
}
