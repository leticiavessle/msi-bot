import { useCallback, useEffect, useState } from "react";

type BeforeInstallPromptEvent = Event & {
  prompt: () => Promise<void>;
  userChoice: Promise<{ outcome: "accepted" | "dismissed" }>;
};

const DISMISS_KEY = "app:install-dismissed-until";
const INSTALLED_KEY = "app:installed";
const SEVEN_DAYS = 7 * 24 * 60 * 60 * 1000;

export function isStandaloneMode() {
  if (typeof window === "undefined") return false;
  const iosStandalone = (window.navigator as Navigator & { standalone?: boolean }).standalone;
  return window.matchMedia("(display-mode: standalone)").matches || iosStandalone === true;
}

export function isIosDevice() {
  if (typeof window === "undefined") return false;
  const ua = window.navigator.userAgent;
  const iPadOS = /Macintosh/.test(ua) && "ontouchend" in document;
  return /iPad|iPhone|iPod/.test(ua) || iPadOS;
}

function isSnoozed() {
  try {
    if (window.localStorage.getItem(INSTALLED_KEY) === "1") return true;
    const until = Number(window.localStorage.getItem(DISMISS_KEY) ?? 0);
    return Number.isFinite(until) && Date.now() < until;
  } catch {
    return false;
  }
}

export function useInstallPrompt() {
  const [deferred, setDeferred] = useState<BeforeInstallPromptEvent | null>(null);
  const [visible, setVisible] = useState(false);
  const [ios, setIos] = useState(false);

  useEffect(() => {
    if (isStandaloneMode() || isSnoozed()) return;

    const iosDevice = isIosDevice();
    setIos(iosDevice);
    // No iOS não existe beforeinstallprompt: mostramos o aviso com instruções manuais.
    if (iosDevice) setVisible(true);

    const onBeforeInstall = (event: Event) => {
      event.preventDefault();
      setDeferred(event as BeforeInstallPromptEvent);
      setVisible(true);
    };
    const onInstalled = () => {
      try {
        window.localStorage.setItem(INSTALLED_KEY, "1");
      } catch {
        /* ignore */
      }
      setDeferred(null);
      setVisible(false);
    };

    window.addEventListener("beforeinstallprompt", onBeforeInstall);
    window.addEventListener("appinstalled", onInstalled);
    return () => {
      window.removeEventListener("beforeinstallprompt", onBeforeInstall);
      window.removeEventListener("appinstalled", onInstalled);
    };
  }, []);

  const dismiss = useCallback(() => {
    try {
      window.localStorage.setItem(DISMISS_KEY, String(Date.now() + SEVEN_DAYS));
    } catch {
      /* ignore */
    }
    setVisible(false);
  }, []);

  const promptInstall = useCallback(async () => {
    if (!deferred) return "unavailable" as const;
    await deferred.prompt();
    const { outcome } = await deferred.userChoice;
    setDeferred(null);
    if (outcome === "accepted") {
      setVisible(false);
    } else {
      dismiss();
    }
    return outcome;
  }, [deferred, dismiss]);

  return {
    visible,
    isIos: ios,
    canPrompt: deferred !== null,
    promptInstall,
    dismiss,
  };
}
