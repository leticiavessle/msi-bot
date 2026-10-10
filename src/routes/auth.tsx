import { createFileRoute, useNavigate, useSearch } from "@tanstack/react-router";
import { useServerFn } from "@tanstack/react-start";
import { useEffect, useState } from "react";
import { BadgeCheck, Lock } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { iniciarEntrada, type ResultadoEntrada } from "@/lib/dr/access.functions";
import { IDENTITY, MARCA } from "@/lib/dr/config";
import { getDeviceId } from "@/lib/dr/device";
import { fillGenero } from "@/lib/dr/genero";
import {
  EMAIL_RE,
  cpfValido,
  nomeCompletoValido,
  normalizarTelefone,
  soDigitos,
  type EtapaEntrada,
} from "@/lib/dr/identificacao";
import { ENTRADA } from "@/oferta/entrada";
import { POLITICAS } from "@/oferta/marca";

import { InstallBanner } from "@/components/pwa/InstallBanner";

export const Route = createFileRoute("/auth")({
  ssr: false,
  validateSearch: (search: Record<string, unknown>): { redirect?: string } =>
    typeof search["redirect"] === "string" ? { redirect: search["redirect"] } : {},
  head: () => ({
    meta: [
      { title: `Entrar — ${IDENTITY.name}` },
      {
        name: "description",
        content: IDENTITY.loginDescription,
      },
      { property: "og:title", content: `Entrar — ${IDENTITY.name}` },
      {
        property: "og:description",
        content: IDENTITY.loginDescription,
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary" },
    ],
  }),
  component: AuthPage,
});

function safePath(value?: string) {
  if (!value || !value.startsWith("/") || value.startsWith("//")) return "/chat";
  return value;
}

const texto = (t: string) => fillGenero(t, POLITICAS.tratamentoPadrao);

/** 52998224725 → 529.982.247-25 enquanto ela digita. */
function mascaraCpf(valor: string) {
  const d = soDigitos(valor).slice(0, 11);
  return d
    .replace(/^(\d{3})(\d)/, "$1.$2")
    .replace(/^(\d{3})\.(\d{3})(\d)/, "$1.$2.$3")
    .replace(/\.(\d{3})(\d)/, ".$1-$2");
}

/** Antes de ir ao servidor: erro de digitação não gasta tentativa. */
function conferirNaTela(etapa: EtapaEntrada, valor: string): string | null {
  if (etapa === "email") return EMAIL_RE.test(valor.trim()) ? null : ENTRADA.invalido.email;
  if (etapa === "cpf") return cpfValido(soDigitos(valor)) ? null : ENTRADA.invalido.cpf;
  if (etapa === "nome") return nomeCompletoValido(valor) ? null : ENTRADA.invalido.nome;
  return normalizarTelefone(valor) ? null : ENTRADA.invalido.whatsapp;
}

type Tela =
  | { tipo: "form" }
  | { tipo: "encontrada"; emailMascarado: string; dica: "email_diferente" | "email_atualizado" | null }
  | { tipo: "nao_encontrada"; whatsapp: string | null };

const inputClass =
  "min-h-12 rounded-full border border-border bg-background px-4 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring";
const botaoClass =
  "min-h-12 rounded-full bg-primary text-sm font-semibold text-primary-foreground transition-opacity hover:opacity-90 disabled:opacity-50";
const linkClass = "text-xs font-medium text-muted-foreground underline-offset-2 hover:underline";

function AuthPage() {
  const navigate = useNavigate();
  const search = useSearch({ from: "/auth" });
  const target = safePath(search.redirect);
  const start = useServerFn(iniciarEntrada);

  const [etapa, setEtapa] = useState<EtapaEntrada>("email");
  const [valores, setValores] = useState<Record<EtapaEntrada, string>>({ email: "", cpf: "", nome: "", whatsapp: "" });
  const [tela, setTela] = useState<Tela>({ tipo: "form" });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    supabase.auth.getSession().then(({ data }) => {
      if (data.session) navigate({ to: target, replace: true });
    });
  }, [navigate, target]);

  const valor = valores[etapa];
  const setValor = (v: string) => setValores((atual) => ({ ...atual, [etapa]: etapa === "cpf" ? mascaraCpf(v) : v }));

  function irPara(proxima: EtapaEntrada) {
    setError(null);
    setEtapa(proxima);
  }

  function recomecar() {
    setError(null);
    setTela({ tipo: "form" });
    setEtapa("email");
  }

  async function concluir(res: Extract<ResultadoEntrada, { status: "entrou" }>) {
    const { error: otpError } = await supabase.auth.verifyOtp({ type: "email", token_hash: res.tokenHash });
    if (otpError) throw otpError;
    if (res.emailMascarado) setTela({ tipo: "encontrada", emailMascarado: res.emailMascarado, dica: res.dica });
    else navigate({ to: target, replace: true });
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    const erroDigitacao = conferirNaTela(etapa, valor);
    if (erroDigitacao) return setError(erroDigitacao);
    setError(null);
    setLoading(true);
    try {
      const res = await start({
        data: {
          etapa,
          deviceId: getDeviceId() || null,
          email: valores.email.trim() || null,
          cpf: valores.cpf || null,
          nome: valores.nome.trim() || null,
          whatsapp: valores.whatsapp.trim() || null,
        },
      });
      if (res.status === "entrou") await concluir(res);
      else if (res.status === "nao_encontrado") {
        if (res.proxima) irPara(res.proxima);
        else setTela({ tipo: "nao_encontrada", whatsapp: res.whatsapp ?? null });
      } else setError(res.mensagem);
    } catch (err) {
      setError(
        err instanceof Error && err.message.length < 120
          ? err.message
          : "Não consegui liberar seu acesso. Confira os dados e tente de novo.",
      );
    } finally {
      setLoading(false);
    }
  }

  const passo = ENTRADA.etapas[etapa];
  const aviso =
    etapa === "cpf"
      ? ENTRADA.etapas.cpf.aviso.replace("[email]", valores.email.trim())
      : etapa === "email"
        ? null
        : ENTRADA.etapas[etapa].aviso;

  return (
    <div className="flex min-h-[100dvh] items-center justify-center bg-background px-4 pb-[max(2.5rem,env(safe-area-inset-bottom))] pt-[max(2.5rem,env(safe-area-inset-top))]">
      <div className="w-full max-w-sm">
        <div className="mb-6 flex flex-col items-center text-center">
          <img
            src={MARCA.avatarUrl}
            alt={IDENTITY.name}
            className="size-14 rounded-full object-cover ring-2 ring-primary/40"
          />

          <div className="mt-3 flex items-center gap-1.5">
            <h1 className="text-lg font-semibold">{IDENTITY.name}</h1>
            <BadgeCheck className="size-4 text-primary" />
          </div>
          <p className="text-xs text-muted-foreground">{IDENTITY.subtitle}</p>
          <p className="mt-2 inline-flex items-center gap-1 text-[11px] text-muted-foreground">
            <Lock className="size-3" /> {IDENTITY.secureLabel}
          </p>
        </div>

        <div className="rounded-2xl border border-border bg-surface p-5">
          {tela.tipo === "encontrada" ? (
            <div className="flex flex-col gap-3">
              <h2 className="text-sm font-semibold">{ENTRADA.encontrada.titulo}</h2>
              <p className="text-xs text-muted-foreground">{ENTRADA.encontrada.texto}</p>
              <p className="rounded-full border border-primary/40 bg-background px-4 py-3 text-center text-sm font-semibold">
                {tela.emailMascarado}
              </p>
              {tela.dica ? (
                <p className="text-xs text-muted-foreground">
                  {texto(
                    tela.dica === "email_diferente"
                      ? ENTRADA.encontrada.dicaEmailDiferente
                      : ENTRADA.encontrada.dicaEmailAtualizado,
                  )}
                </p>
              ) : null}
              <button type="button" onClick={() => navigate({ to: target, replace: true })} className={botaoClass}>
                {ENTRADA.encontrada.botao}
              </button>
            </div>
          ) : tela.tipo === "nao_encontrada" ? (
            <div className="flex flex-col gap-3">
              <h2 className="text-sm font-semibold">{ENTRADA.naoEncontrada.titulo}</h2>
              <p className="text-xs text-muted-foreground">
                {ENTRADA.naoEncontrada.texto.replace("[whatsapp]", tela.whatsapp ?? "que você informou")}
              </p>
              <p className="text-xs text-muted-foreground">{ENTRADA.naoEncontrada.contato}</p>
              <button type="button" onClick={recomecar} className={botaoClass}>
                {ENTRADA.naoEncontrada.botao}
              </button>
            </div>
          ) : (
            <>
              <h2 className="text-sm font-semibold">{texto(ENTRADA.titulo)}</h2>
              {aviso ? <p className="mt-2 text-xs font-medium">{aviso}</p> : null}
              <p className="mt-1 text-xs text-muted-foreground">{passo.texto}</p>

              <form onSubmit={handleSubmit} className="mt-4 flex flex-col gap-3">
                <input
                  key={etapa}
                  type={etapa === "email" ? "email" : etapa === "whatsapp" ? "tel" : "text"}
                  required
                  autoFocus
                  autoComplete={
                    etapa === "email" ? "email" : etapa === "nome" ? "name" : etapa === "whatsapp" ? "tel" : "off"
                  }
                  inputMode={etapa === "email" ? "email" : etapa === "cpf" ? "numeric" : etapa === "whatsapp" ? "tel" : "text"}
                  value={valor}
                  onChange={(e) => setValor(e.target.value)}
                  placeholder={passo.placeholder}
                  maxLength={etapa === "email" ? 255 : etapa === "nome" ? 160 : 30}
                  aria-label={passo.placeholder}
                  className={inputClass}
                />

                {error ? <p className="text-xs text-destructive">{error}</p> : null}

                <button type="submit" disabled={loading} className={botaoClass}>
                  {loading ? "Procurando sua compra…" : passo.botao}
                </button>

                <div className="flex flex-wrap items-center justify-center gap-x-4 gap-y-1">
                  {etapa === "cpf" ? (
                    <button type="button" onClick={() => irPara("nome")} className={linkClass}>
                      {ENTRADA.etapas.cpf.pular}
                    </button>
                  ) : null}
                  {etapa !== "email" ? (
                    <button type="button" onClick={recomecar} className={linkClass}>
                      {ENTRADA.voltar}
                    </button>
                  ) : null}
                </div>
              </form>
            </>
          )}
        </div>

        <InstallBanner className="mt-4" />

        <p className="mt-4 text-center text-[11px] leading-snug text-muted-foreground/80">
          {IDENTITY.disclaimer}
        </p>
      </div>
    </div>
  );
}
