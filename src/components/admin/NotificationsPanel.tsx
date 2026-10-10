import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { BellRing } from "lucide-react";
import { countPushTargets, listPushBroadcasts, sendPushBroadcast } from "@/lib/dr/push.functions";
import { Panel, PanelHeader, buttonPrimary, fieldClass } from "@/components/admin/ui";
import { PRODUCTS, PRODUTO_PADRAO, type Product } from "@/lib/dr/config";

type Audience = "all" | "product" | "email";

function fmt(value: string) {
  return new Date(value).toLocaleString("pt-BR", { dateStyle: "short", timeStyle: "short" });
}

export function NotificationsPanel() {
  const countFn = useServerFn(countPushTargets);
  const sendFn = useServerFn(sendPushBroadcast);
  const listFn = useServerFn(listPushBroadcasts);
  const queryClient = useQueryClient();

  const [title, setTitle] = useState("");
  const [body, setBody] = useState("");
  const [url, setUrl] = useState("/chat");
  const [audience, setAudience] = useState<Audience>("all");
  const [product, setProduct] = useState<Product>(PRODUTO_PADRAO);
  const [email, setEmail] = useState("");
  const [confirming, setConfirming] = useState(false);
  const [result, setResult] = useState<string | null>(null);

  const audienceData = {
    audience,
    ...(audience === "product" ? { product } : {}),
    ...(audience === "email" ? { email: email.trim().toLowerCase() } : {}),
  };

  const { data: targets } = useQuery({
    queryKey: ["push-targets", audience, product, email],
    queryFn: () => countFn({ data: audienceData }),
  });

  const { data: history } = useQuery({
    queryKey: ["push-broadcasts"],
    queryFn: () => listFn(),
  });

  const send = useMutation({
    mutationFn: () =>
      sendFn({
        data: {
          ...audienceData,
          title: title.trim(),
          body: body.trim(),
          url: url.trim(),
        },
      }),
    onSuccess: async (data) => {
      setConfirming(false);
      setResult(
        `Enviado para ${data.sent} de ${data.targeted} aparelho(s). Falhas: ${data.failed}.`,
      );
      await queryClient.invalidateQueries({ queryKey: ["push-broadcasts"] });
      await queryClient.invalidateQueries({ queryKey: ["push-targets"] });
    },
    onError: (err) => {
      setConfirming(false);
      setResult(err instanceof Error ? err.message : "Não consegui enviar.");
    },
  });

  const ready = title.trim().length > 1 && body.trim().length > 1;

  return (
    <section className="flex flex-col gap-5">
      <Panel className="p-5">
        <h3 className="mb-4 text-sm font-semibold">Nova notificação</h3>
        <div className="flex flex-col gap-3">
          <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
            Título
            <input
              value={title}
              maxLength={80}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="Ex.: Aula nova no ar"
              className={fieldClass}
            />
          </label>
          <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
            Texto
            <textarea
              value={body}
              maxLength={300}
              rows={3}
              onChange={(e) => setBody(e.target.value)}
              placeholder="Ex.: Liberamos uma aula nova no Módulo 7 (99Freelas)."
              className={fieldClass}
            />
          </label>
          <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
            Link ao tocar
            <input value={url} onChange={(e) => setUrl(e.target.value)} className={fieldClass} />
          </label>

          <div className="grid gap-3 sm:grid-cols-2">
            <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
              Público
              <select
                value={audience}
                onChange={(e) => setAudience(e.target.value as Audience)}
                className={fieldClass}
              >
                <option value="all">Todos os alunos</option>
                <option value="product">Por produto</option>
                <option value="email">Um e-mail</option>
              </select>
            </label>
            {audience === "product" ? (
              <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                Produto
                <select
                  value={product}
                  onChange={(e) => setProduct(e.target.value as Product)}
                  className={fieldClass}
                >
                  {PRODUCTS.map((p) => (
                    <option key={p} value={p}>
                      {p}
                    </option>
                  ))}
                </select>
              </label>
            ) : null}
            {audience === "email" ? (
              <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                E-mail
                <input
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  placeholder="aluno@email.com"
                  className={fieldClass}
                />
              </label>
            ) : null}
          </div>

          <p className="text-xs text-muted-foreground">
            {targets?.devices ?? 0} aparelho(s) com notificação ativa vão receber.
          </p>

          {result ? <p className="text-xs text-primary">{result}</p> : null}

          {confirming ? (
            <div className="flex flex-wrap items-center gap-2 rounded-xl border border-border bg-muted/40 p-3">
              <p className="text-xs text-foreground">
                Confirmar envio para {targets?.devices ?? 0} aparelho(s)?
              </p>
              <button
                type="button"
                disabled={send.isPending}
                onClick={() => send.mutate()}
                className={buttonPrimary}
              >
                {send.isPending ? "Enviando…" : "Confirmar envio"}
              </button>
              <button
                type="button"
                onClick={() => setConfirming(false)}
                className="text-xs text-muted-foreground underline"
              >
                Cancelar
              </button>
            </div>
          ) : (
            <button
              type="button"
              disabled={!ready}
              onClick={() => {
                setResult(null);
                setConfirming(true);
              }}
              className={`${buttonPrimary} self-start disabled:opacity-40`}
            >
              <BellRing className="size-4" />
              Enviar notificação
            </button>
          )}
        </div>
      </Panel>

      <Panel>
        <PanelHeader title="Histórico de envios" hint="Últimos 50 disparos." />
        <div className="divide-y divide-border/70">
          {(history?.rows ?? []).length === 0 ? (
            <p className="px-4 py-6 text-sm text-muted-foreground">Nenhum envio ainda.</p>
          ) : (
            (history?.rows ?? []).map((row) => (
              <article key={row.id} className="px-4 py-3">
                <p className="text-sm font-medium">{row.title}</p>
                <p className="text-xs break-words text-muted-foreground">{row.body}</p>
                <p className="mt-1 text-[11px] text-muted-foreground">
                  {fmt(row.created_at)} · {row.audience}
                  {row.audience_value ? ` (${row.audience_value})` : ""} · {row.devices_sent}/
                  {row.devices_targeted} entregues · {row.devices_failed} falha(s)
                </p>
              </article>
            ))
          )}
        </div>
      </Panel>
    </section>
  );
}
