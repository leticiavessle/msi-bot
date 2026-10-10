import { createFileRoute } from "@tanstack/react-router";
import { handleDados } from "@/lib/dr/report-routes.server";

// Alias público (mesmo token) caso o site bloqueie /api/relatorio.
export const Route = createFileRoute("/api/public/relatorio/dados")({
  server: { handlers: { GET: ({ request }) => handleDados(request) } },
});
