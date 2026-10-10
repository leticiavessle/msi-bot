import { useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { Check, LogIn, MailPlus, MessageCircle, RotateCcw } from "lucide-react";
import {
  changeAuthorizedEmail,
  listEntradaAlertas,
  resolveEntradaAlerta,
} from "@/lib/dr/entrada-alertas.functions";
import { EmptyState, Panel, StatusBadge, buttonGhost } from "@/components/admin/ui";
import { CopyText } from "@/components/admin/CopyText";
import { trocarEmailConfirmando } from "@/components/admin/trocarEmail";
import { formatarCpf, formatarTelefone } from "@/lib/dr/identificacao";
import { cn } from "@/lib/utils";

const RESOLUCAO: Record<string, string> = {
  chamada: "equipe chamou",
  manter_email: "e-mail mantido",
  email_trocado: "e-mail trocado",
  outro: "resolvido",
};

/**
 * Aba Acessos › Entrada no bot: quem não foi encontrada na entrada (o time procura e chama no WhatsApp)
 * e quem entrou pelo CPF/nome/WhatsApp depois de digitar outro e-mail (talvez trocou de e-mail).
 */
export function EntradaAlertsPanel() {
  const qc = useQueryClient();
  const list = useServerFn(listEntradaAlertas);
  const resolve = useServerFn(resolveEntradaAlerta);
  const trocar = useServerFn(changeAuthorizedEmail);
  const [view, setView] = useState<"pending" | "resolved">("pending");
  const [busy, setBusy] = useState<string | null>(null);
  const [erro, setErro] = useState<string | null>(null);
  const { data, isLoading } = useQuery({
    queryKey: ["entrada-alertas", view],
    queryFn: () => list({ data: { view } }),
    refetchInterval: 60_000,
  });
  const rows = data ?? [];

  async function agir(id: string, run: () => Promise<unknown>) {
    setBusy(id);
    setErro(null);
    try {
      await run();
      await qc.invalidateQueries({ queryKey: ["entrada-alertas"] });
      await qc.invalidateQueries({ queryKey: ["access-alerts-count"] });
    } catch (e) {
      setErro(e instanceof Error ? e.message : "Não consegui concluir.");
    } finally {
      setBusy(null);
    }
  }

  return (
    <div className="flex flex-col gap-4">
      <div className="flex gap-2">
        {(["pending", "resolved"] as const).map((v) => (
          <button
            key={v}
            type="button"
            onClick={() => setView(v)}
            className={cn(
              "min-h-9 rounded-full border px-3.5 text-xs font-medium",
              view === v ? "border-primary bg-primary text-primary-foreground" : "border-border text-muted-foreground hover:bg-muted",
            )}
          >
            {v === "pending" ? "Pendentes" : "Resolvidos"}
          </button>
        ))}
      </div>
      <p className="text-xs text-muted-foreground">{isLoading ? "Carregando…" : `${rows.length} aviso(s)`}</p>
      {erro ? <p className="text-xs text-destructive">{erro}</p> : null}
      {!isLoading && rows.length === 0 ? (
        <EmptyState
          icon={<LogIn className="size-6" />}
          title="Nenhum aviso aqui"
          description="Quem não for encontrada na entrada do bot (e-mail, CPF, nome e WhatsApp) aparece aqui com tudo o que digitou."
        />
      ) : null}
      {rows.map((a) => (
        <Panel key={a.id}>
          <div className="flex flex-wrap items-start gap-3 px-4 py-3">
            <div className="min-w-0 flex-1 space-y-1.5">
              <div className="flex flex-wrap gap-1.5">
                {a.tipo === "nao_encontrada" ? (
                  <StatusBadge tone="danger">não encontrada</StatusBadge>
                ) : (
                  <StatusBadge tone="warning">entrou pelo {a.via} com outro e-mail</StatusBadge>
                )}
                {a.tentativas > 1 ? <StatusBadge tone="neutral">{a.tentativas} tentativas</StatusBadge> : null}
                {a.encontradaAgora ? (
                  <StatusBadge tone="success">
                    já tem cadastro ativo ({a.encontradaAgora.via}): {a.encontradaAgora.email}
                  </StatusBadge>
                ) : null}
                {a.resolucao && view === "resolved" ? (
                  <StatusBadge tone="neutral">{RESOLUCAO[a.resolucao] ?? a.resolucao}</StatusBadge>
                ) : null}
              </div>

              {a.tipo === "nao_encontrada" ? (
                <div className="grid gap-0.5 text-xs">
                  <Linha rotulo="Nome">
                    <CopyText value={a.nomeDigitado} label="nome" className="font-medium" />
                  </Linha>
                  <Linha rotulo="WhatsApp">
                    {a.whatsapp ? (
                      <span className="inline-flex items-center gap-1">
                        <CopyText value={formatarTelefone(a.whatsapp)} label="WhatsApp" />
                        <a
                          href={`https://wa.me/${a.whatsapp}`}
                          target="_blank"
                          rel="noreferrer"
                          className="inline-flex items-center gap-1 rounded-md px-1.5 py-0.5 text-[11px] font-medium text-primary hover:bg-muted"
                        >
                          <MessageCircle className="size-3" /> abrir
                        </a>
                      </span>
                    ) : (
                      "—"
                    )}
                  </Linha>
                  <Linha rotulo="E-mail">
                    <CopyText value={a.emailDigitado} label="e-mail" />
                  </Linha>
                  <Linha rotulo="CPF">
                    {a.cpf ? <CopyText value={formatarCpf(a.cpf)} label="CPF" /> : "não informou"}
                  </Linha>
                </div>
              ) : (
                <div className="grid gap-0.5 text-xs">
                  <Linha rotulo="Nome">{a.cadastroNome ?? "—"}</Linha>
                  <Linha rotulo="E-mail da compra">
                    <CopyText value={a.cadastroEmail} label="e-mail da compra" className="font-medium" />
                  </Linha>
                  <Linha rotulo="Digitou">
                    <CopyText value={a.emailDigitado} label="e-mail digitado" />
                  </Linha>
                </div>
              )}

              {a.observacao ? (
                <p className="rounded-xl border-l-2 border-primary/50 bg-muted px-3 py-2 text-[11px] text-muted-foreground">
                  {a.observacao}
                </p>
              ) : null}
              <p className="text-[11px] text-muted-foreground">
                {new Date(a.atualizadoEm).toLocaleString("pt-BR")}
                {view === "resolved" && a.resolvidoEm
                  ? ` · resolvido em ${new Date(a.resolvidoEm).toLocaleString("pt-BR")}${a.resolvidoPor ? ` por ${a.resolvidoPor}` : ""}`
                  : ""}
              </p>
            </div>

            <div className="flex flex-wrap gap-2">
              {view === "resolved" ? (
                <button
                  type="button"
                  disabled={busy !== null}
                  onClick={() => agir(a.id, () => resolve({ data: { id: a.id, undo: true } }))}
                  className={`${buttonGhost} min-h-9 px-3 text-xs`}
                >
                  <RotateCcw className="size-3.5" /> {busy === a.id ? "…" : "Reabrir"}
                </button>
              ) : a.tipo === "nao_encontrada" ? (
                <button
                  type="button"
                  disabled={busy !== null}
                  onClick={() => agir(a.id, () => resolve({ data: { id: a.id, resolucao: "chamada" } }))}
                  className={`${buttonGhost} min-h-9 px-3 text-xs`}
                >
                  <Check className="size-3.5" /> {busy === a.id ? "…" : "Resolvido"}
                </button>
              ) : (
                <>
                  {a.authorizedUserId && a.emailDigitado && !a.jaTrocado ? (
                    <button
                      type="button"
                      disabled={busy !== null}
                      onClick={() => {
                        if (
                          !window.confirm(
                            `Trocar o e-mail de acesso de ${a.cadastroEmail} para ${a.emailDigitado}? Ela passa a entrar com o novo, a conversa antiga continua e o e-mail antigo segue valendo para reembolso e compras.`,
                          )
                        )
                          return;
                        void agir(a.id, () =>
                          trocarEmailConfirmando((d) => trocar({ data: d }), {
                            authorizedUserId: a.authorizedUserId!,
                            novoEmail: a.emailDigitado!,
                            alertaId: a.id,
                          }),
                        );
                      }}
                      className={`${buttonGhost} min-h-9 px-3 text-xs`}
                    >
                      <MailPlus className="size-3.5" /> {busy === a.id ? "…" : "Trocar para o e-mail digitado"}
                    </button>
                  ) : null}
                  <button
                    type="button"
                    disabled={busy !== null}
                    onClick={() => agir(a.id, () => resolve({ data: { id: a.id, resolucao: "manter_email" } }))}
                    className={`${buttonGhost} min-h-9 px-3 text-xs`}
                  >
                    <Check className="size-3.5" /> Manter como está
                  </button>
                </>
              )}
            </div>
          </div>
        </Panel>
      ))}
    </div>
  );
}

function Linha({ rotulo, children }: { rotulo: string; children: React.ReactNode }) {
  return (
    <div className="flex min-w-0 items-center gap-2">
      <span className="w-28 shrink-0 text-muted-foreground">{rotulo}</span>
      <span className="min-w-0 flex-1 truncate">{children}</span>
    </div>
  );
}
