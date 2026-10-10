/** Utilitários client-safe para ler CSVs de alunos (formato simples ou export da Hubla). */

import { PRODUCTS, PRODUTO_PADRAO, type Product as ProductKey } from "./config";
import { DA_OFERTA_RE, MAPA_NOMES_DE_PRODUTO, SEM_ACESSO_RE } from "../../oferta/produtos";
import { normalizarCpf, normalizarTelefone, soDigitos } from "./identificacao";
export type { ProductKey };
export type ImportStatus = "active" | "blocked" | "refunded" | "canceled";

export type ImportRow = {
  email: string;
  name: string | null;
  products: ProductKey[];
  status: ImportStatus;
  enteredAt?: string | null;
  /** CPF só com números (válido) e telefone com 55: viram código + final no servidor (entrada no bot). */
  cpf?: string | null;
  telefone?: string | null;
};

export type SkippedRow = { email: string; reason: string };

export type ParsedImport = {
  /** planilha = export com cabeçalho de outra plataforma (Payt, LastLink...). */
  format: "hubla" | "simples" | "cademi" | "planilha";
  rows: ImportRow[];
  skipped: number;
  skippedRows: SkippedRow[];
  refunded: number;
  linesRead: number;
  /** Colunas usadas para CPF, WhatsApp, nome e status (para conferir no resumo do painel). */
  colunas?: Partial<Record<DadoDaPlanilha, string>>;
  /** Planilha sem coluna de status do pagamento: o painel pergunta antes de liberar acesso. */
  semStatus?: boolean;
};

/** Parser de CSV que respeita aspas e detecta o separador (`,` ou `;`). */
export function parseCsv(text: string): string[][] {
  const clean = text.replace(/^\uFEFF/, "");
  const firstLine = clean.split(/\r?\n/, 1)[0] ?? "";
  const semis = (firstLine.match(/;/g) ?? []).length;
  const commas = (firstLine.match(/,/g) ?? []).length;
  const delimiter = semis > commas ? ";" : ",";

  const rows: string[][] = [];
  let row: string[] = [];
  let field = "";
  let quoted = false;

  for (let i = 0; i < clean.length; i += 1) {
    const char = clean[i];
    if (quoted) {
      if (char === '"') {
        if (clean[i + 1] === '"') {
          field += '"';
          i += 1;
        } else {
          quoted = false;
        }
      } else {
        field += char;
      }
      continue;
    }
    if (char === '"') {
      quoted = true;
    } else if (char === delimiter) {
      row.push(field.trim());
      field = "";
    } else if (char === "\n") {
      row.push(field.trim());
      if (row.some((c) => c !== "")) rows.push(row);
      row = [];
      field = "";
    } else if (char !== "\r") {
      field += char;
    }
  }
  row.push(field.trim());
  if (row.some((c) => c !== "")) rows.push(row);
  return rows;
}

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

/** Status de fatura que liberam acesso. Comparação EXATA (nunca "contém"). */
const PAID_STATUSES = new Set(["paga", "aprovada", "ativa"]);

/** true só se o status bate exatamente com Paga, Aprovada ou Ativa. */
export function isPaidInvoiceStatus(raw: string): boolean {
  return PAID_STATUSES.has(normalize(raw));
}

function normalize(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim();
}

/** Mapeia o nome do produto/oferta para o produto interno (null = não libera o bot). */
export function productFromName(raw: string): ProductKey | null {
  return resolveProductName(raw).products[0] ?? null;
}

/**
 * Resolve o nome do produto em produtos internos (regras em src/oferta/produtos.ts).
 * - products=[] + outraOferta: produto de outro expert vendido na mesma conta (não libera o bot).
 * - products=[]: produto da oferta que NÃO concede acesso (MSI: Plataforma Soffia AI).
 * - known=false: nome da oferta ainda não mapeado (cai no produto padrão).
 */
export function resolveProductName(raw: string): { products: ProductKey[]; known: boolean; outraOferta?: true } {
  const n = normalize(raw);
  // Sem nome de produto (arquivo sem a coluna): produto padrão, marcado como não confirmado.
  if (!n) return { products: [PRODUTO_PADRAO], known: false };
  if (!DA_OFERTA_RE.test(n)) return { products: [], known: true, outraOferta: true };
  if (SEM_ACESSO_RE.some((re) => re.test(n))) return { products: [], known: true };
  const rule = MAPA_NOMES_DE_PRODUTO.find((r) => r.re.test(n));
  if (rule) return { products: [...rule.products], known: true };
  return { products: [PRODUTO_PADRAO], known: false };
}

function findColumn(header: string[], candidates: string[]) {
  const normalized = header.map(normalize);
  for (const candidate of candidates) {
    const idx = normalized.indexOf(normalize(candidate));
    if (idx >= 0) return idx;
  }
  return -1;
}

const CADEMI_HEADER = "id,nome,email,cpf,celular,gratuito,login_auto,criado_em,primeiro_acesso_em,ultimo_acesso_em,tags";

/* ------------------------------------------------------------------ */
/* Colunas pelo nome (cada plataforma escreve de um jeito)             */
/* ------------------------------------------------------------------ */

export type DadoDaPlanilha = "email" | "nome" | "cpf" | "telefone" | "produto" | "status" | "reembolso";

/**
 * Como reconhecer cada coluna. Ex.: "CPF / CNPJ", "Documento (CPF/CNPJ)", "Documento do cliente",
 * "Telefone / WhatsApp", "Telefone/Celular (Customer Phone)", "Nome do Comprador", "E-mail (Customer Email)".
 * Comparado sem acento e em minúsculas.
 */
const COLUNAS: Record<DadoDaPlanilha, { tem: RegExp[]; evitar?: RegExp[]; preferir?: RegExp[] }> = {
  email: { tem: [/e-?\s?mail/] },
  nome: {
    // "Cliente" sozinho (Payt) também é o nome.
    tem: [/\bnome\b/, /\bname\b/, /^(cliente|comprador|compradora|customer|buyer|membro|aluna|aluno)$/],
    evitar: [/e-?\s?mail/, /produt/, /ofert/, /product/, /offer/, /\bplano\b/, /\bplan\b/, /cupom/, /coupon/, /curso/],
  },
  cpf: { tem: [/\bcpf\b/, /\bdocumento\b/, /\bdocument\b/, /^doc$/], evitar: [/\btipo\b/, /\btype\b/] },
  telefone: { tem: [/telefone/, /celular/, /whats/, /\bphone\b/, /\bfone\b/] },
  produto: {
    tem: [/produto/, /\bproduct\b/, /oferta/, /\boffer\b/],
    evitar: [/\bid\b/, /codigo/, /\bcode\b/, /valor/, /preco/, /price/, /quantidade/, /\bqtd\b/, /tipo/],
    preferir: [/nome/, /name/],
  },
  status: { tem: [/status/, /situacao/], preferir: [/pagamento/, /fatura/, /transa/, /venda/, /compra/, /payment/] },
  reembolso: { tem: [/reembols/, /refund/, /estorno/] },
};
/** Colunas de outras pessoas da venda (afiliado, produtor...) nunca valem. */
const NUNCA = [/afiliad/, /affiliate/, /produtor/, /producer/, /vendedor/, /seller/, /coprodu/, /parceir/, /partner/];
const COMPRADOR = [/cliente/, /comprador/, /customer/, /buyer/, /\balun[ao]\b/, /\blead\b/, /membro/];

/** Índice da coluna do dado (preferindo as do comprador), ou -1. */
export function acharColuna(header: string[], dado: DadoDaPlanilha): number {
  const regra = COLUNAS[dado];
  const candidatas = header
    .map((h, i) => ({ h: normalize(h), i }))
    .filter(({ h }) => regra.tem.some((re) => re.test(h)))
    .filter(({ h }) => !NUNCA.some((re) => re.test(h)) && !(regra.evitar ?? []).some((re) => re.test(h)));
  const preferidas = [...(regra.preferir ?? []), ...COMPRADOR];
  return (candidatas.find(({ h }) => preferidas.some((re) => re.test(h))) ?? candidatas[0])?.i ?? -1;
}

/** CPF e telefone de uma linha (com a coluna de DDD separada, se houver). */
function lerReserva(cols: string[], idx: { cpf: number; telefone: number; ddd: number }) {
  const cpf = idx.cpf >= 0 ? normalizarCpf(cols[idx.cpf], { completarZeros: true }) : null;
  let fone = idx.telefone >= 0 ? (cols[idx.telefone] ?? "") : "";
  const ddd = idx.ddd >= 0 ? soDigitos(cols[idx.ddd]) : "";
  if (ddd.length === 2 && [8, 9].includes(soDigitos(fone).length)) fone = ddd + soDigitos(fone);
  return { cpf, telefone: normalizarTelefone(fone) };
}

function indicesDeReserva(header: string[]) {
  return {
    cpf: acharColuna(header, "cpf"),
    telefone: acharColuna(header, "telefone"),
    ddd: header.findIndex((h) => /^ddd\b/.test(normalize(h))),
  };
}

function nomesDasColunas(header: string[], idx: Partial<Record<DadoDaPlanilha, number>>) {
  const out: Partial<Record<DadoDaPlanilha, string>> = {};
  for (const [dado, i] of Object.entries(idx) as [DadoDaPlanilha, number][]) if (i >= 0) out[dado] = header[i]!;
  return out;
}

/** Linha repetida (várias compras da mesma pessoa): fica o primeiro CPF/telefone preenchido. */
function completarReserva(atual: ImportRow, cpf: string | null, telefone: string | null) {
  if (!atual.cpf && cpf) atual.cpf = cpf;
  if (!atual.telefone && telefone) atual.telefone = telefone;
}

/**
 * Status de outras plataformas. Ex.: Payt "Compra Aprovada", "Aguardando Pagamento", "Período Grátis",
 * "Cancelada", "Compra Reembolsada"; LastLink "Aprovada", "Expirada" (pix/boleto que venceu sem pagar).
 * Devolvido e não pago são conferidos antes de pago ("Aguardando Pagamento" tem "pagamento").
 */
const DEVOLVIDO_RE = /reembols|estorn|chargeback|cancel|refund|disput|contest|devolv/;
const NAO_PAGO_RE = /aguard|pendent|recus|negad|expir|vencid|abandon|gratis|trial|atrasad|falh|analise|bloquead/;
const PAGO_RE = /aprovad|\bpag[ao]\b|conclu|finaliz|complet|confirmad|liberad|\bativ[ao]\b|\bpaid\b|approved|\bactive\b/;

export function situacaoDoPagamento(bruto: string): "pago" | "devolvido" | "nao_pago" | "desconhecido" {
  const st = normalize(bruto);
  if (DEVOLVIDO_RE.test(st)) return "devolvido";
  if (NAO_PAGO_RE.test(st)) return "nao_pago";
  return PAGO_RE.test(st) ? "pago" : "desconhecido";
}

function motivoSemAcesso(resolved: { outraOferta?: true }, nome: string) {
  return resolved.outraOferta ? `produto de outra oferta (${nome})` : `produto sem acesso ao bot (${nome})`;
}

/** Lê o CSV e devolve os alunos prontos para importação. */
export function parseStudentsCsv(text: string): ParsedImport {
  const table = parseCsv(text);
  if (table.length === 0)
    return { format: "simples", rows: [], skipped: 0, skippedRows: [], refunded: 0, linesRead: 0 };

  const header = table[0]!;
  const byEmail = new Map<string, ImportRow>();
  const skippedRows: SkippedRow[] = [];
  const skip = (email: string, reason: string) => skippedRows.push({ email, reason });

  // Alunos da Cademí. A coluna login_auto (token) nunca é lida.
  if (header.map(normalize).join(",") === CADEMI_HEADER) {
    const nameIdx = 1;
    const emailCol = 2;
    const createdIdx = 7;
    for (const cols of table.slice(1)) {
      const email = (cols[emailCol] ?? "").toLowerCase().trim();
      if (!EMAIL_RE.test(email) || email.length > 255) {
        skip(email || "(sem e-mail)", "e-mail inválido");
        continue;
      }
      if (byEmail.has(email)) {
        skip(email, "e-mail repetido no arquivo");
        continue;
      }
      byEmail.set(email, {
        email,
        name: (cols[nameIdx] ?? "").trim().slice(0, 120) || null,
        products: [PRODUTO_PADRAO],
        status: "active",
        enteredAt: (cols[createdIdx] ?? "").trim().slice(0, 40) || null,
        ...lerReserva(cols, { cpf: 3, telefone: 4, ddd: -1 }),
      });
    }
    return {
      format: "cademi",
      rows: [...byEmail.values()],
      skipped: skippedRows.length,
      skippedRows,
      refunded: 0,
      linesRead: table.length - 1,
    };
  }

  const temCabecalho = !header.some((c) => EMAIL_RE.test(c.trim()));
  const emailIdx = findColumn(header, ["Email do cliente", "E-mail do cliente", "email", "e-mail"]);
  const isHubla =
    temCabecalho && findColumn(header, ["ID da fatura", "Status da fatura", "Email do cliente", "Nome do cliente"]) >= 0;
  const hn = header.map(normalize);
  const isSimplesComCabecalho =
    temCabecalho &&
    ["email", "e-mail"].includes(hn[0] ?? "") &&
    hn.slice(1).every((h) => ["nome", "produtos", "produto", "cpf", "telefone", "whatsapp", ""].includes(h));

  if (isHubla) {
    const nameIdx = findColumn(header, ["Nome do cliente", "nome"]);
    const productIdx = findColumn(header, ["Nome do produto"]);
    const offerIdx = findColumn(header, ["Nome da oferta"]);
    const statusIdx = findColumn(header, ["Status da fatura"]);
    const refundIdx = findColumn(header, ["Data de reembolso"]);
    const reserva = indicesDeReserva(header);

    for (const cols of table.slice(1)) {
      const email = (cols[emailIdx] ?? "").toLowerCase().trim();
      if (!EMAIL_RE.test(email)) {
        skip(email || "(sem e-mail)", "e-mail inválido");
        continue;
      }
      const invoiceStatus = normalize(statusIdx >= 0 ? (cols[statusIdx] ?? "") : "");
      const refunded = Boolean(refundIdx >= 0 && (cols[refundIdx] ?? "").trim());
      const isPaid = isPaidInvoiceStatus(invoiceStatus);
      if (refunded) {
        skip(email, "fatura com data de reembolso");
        continue;
      }
      if (!isPaid) {
        skip(email, `fatura não paga (${invoiceStatus || "sem status"})`);
        continue;
      }

      const productName =
        (productIdx >= 0 ? cols[productIdx] : "") || (offerIdx >= 0 ? cols[offerIdx] : "") || "";
      const resolved = resolveProductName(productName);
      if (resolved.products.length === 0) {
        skip(email, motivoSemAcesso(resolved, productName));
        continue;
      }
      const name = (nameIdx >= 0 ? (cols[nameIdx] ?? "").trim() : "") || null;
      const { cpf, telefone } = lerReserva(cols, reserva);

      const current = byEmail.get(email);
      if (!current) {
        byEmail.set(email, { email, name, products: [...resolved.products], status: "active", cpf, telefone });
        continue;
      }
      for (const product of resolved.products)
        if (!current.products.includes(product)) current.products.push(product);
      if (!current.name && name) current.name = name;
      completarReserva(current, cpf, telefone);
    }

    return {
      format: "hubla",
      rows: [...byEmail.values()],
      skipped: skippedRows.length,
      skippedRows,
      refunded: skippedRows.filter((r) => r.reason.includes("reembolso")).length,
      linesRead: table.length - 1,
      colunas: nomesDasColunas(header, { cpf: reserva.cpf, telefone: reserva.telefone, nome: nameIdx }),
    };
  }

  // Export com cabeçalho de outra plataforma (Payt, LastLink...): colunas pelo nome.
  if (temCabecalho && !isSimplesComCabecalho && acharColuna(header, "email") >= 0) {
    const idx = {
      email: acharColuna(header, "email"),
      nome: acharColuna(header, "nome"),
      produto: acharColuna(header, "produto"),
      status: acharColuna(header, "status"),
      reembolso: acharColuna(header, "reembolso"),
    };
    const reserva = indicesDeReserva(header);
    for (const cols of table.slice(1)) {
      const email = (cols[idx.email] ?? "").toLowerCase().trim();
      if (!EMAIL_RE.test(email) || email.length > 255) {
        skip(email || "(sem e-mail)", "e-mail inválido");
        continue;
      }
      if (idx.reembolso >= 0 && (cols[idx.reembolso] ?? "").trim()) {
        skip(email, "reembolso registrado na planilha");
        continue;
      }
      if (idx.status >= 0) {
        const bruto = (cols[idx.status] ?? "").trim();
        const situacao = situacaoDoPagamento(bruto);
        if (situacao !== "pago") {
          skip(
            email,
            situacao === "devolvido"
              ? `reembolso/cancelamento (${bruto})`
              : situacao === "nao_pago"
                ? `não pago (${bruto})`
                : `status não reconhecido como pago (${bruto || "vazio"})`,
          );
          continue;
        }
      }
      const productName = idx.produto >= 0 ? (cols[idx.produto] ?? "").trim() : "";
      const resolved = productName ? resolveProductName(productName) : null;
      if (resolved && resolved.products.length === 0) {
        skip(email, motivoSemAcesso(resolved, productName));
        continue;
      }
      // Produto desconhecido ou sem coluna: vai vazio e o servidor usa o produto padrão (marcado como "padrão").
      const products = resolved?.known ? [...resolved.products] : [];
      const name = (idx.nome >= 0 ? (cols[idx.nome] ?? "").trim().slice(0, 120) : "") || null;
      const { cpf, telefone } = lerReserva(cols, reserva);
      const current = byEmail.get(email);
      if (!current) {
        byEmail.set(email, { email, name, products, status: "active", cpf, telefone });
        continue;
      }
      for (const product of products) if (!current.products.includes(product)) current.products.push(product);
      if (!current.name && name) current.name = name;
      completarReserva(current, cpf, telefone);
    }
    return {
      format: "planilha",
      rows: [...byEmail.values()],
      skipped: skippedRows.length,
      skippedRows,
      refunded: skippedRows.filter((r) => r.reason.includes("reembolso")).length,
      linesRead: table.length - 1,
      colunas: nomesDasColunas(header, { ...idx, cpf: reserva.cpf, telefone: reserva.telefone }),
      semStatus: idx.status < 0 && idx.reembolso < 0,
    };
  }

  // Formato simples: email;nome;produtos[;cpf;telefone] (com ou sem cabeçalho)
  const validProducts: ProductKey[] = [...PRODUCTS];
  for (const cols of isSimplesComCabecalho ? table.slice(1) : table) {
    const email = (cols[0] ?? "").toLowerCase().trim();
    if (!EMAIL_RE.test(email)) {
      skip(email || "(sem e-mail)", "e-mail inválido");
      continue;
    }
    const products = (cols[2] ?? "")
      .split(/[|/]/)
      .map((p) => normalize(p))
      .filter((p): p is ProductKey => validProducts.includes(p as ProductKey));
    byEmail.set(email, {
      email,
      name: (cols[1] ?? "").trim() || null,
      products: products.length ? products : [PRODUTO_PADRAO],
      status: "active",
      ...lerReserva(cols, { cpf: 3, telefone: 4, ddd: -1 }),
    });
  }

  return {
    format: "simples",
    rows: [...byEmail.values()],
    skipped: skippedRows.length,
    skippedRows,
    refunded: 0,
    linesRead: isSimplesComCabecalho ? table.length - 1 : table.length,
  };
}

/** Lê CSV de revogação: colunas email,motivo (cabeçalho opcional). */
export function parseRevokeCsv(text: string): { rows: { email: string; reason: string }[]; invalid: number } {
  const table = parseCsv(text);
  const rows: { email: string; reason: string }[] = [];
  let invalid = 0;
  if (table.length === 0) return { rows, invalid };
  const header = table[0]!.map(normalize);
  const hasHeader = !EMAIL_RE.test((table[0]![0] ?? "").trim());
  const emailIdx = hasHeader ? Math.max(0, header.findIndex((h) => h === "email" || h === "e-mail")) : 0;
  const reasonIdx = hasHeader ? header.findIndex((h) => h === "motivo" || h === "reason") : 1;
  for (const cols of hasHeader ? table.slice(1) : table) {
    const email = (cols[emailIdx] ?? "").toLowerCase().trim();
    if (!EMAIL_RE.test(email) || email.length > 255) {
      invalid += 1;
      continue;
    }
    rows.push({ email, reason: (reasonIdx >= 0 ? (cols[reasonIdx] ?? "") : "").trim().slice(0, 300) });
  }
  return { rows, invalid };
}
