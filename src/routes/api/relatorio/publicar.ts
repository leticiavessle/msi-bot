import { createFileRoute } from "@tanstack/react-router";
import { handlePublicar } from "@/lib/dr/report-routes.server";

export const Route = createFileRoute("/api/relatorio/publicar")({
  server: { handlers: { POST: ({ request }) => handlePublicar(request) } },
});
