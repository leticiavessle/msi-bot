import { useState } from "react";
import { useQuery } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { Link2 as LinkIcon, Search } from "lucide-react";
import { checkCatalogLinks, getCatalogStats, testRetrieval } from "@/lib/dr/catalog.functions";

type TestResult = Awaited<ReturnType<typeof testRetrieval>>;
type CheckResult = Awaited<ReturnType<typeof checkCatalogLinks>>;

export function CatalogPanel() {
  const stats = useServerFn(getCatalogStats);
  const test = useServerFn(testRetrieval);
  const checkLinks = useServerFn(checkCatalogLinks);
  const [question, setQuestion] = useState("");
  const [result, setResult] = useState<TestResult | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [check, setCheck] = useState<CheckResult | null>(null);
  const [checking, setChecking] = useState(false);

  const { data } = useQuery({ queryKey: ["catalog-stats"], queryFn: () => stats() });

  async function runCheck() {
    setChecking(true);
    try {
      setCheck(await checkLinks({ data: { limit: 60 } }));
    } catch (err) {
      setError(err instanceof Error ? err.message : "Falha na verificação.");
    } finally {
      setChecking(false);
    }
  }

  async function run() {
    if (question.trim().length < 2) return;
    setLoading(true);
    setError(null);
    try {
      setResult(await test({ data: { question: question.trim() } }));
    } catch (err) {
      setError(err instanceof Error ? err.message : "Falha no teste.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="flex flex-col gap-4">
      <section className="grid grid-cols-2 gap-2 sm:grid-cols-3">
        {[
          ["Blocos de aula", data?.chunks],
          ["Blocos aprovados", data?.approvedChunks],
          ["Vitrines", data?.vitrines],
          ["Materiais", data?.materials],
          ["Materiais liberados", data?.approvedMaterials],
          ["Arquivos no storage", data?.storedFiles],
        ].map(([label, value]) => (
          <div key={String(label)} className="rounded-xl border border-border bg-surface p-3">
            <p className="text-[11px] text-muted-foreground">{label}</p>
            <p className="text-lg font-semibold">{value ?? "—"}</p>
          </div>
        ))}
      </section>

      <section className="rounded-2xl border border-border bg-surface p-4">
        <h2 className="mb-3 text-sm font-semibold">Testar recuperação</h2>
        <div className="flex gap-2">
          <input
            value={question}
            onChange={(e) => setQuestion(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === "Enter") void run();
            }}
            placeholder="Ex.: por onde eu começo?"
            className="min-h-11 flex-1 rounded-xl border border-border bg-background px-3 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
          />
          <button
            type="button"
            onClick={() => void run()}
            disabled={loading}
            className="inline-flex min-h-11 items-center gap-2 rounded-xl bg-primary px-4 text-sm font-semibold text-primary-foreground disabled:opacity-50"
          >
            <Search className="size-4" />
            {loading ? "…" : "Testar"}
          </button>
        </div>
        {error ? <p className="mt-2 text-xs text-destructive">{error}</p> : null}

        {result ? (
          <div className="mt-4 flex flex-col gap-3 text-xs">
            <p className="text-muted-foreground">Intenções: {result.intents.join(", ")}</p>
            <div>
              <p className="mb-1 font-semibold">Materiais ({result.materials.length})</p>
              {result.materials.map((m) => (
                <p key={m.id} className="text-muted-foreground">
                  {m.title} — {m.resourceType} · entrega: {m.delivery}
                  {m.commercial ? " · oferta comercial" : ""}
                </p>
              ))}
            </div>
            <div>
              <p className="mb-1 font-semibold">Blocos de aula ({result.chunks.length})</p>
              {result.chunks.map((c) => (
                <p key={c.id} className="text-muted-foreground">
                  vitrine {c.level ?? "?"} · módulo {c.module ?? "?"} — {c.title}
                </p>
              ))}
            </div>
          </div>
        ) : null}
      </section>

      <section className="rounded-2xl border border-border bg-surface p-4">
        <div className="flex items-center justify-between gap-2">
          <div>
            <h2 className="text-sm font-semibold">Verificar links externos</h2>
            <p className="text-[11px] text-muted-foreground">
              Verificação manual. Convites de WhatsApp e checkouts ficam sempre como “desconhecido”
              para revisão humana.
            </p>
          </div>
          <button
            type="button"
            onClick={() => void runCheck()}
            disabled={checking}
            className="inline-flex min-h-11 shrink-0 items-center gap-2 rounded-xl border border-border px-4 text-sm font-semibold disabled:opacity-50"
          >
            <LinkIcon className="size-4" />
            {checking ? "Verificando…" : "Verificar"}
          </button>
        </div>
        {check ? (
          <div className="mt-3 text-xs">
            <p className="mb-2 text-muted-foreground">
              {check.checked} verificados · {check.available} disponíveis · {check.unavailable} fora
              do ar · {check.unknown} desconhecidos
            </p>
            <div className="max-h-64 overflow-y-auto">
              {check.results
                .filter((r) => r.status !== "available")
                .map((r) => (
                  <p key={r.id} className="text-muted-foreground">
                    [{r.status}] {r.title} — {r.detail}
                  </p>
                ))}
            </div>
          </div>
        ) : null}
      </section>
    </div>
  );
}
