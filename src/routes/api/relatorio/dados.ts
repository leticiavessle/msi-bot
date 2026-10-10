import { createFileRoute } from "@tanstack/react-router";
import { handleDados } from "@/lib/dr/report-routes.server";

export const Route = createFileRoute("/api/relatorio/dados")({
  server: { handlers: { GET: ({ request }) => handleDados(request) } },
});
