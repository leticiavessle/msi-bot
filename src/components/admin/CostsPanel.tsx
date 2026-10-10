import { useEffect, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { CircleDollarSign, CalendarRange, TrendingUp, Coins } from "lucide-react";
import { getAiCostReport, setAiPrices } from "@/lib/dr/admin-analytics.functions";
import {
  EmptyState,
  Panel,
  PanelHeader,
  SkeletonRows,
  StatCard,
  buttonPrimary,
  fieldClass,
} from "@/components/admin/ui";

const usd = (v: number) =>
  v.toLocaleString("pt-BR", {
    style: "currency",
    currency: "USD",
    minimumFractionDigits: v < 1 ? 4 : 2,
  });

function Bar({ label, value, max }: { label: string; value: number; max: number }) {
  const width = max > 0 ? Math.max(2, Math.round((value / max) * 100)) : 0;
  return (
    <div className="flex items-center gap-3 text-xs">
      <span className="w-16 shrink-0 truncate text-muted-foreground">{label}</span>
      <span className="h-2.5 flex-1 rounded-full bg-muted">
        <span
          className="block h-2.5 rounded-full bg-gradient-to-r from-primary/70 to-primary"
          style={{ width: `${width}%` }}
        />
      </span>
      <span className="w-20 text-right font-medium tabular-nums">{usd(value)}</span>
    </div>
  );
}

export function CostsPanel() {
  const queryClient = useQueryClient();
  const report = useServerFn(getAiCostReport);
  const savePrices = useServerFn(setAiPrices);
  const { data } = useQuery({ queryKey: ["admin-ai-cost"], queryFn: () => report() });

  const [input, setInput] = useState("");
  const [output, setOutput] = useState("");

  useEffect(() => {
    if (data) {
      setInput(String(data.prices.input));
      setOutput(String(data.prices.output));
    }
  }, [data]);

  const mutation = useMutation({
    mutationFn: (vars: { input: number; output: number }) => savePrices({ data: vars }),
    onSuccess: () => queryClient.invalidateQueries({ queryKey: ["admin-ai-cost"] }),
  });

  if (!data) return <SkeletonRows rows={4} />;

  const maxDaily = Math.max(0.000001, ...data.daily.map((d) => d.cost));

  return (
    <div className="flex flex-col gap-4">
      <div className="grid gap-3 sm:grid-cols-2 xl:grid-cols-4">
        <StatCard
          label="Hoje"
          value={usd(data.costToday)}
          icon={<CircleDollarSign className="size-4" />}
          tone="primary"
        />
        <StatCard
          label="Últimos 7 dias"
          value={usd(data.cost7d)}
          icon={<CalendarRange className="size-4" />}
          tone="info"
        />
        <StatCard
          label="Mês atual"
          value={usd(data.costMonth)}
          icon={<Coins className="size-4" />}
          tone="success"
        />
        <StatCard
          label="Projeção do mês"
          value={usd(data.projectedMonth)}
          hint="Média diária × dias do mês"
          icon={<TrendingUp className="size-4" />}
          tone="warning"
        />
      </div>

      <div className="grid gap-3 sm:grid-cols-3">
        <StatCard
          label="Custo por mensagem"
          value={usd(data.avgPerMessage)}
          hint={`${data.messages} respostas`}
        />
        <StatCard
          label="Custo por aluno"
          value={usd(data.avgPerUser)}
          hint={`${data.users} alunos`}
        />
        <StatCard
          label="Tokens consumidos"
          value={data.totalTokens.toLocaleString("pt-BR")}
          hint="Últimos 60 dias"
        />
      </div>

      <div className="grid gap-4 xl:grid-cols-2">
        <Panel>
          <PanelHeader title="Custo por dia" hint="Últimos 30 dias com registro" />
          <div className="flex flex-col gap-1.5 p-4">
            {data.daily.length === 0 ? (
              <EmptyState
                title="Ainda sem custo registrado"
                description="Os valores aparecem a partir das próximas conversas dos alunos."
              />
            ) : null}
            {data.daily.map((d) => (
              <Bar
                key={d.day}
                label={new Date(`${d.day}T12:00:00`).toLocaleDateString("pt-BR", {
                  day: "2-digit",
                  month: "2-digit",
                })}
                value={d.cost}
                max={maxDaily}
              />
            ))}
          </div>
        </Panel>

        <Panel>
          <PanelHeader title="Alunos que mais consomem" hint="Top 10 por custo" />
          <div className="divide-y divide-border/70">
            {data.topUsers.length === 0 ? (
              <p className="p-4 text-xs text-muted-foreground">Sem dados ainda.</p>
            ) : null}
            {data.topUsers.map((u) => (
              <div
                key={u.userId}
                className="flex items-center justify-between gap-3 px-4 py-2.5 text-sm"
              >
                <div className="min-w-0">
                  <p className="truncate font-medium">{u.name ?? u.email ?? "Aluno"}</p>
                  <p className="truncate text-[11px] text-muted-foreground">
                    {u.email ?? ""} · {u.messages} respostas
                  </p>
                </div>
                <span className="shrink-0 font-semibold tabular-nums">{usd(u.cost)}</span>
              </div>
            ))}
          </div>
        </Panel>
      </div>

      <Panel>
        <PanelHeader title="Preço do modelo" hint="Valor em dólar por 1 milhão de tokens" />
        <form
          className="flex flex-wrap items-end gap-3 p-4"
          onSubmit={(e) => {
            e.preventDefault();
            mutation.mutate({ input: Number(input) || 0, output: Number(output) || 0 });
          }}
        >
          <label className="flex flex-col gap-1 text-xs">
            <span className="text-muted-foreground">Entrada (US$ / 1M tokens)</span>
            <input
              className={fieldClass}
              type="number"
              step="0.01"
              min="0"
              value={input}
              onChange={(e) => setInput(e.target.value)}
            />
          </label>
          <label className="flex flex-col gap-1 text-xs">
            <span className="text-muted-foreground">Saída (US$ / 1M tokens)</span>
            <input
              className={fieldClass}
              type="number"
              step="0.01"
              min="0"
              value={output}
              onChange={(e) => setOutput(e.target.value)}
            />
          </label>
          <button className={buttonPrimary} type="submit" disabled={mutation.isPending}>
            {mutation.isPending ? "Salvando..." : "Salvar preço"}
          </button>
          <p className="w-full text-[11px] text-muted-foreground">
            O custo é calculado no momento da resposta, então mudar o preço aqui não altera o
            histórico já registrado.
          </p>
        </form>
      </Panel>
    </div>
  );
}
