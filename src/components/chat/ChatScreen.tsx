import { useEffect, useRef, useState, type ReactNode } from "react";
import { ChatHeader } from "./ChatHeader";
import { Composer } from "./Composer";
import { MessageBubble, TypingBubble, type ChatRole } from "./MessageBubble";
import { QuickActions } from "./QuickActions";
import { IDENTITY, type QuickAction } from "@/lib/dr/config";
import type { ChatAttachment } from "@/lib/dr/attachments";

export type ChatMessage = {
  id: string;
  role: ChatRole;
  content: string;
  createdAt: string;
  attachments?: ChatAttachment[];
  human?: boolean;
};

export function formatTime(iso: string) {
  return new Date(iso).toLocaleTimeString("pt-BR", { hour: "2-digit", minute: "2-digit" });
}

export function ChatScreen({
  messages,
  actions,
  sending,
  error,
  headerActions,
  onSend,
  banner,
}: {
  messages: ChatMessage[];
  actions: QuickAction[];
  sending: boolean;
  error?: string | null;
  headerActions?: ReactNode;
  banner?: ReactNode;
  onSend: (text: string, intent?: string, file?: File | null) => void;
}) {
  const endRef = useRef<HTMLDivElement>(null);
  const [autoScroll, setAutoScroll] = useState(true);

  useEffect(() => {
    if (autoScroll) endRef.current?.scrollIntoView({ behavior: "smooth", block: "end" });
  }, [messages, sending, autoScroll]);

  return (
    <div
      className="page-gradient flex min-h-[100dvh] w-full max-w-full items-stretch justify-center overflow-x-hidden sm:items-center sm:p-4"
      style={{
        paddingLeft: "env(safe-area-inset-left)",
        paddingRight: "env(safe-area-inset-right)",
      }}
    >
      <div className="flex h-[100dvh] max-h-[100dvh] w-full max-w-[480px] flex-col overflow-hidden bg-background sm:h-[min(92dvh,880px)] sm:rounded-3xl sm:border sm:border-border sm:shadow-2xl">
        <ChatHeader actions={headerActions} />

        <main
          onScroll={(e) => {
            const el = e.currentTarget;
            setAutoScroll(el.scrollHeight - el.scrollTop - el.clientHeight < 120);
          }}
          className="flex-1 overflow-y-auto overflow-x-hidden"
        >
          <div className="flex w-full flex-col gap-3.5 px-3 py-4">
            {banner}
            {messages.map((m, i) => (
              <MessageBubble
                key={m.id}
                role={m.role}
                content={m.content}
                time={formatTime(m.createdAt)}
                attachments={m.attachments ?? []}
                human={m.human ?? false}
                onReply={i === messages.length - 1 && !sending ? (text) => onSend(text) : undefined}
              />
            ))}
            {sending ? <TypingBubble /> : null}
            <div ref={endRef} />
          </div>
        </main>

        <div className="shrink-0 border-t border-border bg-surface/95 backdrop-blur">
          {error ? (
            <p className="px-4 pt-2 text-xs text-destructive" role="alert">
              {error}
            </p>
          ) : null}
          <QuickActions
            actions={actions}
            disabled={sending}
            onSelect={(a) => onSend(a.label, a.intent)}
          />
          <Composer disabled={sending} onSend={(text, file) => onSend(text, undefined, file)} />
          <p className="pb-[max(0.6rem,env(safe-area-inset-bottom))] text-center text-[11px] text-muted-foreground">
            {IDENTITY.footerNote}
          </p>
        </div>
      </div>
    </div>
  );
}
