import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { groupAccessAlerts, isAccessComplaint, shouldMarkReopened, type AccessAlertRow } from "./access-alert";

describe("alerta de acesso: dispara", () => {
  for (const s of [
    "não estou conseguindo acessar a área de membros",
    "não consigo ver as aulas",
    "não consigo entrar na plataforma",
    "não recebi o e-mail de acesso",
    "não chegou o link",
    "meu login não funciona",
    "minha senha não entra",
    "comprei e não liberou nada",
    "não acho o curso",
    "entrei e não aparece nada",
    "está pedindo senha e eu não tenho",
    "o link que vocês mandaram não abre",
  ]) test(s, () => assert.equal(isAccessComplaint(s), true));
});

describe("alerta de acesso: não dispara", () => {
  for (const s of [
    "não consigo entrar na minha conta do Workana",
    "não consigo acessar o app do AttaPoll",
    "não consigo entrar no grupo da comunidade",
    "não consigo logar no 99Freelas",
    "como funciona o acesso à área de membros?",
    "quanto tempo leva pra ter resultado?",
  ]) test(s, () => assert.equal(isAccessComplaint(s), false));
});

const row = (p: Partial<AccessAlertRow>): AccessAlertRow => ({
  id: crypto.randomUUID(), user_id: "u1", conversation_id: "c1", trigger_text: "não consigo entrar",
  status: "pending", reopened: false, resolved_by: null, resolved_at: null, created_at: "2026-09-27T10:00:00Z", ...p,
});

describe("agrupamento e reenvio", () => {
  test("mesma pessoa reclamando duas vezes vira uma linha", () => {
    const g = groupAccessAlerts([row({}), row({ created_at: "2026-09-27T11:00:00Z" })], "pending");
    assert.equal(g.length, 1);
    assert.equal(g[0]!.count, 2);
  });
  test("marcada como reenviada e volta a reclamar", () => {
    const resolved = [row({ status: "resolved", resolved_at: "2026-09-27T12:00:00Z", resolved_by: "adm" })];
    assert.equal(groupAccessAlerts(resolved, "pending").length, 0);
    assert.equal(groupAccessAlerts(resolved, "resolved").length, 1);
    assert.equal(shouldMarkReopened(resolved), true);
    const again = [...resolved, row({ reopened: true, created_at: "2026-09-27T13:00:00Z" })];
    const g = groupAccessAlerts(again, "pending");
    assert.equal(g.length, 1);
    assert.equal(g[0]!.reopened, true);
    assert.equal(groupAccessAlerts(again, "resolved").length, 0);
  });
});
