import { createFileRoute, useNavigate } from "@tanstack/react-router";
import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { LogOut, SquarePen } from "lucide-react";
import { useEffect, useMemo, useState } from "react";
import { ChatScreen, type ChatMessage } from "@/components/chat/ChatScreen";
import { PushPrompt } from "@/components/chat/PushPrompt";
import { supabase } from "@/integrations/supabase/client";
import { IDENTITY, PRODUTO_PADRAO, actionsForProducts, type Product } from "@/lib/dr/config";
import { getChatBootstrap, sendChatMessage, startNewConversation } from "@/lib/dr/chat.functions";
import { touchAccessSession } from "@/lib/dr/access.functions";
import { getDeviceId, throttledPing } from "@/lib/dr/device";
import { mascararEmail } from "@/lib/dr/identificacao";
import { ENTRADA } from "@/oferta/entrada";

export const Route = createFileRoute("/_authenticated/chat")({
  head: () => ({
    meta: [
      { title: `Chat — ${IDENTITY.name}` },
      {
        name: "description",
        content: IDENTITY.pageDescription,
      },
      { property: "og:title", content: `Chat — ${IDENTITY.name}` },
      {
        property: "og:description",
        content: IDENTITY.pageDescription,
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary" },
    ],
  }),
  component: ChatRoute,
});

function ChatRoute() {
  const navigate = useNavigate();
  const queryClient = useQueryClient();
  const bootstrap = useServerFn(getChatBootstrap);
  const send = useServerFn(sendChatMessage);
  const touch = useServerFn(touchAccessSession);
  const newConversation = useServerFn(startNewConversation);
  const [resetting, setResetting] = useState(false);

  async function handleNewConversation() {
    if (resetting || sending) return;
    if (!window.confirm("Começar uma nova conversa do zero?")) return;
    setResetting(true);
    try {
      await newConversation();
      setPending([]);
      setSendError(null);
      await queryClient.invalidateQueries({ queryKey: ["chat-bootstrap"] });
    } catch {
      setSendError("Não consegui abrir uma nova conversa. Tente de novo.");
    } finally {
      setResetting(false);
    }
  }

  const { data, isLoading, error } = useQuery({
    queryKey: ["chat-bootstrap"],
    queryFn: () => bootstrap(),
    retry: 1,
    // Mensagens da equipe chegam sem recarregar; mais rápido durante atendimento humano.
    refetchInterval: (q) => (q.state.data?.humanTakeover ? 4000 : 20000),
    refetchIntervalInBackground: false,
  });

  useEffect(() => {
    const deviceId = getDeviceId();
    if (!deviceId) return;
    let stopped = false;
    const ping = () => {
      if (stopped || document.visibilityState !== "visible") return;
      throttledPing(() => touch({ data: { deviceId } }));
    };
    ping();
    const timer = window.setInterval(ping, 60_000);
    document.addEventListener("visibilitychange", ping);
    return () => {
      stopped = true;
      window.clearInterval(timer);
      document.removeEventListener("visibilitychange", ping);
    };
  }, [touch]);

  const [pending, setPending] = useState<ChatMessage[]>([]);
  const [sending, setSending] = useState(false);
  const [sendError, setSendError] = useState<string | null>(null);

  useEffect(() => {
    setPending([]);
  }, [data?.conversationId]);

  const messages = useMemo<ChatMessage[]>(() => {
    const welcome: ChatMessage = {
      id: "welcome",
      role: "assistant",
      content: IDENTITY.welcome,
      createdAt: new Date().toISOString(),
    };
    const stored = (data?.messages ?? []).map((m) => ({
      id: m.id,
      role: m.role,
      content: m.content,
      createdAt: m.createdAt,
      attachments: m.attachments,
      human: m.human,
    }));
    return [welcome, ...stored, ...pending];
  }, [data?.messages, pending]);

  const actions = actionsForProducts((data?.products ?? [PRODUTO_PADRAO]) as Product[]);

  async function handleSend(text: string, intent?: string, file?: File | null) {
    if (!data?.conversationId) return;
    setSendError(null);
    const optimistic: ChatMessage = {
      id: `tmp-${Date.now()}`,
      role: "user",
      content: text,
      createdAt: new Date().toISOString(),
    };
    setPending((p) => [...p, optimistic]);
    setSending(true);
    try {
      let attachment: {
        path: string;
        name: string;
        size: number;
        mimeType: string;
      } | null = null;

      if (file) {
        const { data: auth } = await supabase.auth.getUser();
        const uid = auth.user?.id;
        if (!uid) throw new Error("401");
        const ext = (file.name.split(".").pop() ?? "jpg").toLowerCase().slice(0, 5);
        const path = `${uid}/${crypto.randomUUID()}.${ext}`;
        const { error: uploadError } = await supabase.storage
          .from("uploads")
          .upload(path, file, { contentType: file.type, upsert: false });
        if (uploadError) throw new Error("upload");
        attachment = { path, name: file.name, size: file.size, mimeType: file.type };
        setPending((p) =>
          p.map((m) =>
            m.id === optimistic.id
              ? { ...m, attachments: [{ kind: "image", path, name: file.name, size: file.size }] }
              : m,
          ),
        );
      }

      await send({
        data: {
          conversationId: data.conversationId,
          content: text,
          intent: intent ?? null,
          deviceId: getDeviceId() || null,
          attachment,
        },
      });
      await queryClient.invalidateQueries({ queryKey: ["chat-bootstrap"] });
      setPending([]);
    } catch (err) {
      setPending((p) => p.filter((m) => m.id !== optimistic.id));
      const message = err instanceof Error ? err.message : "";
      setSendError(
        /401|unauthor/i.test(message)
          ? "Sua sessão expirou. Entre novamente para continuar."
          : /upload/i.test(message)
            ? "Não consegui enviar sua imagem. Tente novamente com um arquivo menor."
            : "Não consegui enviar sua mensagem. Verifique sua conexão e tente de novo.",
      );
    } finally {
      setSending(false);
    }
  }

  async function handleSignOut() {
    // Lembra o e-mail de entrada antes de sair (escondido): ajuda quem entrou pelo CPF, nome ou WhatsApp.
    const email = data?.profile.email;
    if (email && !window.confirm(ENTRADA.confirmarSaida.replace("[email]", mascararEmail(email)))) return;
    await queryClient.cancelQueries();
    queryClient.clear();
    await supabase.auth.signOut();
    navigate({ to: "/auth", replace: true });
  }

  return (
    <ChatScreen
      messages={messages}
      actions={actions}
      sending={sending || isLoading || resetting}
      error={
        sendError ?? (error ? "Não consegui carregar seu histórico. Recarregue a página." : null)
      }
      headerActions={
        <div className="flex items-center gap-1">
          <button
            type="button"
            onClick={handleNewConversation}
            disabled={resetting}
            aria-label="Nova conversa"
            title="Nova conversa"
            className="flex size-10 items-center justify-center rounded-full text-header-foreground/80 transition-colors hover:bg-header-foreground/15 hover:text-header-foreground disabled:opacity-50"
          >
            <SquarePen className="size-4" />
          </button>
          <button
            type="button"
            onClick={handleSignOut}
            aria-label="Sair"
            className="flex size-10 items-center justify-center rounded-full text-header-foreground/80 transition-colors hover:bg-header-foreground/15 hover:text-header-foreground"
          >
            <LogOut className="size-4" />
          </button>
        </div>
      }
      banner={<PushPrompt />}
      onSend={handleSend}
    />
  );
}
