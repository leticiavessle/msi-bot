/** Chave pública VAPID (do .env: VITE_VAPID_PUBLIC_KEY; gere um par novo para este app). */
export const VAPID_PUBLIC_KEY: string = import.meta.env["VITE_VAPID_PUBLIC_KEY"] ?? "";

function urlBase64ToUint8Array(base64: string) {
  const padding = "=".repeat((4 - (base64.length % 4)) % 4);
  const raw = atob((base64 + padding).replace(/-/g, "+").replace(/_/g, "/"));
  const out = new Uint8Array(raw.length);
  for (let i = 0; i < raw.length; i += 1) out[i] = raw.charCodeAt(i);
  return out;
}

export function pushSupported() {
  return (
    Boolean(VAPID_PUBLIC_KEY) &&
    typeof window !== "undefined" &&
    window.self === window.top &&
    "serviceWorker" in navigator &&
    "PushManager" in window &&
    "Notification" in window
  );
}

export function pushPermission(): NotificationPermission | "unsupported" {
  if (!pushSupported()) return "unsupported";
  return Notification.permission;
}

async function ready() {
  const existing = await navigator.serviceWorker.getRegistration("/");
  if (existing) return navigator.serviceWorker.ready;
  await navigator.serviceWorker.register("/sw.js", { scope: "/" });
  return navigator.serviceWorker.ready;
}

export async function currentSubscription() {
  if (!pushSupported()) return null;
  const registration = await navigator.serviceWorker.getRegistration("/");
  if (!registration) return null;
  return registration.pushManager.getSubscription();
}

export type PushKeys = { endpoint: string; p256dh: string; auth: string; device: string };

function encodeKey(sub: PushSubscription, name: "p256dh" | "auth") {
  const key = sub.getKey(name);
  if (!key) return "";
  let binary = "";
  const bytes = new Uint8Array(key);
  for (const b of bytes) binary += String.fromCharCode(b);
  return btoa(binary).replace(/\+/g, "-").replace(/\//g, "_").replace(/=+$/, "");
}

/** Pede a permissão (precisa vir de um toque) e devolve a inscrição pronta para salvar. */
export async function subscribeToPush(): Promise<PushKeys> {
  if (!pushSupported()) throw new Error("Este aparelho não aceita notificações.");
  const permission = await Notification.requestPermission();
  if (permission !== "granted") throw new Error("Permissão não liberada.");
  const registration = await ready();
  const sub =
    (await registration.pushManager.getSubscription()) ??
    (await registration.pushManager.subscribe({
      userVisibleOnly: true,
      applicationServerKey: urlBase64ToUint8Array(VAPID_PUBLIC_KEY),
    }));
  return {
    endpoint: sub.endpoint,
    p256dh: encodeKey(sub, "p256dh"),
    auth: encodeKey(sub, "auth"),
    device: navigator.userAgent.slice(0, 200),
  };
}
