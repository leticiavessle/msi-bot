/** Utilitários client-safe para gerar e baixar planilhas CSV (compatível com Excel). */

const SEP = ";";

function escapeCell(value: unknown): string {
  const text = value === null || value === undefined ? "" : String(value);
  return `"${text.replace(/"/g, '""')}"`;
}

/** Converte cabeçalho + linhas em CSV com BOM UTF-8. */
export function toCsv(header: string[], rows: (string | number | null)[][]): string {
  const lines = [header.map(escapeCell).join(SEP), ...rows.map((r) => r.map(escapeCell).join(SEP))];
  return `\uFEFF${lines.join("\r\n")}`;
}

/** Dispara o download do CSV no navegador. */
export function downloadCsv(filename: string, csv: string) {
  const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
  const url = URL.createObjectURL(blob);
  const link = document.createElement("a");
  link.href = url;
  link.download = filename;
  document.body.appendChild(link);
  link.click();
  link.remove();
  URL.revokeObjectURL(url);
}

/** Nome de arquivo seguro no padrão conversas-<escopo>-<data>.csv */
export function csvFileName(scope: string) {
  const slug =
    scope
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, "-")
      .replace(/^-|-$/g, "")
      .slice(0, 40) || "conversas";
  const date = new Date().toISOString().slice(0, 10);
  return `conversas-${slug}-${date}.csv`;
}

export const CONVERSATION_CSV_HEADER = [
  "Aluno",
  "E-mail",
  "Conversa",
  "ID da conversa",
  "Data e hora",
  "Quem falou",
  "Mensagem",
  "Intenção detectada",
];

export type ConversationExportRow = {
  name: string | null;
  email: string | null;
  title: string | null;
  conversationId: string;
  createdAt: string;
  role: string;
  content: string;
  intent: string | null;
};

function formatDate(iso: string) {
  return new Date(iso).toLocaleString("pt-BR", { timeZone: "America/Sao_Paulo" });
}

export function conversationRowsToCsv(rows: ConversationExportRow[]) {
  return toCsv(
    CONVERSATION_CSV_HEADER,
    rows.map((r) => [
      r.name ?? "",
      r.email ?? "",
      r.title ?? "Conversa",
      r.conversationId,
      formatDate(r.createdAt),
      r.role === "user" ? "Aluno" : "Assistente",
      r.content,
      r.intent ?? "",
    ]),
  );
}
