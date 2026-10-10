import { useEffect, useState } from "react";

/** Aviso discreto quando uma versão nova do app foi instalada. */
export function UpdateBanner() {
  const [show, setShow] = useState(false);
  useEffect(() => {
    const on = () => setShow(true);
    window.addEventListener("app-sw-update", on);
    return () => window.removeEventListener("app-sw-update", on);
  }, []);
  if (!show) return null;
  return (
    <button
      type="button"
      onClick={() => window.location.reload()}
      className="fixed left-1/2 top-[max(0.75rem,env(safe-area-inset-top))] z-50 -translate-x-1/2 rounded-full border border-border bg-surface px-4 py-2 text-xs font-medium text-foreground shadow-lg"
    >
      Nova versão disponível, toque para atualizar
    </button>
  );
}
