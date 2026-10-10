import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useEffect, useMemo, useState } from "react";
import { FileText } from "lucide-react";
import { getDailyReport, listDailyReports } from "@/lib/dr/reports.functions";
import { EmptyState, Panel, StatusBadge, fieldClass } from "@/components/admin/ui";

export function ReportsPanel() {
  const listFn = useServerFn(listDailyReports);
  const getFn = useServerFn(getDailyReport);
  const { data: list, isLoading } = useQuery({ queryKey: ["daily-reports"], queryFn: () => listFn(), refetchInterval: 120_000 });

  const [dia, setDia] = useState("");
  const [edicao, setEdicao] = useState<"08h" | "17h">("08h");

  useEffect(() => {
    if (!dia && list?.[0]) {
      setDia(list[0].dia);
      setEdicao(list[0].edicao as "08h" | "17h");
    }
  }, [list, dia]);

  const selected = useMemo(() => list?.find((r) => r.dia === dia && r.edicao === edicao) ?? null, [list, dia, edicao]);
  const { data: report } = useQuery({
    queryKey: ["daily-report", selected?.id],
    queryFn: () => getFn({ data: { id: selected!.id } }),
    enabled: Boolean(selected?.id),
  });

  if (isLoading) return <p className="text-sm text-muted-foreground">Carregando…</p>;
  if (!list?.length) {
    return <EmptyState icon={<FileText className="size-6" />} title="Nenhum relatório ainda" description="Os relatórios das 08h e 17h aparecem aqui assim que forem publicados." />;
  }

  return (
    <div className="flex flex-col gap-4">
      <Panel className="flex flex-wrap items-end gap-3 p-4">
        <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
          Data
          <input type="date" value={dia} onChange={(e) => setDia(e.target.value)} className={fieldClass} />
        </label>
        <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
          Edição
          <select value={edicao} onChange={(e) => setEdicao(e.target.value as "08h" | "17h")} className={fieldClass}>
            <option value="08h">08h</option>
            <option value="17h">17h</option>
          </select>
        </label>
        {selected ? (
          <div className="flex items-center gap-2 text-xs text-muted-foreground">
            WhatsApp:
            <StatusBadge tone={selected.whatsapp_status === "enviado" ? "success" : selected.whatsapp_status === "erro" ? "danger" : "warning"}>
              {selected.whatsapp_status ?? "—"}
            </StatusBadge>
            {selected.whatsapp_error ? <span className="max-w-md truncate text-destructive" title={selected.whatsapp_error}>{selected.whatsapp_error}</span> : null}
          </div>
        ) : null}
      </Panel>
      {!selected ? (
        <EmptyState icon={<FileText className="size-6" />} title="Sem relatório nesta data/edição" description="Escolha outra data ou edição." />
      ) : (
        <Panel className="overflow-hidden">
          <iframe title={`Relatório ${dia} ${edicao}`} sandbox="" srcDoc={report?.html ?? ""} className="h-[80vh] w-full border-0 bg-background" />
        </Panel>
      )}
    </div>
  );
}
