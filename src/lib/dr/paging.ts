/**
 * Lê todas as linhas de uma consulta em páginas de 1.000 (o banco devolve no
 * máximo 1.000 por vez; `.limit(50000)` NÃO passa desse teto).
 */
export async function fetchAll<T>(
  fn: (from: number, to: number) => PromiseLike<{ data: T[] | null; error?: unknown }>,
  maxPages = 200,
): Promise<T[]> {
  const out: T[] = [];
  for (let i = 0; i < maxPages; i++) {
    const { data, error } = await fn(i * 1000, i * 1000 + 999);
    if (error) throw new Error(String((error as { message?: string }).message ?? error));
    out.push(...(data ?? []));
    if (!data || data.length < 1000) break;
  }
  return out;
}

/** Dia (AAAA-MM-DD) no fuso de Brasília. */
export function spDayKey(d: Date | string): string {
  return new Date(d).toLocaleDateString("sv-SE", { timeZone: "America/Sao_Paulo" });
}
