const KEY = "dr:device-id";

export function getDeviceId(): string {
  if (typeof window === "undefined") return "";
  let id = window.localStorage.getItem(KEY);
  if (!id) {
    id = crypto.randomUUID().replace(/-/g, "");
    window.localStorage.setItem(KEY, id);
  }
  return id;
}

let lastPingAt = 0;
let inFlight: Promise<unknown> | null = null;

/** Evita pings duplicados (StrictMode, múltiplas abas, visibilitychange). */
export function throttledPing(run: () => Promise<unknown>, minIntervalMs = 30_000) {
  const now = Date.now();
  if (inFlight || now - lastPingAt < minIntervalMs) return;
  lastPingAt = now;
  inFlight = run()
    .catch(() => {})
    .finally(() => {
      inFlight = null;
    });
}
