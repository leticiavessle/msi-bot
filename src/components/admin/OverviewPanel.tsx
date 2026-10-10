import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import {
  Activity,
  AlertTriangle,
  CalendarClock,
  MessagesSquare,
  Repeat,
  ShieldAlert,
  Signal,
  Sparkles,
  UserPlus,
  Users,
} from "lucide-react";
import { getAdminAnalytics, getAdminOverview } from "@/lib/dr/admin-analytics.functions";
import { Panel, SkeletonRows, StatCard } from "@/components/admin/ui";

function Group({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section>
      <h3 className="mb-2 text-[11px] font-semibold uppercase tracking-wide text-muted-foreground">
        {title}
      </h3>
      <div className="grid grid-cols-2 gap-3 lg:grid-cols-4">{children}</div>
    </section>
  );
}

export function OverviewPanel() {
  const overview = useServerFn(getAdminOverview);
  const analyticsFn = useServerFn(getAdminAnalytics);

  const { data, isLoading } = useQuery({
    queryKey: ["admin-overview"],
    queryFn: () => overview(),
    refetchInterval: 60_000,
  });

  const { data: analytics } = useQuery({
    queryKey: ["admin-analytics"],
    queryFn: () => analyticsFn(),
  });

  if (isLoading || !data) return <SkeletonRows rows={4} />;

  const daily = (analytics?.daily ?? []).slice(-14);
  const max = Math.max(1, ...daily.map((d) => d.messages));

  return (
    <div className="flex flex-col gap-6">
      <Group title="Presença (horário de Brasília)">
        <StatCard
          label="Online agora"
          value={data.onlineNow}
          hint="Com o chat aberto e sinal nos últimos 2 min. Zero pode ser verdade."
          tone="success"
          icon={<Signal className="size-4" />}
        />
        <StatCard
          label="Ativas hoje"
          value={data.activeToday}
          hint="Pessoas que abriram o app desde 00h"
          icon={<Activity className="size-4" />}
        />
        <StatCard
          label="Ativas nos últimos 7 dias"
          value={data.active7d}
          hint="Hoje + 6 dias anteriores"
          icon={<CalendarClock className="size-4" />}
        />
        <StatCard
          label="Ativas 30 dias"
          value={data.active30d}
          icon={<CalendarClock className="size-4" />}
        />
      </Group>

      <Group title="Engajamento de hoje (desde 00h, Brasília)">
        <StatCard
          label="Mensagens das alunas"
          value={data.messagesTodayUser}
          hint={data.lastUserMessageAt ? `Só alunas · última às ${new Date(data.lastUserMessageAt).toLocaleTimeString("pt-BR", { timeZone: "America/Sao_Paulo", hour: "2-digit", minute: "2-digit" })}` : "Só alunas"}
          icon={<MessagesSquare className="size-4" />}
          tone="primary"
        />
        <StatCard
          label="Respostas do bot"
          value={data.messagesTodayBot}
          hint="Só bot"
          icon={<Sparkles className="size-4" />}
        />
        <StatCard
          label="Conversas hoje"
          value={data.conversationsToday}
          hint={`Com mensagem de aluna hoje · ${data.peopleToday} pessoa(s)`}
          icon={<Activity className="size-4" />}
        />
        <StatCard
          label="Taxa de retorno"
          value={`${data.returnRate}%`}
          hint={`Voltaram em 2+ dias (30 dias) · média ${data.avgMessagesPerUser} msg/aluna`}
          icon={<Repeat className="size-4" />}
        />
      </Group>

      <Group title="Base de alunos">
        <StatCard
          label="Alunos autorizados"
          value={data.totalUsers}
          hint={`${data.activeUsers} ativos`}
          icon={<Users className="size-4" />}
        />
        <StatCard
          label="Novos (7 dias)"
          value={data.newUsers7d}
          icon={<UserPlus className="size-4" />}
          tone="info"
        />
        <StatCard
          label="Alunos em risco"
          value={data.atRisk}
          tone={data.atRisk > 0 ? "warning" : "neutral"}
          icon={<AlertTriangle className="size-4" />}
        />
        <StatCard
          label="Alertas críticos"
          value={data.criticalAlerts}
          tone={data.criticalAlerts > 0 ? "danger" : "neutral"}
          icon={<ShieldAlert className="size-4" />}
        />
      </Group>

      <Panel className="p-5">
        <h3 className="text-sm font-semibold">Atividade dos últimos 14 dias</h3>
        <p className="mb-4 text-[11px] text-muted-foreground">Mensagens das alunas por dia (horário de Brasília).</p>
        {daily.length === 0 ? (
          <p className="text-xs text-muted-foreground">Sem dados ainda.</p>
        ) : (
          <div className="flex h-32 items-end gap-1.5">
            {daily.map((d) => (
              <div key={d.day} className="group flex flex-1 flex-col items-center gap-1">
                <span
                  className="w-full rounded-t-md bg-primary/80 transition-colors group-hover:bg-primary"
                  style={{ height: `${Math.max(4, (d.messages / max) * 100)}%` }}
                  title={`${d.messages} das alunas · ${d.botMessages} do bot`}
                />
                <span className="text-[9px] tabular-nums text-muted-foreground">
                  {d.day.slice(8, 10)}
                </span>
              </div>
            ))}
          </div>
        )}
      </Panel>
    </div>
  );
}
