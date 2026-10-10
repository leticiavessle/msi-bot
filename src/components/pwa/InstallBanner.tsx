import { useState } from "react";
import { Download, Share, Plus, PlusSquare, X } from "lucide-react";
import { useInstallPrompt } from "@/lib/pwa/useInstallPrompt";
import { IDENTITY, MARCA } from "@/lib/dr/config";

export function InstallBanner({ className = "" }: { className?: string }) {
  const { visible, isIos, canPrompt, promptInstall, dismiss } = useInstallPrompt();
  const [showIosSteps, setShowIosSteps] = useState(false);

  // No iOS não há prompt nativo: o botão abre as instruções manuais.
  const showButton = canPrompt || isIos;
  if (!visible || !showButton) return null;

  return (
    <div
      className={`w-full rounded-2xl border border-border bg-surface p-3.5 text-left shadow-sm ${className}`}
    >
      <div className="grid grid-cols-[auto_minmax(0,1fr)_auto] items-start gap-3">
        <span className="grid size-9 shrink-0 place-items-center rounded-xl bg-primary/10 text-primary">
          <Download className="size-4" />
        </span>

        <div className="min-w-0">
          <p className="text-sm font-semibold leading-tight">Instale o {IDENTITY.name}</p>
          <p className="mt-0.5 text-xs leading-snug text-muted-foreground">
            Tenha acesso mais rápido e uma experiência melhor pelo celular.
          </p>
        </div>

        <button
          type="button"
          onClick={dismiss}
          aria-label="Fechar aviso de instalação"
          className="grid size-8 shrink-0 place-items-center rounded-full text-muted-foreground transition-colors hover:bg-muted"
        >
          <X className="size-4" />
        </button>
      </div>

      <button
        type="button"
        onClick={() => (isIos ? setShowIosSteps((v) => !v) : void promptInstall())}
        className="mt-3 inline-flex min-h-11 w-full items-center justify-center gap-2 rounded-full bg-primary px-4 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90"
      >
        <Download className="size-4" />
        Instalar aplicativo
      </button>

      {isIos && showIosSteps ? (
        <div className="mt-3 rounded-xl border border-border bg-background p-3">
          <p className="text-xs font-semibold">Instalar o {MARCA.nomeCurto} no iPhone</p>
          <ol className="mt-2 flex flex-col gap-2 text-xs leading-snug text-muted-foreground">
            <li className="flex items-start gap-2">
              <Share className="mt-0.5 size-3.5 shrink-0 text-primary" />
              <span>
                1. Toque no botão <strong className="text-foreground">Compartilhar</strong> do
                Safari.
              </span>
            </li>
            <li className="flex items-start gap-2">
              <PlusSquare className="mt-0.5 size-3.5 shrink-0 text-primary" />
              <span>
                2. Role as opções e selecione{" "}
                <strong className="text-foreground">Adicionar à Tela de Início</strong>.
              </span>
            </li>
            <li className="flex items-start gap-2">
              <Plus className="mt-0.5 size-3.5 shrink-0 text-primary" />
              <span>
                3. Toque em <strong className="text-foreground">Adicionar</strong> para concluir.
              </span>
            </li>
          </ol>
        </div>
      ) : null}
    </div>
  );
}
