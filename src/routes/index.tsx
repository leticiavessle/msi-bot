import { createFileRoute, Link, useNavigate } from "@tanstack/react-router";
import { BadgeCheck, Lock, MessageCircle } from "lucide-react";
import { useEffect } from "react";
import { supabase } from "@/integrations/supabase/client";
import { IDENTITY, MARCA } from "@/lib/dr/config";

import { InstallBanner } from "@/components/pwa/InstallBanner";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: IDENTITY.name },
      {
        name: "description",
        content: IDENTITY.pageDescription,
      },
      { property: "og:title", content: IDENTITY.name },
      {
        property: "og:description",
        content: IDENTITY.pageDescription,
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Landing,
});

function Landing() {
  const navigate = useNavigate();

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      if (data.session) navigate({ to: "/chat", replace: true });
    });
  }, [navigate]);

  return (
    <main className="flex min-h-[100dvh] items-center justify-center bg-background px-4 pb-[max(2.5rem,env(safe-area-inset-bottom))] pt-[max(2.5rem,env(safe-area-inset-top))]">
      <div className="w-full max-w-md text-center">
        <img
          src={MARCA.avatarUrl}
          alt={IDENTITY.name}
          className="mx-auto size-16 rounded-full object-cover ring-2 ring-primary/40"
        />

        <div className="mt-4 flex items-center justify-center gap-1.5">
          <h1 className="text-xl font-semibold">{IDENTITY.name}</h1>
          <BadgeCheck className="size-5 text-primary" aria-label="Perfil verificado" />
        </div>
        <p className="mt-1 text-sm text-muted-foreground">{IDENTITY.subtitle}</p>

        <div className="mt-3 flex items-center justify-center gap-4 text-[11px] text-muted-foreground">
          <span className="inline-flex items-center gap-1">
            <span className="size-1.5 rounded-full bg-online" /> {IDENTITY.onlineLabel}
          </span>
          <span className="inline-flex items-center gap-1">
            <Lock className="size-3" /> {IDENTITY.secureLabel}
          </span>
        </div>

        <div className="mt-8 rounded-2xl rounded-bl-md bg-bubble-bot p-4 text-left text-[15px] leading-relaxed text-bubble-bot-foreground">
          {IDENTITY.welcome}
        </div>

        <Link
          to="/auth"
          className="mt-6 inline-flex min-h-12 w-full items-center justify-center gap-2 rounded-2xl bg-primary px-5 text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90"
        >
          <MessageCircle className="size-4" />
          Entrar no chat
        </Link>

        <InstallBanner className="mt-5" />

        <p className="mt-4 text-[11px] leading-snug text-muted-foreground/80">
          {IDENTITY.disclaimer}
        </p>
      </div>
    </main>
  );
}
