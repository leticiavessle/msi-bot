import { BadgeCheck } from "lucide-react";
import type { ReactNode } from "react";
import { IDENTITY, MARCA } from "@/lib/dr/config";


export function ChatHeader({ actions }: { actions?: ReactNode }) {
  return (
    <header className="shrink-0 bg-header px-4 pb-2.5 pt-[max(0.7rem,env(safe-area-inset-top))] text-header-foreground">
      <div className="grid grid-cols-[auto_minmax(0,1fr)_auto] items-center gap-3">
        <div className="relative shrink-0">
          <img
            src={MARCA.avatarUrl}
            alt={IDENTITY.name}
            loading="eager"
            className="size-10 rounded-full object-cover ring-2 ring-primary/50"
          />
          <span className="absolute -bottom-0.5 -right-0.5 size-3 rounded-full border-2 border-header bg-online" />
        </div>

        <div className="min-w-0">
          <div className="flex items-center gap-1.5">
            <h1 className="truncate text-[15px] font-semibold leading-tight">{IDENTITY.name}</h1>
            <BadgeCheck className="size-3.5 shrink-0" aria-label="Perfil verificado" />
          </div>
          <p className="truncate text-[11.5px] leading-snug text-header-foreground/75">
            {IDENTITY.subtitle}
          </p>
        </div>

        {actions ? <div className="shrink-0">{actions}</div> : null}
      </div>

      <div className="mt-2 flex flex-wrap gap-1.5">
        {IDENTITY.badges.map((badge) => (
          <span
            key={badge}
            className="rounded-full bg-header-foreground/12 px-2.5 py-1 text-[11px] font-medium text-header-foreground/90"
          >
            {badge}
          </span>
        ))}
      </div>
    </header>
  );
}
