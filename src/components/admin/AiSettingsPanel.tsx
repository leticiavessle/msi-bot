import { useEffect, useState } from "react";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import {
  getAiSettings,
  getAiUsage,
  listProviderModels,
  removeAiKey,
  saveAiConfig,
  saveAiKey,
  testAiConnection,
} from "@/lib/dr/ai-settings.functions";
import { Panel, PanelHeader, SkeletonRows, StatusBadge, buttonGhost, buttonPrimary, fieldClass } from "@/components/admin/ui";

type P = "openai" | "gemini";
const NAMES: Record<P, string> = { openai: "OpenAI", gemini: "Gemini" };
const errMsg = (e: unknown) => (e instanceof Error ? e.message : "Não consegui salvar.");
const fmt = (iso: string | null) => (iso ? new Date(iso).toLocaleString("pt-BR", { timeZone: "America/Sao_Paulo" }) : "—");

function KeyField({ provider, masked, onChanged }: { provider: P; masked: string | null; onChanged: () => void }) {
  const save = useServerFn(saveAiKey);
  const remove = useServerFn(removeAiKey);
  const [editing, setEditing] = useState(false);
  const [value, setValue] = useState("");
  const [error, setError] = useState<string | null>(null);
  const m = useMutation({
    mutationFn: (k: string) => save({ data: { provider, key: k } }),
    onSuccess: () => { setValue(""); setEditing(false); setError(null); onChanged(); },
    onError: (e) => setError(errMsg(e)),
  });
  const del = useMutation({ mutationFn: () => remove({ data: { provider } }), onSuccess: onChanged, onError: (e) => setError(errMsg(e)) });
  return (
    <div className="flex flex-col gap-1.5 text-xs">
      <span className="font-medium text-muted-foreground">Chave {NAMES[provider]}{provider === "gemini" ? " (Google AI Studio)" : ""}</span>
      {masked && !editing ? (
        <div className="flex flex-wrap items-center gap-2">
          <code className="rounded-md bg-muted px-2 py-1">{masked}</code>
          <button className={buttonGhost} onClick={() => setEditing(true)}>Trocar</button>
          <button className={buttonGhost} onClick={() => { if (confirm(`Remover a chave ${NAMES[provider]}?`)) del.mutate(); }}>Remover</button>
        </div>
      ) : (
        <div className="flex flex-wrap gap-2">
          <input type="password" autoComplete="off" value={value} onChange={(e) => setValue(e.target.value)} placeholder={provider === "openai" ? "sk-..." : "AIza..."} className={`${fieldClass} min-w-64 flex-1`} />
          <button className={buttonPrimary} disabled={value.trim().length < 10 || m.isPending} onClick={() => m.mutate(value.trim())}>Salvar chave</button>
          {editing ? <button className={buttonGhost} onClick={() => { setEditing(false); setValue(""); }}>Cancelar</button> : null}
        </div>
      )}
      {error ? <span className="text-destructive">{error}</span> : null}
    </div>
  );
}

export function AiSettingsPanel() {
  const qc = useQueryClient();
  const get = useServerFn(getAiSettings);
  const usageFn = useServerFn(getAiUsage);
  const saveCfg = useServerFn(saveAiConfig);
  const listModels = useServerFn(listProviderModels);
  const test = useServerFn(testAiConnection);
  const { data: s } = useQuery({ queryKey: ["ai-settings"], queryFn: () => get() });
  const { data: usage } = useQuery({ queryKey: ["ai-usage"], queryFn: () => usageFn() });
  const refresh = () => { qc.invalidateQueries({ queryKey: ["ai-settings"] }); qc.invalidateQueries({ queryKey: ["ai-usage"] }); };

  const [provider, setProvider] = useState<P>("openai");
  const [modelChat, setModelChat] = useState("");
  const [modelTasks, setModelTasks] = useState("");
  const [temp, setTemp] = useState("");
  const [models, setModels] = useState<string[]>([]);
  const [msg, setMsg] = useState<{ ok: boolean; text: string } | null>(null);

  useEffect(() => {
    if (!s) return;
    setProvider(s.provider ?? "openai");
    setModelChat(s.modelChat ?? "");
    setModelTasks(s.modelTasks ?? "");
    setTemp(s.temperature === null ? "" : String(s.temperature));
  }, [s]);

  const cfg = useMutation({
    mutationFn: () => saveCfg({ data: { provider, modelChat: modelChat || null, modelTasks: modelTasks || null, temperature: temp === "" ? null : Number(temp) } }),
    onSuccess: (r) => { setMsg({ ok: true, text: r.deactivated ? "Salvo. Teste a conexão de novo para voltar a usar sua chave." : "Salvo." }); refresh(); },
    onError: (e) => setMsg({ ok: false, text: errMsg(e) }),
  });
  const load = useMutation({
    mutationFn: () => listModels({ data: { provider } }),
    onSuccess: (r) => setModels(r.models),
    onError: (e) => setMsg({ ok: false, text: errMsg(e) }),
  });
  const t = useMutation({
    mutationFn: () => test(),
    onSuccess: (r) => { setMsg(r.ok ? { ok: true, text: "Funcionou. A partir de agora o bot usa sua chave." } : { ok: false, text: r.error ?? "Falhou." }); refresh(); },
    onError: (e) => setMsg({ ok: false, text: errMsg(e) }),
  });

  if (!s) return <SkeletonRows rows={4} />;

  const sum = (period: string, use: string) => usage?.summary.find((x) => x.period === period && x.use === use);

  return (
    <div className="flex flex-col gap-5">
      <Panel className="p-5">
        <p className="text-xs text-muted-foreground">IA em uso agora</p>
        <p className="mt-1 text-lg font-semibold">
          {s.inUse === "env" ? "Chave do .env (temporária, até salvar e testar uma chave aqui)" : `Sua chave: ${NAMES[s.inUse]}`}
        </p>
        <p className="mt-1 text-xs text-muted-foreground">
          Última alteração: {s.updatedByName ?? "—"} em {fmt(s.updatedAt)}
          {s.lastTestAt ? ` · Último teste: ${fmt(s.lastTestAt)} ${s.lastTestError ? "(falhou)" : "(funcionou)"}` : ""}
        </p>
        {s.active ? (
          <p className="mt-2 text-xs text-muted-foreground">Se sua chave der erro, o bot não volta para a chave do .env: a pessoa vê a mensagem de indisponibilidade e o erro aparece abaixo.</p>
        ) : null}
      </Panel>

      <Panel>
        <PanelHeader title="Configuração" hint="Trocar provedor, modelo ou chave exige testar a conexão de novo." />
        <div className="flex flex-col gap-4 p-5">
          <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
            Provedor
            <select value={provider} onChange={(e) => { setProvider(e.target.value as P); setModels([]); }} className={fieldClass}>
              <option value="openai">OpenAI</option>
              <option value="gemini">Gemini (Google AI Studio)</option>
            </select>
          </label>
          <KeyField provider="openai" masked={s.openaiMasked} onChanged={refresh} />
          <KeyField provider="gemini" masked={s.geminiMasked} onChanged={refresh} />
          <div className="flex flex-wrap items-center gap-2">
            <button className={buttonGhost} disabled={load.isPending} onClick={() => load.mutate()}>
              {load.isPending ? "Carregando…" : `Carregar modelos da ${NAMES[provider]}`}
            </button>
            {models.length ? <span className="text-xs text-muted-foreground">{models.length} modelos</span> : null}
          </div>
          <datalist id="ai-models">{models.map((m) => <option key={m} value={m} />)}</datalist>
          <div className="grid gap-3 sm:grid-cols-3">
            <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
              Modelo de chat
              <input list="ai-models" value={modelChat} onChange={(e) => setModelChat(e.target.value)} placeholder="escolha ou digite" className={fieldClass} />
            </label>
            <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
              Modelo de tarefas
              <input list="ai-models" value={modelTasks} onChange={(e) => setModelTasks(e.target.value)} placeholder="vazio = mesmo do chat" className={fieldClass} />
            </label>
            <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
              Temperatura
              <input type="number" step="0.1" min="0" max="2" value={temp} onChange={(e) => setTemp(e.target.value)} placeholder="padrão do modelo" className={fieldClass} />
            </label>
          </div>
          <div className="flex flex-wrap gap-2">
            <button className={buttonPrimary} disabled={cfg.isPending} onClick={() => cfg.mutate()}>Salvar</button>
            <button className={buttonGhost} disabled={t.isPending} onClick={() => t.mutate()}>{t.isPending ? "Testando…" : "Testar conexão"}</button>
          </div>
          {msg ? <p className={`text-sm ${msg.ok ? "text-foreground" : "text-destructive"} break-words`}>{msg.text}</p> : null}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Uso" hint="Horário de Brasília. Mês = desde o dia 1." />
        <div className="overflow-x-auto p-5">
          <table className="w-full text-sm">
            <thead className="text-left text-xs text-muted-foreground">
              <tr><th className="py-1">Período</th><th>Uso</th><th>Chamadas</th><th>Erros</th><th>Tokens entrada</th><th>Tokens saída</th></tr>
            </thead>
            <tbody>
              {(["hoje", "7d", "mes"] as const).flatMap((p) =>
                (["chat", "classificacao"] as const).map((u) => {
                  const r = sum(p, u);
                  return (
                    <tr key={p + u} className="border-t border-border/60 tabular-nums">
                      <td className="py-1.5">{p === "hoje" ? "Hoje" : p === "7d" ? "7 dias" : "Mês"}</td>
                      <td>{u === "chat" ? "Chat" : "Classificação"}</td>
                      <td>{r?.calls ?? 0}</td><td>{r?.errors ?? 0}</td>
                      <td>{(r?.input ?? 0).toLocaleString("pt-BR")}</td><td>{(r?.output ?? 0).toLocaleString("pt-BR")}</td>
                    </tr>
                  );
                }),
              )}
            </tbody>
          </table>
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Últimos 20 erros" />
        <div className="flex flex-col divide-y divide-border/60">
          {usage?.errors.length ? usage.errors.map((e, i) => (
            <div key={i} className="px-5 py-2 text-xs">
              <div className="flex flex-wrap gap-2">
                <StatusBadge tone="danger">{e.provider}</StatusBadge>
                <span className="text-muted-foreground">{fmt(e.created_at)} · {e.use} · {e.model ?? "—"}</span>
              </div>
              <p className="mt-1 break-words">{e.error}</p>
            </div>
          )) : <p className="px-5 py-4 text-sm text-muted-foreground">Nenhum erro registrado.</p>}
        </div>
      </Panel>
    </div>
  );
}
