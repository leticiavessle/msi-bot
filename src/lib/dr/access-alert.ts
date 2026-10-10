/**
 * Detecção de "dificuldade de acesso" à área de membros e agrupamento por pessoa.
 * Módulo puro (sem banco) para ser testável. Não altera resposta do bot.
 */
import { ACESSO_EXCLUIR_RE } from "../../oferta/atalhos";

const strip = (t: string) =>
  t.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().replace(/\s+/g, " ").trim();

const NEG = "(?:nao|n|nem|ainda nao|nunca)";
const PLATFORM = "(?:aulas?|curso|conteudos?|modulos?|videos?|area|plataforma|membros|materia(?:l|is) do curso)";

const TRIGGERS: RegExp[] = [
  // não consigo acessar / entrar / logar
  new RegExp(`\\b${NEG} (?:\\w+ ){0,2}(?:consig\\w*|consegu\\w*|to conseguindo|estou conseguindo)\\b.{0,30}\\b(?:acess\\w*|entrar|entra|logar|login|abrir)`),
  // não consigo ver / assistir as aulas
  new RegExp(`\\b${NEG} (?:\\w+ ){0,2}(?:consig\\w*|consegu\\w*)\\b.{0,20}\\b(?:ver|assistir|achar|encontrar)\\b.{0,25}\\b${PLATFORM}`),
  // não recebi o e-mail / não chegou o link
  new RegExp(`\\b${NEG} (?:\\w+ ){0,1}(?:recebi|recebo|chegou|chega|veio|mandaram|enviaram)\\b.{0,30}\\b(?:e-?mail|link|acesso|login|senha)`),
  new RegExp(`\\b(?:e-?mail|link) de acesso\\b.{0,25}\\b${NEG} (?:chegou|veio|recebi)`),
  // login/senha não funciona
  new RegExp(`\\b(?:login|senha|acesso)\\b.{0,25}\\b${NEG} (?:\\w+ ){0,1}(?:funciona|entra|abre|vai|aceita|passa|libera)`),
  // comprei e não liberou
  new RegExp(`\\bcomprei\\b.{0,40}\\b${NEG} (?:\\w+ ){0,1}(?:liberou|libera|foi liberad\\w*|apareceu|aparece|recebi|chegou)`),
  new RegExp(`\\b${NEG} (?:foi |me )?liberou (?:nada|o acesso|meu acesso|o curso)`),
  // não acho o curso / entrei e não aparece nada
  new RegExp(`\\b${NEG} (?:acho|encontro|localizo)\\b.{0,15}\\b${PLATFORM}`),
  new RegExp(`\\bentrei\\b.{0,30}\\b${NEG} (?:aparece|tem|mostra)\\b`),
  new RegExp(`\\b${NEG} aparece nada\\b`),
  // pedindo senha e não tenho
  new RegExp(`\\b(?:pedindo|pede|pediu|solicitando)\\b.{0,15}\\bsenha\\b`),
  // link que mandaram não abre
  new RegExp(`\\blink\\b.{0,40}\\b${NEG} (?:abre|funciona|carrega|vai)`),
];

/** Assuntos que NÃO são área de membros (lista em src/oferta/atalhos.ts). */
const EXCLUDE = ACESSO_EXCLUIR_RE;

export function isAccessComplaint(text: string | null | undefined): boolean {
  if (!text) return false;
  const t = strip(text);
  if (t.length < 6) return false;
  if (EXCLUDE.test(t)) return false;
  return TRIGGERS.some((r) => r.test(t));
}

export type AccessAlertRow = {
  id: string;
  user_id: string;
  conversation_id: string | null;
  trigger_text: string;
  status: string;
  reopened: boolean;
  from_retention?: boolean;
  /** Dupla checagem: entrou no bot pelo nome ou WhatsApp (sem link de acesso direto). */
  conferir_identidade?: boolean;
  entrada_via?: string | null;
  resolved_by: string | null;
  resolved_at: string | null;
  created_at: string;
};

/** Novo alerta volta como "voltou a reclamar" se a pessoa tinha resolvidos e nenhum pendente. */
export function shouldMarkReopened(existing: Pick<AccessAlertRow, "status">[]): boolean {
  return existing.some((a) => a.status === "resolved") && !existing.some((a) => a.status === "pending");
}

export type AccessPerson = {
  userId: string;
  count: number;
  latestAt: string;
  latestText: string;
  conversationId: string | null;
  reopened: boolean;
  fromRetention: boolean;
  /** Por onde entrou no bot, quando precisa conferir a identidade antes de mandar link ("nome" ou "whatsapp"). */
  conferirVia: string | null;
  resolvedAt: string | null;
  resolvedBy: string | null;
};

/** Uma linha por pessoa. pending: só alertas pendentes; resolved: quem não tem pendente. */
export function groupAccessAlerts(rows: AccessAlertRow[], view: "pending" | "resolved"): AccessPerson[] {
  const byUser = new Map<string, AccessAlertRow[]>();
  for (const r of rows) byUser.set(r.user_id, [...(byUser.get(r.user_id) ?? []), r]);
  const out: AccessPerson[] = [];
  for (const [userId, all] of byUser) {
    const pending = all.filter((a) => a.status === "pending");
    const pick = view === "pending" ? pending : pending.length ? [] : all.filter((a) => a.status === "resolved");
    if (!pick.length) continue;
    pick.sort((a, b) => b.created_at.localeCompare(a.created_at));
    const latest = pick[0]!;
    const lastResolved = all
      .filter((a) => a.resolved_at)
      .sort((a, b) => b.resolved_at!.localeCompare(a.resolved_at!))[0];
    out.push({
      userId,
      count: pick.length,
      latestAt: latest.created_at,
      latestText: latest.trigger_text,
      conversationId: latest.conversation_id,
      reopened: pick.some((a) => a.reopened),
      fromRetention: pick.some((a) => a.from_retention),
      conferirVia: latest.conferir_identidade ? (latest.entrada_via ?? "nome") : null,
      resolvedAt: lastResolved?.resolved_at ?? null,
      resolvedBy: lastResolved?.resolved_by ?? null,
    });
  }
  return out.sort((a, b) => b.latestAt.localeCompare(a.latestAt));
}
