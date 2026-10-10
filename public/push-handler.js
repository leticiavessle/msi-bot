/* Notificações push do app.
 *
 * Carregado pelo service worker gerado na compilação (workbox → importScripts).
 * No MGA este código ficava em public/sw.js, mas a compilação substituía esse arquivo pelo
 * service worker gerado, e as notificações chegavam sem ninguém para exibi-las.
 * O servidor sempre manda { title, body, url, tag } (src/lib/dr/push.server.ts).
 */
self.addEventListener("push", (event) => {
  let data = {};
  try {
    data = event.data ? event.data.json() : {};
  } catch {
    data = { body: event.data ? event.data.text() : "" };
  }
  const title = data.title || "Nova mensagem";
  const options = {
    body: data.body || "",
    icon: data.icon || "/icons/v2/icon-192.png",
    badge: "/icons/v2/icon-96.png",
    tag: data.tag || "app",
    renotify: true,
    data: { url: data.url || "/chat" },
  };
  event.waitUntil(self.registration.showNotification(title, options));
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const target = new URL(event.notification.data?.url || "/chat", self.location.origin).href;
  event.waitUntil(
    (async () => {
      const clientList = await self.clients.matchAll({ type: "window", includeUncontrolled: true });
      for (const client of clientList) {
        if (client.url.startsWith(self.location.origin)) {
          await client.focus();
          if ("navigate" in client) await client.navigate(target);
          return;
        }
      }
      await self.clients.openWindow(target);
    })(),
  );
});
