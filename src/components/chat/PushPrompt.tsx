import { useEffect, useState } from "react";
import { useServerFn } from "@tanstack/react-start";
import { Bell, X } from "lucide-react";
import { currentSubscription, pushSupported, subscribeToPush } from "@/lib/pwa/push";
import { savePushSubscription } from "@/lib/dr/push.functions";
import { isIosDevice, isStandaloneMode } from "@/lib/pwa/useInstallPrompt";

const DISMISS_KEY = "app:push-dismissed";

/** Aviso discreto para ativar as notificações (precisa de um toque, exigência do iPhone). */
export function PushPrompt() {
  const save = useServerFn(savePushSubscription);
  const [state, setState] = useState<"hidden" | "offer" | "ios" | "done">("hidden");
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  useEffect(() => {
    let alive = true;
    void (async () => {
      if (typeof window === "undefined") return;
      if (window.localStorage.getItem(DISMISS_KEY) === "1") return;
      const ios = isIosDevice();
      const installed = isStandaloneMode();
      if (!pushSupported()) {
        if (alive && ios && !installed) setState("ios");
        return;
      }
      if (Notification.permission === "granted") {
        const sub = await currentSubscription();
        if (sub) return;
      }
      if (Notification.permission === "denied") return;
      if (ios && !installed) {
        if (alive) setState("ios");
        return;
      }
      if (alive) setState("offer");
    })();
    return () => {
      alive = false;
    };
  }, []);

  if (state === "hidden" || state === "done") return null;

  function dismiss() {
    window.localStorage.setItem(DISMISS_KEY, "1");
    setState("hidden");
  }

  return (
    <div className="flex w-full max-w-full flex-col gap-2 rounded-2xl border border-border bg-surface px-3 py-2.5">
      <div className="flex items-start gap-2">
        <Bell className="mt-0.5 size-4 shrink-0 text-primary" />
        <div className="min-w-0 flex-1">
          {state === "offer" ? (
            <>
              <p className="text-[13px] font-medium text-foreground">🔔 Ativar notificações</p>
              <p className="text-[12px] break-words text-muted-foreground">
                Receba um aviso quando o suporte responder ou quando sair novidade.
              </p>
            </>
          ) : (
            <>
              <p className="text-[13px] font-medium text-foreground">🔔 Notificações no iPhone</p>
              <p className="text-[12px] break-words text-muted-foreground">
                Toque em Compartilhar → Adicionar à Tela de Início, abra o app pelo ícone e ative as
                notificações por lá.
              </p>
            </>
          )}
          {error ? <p className="mt-1 text-[12px] text-destructive">{error}</p> : null}
        </div>
        <button
          type="button"
          aria-label="Fechar aviso"
          onClick={dismiss}
          className="flex size-7 shrink-0 items-center justify-center rounded-full text-muted-foreground hover:bg-muted"
        >
          <X className="size-4" />
        </button>
      </div>

      {state === "offer" ? (
        <button
          type="button"
          disabled={busy}
          onClick={async () => {
            setBusy(true);
            setError(null);
            try {
              const keys = await subscribeToPush();
              await save({ data: keys });
              window.localStorage.setItem(DISMISS_KEY, "1");
              setState("done");
            } catch (err) {
              setError(err instanceof Error ? err.message : "Não consegui ativar.");
            } finally {
              setBusy(false);
            }
          }}
          className="self-start rounded-full bg-primary px-4 py-2 text-[13px] font-semibold text-primary-foreground disabled:opacity-50"
        >
          {busy ? "Ativando…" : "Ativar notificações"}
        </button>
      ) : null}
    </div>
  );
}
