import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { getAdminAnalytics } from "@/lib/dr/admin-analytics.functions";
import { Panel, PanelHeader, SkeletonRows } from "@/components/admin/ui";

function Bar({ label, value, max }: { label: string; value: number; max: number }) {
  const width = max > 0 ? Math.max(2, Math.round((value / max) * 100)) : 0;
  return (
    <div className="flex items-center gap-3 text-xs">
      <span className="w-20 shrink-0 truncate text-muted-foreground">{label}</span>
      <span className="h-2.5 flex-1 rounded-full bg-muted">
        <span
          className="block h-2.5 rounded-full bg-gradient-to-r from-primary/70 to-primary"
          style={{ width: `${width}%` }}
        />
      </span>
      <span className="w-10 text-right font-medium tabular-nums">{value}</span>
    </div>
  );
}

function Group({
  rows,
  empty = "Sem dados ainda.",
}: {
  rows: { name: string; count: number }[];
  empty?: string;
}) {
  if (rows.length === 0) return <p className="text-xs text-muted-foreground">{empty}</p>;
  const max = Math.max(1, ...rows.map((r) => r.count));
  return (
    <>
      {rows.map((r) => (
        <Bar key={r.name} label={r.name} value={r.count} max={max} />
      ))}
    </>
  );
}

export function AnalyticsPanel() {
  const analytics = useServerFn(getAdminAnalytics);
  const { data } = useQuery({ queryKey: ["admin-analytics"], queryFn: () => analytics() });

  if (!data) return <SkeletonRows rows={4} />;

  const maxDaily = Math.max(1, ...data.daily.map((d) => d.messages));
  const maxHour = Math.max(1, ...data.hourly.map((h) => h.count));
  const maxTopic = Math.max(1, ...data.topics.map((t) => t.count));
  const maxEvent = Math.max(1, ...data.events.map((e) => e.count));

  return (
    <div className="grid gap-4 xl:grid-cols-2">
      <Panel>
        <PanelHeader title="Mensagens por dia" hint="Só mensagens das alunas · últimos 14 dias · Brasília" />
        <div className="flex flex-col gap-1.5 p-4">
          {data.daily.length === 0 ? (
            <p className="text-xs text-muted-foreground">Sem dados ainda.</p>
          ) : null}
          {data.daily.slice(-14).map((d) => (
            <Bar
              key={d.day}
              label={new Date(`${d.day}T12:00:00`).toLocaleDateString("pt-BR", {
                day: "2-digit",
                month: "2-digit",
              })}
              value={d.messages}
              max={maxDaily}
            />
          ))}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Horários de maior uso" hint="Mensagens das alunas por hora · 30 dias · Brasília" />
        <div className="flex flex-col gap-1.5 p-4">
          {data.hourly.filter((h) => h.count > 0).length === 0 ? (
            <p className="text-xs text-muted-foreground">Sem dados ainda.</p>
          ) : null}
          {data.hourly
            .filter((h) => h.count > 0)
            .map((h) => (
              <Bar
                key={h.hour}
                label={`${String(h.hour).padStart(2, "0")}h`}
                value={h.count}
                max={maxHour}
              />
            ))}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Temas mais perguntados" hint="Intenções detectadas pelo assistente" />
        <div className="flex flex-col gap-1.5 p-4">
          {data.topics.length === 0 ? (
            <p className="text-xs text-muted-foreground">Sem dados ainda.</p>
          ) : null}
          {data.topics.map((t) => (
            <Bar key={t.intent} label={t.intent} value={t.count} max={maxTopic} />
          ))}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Eventos de uso" hint="Ações registradas no app" />
        <div className="flex flex-col gap-1.5 p-4">
          {data.events.length === 0 ? (
            <p className="text-xs text-muted-foreground">Sem eventos ainda.</p>
          ) : null}
          {data.events.map((e) => (
            <Bar key={e.name} label={e.name} value={e.count} max={maxEvent} />
          ))}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Próximas ações registradas" hint="O que os alunos precisam executar" />
        <div className="flex flex-col gap-1.5 p-4">
          <Group rows={data.journey.nextActions} />
        </div>
      </Panel>
    </div>
  );
}
