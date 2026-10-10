import { useEffect, useState } from "react";
import { Download, ExternalLink, FileDown, Loader2 } from "lucide-react";
import { useServerFn } from "@tanstack/react-start";
import { supabase } from "@/integrations/supabase/client";
import { getMaterialDownloadUrl } from "@/lib/dr/materials.functions";
import { formatBytes, type ChatAttachment } from "@/lib/dr/attachments";
import { logUsageEvent } from "@/lib/dr/events.functions";

function FileAttachment({ path, name, size }: { path: string; name: string; size?: number | null | undefined }) {
  const [url, setUrl] = useState<string | null>(null);
  useEffect(() => {
    let active = true;
    supabase.storage
      .from("uploads")
      .createSignedUrl(path, 600, { download: name })
      .then(({ data }) => {
        if (active && data?.signedUrl) setUrl(data.signedUrl);
      });
    return () => {
      active = false;
    };
  }, [path, name]);
  return (
    <a
      href={url ?? undefined}
      target="_blank"
      rel="noreferrer noopener"
      className="flex items-center gap-2 rounded-xl border border-border bg-surface px-3 py-2 text-[13px] font-medium hover:bg-muted"
    >
      <FileDown className="size-4 shrink-0 text-primary" />
      <span className="min-w-0 flex-1 truncate">{name}</span>
      <span className="text-[11px] text-muted-foreground">{formatBytes(size)}</span>
    </a>
  );
}

function ImageAttachment({ path, name }: { path: string; name: string }) {
  const [url, setUrl] = useState<string | null>(null);

  useEffect(() => {
    let active = true;
    supabase.storage
      .from("uploads")
      .createSignedUrl(path, 600)
      .then(({ data }) => {
        if (active && data?.signedUrl) setUrl(data.signedUrl);
      });
    return () => {
      active = false;
    };
  }, [path]);

  if (!url) {
    return (
      <div className="flex h-40 w-full items-center justify-center rounded-xl border border-border bg-muted/40">
        <Loader2 className="size-4 animate-spin text-muted-foreground" />
      </div>
    );
  }

  return (
    <a href={url} target="_blank" rel="noreferrer noopener" className="block">
      <img
        src={url}
        alt={name}
        loading="lazy"
        className="max-h-56 w-full rounded-xl border border-border object-cover"
      />
    </a>
  );
}

function MaterialAttachment({
  materialId,
  name,
  size,
}: {
  materialId: string;
  name: string;
  size?: number | null | undefined;
}) {
  const getUrl = useServerFn(getMaterialDownloadUrl);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);

  async function download() {
    setLoading(true);
    setError(null);
    try {
      const res = await getUrl({ data: { materialId } });
      const priceNote =
        res.commercialOffer && res.priceState === "stale"
          ? "Confirme o valor atual no checkout."
          : res.commercialOffer && res.priceVerifiedAt
            ? `Condição verificada em ${res.priceVerifiedAt}. Confirme no checkout.`
            : null;
      setNotice(res.riskNotice ?? priceNote);
      if (res.kind === "contact" && res.contact) {
        setNotice(`${res.contact.type ?? "Contato"}: ${res.contact.value}`);
      } else if (res.url) {
        window.open(res.url, "_blank", "noopener");
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Não consegui gerar o link. Tente de novo.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <button
      type="button"
      onClick={download}
      disabled={loading}
      className="flex w-full items-center gap-3 rounded-xl border border-border bg-background px-3 py-2 text-left transition-colors hover:bg-muted disabled:opacity-60"
    >
      <span className="flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary/10 text-primary">
        <FileDown className="size-4" />
      </span>
      <span className="min-w-0 flex-1">
        <span className="block truncate text-[13px] font-semibold text-foreground">{name}</span>
        <span className="block text-[11px] text-muted-foreground">
          {error ?? notice ?? formatBytes(size) ?? "Baixar material"}
        </span>
      </span>
      {loading ? (
        <Loader2 className="size-4 shrink-0 animate-spin text-muted-foreground" />
      ) : (
        <Download className="size-4 shrink-0 text-muted-foreground" />
      )}
    </button>
  );
}

function SupportAttachment({
  url,
  label,
  note,
}: {
  url: string;
  label: string;
  note?: string | null | undefined;
}) {
  const logEvent = useServerFn(logUsageEvent);
  return (
    <a
      href={url}
      target="_blank"
      rel="noreferrer noopener"
      onClick={() =>
        void logEvent({
          data: { eventName: "support_clicked", metadata: { url, note: note ?? null } },
        })
      }
      className="flex w-full items-center gap-3 rounded-xl border border-primary/35 bg-primary/10 px-3 py-3 text-left transition-colors hover:bg-primary/15"
    >
      <span className="flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary text-primary-foreground">
        <ExternalLink className="size-4" />
      </span>
      <span className="min-w-0 flex-1">
        <span className="block text-[13px] font-semibold text-foreground">{label}</span>
        {note ? <span className="block text-[11px] text-muted-foreground">{note}</span> : null}
      </span>
    </a>
  );
}

function LessonAttachment({
  url,
  lessonId,
  title,
  location,
}: {
  url: string;
  lessonId: string;
  title: string;
  location: string;
}) {
  const logEvent = useServerFn(logUsageEvent);
  return (
    <a
      href={url}
      target="_blank"
      rel="noreferrer noopener"
      onClick={() =>
        void logEvent({
          data: { eventName: "aula_clicked", metadata: { url, lessonId, title } },
        })
      }
      className="flex w-full max-w-full items-center gap-3 rounded-xl border border-primary/35 bg-primary/10 px-3 py-3 text-left transition-colors hover:bg-primary/15"
    >
      <span className="flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary text-primary-foreground">
        <ExternalLink className="size-4" />
      </span>
      <span className="min-w-0 flex-1 [overflow-wrap:anywhere]">
        <span className="block text-[13px] font-semibold text-foreground">{title}</span>
        <span className="block text-[11px] text-muted-foreground">{location}</span>
      </span>
    </a>
  );
}

function OfficialLinkAttachment({ url, label }: { url: string; label: string }) {
  const logEvent = useServerFn(logUsageEvent);
  return (
    <a
      href={url}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      onClick={() =>
        void logEvent({ data: { eventName: "link_clicked", metadata: { url, label } } })
      }
      className="flex w-full max-w-full items-center gap-3 rounded-xl border border-primary/35 bg-primary/10 px-3 py-3 text-left transition-colors hover:bg-primary/15"
    >
      <span className="flex size-9 shrink-0 items-center justify-center rounded-lg bg-primary text-primary-foreground">
        <ExternalLink className="size-4" />
      </span>
      <span className="min-w-0 flex-1 text-[13px] font-semibold text-foreground">{label}</span>
    </a>
  );
}

function ReplyOptions({
  options,
  onReply,
}: {
  options: string[];
  onReply?: ((text: string) => void) | undefined;
}) {
  if (!onReply || options.length === 0) return null;
  return (
    <div className="flex flex-col gap-2">
      {options.map((option) => (
        <button
          key={option}
          type="button"
          onClick={() => onReply(option)}
          className="w-full rounded-xl border border-primary/40 bg-primary/10 px-3 py-2 text-left text-[13px] font-semibold text-foreground transition-colors hover:bg-primary hover:text-primary-foreground"
        >
          {option}
        </button>
      ))}
    </div>
  );
}

export function AttachmentList({
  attachments,
  onReply,
}: {
  attachments: ChatAttachment[];
  onReply?: ((text: string) => void) | undefined;
}) {
  if (attachments.length === 0) return null;
  const lessonCount = attachments.filter((attachment) => attachment.kind === "lesson").length;
  return (
    <div className="mt-2 flex flex-col gap-2">
      {lessonCount > 0 ? (
        <p className="mb-0.5 text-[13px] text-foreground">
          {lessonCount === 1 ? "Aqui tá o link da aula 👇" : "Aqui estão os links das aulas 👇"}
        </p>
      ) : null}
      {attachments.map((a, i) =>
        a.kind === "image" ? (
          <ImageAttachment key={`${a.path}-${i}`} path={a.path} name={a.name} />
        ) : a.kind === "file" ? (
          <FileAttachment key={`${a.path}-${i}`} path={a.path} name={a.name} size={a.size} />
        ) : a.kind === "material" ? (
          <MaterialAttachment
            key={`${a.materialId}-${i}`}
            materialId={a.materialId}
            name={a.name}
            size={a.size}
          />
        ) : a.kind === "replies" ? (
          <ReplyOptions key={`replies-${i}`} options={a.options} onReply={onReply} />
        ) : a.kind === "lesson" ? (
          <LessonAttachment
            key={`${a.lessonId}-${i}`}
            url={a.url}
            lessonId={a.lessonId}
            title={a.title}
            location={a.location}
          />
        ) : a.kind === "link" ? (
          <OfficialLinkAttachment key={`${a.url}-${i}`} url={a.url} label={a.label} />
        ) : (
          <SupportAttachment key={`${a.url}-${i}`} url={a.url} label={a.label} note={a.note} />
        ),
      )}
    </div>
  );
}
