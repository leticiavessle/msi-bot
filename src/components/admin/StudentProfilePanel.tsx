import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { ArrowLeft, Download } from "lucide-react";
import {
  getConversationMessages,
  getStudentProfile,
  revokeUserSessions,
} from "@/lib/dr/admin-users.functions";
import { exportConversations } from "@/lib/dr/admin-analytics.functions";
import { changeAuthorizedEmail } from "@/lib/dr/entrada-alertas.functions";
import { trocarEmailConfirmando } from "./trocarEmail";
import { EMAIL_RE, formatarCpf, formatarTelefone, viaPrecisaConferir } from "@/lib/dr/identificacao";
import { conversationRowsToCsv, csvFileName } from "@/lib/dr/export-csv";
import { PRODUCT_LABELS, type Product } from "@/lib/dr/config";

function Section({ title, children }: { title: string; children: React.ReactNode }) {
  return (
    <section className="rounded-2xl border border-border bg-surface p-4">
      <h3 className="mb-2 text-sm font-semibold">{title}</h3>
      {children}
    </section>
  );
}

export function StudentProfilePanel({ userId, onBack }: { userId: string; onBack: () => void }) {
  const queryClient = useQueryClient();
  const detail = useServerFn(getStudentProfile);
  const messagesFn = useServerFn(getConversationMessages);
  const revoke = useServerFn(revokeUserSessions);
  const exportFn = useServerFn(exportConversations);
  const trocarEmail = useServerFn(changeAuthorizedEmail);
  const [novoEmail, setNovoEmail] = useState("");
  const [trocando, setTrocando] = useState(false);
  const [erroTroca, setErroTroca] = useState<string | null>(null);
  const [openConversation, setOpenConversation] = useState<string | null>(null);
  const [exporting, setExporting] = useState(false);
  const [notice, setNotice] = useState<string | null>(null);

  const { data } = useQuery({
    queryKey: ["admin-student", userId],
    queryFn: () => detail({ data: { userId } }),
  });

  const { data: messages } = useQuery({
    queryKey: ["admin-conversation", openConversation],
    queryFn: () => messagesFn({ data: { conversationId: openConversation! } }),
    enabled: Boolean(openConversation),
  });

  if (!data) return <p className="text-sm text-muted-foreground">Carregando…</p>;

  return (
    <div className="flex flex-col gap-3">
      <button
        type="button"
        onClick={onBack}
        className="inline-flex w-fit items-center gap-2 text-sm font-medium text-muted-foreground"
      >
        <ArrowLeft className="size-4" /> Voltar
      </button>

      <Section title="Aluno">
        <p className="text-sm font-medium">{data.profile?.name ?? "Sem nome"}</p>
        <p className="text-xs text-muted-foreground">{data.profile?.email}</p>
        <p className="mt-2 text-xs text-muted-foreground">
          Produtos:{" "}
          {data.products
            .filter((p) => p.active)
            .map((p) => PRODUCT_LABELS[p.product as Product] ?? p.product)
            .join(", ") || "nenhum"}
        </p>
        <p className="text-xs text-muted-foreground">
          Risco atual: {data.memory?.risk_level ?? "low"} · Etapa:{" "}
          {data.memory?.current_stage ?? "não registrada"}
        </p>
      </Section>

      <Section title="Identificação na entrada do bot">
        {(() => {
          const id = data.identificacao;
          const VIA: Record<string, string> = {
            email: "e-mail",
            email_anterior: "e-mail antigo",
            cpf: "CPF",
            nome: "nome",
            whatsapp: "WhatsApp",
          };
          return (
            <div className="flex flex-col gap-1 text-xs text-muted-foreground">
              <p>
                E-mail de acesso: <span className="font-medium text-foreground">{id.email ?? "—"}</span>
              </p>
              {id.emailsAnteriores.length ? <p>E-mails anteriores: {id.emailsAnteriores.join(", ")}</p> : null}
              <p>CPF: {id.cpf ? formatarCpf(id.cpf) : "não registrado"}</p>
              <p>WhatsApp: {id.telefone ? formatarTelefone(id.telefone) : "não registrado"}</p>
              <p>
                Últimas entradas:{" "}
                {id.entradas.length
                  ? id.entradas
                      .slice(0, 5)
                      .map(
                        (e) =>
                          `${VIA[e.via ?? ""] ?? e.via ?? "?"}${viaPrecisaConferir(e.via) ? " (conferir identidade)" : ""} em ${new Date(e.em).toLocaleString("pt-BR")}`,
                      )
                      .join(" · ")
                  : "nenhuma registrada"}
              </p>
              {id.authorizedUserId ? (
                <form
                  className="mt-2 flex flex-wrap items-center gap-2"
                  onSubmit={async (e) => {
                    e.preventDefault();
                    const email = novoEmail.trim().toLowerCase();
                    if (!EMAIL_RE.test(email)) return setErroTroca("E-mail inválido.");
                    if (!window.confirm(`Trocar o e-mail de acesso de ${id.email} para ${email}? Ela passa a entrar com o novo, a conversa antiga continua e o e-mail antigo segue valendo para reembolso e compras.`)) return;
                    setTrocando(true);
                    setErroTroca(null);
                    try {
                      const trocou = await trocarEmailConfirmando((d) => trocarEmail({ data: d }), {
                        authorizedUserId: id.authorizedUserId!,
                        novoEmail: email,
                      });
                      if (!trocou) return;
                      setNovoEmail("");
                      await queryClient.invalidateQueries({ queryKey: ["admin-student", userId] });
                      await queryClient.invalidateQueries({ queryKey: ["admin-users"] });
                    } catch (err) {
                      setErroTroca(err instanceof Error ? err.message : "Não consegui trocar o e-mail.");
                    } finally {
                      setTrocando(false);
                    }
                  }}
                >
                  <input
                    value={novoEmail}
                    onChange={(e) => setNovoEmail(e.target.value)}
                    placeholder="Novo e-mail de acesso"
                    type="email"
                    className="min-h-9 min-w-0 flex-1 rounded-xl border border-border bg-background px-3 text-xs"
                  />
                  <button
                    type="submit"
                    disabled={trocando || !novoEmail.trim()}
                    className="min-h-9 rounded-xl border border-border px-3 text-xs font-medium hover:bg-muted disabled:opacity-50"
                  >
                    {trocando ? "Trocando…" : "Trocar e-mail"}
                  </button>
                  {erroTroca ? <p className="w-full text-destructive">{erroTroca}</p> : null}
                </form>
              ) : null}
            </div>
          );
        })()}
      </Section>

      <Section title="Origem do acesso por produto">
        {data.grants.length === 0 ? (
          <p className="text-xs text-muted-foreground">Nenhum registro de plataforma ainda.</p>
        ) : (
          <div className="flex flex-col gap-1 text-xs text-muted-foreground">
            {data.grants.map((g) => (
              <p key={g.product}>
                {PRODUCT_LABELS[g.product as Product] ?? g.product}: concedido por{" "}
                {g.source ?? "—"}
                {g.granted_at ? ` em ${new Date(g.granted_at).toLocaleString("pt-BR")}` : ""}
                {g.hubla_status
                  ? ` · último na Hubla: ${g.hubla_status}${g.hubla_status_at ? ` (${new Date(g.hubla_status_at).toLocaleDateString("pt-BR")})` : ""}`
                  : ""}
              </p>
            ))}
          </div>
        )}
      </Section>

      <Section title="Contexto da conversa">
        {(() => {
          const m = data.memory as Record<string, unknown> | null;
          const txt = (k: string, fallback = "não registrada") =>
            (m?.[k] as string | null) || fallback;
          return (
            <div className="flex flex-col gap-1 text-xs text-muted-foreground">
              <p>Próxima ação: {txt("next_action")}</p>
              <p>Dificuldade atual: {txt("current_difficulty")}</p>
              <p>Motivo do travamento: {txt("stuck_reason", "não registrado")}</p>
              <p>Última evolução: {txt("last_evolution")}</p>
            </div>
          );
        })()}
      </Section>

      <Section title="Memória">
        {data.facts.length === 0 ? (
          <p className="text-xs text-muted-foreground">
            {data.memory?.last_guidance
              ? `Última orientação: ${data.memory.last_guidance.slice(0, 200)}`
              : "Sem registros ainda."}
          </p>
        ) : (
          <ul className="flex flex-col gap-1 text-xs">
            {data.facts.map((f) => (
              <li key={f.key}>
                <span className="font-medium">{f.key}</span>: {f.value}
              </li>
            ))}
          </ul>
        )}
      </Section>

      <Section title="Sessões e dispositivos">
        <div className="flex flex-col gap-2">
          {data.sessions.length === 0 ? (
            <p className="text-xs text-muted-foreground">Nenhuma sessão registrada.</p>
          ) : null}
          {data.sessions.map((s) => (
            <div key={s.id} className="flex items-center gap-2 text-xs">
              <span className="min-w-0 flex-1 truncate text-muted-foreground">
                {s.device_id.slice(0, 8)} · {s.ip_city ?? "?"}/{s.ip_country ?? "?"} ·{" "}
                {new Date(s.last_seen_at).toLocaleString("pt-BR")}
                {s.revoked_at ? " · revogada" : ""}
              </span>
              {!s.revoked_at ? (
                <button
                  type="button"
                  onClick={async () => {
                    await revoke({ data: { userId, sessionId: s.id } });
                    await queryClient.invalidateQueries({ queryKey: ["admin-student", userId] });
                  }}
                  className="rounded-lg border border-border px-2 py-1 font-medium"
                >
                  Revogar
                </button>
              ) : null}
            </div>
          ))}
          <button
            type="button"
            onClick={async () => {
              await revoke({ data: { userId, sessionId: null } });
              await queryClient.invalidateQueries({ queryKey: ["admin-student", userId] });
            }}
            className="w-fit rounded-lg border border-border px-3 py-1 text-xs font-medium text-destructive"
          >
            Revogar todas as sessões
          </button>
        </div>
      </Section>

      <Section title="Alertas de risco">
        {data.alerts.length === 0 ? (
          <p className="text-xs text-muted-foreground">Nenhum alerta.</p>
        ) : (
          <ul className="flex flex-col gap-1 text-xs">
            {data.alerts.map((a) => (
              <li key={a.id} className="text-muted-foreground">
                <span className="font-medium text-foreground">{a.risk_level}</span> ·{" "}
                {new Date(a.created_at).toLocaleDateString("pt-BR")} · {a.status} — {a.reason}
              </li>
            ))}
          </ul>
        )}
      </Section>

      <Section title="Conversas">
        <div className="mb-2 flex items-center gap-2">
          <button
            type="button"
            disabled={exporting}
            onClick={async () => {
              setExporting(true);
              setNotice(null);
              try {
                const result = await exportFn({ data: { userId } });
                if (result.rows.length === 0) {
                  setNotice("Nenhuma mensagem para exportar.");
                  return;
                }
                const { downloadCsv } = await import("@/lib/dr/export-csv");
                downloadCsv(
                  csvFileName(data.profile?.name ?? data.profile?.email ?? "aluno"),
                  conversationRowsToCsv(result.rows),
                );
                setNotice(
                  `${result.conversations} conversa(s) e ${result.rows.length} mensagem(ns) exportadas.`,
                );
              } catch {
                setNotice("Não consegui gerar a planilha. Tente novamente.");
              } finally {
                setExporting(false);
              }
            }}
            className="inline-flex min-h-9 items-center gap-1.5 rounded-xl border border-border px-3 text-xs font-medium transition-colors hover:bg-muted disabled:opacity-50"
          >
            <Download className="size-3.5" />
            {exporting ? "Gerando…" : "Exportar conversas (CSV)"}
          </button>
          {notice ? <span className="text-[11px] text-muted-foreground">{notice}</span> : null}
        </div>
        <div className="flex flex-col gap-1">
          {data.conversations.map((c) => (
            <button
              key={c.id}
              type="button"
              onClick={() => setOpenConversation(openConversation === c.id ? null : c.id)}
              className="rounded-lg px-2 py-1 text-left text-xs hover:bg-muted"
            >
              {c.title ?? "Conversa"} · {new Date(c.updated_at).toLocaleString("pt-BR")}
            </button>
          ))}
          {openConversation ? (
            <div className="mt-2 flex max-h-80 flex-col gap-2 overflow-y-auto rounded-xl bg-muted p-3">
              {(messages ?? []).map((m) => (
                <div key={m.id} className="text-xs">
                  <span className="font-medium">{m.role === "user" ? "Aluno" : "Assistente"}:</span>{" "}
                  {m.content}
                </div>
              ))}
            </div>
          ) : null}
        </div>
      </Section>
    </div>
  );
}
