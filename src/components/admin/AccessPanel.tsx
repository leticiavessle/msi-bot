import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { ArrowLeft } from "lucide-react";
import { getStudentAccessDetail, listStudentAccess } from "@/lib/dr/admin.functions";
import { Pager } from "./WebhooksPanel";
import { listLoginDenied } from "@/lib/dr/admin-users.functions";

function fmt(value: string | null) {
  if (!value) return "—";
  return new Date(value).toLocaleString("pt-BR", { dateStyle: "short", timeStyle: "short" });
}

function duration(minutes: number) {
  if (minutes < 60) return `${minutes} min`;
  const h = Math.floor(minutes / 60);
  const m = minutes % 60;
  return m ? `${h}h ${m}min` : `${h}h`;
}

function sharingClass(level: string) {
  if (level === "provável compartilhamento") return "bg-destructive/10 text-destructive";
  if (level === "atenção") return "bg-primary/10 text-primary";
  return "bg-muted text-muted-foreground";
}

function DeniedLogins() {
  const fn = useServerFn(listLoginDenied);
  const [search, setSearch] = useState("");
  const { data = [] } = useQuery({
    queryKey: ["login-denied", search],
    queryFn: () => fn({ data: { search } }),
    refetchInterval: 30000,
  });
  return (
    <div className="mt-6 rounded-2xl border border-border bg-surface p-4">
      <h3 className="text-sm font-semibold">Tentativas de entrada recusadas</h3>
      <p className="mb-2 text-xs text-muted-foreground">
        Últimas 100 tentativas com e-mail não liberado (data, hora, e-mail e motivo).
      </p>
      <input
        value={search}
        onChange={(e) => setSearch(e.target.value)}
        placeholder="Buscar e-mail…"
        className="mb-3 w-full rounded-lg border border-border bg-background px-3 py-2 text-sm"
      />
      {data.length === 0 ? (
        <p className="text-xs text-muted-foreground">Nenhuma tentativa recusada.</p>
      ) : (
        <div className="flex flex-col divide-y divide-border">
          {data.map((r) => (
            <div key={r.id} className="flex items-center justify-between gap-3 py-2 text-xs">
              <span className="min-w-0 flex-1 truncate font-medium">{r.email ?? "—"}</span>
              <span className="text-muted-foreground">{r.reason}</span>
              <span className="text-muted-foreground">{fmt(r.createdAt)}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}

export function AccessPanel() {
  const list = useServerFn(listStudentAccess);
  const detailFn = useServerFn(getStudentAccessDetail);
  const [selected, setSelected] = useState<string | null>(null);
  const [page, setPage] = useState(0);

  const { data, isLoading } = useQuery({
    queryKey: ["student-access", page],
    queryFn: () => list({ data: { page, pageSize: 50 } }),
  });

  const students = data?.rows ?? [];
  const total = data?.total ?? 0;

  const { data: detail } = useQuery({
    queryKey: ["student-access-detail", selected],
    queryFn: () => detailFn({ data: { userId: selected! } }),
    enabled: Boolean(selected),
  });

  if (isLoading) return <p className="text-sm text-muted-foreground">Carregando acessos…</p>;

  if (selected) {
    return (
      <section className="flex flex-col gap-4">
        <button
          type="button"
          onClick={() => setSelected(null)}
          className="inline-flex items-center gap-2 self-start text-sm font-medium text-primary"
        >
          <ArrowLeft className="size-4" /> Voltar à lista
        </button>

        <div className="rounded-2xl border border-border bg-surface p-4">
          <h3 className="text-sm font-semibold">{detail?.profile?.email ?? "Aluno"}</h3>
          <p className="text-xs text-muted-foreground">
            {detail?.profile?.name ?? "sem nome"} · cadastro em{" "}
            {fmt(detail?.profile?.created_at ?? null)}
          </p>
        </div>

        <div className="rounded-2xl border border-border bg-surface p-4">
          <h4 className="mb-2 text-sm font-semibold">Sessões de acesso</h4>
          <div className="flex flex-col gap-2">
            {(detail?.sessions ?? []).length === 0 ? (
              <p className="text-xs text-muted-foreground">Nenhuma sessão registrada ainda.</p>
            ) : null}
            {(detail?.sessions ?? []).map((s) => {
              const mins = Math.max(
                0,
                Math.round(
                  (new Date(s.last_seen_at).getTime() - new Date(s.started_at).getTime()) / 60000,
                ),
              );
              return (
                <div key={s.id} className="rounded-xl border border-border px-3 py-2 text-xs">
                  <p className="font-medium">
                    {fmt(s.started_at)} · {duration(mins)}
                  </p>
                  <p className="text-muted-foreground">
                    aparelho {s.device_id.slice(0, 8)} · {s.ip ?? "IP desconhecido"}
                    {s.ip_city ? ` · ${s.ip_city}` : ""}
                    {s.ip_country ? `/${s.ip_country}` : ""}
                  </p>
                  <p className="truncate text-muted-foreground/80">{s.user_agent ?? ""}</p>
                </div>
              );
            })}
          </div>
        </div>

        <div className="rounded-2xl border border-border bg-surface p-4">
          <h4 className="mb-2 text-sm font-semibold">Conversa completa</h4>
          <div className="flex flex-col gap-2">
            {(detail?.messages ?? []).length === 0 ? (
              <p className="text-xs text-muted-foreground">Sem mensagens.</p>
            ) : null}
            {(detail?.messages ?? []).map((m) => (
              <div
                key={m.id}
                className={`rounded-xl px-3 py-2 text-xs ${
                  m.role === "user" ? "bg-primary/10" : "bg-muted"
                }`}
              >
                <p className="mb-1 font-medium text-muted-foreground">
                  {m.role === "user" ? "Aluno" : "Assistente"} · {fmt(m.created_at)}
                </p>
                <p className="whitespace-pre-wrap">{m.content}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    );
  }

  return (
    <section className="flex flex-col gap-2">
      <p className="text-xs text-muted-foreground">{total} aluno(s) com acesso registrado</p>
      {students.length === 0 ? (
        <p className="text-sm text-muted-foreground">Nenhum aluno registrado ainda.</p>
      ) : null}
      {students.map((s) => (
        <button
          key={s.userId}
          type="button"
          onClick={() => setSelected(s.userId)}
          className="rounded-xl border border-border bg-surface px-4 py-3 text-left transition-colors hover:bg-muted"
        >
          <div className="flex items-center justify-between gap-3">
            <p className="min-w-0 flex-1 truncate text-sm font-medium">{s.email ?? s.userId}</p>
            <span
              className={`rounded-full px-2 py-0.5 text-[10px] font-medium ${sharingClass(s.sharing)}`}
            >
              {s.sharing}
            </span>
          </div>
          <p className="mt-1 text-[11px] text-muted-foreground">
            último acesso {fmt(s.lastAccess)} · {s.sessions} sessões · {duration(s.totalMinutes)} ·{" "}
            {s.messages} mensagens
          </p>
          <p className="text-[11px] text-muted-foreground/80">
            {s.devices} aparelho(s) · {s.ips} IP(s) · primeiro acesso {fmt(s.firstAccess)}
          </p>
        </button>
      ))}
      <Pager page={page} total={total} pageSize={50} onChange={setPage} />
      <DeniedLogins />
    </section>
  );
}
