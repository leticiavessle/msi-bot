/**
 * Configuração de compilação SEM Lovable.
 *
 * Reproduz o que o pacote @lovable.dev/vite-tanstack-config fazia no projeto do MGA:
 * Tailwind, caminhos "@/", TanStack Start (com o src/server.ts como entrada do servidor),
 * React, PWA e, na compilação, o Nitro gerando um Worker da Cloudflare
 * (preset "cloudflare-module", o mesmo que o Lovable usava).
 *
 * Para outra hospedagem (ex.: Vercel), rode a compilação com NITRO_PRESET=vercel.
 */
import { defineConfig, loadEnv } from "vite";
import tailwindcss from "@tailwindcss/vite";
import tsConfigPaths from "vite-tsconfig-paths";
import { tanstackStart } from "@tanstack/react-start/plugin/vite";
import viteReact from "@vitejs/plugin-react";
import { nitro } from "nitro/vite";
import { VitePWA } from "vite-plugin-pwa";

export default defineConfig(({ command, mode }) => {
  // Variáveis VITE_* do .env ficam disponíveis no navegador e no servidor (SSR).
  const viteEnv = loadEnv(mode, process.cwd(), "VITE_");
  const envDefine = Object.fromEntries(
    Object.entries(viteEnv).map(([key, value]) => [`import.meta.env.${key}`, JSON.stringify(value)]),
  );
  const preset = process.env["NITRO_PRESET"] || "cloudflare-module";

  return {
    define: envDefine,
    css: { transformer: "lightningcss" },
    resolve: {
      alias: { "@": `${process.cwd()}/src` },
      dedupe: [
        "react",
        "react-dom",
        "react/jsx-runtime",
        "react/jsx-dev-runtime",
        "@tanstack/react-query",
        "@tanstack/query-core",
      ],
    },
    optimizeDeps: {
      include: ["react", "react-dom", "react-dom/client", "react/jsx-runtime", "react/jsx-dev-runtime"],
    },
    server: { host: "::", port: 8080 },
    plugins: [
      tailwindcss(),
      tsConfigPaths({ projects: ["./tsconfig.json"] }),
      tanstackStart({
        // Arquivos de servidor nunca podem ir para o navegador.
        importProtection: {
          behavior: "error",
          client: { files: ["**/server/**"], specifiers: ["server-only"] },
        },
        // Entrada do servidor: src/server.ts (página de erro amigável no lugar do 500 cru).
        server: { entry: "server" },
      }),
      ...(command === "build"
        ? [
            nitro({
              preset,
              // Mesmo layout de saída do Lovable: dist/server (Worker) e dist/client (arquivos).
              output: { dir: "dist", serverDir: "dist/server", publicDir: "dist/client" },
              ...(preset.startsWith("cloudflare")
                ? { cloudflare: { nodeCompat: true, deployConfig: true } }
                : {}),
            }),
          ]
        : []),
      viteReact(),
      VitePWA({
        strategies: "generateSW",
        registerType: "autoUpdate",
        // O registrador protegido em src/lib/pwa/register.ts é o único que registra o SW.
        injectRegister: null,
        devOptions: { enabled: false },

        filename: "sw.js",
        // O build do TanStack Start publica os arquivos estáticos em dist/client.
        outDir: "dist/client",

        // O manifesto é servido estaticamente de public/manifest.webmanifest
        // (assim também funciona em dev/preview).
        manifest: false,

        workbox: {
          // Notificações push (exibir e abrir ao tocar). Ver public/push-handler.js.
          importScripts: ["/push-handler.js"],
          // App com SSR: nunca servir um HTML de "casca" vindo do cache.
          navigateFallback: null,
          globPatterns: ["**/*.{js,css,png,svg,ico,woff2}"],
          globIgnores: ["**/sw.js", "**/workbox-*.js"],
          cleanupOutdatedCaches: true,
          clientsClaim: true,
          skipWaiting: true,
          navigationPreload: true,
          runtimeCaching: [
            {
              // Navegação HTML: sempre tenta a rede primeiro, para a versão nova ganhar.
              urlPattern: ({ request, url }) =>
                request.mode === "navigate" &&
                !url.pathname.startsWith("/~oauth") &&
                !url.pathname.startsWith("/api") &&
                !url.pathname.startsWith("/_serverFn"),
              handler: "NetworkFirst",
              options: {
                cacheName: "app-html",
                networkTimeoutSeconds: 10,
                expiration: { maxEntries: 20, maxAgeSeconds: 60 * 60 * 24 },
                cacheableResponse: { statuses: [200] },
              },
            },
            {
              // Arquivos do build com hash, do próprio site.
              urlPattern: ({ url, sameOrigin }) =>
                sameOrigin && /\/_build\/|\/assets\//.test(url.pathname),
              handler: "CacheFirst",
              options: {
                cacheName: "app-assets",
                expiration: { maxEntries: 200, maxAgeSeconds: 60 * 60 * 24 * 30 },
                cacheableResponse: { statuses: [0, 200] },
              },
            },
            {
              urlPattern: ({ url }) => url.origin === "https://fonts.gstatic.com",
              handler: "CacheFirst",
              options: {
                cacheName: "app-fonts",
                expiration: { maxEntries: 20, maxAgeSeconds: 60 * 60 * 24 * 365 },
                cacheableResponse: { statuses: [0, 200] },
              },
            },
          ],
        },
      }),
    ],
  };
});
