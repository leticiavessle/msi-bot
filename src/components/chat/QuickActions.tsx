import type { QuickAction } from "@/lib/dr/config";

export function QuickActions({
  actions,
  disabled,
  onSelect,
}: {
  actions: QuickAction[];
  disabled?: boolean;
  onSelect: (action: QuickAction) => void;
}) {
  if (actions.length === 0) return null;

  return (
    <div className="flex flex-wrap justify-center gap-1.5 px-3 pb-2 pt-2">
      {actions.map((action) => (
        <button
          key={action.intent}
          type="button"
          disabled={disabled}
          onClick={() => onSelect(action)}
          className="rounded-full border border-border bg-chip px-3 py-1.5 text-[12px] font-medium leading-snug text-chip-foreground transition-colors hover:bg-accent hover:text-accent-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring disabled:opacity-50"
        >
          {action.label}
        </button>
      ))}
    </div>
  );
}
