import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useRef, useState } from "react";
import { Paperclip, Send, UserRound, X } from "lucide-react";
import {
  getConversationLive,
  releaseConversation,
  sendStaffMessage,
  takeOverConversation,
} from "@/lib/dr/takeover.functions";
import { cn } from "@/lib/utils";
import { MARCA } from "@/lib/dr/config";

function fmt(iso: string) {
  return new Date(iso).toLocaleString("pt-BR", { timeZone: "America/Sao_Paulo" });
}

async function toBase64(file: File) {
  const buf = new Uint8Array(await file.arrayBuffer());
  let bin = "";
  for (let i = 0; i < buf.length; i += 0x8000) bin += String.fromCharCode(...buf.subarray(i, i + 0x8000));
  return btoa(bin);
}

/** Mensagens de uma conversa + atendimento humano (assumir, responder, devolver ao bot). */
export function ConversationMessages({ conversationId }: { conversationId: string }) {
  const liveFn = useServerFn(getConversationLive);
  const takeFn = useServerFn(takeOverConversation);
  const releaseFn = useServerFn(releaseConversation);
  const sendFn = useServerFn(sendStaffMessage);
  const qc = useQueryClient();
  const [text, setText] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [busy, setBusy] = useState(false);
  const [err, setErr] = useState<string | null>(null);
  const fileRef = useRef<HTMLInputElement>(null);

  const key = ["admin-conversation-live", conversationId];
  const { data, isLoading, isError } = useQuery({
    queryKey: key,
    queryFn: () => liveFn({ data: { conversationId } }),
    refetchInterval: (q) => (q.state.data?.takeover ? 3000 : false),
  });
  const messages = data?.messages ?? [];
  const takeover = data?.takeover ?? null;

  async function refresh() {
    await qc.invalidateQueries({ queryKey: key });
    await qc.invalidateQueries({ queryKey: ["admin-conversations"] });
    await qc.invalidateQueries({ queryKey: ["admin-people"] });
  }

  async function run(fn: () => Promise<unknown>) {
    setBusy(true);
    setErr(null);
    try {
      await fn();
      await refresh();
    } catch (e) {
      setErr(e instanceof Error ? e.message : "Algo deu errado. Tente de novo.");
    } finally {
      setBusy(false);
    }
  }

  async function send() {
    if (!text.trim() && !file) return;
    if (file && file.size > 10 * 1024 * 1024) {
      setErr("Arquivo maior que 10 MB.");
      return;
    }
    await run(async () => {
      await sendFn({
        data: {
          conversationId,
          content: text,
          file: file ? { name: file.name, mimeType: file.type || "application/octet-stream", base64: await toBase64(file) } : null,
        },
      });
      setText("");
      setFile(null);
      if (fileRef.current) fileRef.current.value = "";
    });
  }

  return (
    <div className="border-t border-border/70 bg-muted/50">
      <div className="flex flex-wrap items-center gap-2 border-b border-border/70 px-4 py-2">
        {takeover ? (
          <>
            <span className="inline-flex items-center gap-1.5 rounded-full bg-primary px-2.5 py-1 text-[11px] font-semibold text-primary-foreground">
              <UserRound className="size-3.5" /> Em atendimento humano
            </span>
            <span className="text-[11px] text-muted-foreground">
              {takeover.name} · desde {fmt(takeover.since)}
            </span>
            <button
              type="button"
              disabled={busy}
              onClick={() => {
                if (window.confirm("Devolver esta conversa ao bot? Ele volta a responder a aluna."))
                  run(() => releaseFn({ data: { conversationId } }));
              }}
              className="ml-auto min-h-9 rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted disabled:opacity-50"
            >
              Devolver ao bot
            </button>
          </>
        ) : (
          <>
            <span className="text-[11px] text-muted-foreground">O bot está respondendo esta conversa.</span>
            <button
              type="button"
              disabled={busy}
              onClick={() => run(() => takeFn({ data: { conversationId } }))}
              className="ml-auto min-h-9 rounded-xl bg-primary px-3 text-xs font-medium text-primary-foreground disabled:opacity-50"
            >
              Assumir conversa
            </button>
          </>
        )}
      </div>

      <div className="flex max-h-[32rem] flex-col gap-2 overflow-y-auto p-4">
        {isLoading ? <p className="text-xs text-muted-foreground">Carregando mensagens…</p> : null}
        {isError ? (
          <p className="text-xs text-destructive">Não consegui carregar as mensagens desta conversa.</p>
        ) : null}
        {!isLoading && !isError && messages.length === 0 ? (
          <p className="rounded-xl border border-dashed border-border p-3 text-xs text-muted-foreground">
            Esta conversa não tem nenhuma mensagem. O aluno abriu o chat, mas não chegou a escrever.
          </p>
        ) : null}
        {messages.length > 0 ? (
          <p className="text-[10px] text-muted-foreground">{messages.length} mensagem(ns)</p>
        ) : null}
        {messages.map((m) => (
          <div
            key={m.id}
            className={cn(
              "max-w-[85%] select-text whitespace-pre-wrap rounded-2xl px-3 py-2 text-xs leading-relaxed",
              m.role === "user"
                ? "self-end rounded-br-sm bg-primary text-primary-foreground"
                : m.human
                  ? "self-start rounded-bl-sm border-2 border-primary/60 bg-surface"
                  : "self-start rounded-bl-sm border border-border bg-surface",
            )}
          >
            <p className="mb-1 text-[10px] opacity-70">
              {m.human ? `Atendimento humano · ${m.human.name} · ` : ""}
              {fmt(m.created_at)}
            </p>
            {m.content}
            {m.files.map((f, i) =>
              f.url && f.kind === "image" ? (
                <a key={i} href={f.url} target="_blank" rel="noreferrer" className="mt-2 block">
                  <img src={f.url} alt={f.name} className="max-h-48 rounded-lg" />
                </a>
              ) : (
                <a key={i} href={f.url ?? undefined} target="_blank" rel="noreferrer" className="mt-2 block underline">
                  {f.name}
                </a>
              ),
            )}
          </div>
        ))}
      </div>

      {takeover ? (
        <div className="flex flex-col gap-2 border-t border-border/70 p-3">
          {file ? (
            <span className="inline-flex w-fit items-center gap-2 rounded-lg border border-border px-2 py-1 text-[11px]">
              {file.name}
              <button type="button" aria-label="Remover anexo" onClick={() => setFile(null)}>
                <X className="size-3.5" />
              </button>
            </span>
          ) : null}
          <div className="flex items-end gap-2">
            <input
              ref={fileRef}
              type="file"
              className="hidden"
              onChange={(e) => setFile(e.target.files?.[0] ?? null)}
            />
            <button
              type="button"
              aria-label="Anexar imagem ou arquivo"
              onClick={() => fileRef.current?.click()}
              className="flex size-10 shrink-0 items-center justify-center rounded-xl border border-border hover:bg-muted"
            >
              <Paperclip className="size-4" />
            </button>
            <textarea
              value={text}
              onChange={(e) => setText(e.target.value)}
              rows={2}
              placeholder="Escreva a mensagem para a aluna…"
              className="min-h-10 flex-1 resize-y rounded-xl border border-border bg-background px-3 py-2 text-sm"
            />
            <button
              type="button"
              disabled={busy || (!text.trim() && !file)}
              onClick={send}
              className="flex h-10 shrink-0 items-center gap-1.5 rounded-xl bg-primary px-3 text-xs font-medium text-primary-foreground disabled:opacity-50"
            >
              <Send className="size-4" /> Enviar
            </button>
          </div>
          <p className="text-[10px] text-muted-foreground">
            A pessoa vê como "Atendimento humano · {MARCA.nomeEquipe}". O bot não responde enquanto a conversa estiver assumida.
          </p>
        </div>
      ) : null}
      {err ? <p className="px-4 pb-3 text-xs text-destructive">{err}</p> : null}
    </div>
  );
}
