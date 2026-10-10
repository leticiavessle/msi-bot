import { cn } from "@/lib/utils";
import { IDENTITY, MARCA } from "@/lib/dr/config";

import { AttachmentList } from "./Attachments";
import type { ChatAttachment } from "@/lib/dr/attachments";
import { Message, MessageContent, MessageResponse } from "@/components/ai-elements/message";
import { formatAssistantMessage } from "@/lib/dr/chat-format";

export type ChatRole = "assistant" | "user";

function AssistantAvatar() {
  return (
    <img
      src={MARCA.avatarUrl}
      alt={IDENTITY.name}
      loading="lazy"
      className="mt-auto size-7 shrink-0 rounded-full object-cover"
    />
  );
}

const URL_RE = /(https?:\/\/[^\s]+)/g;
const BOLD_RE = /(\*\*[^*]+\*\*)/g;

function renderInline(text: string, isUser: boolean, keyPrefix: string) {
  return text.split(BOLD_RE).map((chunk, i) => {
    const bold = chunk.startsWith("**") && chunk.endsWith("**") && chunk.length > 4;
    const plain = bold ? chunk.slice(2, -2) : chunk;
    const inner = plain.split(URL_RE).map((part, j) =>
      URL_RE.test(part) ? (
        <a
          key={`${keyPrefix}-${i}-${j}`}
          href={part}
          target="_blank"
          rel="noreferrer noopener"
          className={cn(
            "break-all font-semibold underline underline-offset-2",
            isUser ? "" : "text-primary",
          )}
        >
          {part}
        </a>
      ) : (
        <span key={`${keyPrefix}-${i}-${j}`}>{part}</span>
      ),
    );
    return bold ? (
      <strong key={`${keyPrefix}-${i}`} className="font-semibold">
        {inner}
      </strong>
    ) : (
      <span key={`${keyPrefix}-${i}`}>{inner}</span>
    );
  });
}

function AssistantContent({ text }: { text: string }) {
  return (
    <MessageResponse
      linkSafety={{ enabled: false }}
      components={{
        a: ({ href, children }) => (
          <a href={href} target="_blank" rel="noopener noreferrer" className="break-all">
            {children}
          </a>
        ),
      }}
      className="break-words leading-[1.72] [overflow-wrap:anywhere] [&_a]:font-semibold [&_a]:text-primary [&_a]:underline [&_a]:underline-offset-2 [&_li]:my-2 [&_ol]:my-3 [&_ol]:space-y-2 [&_ol]:pl-5 [&_p]:my-3.5 [&_ul]:my-3 [&_ul]:space-y-2 [&_ul]:pl-5"
    >
      {formatAssistantMessage(text)}
    </MessageResponse>
  );
}

export function MessageBubble({
  role,
  content,
  time,
  attachments = [],
  onReply,
  human = false,
}: {
  human?: boolean;
  role: ChatRole;
  content: string;
  time?: string;
  attachments?: ChatAttachment[];
  onReply?: ((text: string) => void) | undefined;
}) {
  const isUser = role === "user";
  const lessonAttachments = attachments.filter((attachment) => attachment.kind === "lesson");
  const inlineAttachments = attachments.filter((attachment) => attachment.kind !== "lesson");

  return (
    <Message
      from={role}
      className={cn(
        "max-w-full gap-2",
        isUser ? "ml-auto flex-row justify-end" : "flex-row items-end justify-start",
      )}
    >
      {!isUser && <AssistantAvatar />}

      <div className={cn("flex max-w-[85%] flex-col gap-2", isUser && "ml-auto items-end")}>
        <MessageContent
          className={cn(
            "max-w-full gap-0 overflow-hidden rounded-2xl px-4 text-[14.5px] leading-[1.72]",
            isUser
              ? "ml-auto rounded-br-md bg-bubble-user py-2.5 text-bubble-user-foreground"
              : "rounded-bl-md border border-border bg-bubble-bot py-3.5 text-bubble-bot-foreground shadow-[0_1px_2px_rgb(0_0_0/0.06)]",
          )}
        >
          {human ? (
            <span className="mb-1.5 block text-[11px] font-semibold uppercase tracking-wide text-primary">
              Atendimento humano · {MARCA.nomeEquipe}
            </span>
          ) : null}
          {isUser ? (
            <p className="whitespace-pre-wrap break-words leading-[1.72] [overflow-wrap:anywhere]">
              {renderInline(content, true, "u")}
            </p>
          ) : human ? (
            content ? (
              <p className="whitespace-pre-wrap break-words [overflow-wrap:anywhere]">{content}</p>
            ) : null
          ) : (
            <AssistantContent text={content} />
          )}
          <AttachmentList attachments={inlineAttachments} onReply={onReply} />
          {time ? (
            <span
              className={cn(
                "mt-2 block text-right text-[10px] leading-none",
                isUser ? "text-bubble-user-foreground/60" : "text-muted-foreground",
              )}
            >
              {time}
            </span>
          ) : null}
        </MessageContent>
        {lessonAttachments.length > 0 ? (
          <MessageContent className="w-full max-w-full rounded-2xl rounded-bl-md border border-border bg-bubble-bot px-3 py-3 text-bubble-bot-foreground shadow-[0_1px_2px_rgb(0_0_0/0.06)]">
            <AttachmentList attachments={lessonAttachments} onReply={onReply} />
          </MessageContent>
        ) : null}
      </div>
    </Message>
  );
}

export function TypingBubble() {
  return (
    <div className="flex w-full justify-start gap-2">
      <AssistantAvatar />

      <div className="rounded-2xl rounded-bl-md border border-border bg-bubble-bot px-4 py-3">
        <span className="flex items-center gap-1">
          {[0, 1, 2].map((i) => (
            <span
              key={i}
              className="size-1.5 animate-bounce rounded-full bg-muted-foreground"
              style={{ animationDelay: `${i * 0.15}s` }}
            />
          ))}
        </span>
      </div>
    </div>
  );
}
