import { Paperclip, SendHorizonal, X } from "lucide-react";
import { useEffect, useRef, useState, type FormEvent } from "react";
import { IDENTITY } from "@/lib/dr/config";
import { ACCEPTED_IMAGE_TYPES, MAX_IMAGE_BYTES, formatBytes } from "@/lib/dr/attachments";

export const MAX_MESSAGE_LENGTH = 2000;

export function Composer({
  disabled,
  onSend,
}: {
  disabled?: boolean;
  onSend: (text: string, file?: File | null) => void;
}) {
  const [value, setValue] = useState("");
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [fileError, setFileError] = useState<string | null>(null);
  const ref = useRef<HTMLTextAreaElement>(null);
  const fileRef = useRef<HTMLInputElement>(null);

  useEffect(() => {
    if (!file) {
      setPreview(null);
      return;
    }
    const url = URL.createObjectURL(file);
    setPreview(url);
    return () => URL.revokeObjectURL(url);
  }, [file]);

  function pickFile(selected: File | null) {
    setFileError(null);
    if (!selected) {
      setFile(null);
      return;
    }
    if (!ACCEPTED_IMAGE_TYPES.includes(selected.type.toLowerCase())) {
      setFileError("Envie uma imagem JPG, PNG ou WEBP.");
      return;
    }
    if (selected.size > MAX_IMAGE_BYTES) {
      setFileError(`A imagem deve ter até ${formatBytes(MAX_IMAGE_BYTES)}.`);
      return;
    }
    setFile(selected);
  }

  function submit(e?: FormEvent) {
    e?.preventDefault();
    const text = value.trim();
    if ((!text && !file) || disabled) return;
    onSend((text || "Pode analisar essa imagem?").slice(0, MAX_MESSAGE_LENGTH), file);
    setValue("");
    setFile(null);
    setFileError(null);
    if (fileRef.current) fileRef.current.value = "";
    if (ref.current) ref.current.style.height = "auto";
  }

  return (
    <form onSubmit={submit} className="flex flex-col gap-1 px-3 pb-2 pt-1">
      {preview ? (
        <div className="flex items-center gap-2 rounded-xl border border-border bg-surface p-2">
          <img src={preview} alt="Imagem selecionada" className="size-12 rounded-lg object-cover" />
          <div className="min-w-0 flex-1">
            <p className="truncate text-[12px] font-medium text-foreground">{file?.name}</p>
            <p className="text-[11px] text-muted-foreground">{formatBytes(file?.size)}</p>
          </div>
          <button
            type="button"
            aria-label="Remover imagem"
            onClick={() => pickFile(null)}
            className="flex size-8 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-foreground"
          >
            <X className="size-4" />
          </button>
        </div>
      ) : null}

      {fileError ? (
        <p className="px-1 text-[11px] text-destructive" role="alert">
          {fileError}
        </p>
      ) : null}

      <div className="flex items-end gap-2">
        <input
          ref={fileRef}
          type="file"
          accept="image/*"
          className="hidden"
          onChange={(e) => pickFile(e.target.files?.[0] ?? null)}
        />
        <button
          type="button"
          aria-label="Enviar imagem"
          disabled={disabled}
          onClick={() => fileRef.current?.click()}
          className="flex size-11 shrink-0 items-center justify-center rounded-full border border-border bg-surface text-muted-foreground transition-colors hover:text-foreground disabled:opacity-40"
        >
          <Paperclip className="size-5" />
        </button>

        <textarea
          ref={ref}
          rows={1}
          value={value}
          maxLength={MAX_MESSAGE_LENGTH}
          placeholder={IDENTITY.composerPlaceholder}
          enterKeyHint="enter"
          onChange={(e) => {
            setValue(e.target.value);
            const el = e.target;
            el.style.height = "auto";
            // ~6 linhas (16px * 1.375) + padding; depois rola por dentro.
            el.style.height = `${Math.min(el.scrollHeight, 156)}px`;
          }}
          className="max-h-[156px] min-h-[3.5rem] w-full resize-none overflow-y-auto rounded-3xl border border-border bg-surface px-4 py-3 text-[16px] leading-snug text-foreground shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring"
        />
        <button
          type="submit"
          aria-label="Enviar mensagem"
          disabled={disabled || (value.trim().length === 0 && !file)}
          className="flex size-11 shrink-0 items-center justify-center rounded-full bg-primary text-primary-foreground shadow-md transition-opacity hover:opacity-90 disabled:opacity-40"
        >
          <SendHorizonal className="size-5" />
        </button>
      </div>
    </form>
  );
}
