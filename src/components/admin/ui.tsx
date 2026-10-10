import type { ReactNode } from "react";
import { cn } from "@/lib/utils";

/** Cartão base do painel: superfície branca, borda suave e sombra discreta. */
export function Panel({ className, children }: { className?: string; children: ReactNode }) {
  return (
    <section
      className={cn(
        "rounded-2xl border border-border/70 bg-surface shadow-[0_1px_2px_oklch(0_0_0/0.04),0_8px_24px_-16px_oklch(0_0_0/0.25)]",
        className,
      )}
    >
      {children}
    </section>
  );
}

export function SectionHeader({
  title,
  description,
  action,
}: {
  title: string;
  description?: string;
  action?: ReactNode;
}) {
  return (
    <div className="mb-5 flex flex-wrap items-end justify-between gap-3">
      <div className="min-w-0">
        <h2 className="text-xl font-semibold tracking-tight">{title}</h2>
        {description ? <p className="mt-1 text-sm text-muted-foreground">{description}</p> : null}
      </div>
      {action ? <div className="shrink-0">{action}</div> : null}
    </div>
  );
}

export function PanelHeader({
  title,
  hint,
  action,
}: {
  title: string;
  hint?: string;
  action?: ReactNode;
}) {
  return (
    <div className="flex flex-wrap items-center justify-between gap-2 border-b border-border/70 px-4 py-3">
      <div className="min-w-0">
        <h3 className="text-sm font-semibold">{title}</h3>
        {hint ? <p className="text-[11px] text-muted-foreground">{hint}</p> : null}
      </div>
      {action}
    </div>
  );
}

type Tone = "neutral" | "success" | "warning" | "danger" | "info" | "primary";

const TONES: Record<Tone, string> = {
  neutral: "bg-muted text-muted-foreground",
  success: "bg-success text-success-foreground",
  warning: "bg-warning text-warning-foreground",
  info: "bg-info text-info-foreground",
  danger: "bg-destructive/12 text-destructive",
  primary: "bg-accent text-accent-foreground",
};

export function StatusBadge({ tone = "neutral", children }: { tone?: Tone; children: ReactNode }) {
  return (
    <span
      className={cn(
        "inline-flex items-center gap-1 rounded-full px-2.5 py-0.5 text-[11px] font-semibold whitespace-nowrap",
        TONES[tone],
      )}
    >
      {children}
    </span>
  );
}

export function riskTone(level?: string | null): Tone {
  if (level === "critical" || level === "high") return "danger";
  if (level === "medium") return "warning";
  return "success";
}

export function statusTone(status?: string | null): Tone {
  if (status === "active" || status === "confirmed" || status === "resolved") return "success";
  if (status === "pending") return "warning";
  if (status === "blocked" || status === "refunded" || status === "canceled") return "danger";
  return "neutral";
}

export function StatCard({
  label,
  value,
  hint,
  icon,
  tone = "neutral",
}: {
  label: string;
  value: string | number;
  hint?: string;
  icon?: ReactNode;
  tone?: Tone;
}) {
  return (
    <Panel className="flex items-start gap-3 p-4">
      {icon ? (
        <span
          className={cn("flex size-9 shrink-0 items-center justify-center rounded-xl", TONES[tone])}
        >
          {icon}
        </span>
      ) : null}
      <div className="min-w-0">
        <p className="text-[11px] font-medium uppercase tracking-wide text-muted-foreground">
          {label}
        </p>
        <p className="mt-0.5 text-2xl font-semibold tabular-nums tracking-tight">{value}</p>
        {hint ? <p className="text-[11px] text-muted-foreground">{hint}</p> : null}
      </div>
    </Panel>
  );
}

export function EmptyState({
  title,
  description,
  icon,
  action,
}: {
  title: string;
  description?: string;
  icon?: ReactNode;
  action?: ReactNode;
}) {
  return (
    <div className="flex flex-col items-center justify-center gap-2 rounded-2xl border border-dashed border-border px-6 py-12 text-center">
      {icon ? <span className="text-muted-foreground">{icon}</span> : null}
      <p className="text-sm font-medium">{title}</p>
      {description ? <p className="max-w-sm text-xs text-muted-foreground">{description}</p> : null}
      {action}
    </div>
  );
}

export function SkeletonRows({ rows = 4 }: { rows?: number }) {
  return (
    <div className="flex flex-col gap-2">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="h-14 animate-pulse rounded-xl bg-muted" />
      ))}
    </div>
  );
}

export function Avatar({ name }: { name?: string | null }) {
  const initials = (name ?? "?")
    .trim()
    .split(/\s+/)
    .slice(0, 2)
    .map((p) => p[0]?.toUpperCase() ?? "")
    .join("");
  return (
    <span className="flex size-9 shrink-0 items-center justify-center rounded-full bg-accent text-xs font-semibold text-accent-foreground">
      {initials || "?"}
    </span>
  );
}

/** Classes compartilhadas de formulário para manter os campos consistentes. */
export const fieldClass =
  "min-h-10 rounded-xl border border-border bg-background px-3 text-sm outline-none transition-shadow placeholder:text-muted-foreground focus-visible:ring-2 focus-visible:ring-ring/40";

export const buttonPrimary =
  "inline-flex min-h-10 items-center justify-center gap-2 rounded-xl bg-primary px-4 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 disabled:opacity-50";

export const buttonGhost =
  "inline-flex min-h-10 items-center justify-center gap-2 rounded-xl border border-border bg-background px-4 text-sm font-medium transition-colors hover:bg-muted disabled:opacity-50";
