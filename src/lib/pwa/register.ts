/**
 * Único registrador do service worker do app.
 *
 * Nunca registra em dev, dentro de iframe ou em endereços de pré-visualização —
 * nesses contextos remove qualquer registro antigo para não servir HTML velho.
 */
const SW_URL = "/sw.js";

function isPreviewHost(hostname: string) {
  // Endereços provisórios de pré-visualização (ex.: *.workers.dev de teste, localhost).
  return (
    hostname.startsWith("preview--") ||
    hostname === "localhost" ||
    hostname === "127.0.0.1"
  );
}

async function unregisterAppServiceWorkers() {
  if (!("serviceWorker" in navigator)) return;
  const registrations = await navigator.serviceWorker.getRegistrations();
  await Promise.allSettled(
    registrations
      .filter((registration) => {
        const scriptURL =
          registration.active?.scriptURL ??
          registration.waiting?.scriptURL ??
          registration.installing?.scriptURL ??
          "";
        return scriptURL.endsWith(SW_URL);
      })
      .map((registration) => registration.unregister()),
  );
}

export function registerServiceWorker() {
  if (typeof window === "undefined" || !("serviceWorker" in navigator)) return;

  const inIframe = window.self !== window.top;
  const swOff = new URLSearchParams(window.location.search).get("sw") === "off";
  const refuse =
    !import.meta.env.PROD || inIframe || swOff || isPreviewHost(window.location.hostname);

  if (refuse) {
    void unregisterAppServiceWorkers();
    return;
  }

  window.addEventListener("load", () => {
    const hadController = Boolean(navigator.serviceWorker.controller);
    navigator.serviceWorker.addEventListener("controllerchange", () => {
      if (hadController) window.dispatchEvent(new Event("app-sw-update"));
    });
    void navigator.serviceWorker
      .register(SW_URL, { scope: "/", updateViaCache: "none" })
      .then((registration) => {
        void registration.update();
        const check = () => void registration.update().catch(() => {});
        document.addEventListener("visibilitychange", () => {
          if (document.visibilityState === "visible") check();
        });
        window.setInterval(check, 30 * 60 * 1000);
      })
      .catch(() => {});
  });
}
