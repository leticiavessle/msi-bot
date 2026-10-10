/**
 * Troca do e-mail de acesso pelo painel, com a confirmação de juntar quando o e-mail novo já tem outro cadastro.
 * Usado na ficha da aluna e na aba Acessos (Entrada no bot e Área de membros).
 */
type Resultado =
  | { ok: true; email: string; juntou: boolean }
  | { ok: false; precisaJuntar: true; outro: { email: string; name: string | null; status: string } };

type Dados = {
  authorizedUserId?: string | null;
  emailAtual?: string | null;
  novoEmail: string;
  alertaId?: string | null;
  juntar?: boolean;
};

const STATUS: Record<string, string> = {
  active: "ativo",
  blocked: "bloqueado",
  refunded: "reembolsado",
  canceled: "cancelado",
};

/** true = trocou (ou juntou); false = a pessoa da equipe desistiu na confirmação. */
export async function trocarEmailConfirmando(trocar: (d: Dados) => Promise<Resultado>, dados: Dados): Promise<boolean> {
  const res = await trocar(dados);
  if (res.ok) return true;
  const { outro } = res;
  const juntar = window.confirm(
    `O e-mail ${dados.novoEmail} já tem outro cadastro (${outro.name ?? "sem nome"}, ${STATUS[outro.status] ?? outro.status}).\n\n` +
      "Juntar os dois? Os produtos somam, a conversa antiga continua e ela passa a entrar com o e-mail novo.",
  );
  if (!juntar) return false;
  const final = await trocar({ ...dados, juntar: true });
  return final.ok;
}
