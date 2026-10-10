import { useState, type ReactNode } from "react";
import { Link } from "@tanstack/react-router";
import { ArrowLeft, Menu, X } from "lucide-react";
import { cn } from "@/lib/utils";
import { IDENTITY } from "@/lib/dr/config";

export type NavItem<T extends string> = {
  key: T;
  label: string;
  icon: ReactNode;
  badge?: number;
};

export function AdminShell<T extends string>({
  items,
  active,
  onSelect,
  title,
  description,
  online,
  email,
  children,
}: {
  items: NavItem<T>[];
  active: T;
  onSelect: (key: T) => void;
  title: string;
  description?: string;
  online?: number;
  email?: string | null;
  children: ReactNode;
}) {
  const [open, setOpen] = useState(false);

  const nav = (
    <nav className="flex flex-col gap-1">
      {items.map((item) => (
        <button
          key={item.key}
          type="button"
          onClick={() => {
            onSelect(item.key);
            setOpen(false);
          }}
          className={cn(
            "flex min-h-10 items-center gap-3 rounded-xl px-3 text-sm font-medium transition-colors",
            active === item.key
              ? "bg-primary text-primary-foreground shadow-sm"
              : "text-muted-foreground hover:bg-muted hover:text-foreground",
          )}
        >
          <span className="flex size-5 items-center justify-center">{item.icon}</span>
          <span className="flex-1 text-left">{item.label}</span>
          {item.badge ? (
            <span
              className={cn(
                "rounded-full px-1.5 text-[10px] font-bold tabular-nums",
                active === item.key
                  ? "bg-primary-foreground/20"
                  : "bg-destructive/12 text-destructive",
              )}
            >
              {item.badge}
            </span>
          ) : null}
        </button>
      ))}
    </nav>
  );

  return (
    <div className="flex h-[100dvh] overflow-hidden bg-background">
      <aside className="sticky top-0 hidden h-[100dvh] w-64 shrink-0 flex-col border-r border-border/70 bg-sidebar px-3 py-4 lg:flex">
        <Brand />
        <div className="mt-5 flex-1 overflow-y-auto">{nav}</div>
        <Link
          to="/chat"
          className="mt-3 flex min-h-10 items-center gap-2 rounded-xl px-3 text-sm font-medium text-muted-foreground hover:bg-muted hover:text-foreground"
        >
          <ArrowLeft className="size-4" /> Voltar ao chat
        </Link>
      </aside>

      {open ? (
        <div className="fixed inset-0 z-50 lg:hidden">
          <button
            type="button"
            aria-label="Fechar menu"
            onClick={() => setOpen(false)}
            className="absolute inset-0 bg-foreground/40"
          />
          <div className="absolute inset-y-0 left-0 flex w-72 flex-col border-r border-border bg-sidebar px-3 pb-[max(1rem,env(safe-area-inset-bottom))] pt-[max(1rem,env(safe-area-inset-top))]">
            <div className="flex items-center justify-between">
              <Brand />
              <button
                type="button"
                onClick={() => setOpen(false)}
                aria-label="Fechar menu"
                className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted"
              >
                <X className="size-4" />
              </button>
            </div>
            <div className="mt-5 flex-1 overflow-y-auto">{nav}</div>
            <Link
              to="/chat"
              className="mt-3 flex min-h-10 items-center gap-2 rounded-xl px-3 text-sm font-medium text-muted-foreground"
            >
              <ArrowLeft className="size-4" /> Voltar ao chat
            </Link>
          </div>
        </div>
      ) : null}

      <div className="flex min-h-0 min-w-0 flex-1 flex-col overflow-hidden">
        <header className="sticky top-0 z-30 flex items-center gap-3 border-b border-border/70 bg-background/85 px-[max(1rem,env(safe-area-inset-left))] pb-3 pt-[max(0.75rem,env(safe-area-inset-top))] backdrop-blur-md sm:px-6">
          <button
            type="button"
            onClick={() => setOpen(true)}
            aria-label="Abrir menu"
            className="flex size-9 items-center justify-center rounded-xl border border-border lg:hidden"
          >
            <Menu className="size-4" />
          </button>
          <div className="min-w-0 flex-1">
            <h1 className="truncate text-sm font-semibold">{title}</h1>
            {description ? (
              <p className="truncate text-[11px] text-muted-foreground">{description}</p>
            ) : null}
          </div>
          {typeof online === "number" ? (
            <span className="hidden items-center gap-1.5 rounded-full border border-border px-3 py-1 text-[11px] font-medium sm:inline-flex">
              <span className="size-2 rounded-full bg-online" />
              {online} online
            </span>
          ) : null}
          {email ? (
            <span className="hidden max-w-[200px] truncate text-[11px] text-muted-foreground md:inline">
              {email}
            </span>
          ) : null}
        </header>

        <main className="min-h-0 flex-1 overflow-y-auto overscroll-contain">
          <div className="mx-auto w-full max-w-6xl px-4 pb-[max(1.5rem,env(safe-area-inset-bottom))] pt-6 sm:px-6">
            {children}
          </div>
        </main>
      </div>
    </div>
  );
}

function Brand() {
  return (
    <div className="flex items-center gap-2 px-2">
      <span className="flex size-8 items-center justify-center rounded-xl bg-primary text-sm font-bold text-primary-foreground">
        {IDENTITY.initials}
      </span>
      <div className="leading-tight">
        <p className="text-sm font-semibold">{IDENTITY.name}</p>
        <p className="text-[11px] text-muted-foreground">Painel administrativo</p>
      </div>
    </div>
  );
}
