import { useState } from "react";
import { Check, Copy } from "lucide-react";
import { cn } from "@/lib/utils";

/** Texto selecionável com botão de copiar e confirmação "copiado". */
export function CopyText({
  value,
  label,
  className,
}: {
  value: string | null | undefined;
  label: string;
  className?: string;
}) {
  const [copied, setCopied] = useState(false);
  if (!value) return <span className={cn("truncate", className)}>—</span>;
  return (
    <span className="inline-flex min-w-0 max-w-full items-center gap-1">
      <span className={cn("cursor-text select-text truncate", className)}>{value}</span>
      <button
        type="button"
        aria-label={`Copiar ${label}`}
        title={copied ? "Copiado" : `Copiar ${label}`}
        onClick={async (e) => {
          e.stopPropagation();
          try {
            await navigator.clipboard.writeText(value);
          } catch {
            const t = document.createElement("textarea");
            t.value = value;
            document.body.appendChild(t);
            t.select();
            document.execCommand("copy");
            t.remove();
          }
          setCopied(true);
          setTimeout(() => setCopied(false), 1500);
        }}
        className="inline-flex h-6 shrink-0 items-center gap-1 rounded-md px-1.5 text-[10px] font-medium text-muted-foreground hover:bg-muted hover:text-foreground"
      >
        {copied ? <Check className="size-3 text-success-foreground" /> : <Copy className="size-3" />}
        {copied ? "copiado" : null}
      </button>
    </span>
  );
}
