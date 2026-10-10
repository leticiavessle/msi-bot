export type ChatAttachment =
  | { kind: "image"; path: string; name: string; size?: number | null }
  | { kind: "file"; path: string; name: string; size?: number | null }
  | { kind: "material"; materialId: string; name: string; size?: number | null }
  | { kind: "support"; url: string; label: string; note?: string | null }
  | {
      kind: "lesson";
      url: string;
      lessonId: string;
      title: string;
      location: string;
    }
  | { kind: "link"; url: string; label: string }
  | { kind: "replies"; options: string[] };

export const MAX_IMAGE_BYTES = 8 * 1024 * 1024;
export const ACCEPTED_IMAGE_TYPES = [
  "image/jpeg",
  "image/png",
  "image/webp",
  "image/heic",
  "image/heif",
];

export function parseAttachments(metadata: unknown): ChatAttachment[] {
  if (!metadata || typeof metadata !== "object") return [];
  const raw = (metadata as { attachments?: unknown }).attachments;
  if (!Array.isArray(raw)) return [];
  const out: ChatAttachment[] = [];
  for (const item of raw) {
    if (!item || typeof item !== "object") continue;
    const a = item as Record<string, unknown>;
    if (a["kind"] === "image" && typeof a["path"] === "string") {
      out.push({
        kind: "image",
        path: a["path"],
        name: typeof a["name"] === "string" ? a["name"] : "imagem",
        size: typeof a["size"] === "number" ? a["size"] : null,
      });
    } else if (a["kind"] === "file" && typeof a["path"] === "string") {
      out.push({
        kind: "file",
        path: a["path"],
        name: typeof a["name"] === "string" ? a["name"] : "arquivo",
        size: typeof a["size"] === "number" ? a["size"] : null,
      });
    } else if (a["kind"] === "material" && typeof a["materialId"] === "string") {
      out.push({
        kind: "material",
        materialId: a["materialId"],
        name: typeof a["name"] === "string" ? a["name"] : "material",
        size: typeof a["size"] === "number" ? a["size"] : null,
      });
    } else if (a["kind"] === "replies" && Array.isArray(a["options"])) {
      const options = (a["options"] as unknown[]).filter(
        (o): o is string => typeof o === "string" && o.trim().length > 0,
      );
      if (options.length) out.push({ kind: "replies", options });
    } else if (
      a["kind"] === "link" &&
      typeof a["url"] === "string" &&
      typeof a["label"] === "string"
    ) {
      out.push({ kind: "link", url: a["url"], label: a["label"] });
    } else if (a["kind"] === "support" && typeof a["url"] === "string") {
      out.push({
        kind: "support",
        url: a["url"],
        label: typeof a["label"] === "string" ? a["label"] : "Falar com o atendimento humano",
        note: typeof a["note"] === "string" ? a["note"] : null,
      });
    } else if (
      a["kind"] === "lesson" &&
      typeof a["url"] === "string" &&
      typeof a["lessonId"] === "string" &&
      typeof a["title"] === "string" &&
      typeof a["location"] === "string"
    ) {
      out.push({
        kind: "lesson",
        url: a["url"],
        lessonId: a["lessonId"],
        title: a["title"],
        location: a["location"],
      });
    }
  }
  return out;
}

export function formatBytes(bytes?: number | null) {
  if (!bytes || bytes <= 0) return "";
  const units = ["B", "KB", "MB", "GB"];
  let value = bytes;
  let i = 0;
  while (value >= 1024 && i < units.length - 1) {
    value /= 1024;
    i++;
  }
  return `${value.toFixed(value >= 10 || i === 0 ? 0 : 1)} ${units[i]}`;
}
