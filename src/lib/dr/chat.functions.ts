import { createServerFn } from "@tanstack/react-start";
import { requireSupabaseAuth } from "@/integrations/supabase/auth-middleware";
import { z } from "zod";
import { IDENTITY, INTENT_COMUNIDADE, PRODUCTS, PRODUTO_PADRAO, PRODUTO_RECORRENTE, QUICK_ACTIONS, type Product } from "./config";
import { LESSON_URL_RE, NOMES_DOS_NIVEIS, PRIMEIRAS_AULAS, ROTULO_NIVEL } from "../../oferta/aulas";
import { ATALHOS_EXECUCAO, CASOS_ATENDIMENTO_HUMANO } from "../../oferta/atalhos";
import { ATENDIMENTO_HUMANO, COMUNIDADE, communityUrlFor, supportUrlFor } from "../../oferta/produtos";
import { serverHandledHumanCase, textoDuplaChecagem } from "./human-cases";
import { viaPrecisaConferir } from "./identificacao";
import { buildSystemPrompt, detectRefundRisk, type MemoryRow } from "./prompt";
import { PROMPT_BLOCKS } from "./prompt-blocks";
import { parseAttachments, type ChatAttachment } from "./attachments";
import { extractOfficialLinks, mergeLinkAttachments, officialLink, type OfficialLinkKey } from "./official-links";
import { isAdsTechnical, matchSupportAnswers, supportAnswerKnowledge } from "./support-answers";
import {
  EMPTY_FLOW,
  advanceFlow,
  firstName,
  hasLifeRisk,
  isFlowStale,
  isNewRefundRequest,
  isHypotheticalRefund,
  isRefundTrigger,
  isCancelRequest,
  cancelContext,
  isDeadlineFollowUp,
  COBRANCA_PRAZO,
  guardRefundOutput,
  startFlow,
  type RefundFlowState,
  type RefundOutputGuard,
  hasLegalThreat,
  AMEACA_JURIDICA,
  fillName,
  asksWhatsappLinkAgain,
  looksLikeDiagnosisAnswer,
  WHATSAPP_THANKS,
  WHATSAPP_LINK_DE_NOVO,
  HUMANO_DE_NOVO,
  NOME_ATIVACAO,
  ATIVACAO_ALERTA_PREFIXO,
} from "./refund-protocol";

/* Casos oficiais que liberam o cartão de atendimento humano fora do 7D: src/oferta/atalhos.ts. */
/** Pedido explícito de atendimento humano. */
const HUMAN_REQUEST_RE =
  /\b(falar|conversar)\s+com\s+(um\s+|uma\s+|o\s+|a\s+)?(humano|atendente|pessoa|algu[eé]m|suporte|time|atendimento)|\b(cad[eê]|quero|chama|chamar)\s+(o\s+|um\s+|a\s+)?(atendente|humano|atendimento)\b/i;

/** Pergunta de "por onde começo" / primeiros passos. */
const START_RE =
  /\b(por\s+onde\s+(eu\s+)?come[çc]|o\s+que\s+(eu\s+)?fa[çc]o\s+primeiro|primeiros?\s+passos?|como\s+(eu\s+)?come[çc]o|come[çc]ar\s+do\s+zero)\b/i;

/** Primeiras aulas da jornada (link na área de membros). */
const FIRST_LESSONS = PRIMEIRAS_AULAS;

function lessonKey(chunkId: string) {
  return chunkId.replace(/-\d+$/, "");
}

const SHOWCASE_NAMES: Record<number, string> = NOMES_DOS_NIVEIS;

type LessonDetails = {
  lessonId: string;
  url: string;
  title: string;
  level: number;
  module: number;
  lessonNumber: string;
};

/** O link e o nome oficial da aula ficam no primeiro bloco (-01). */
async function loadLessonDetails(admin: AdminClient, chunkIds: string[]) {
  const keys = [...new Set(chunkIds.map(lessonKey))];
  const map = new Map<string, LessonDetails>();
  if (!keys.length) return map;
  const { data } = await admin
    .from("course_chunks")
    .select("id, content, lesson, title, level, module")
    .in(
      "id",
      keys.map((k) => `${k}-01`),
    );
  for (const row of data ?? []) {
    const m = LESSON_URL_RE.exec(row.content ?? "");
    const key = lessonKey(row.id);
    const lessonNumber = /\.A(\d+)/i.exec(key)?.[1]?.replace(/^0+/, "") || "?";
    const officialTitle = row.lesson
      ?.split(/\s+—\s+/)
      .slice(1)
      .join(" — ")
      .trim();
    if (m && row.level != null && row.module != null) {
      map.set(key, {
        lessonId: key,
        url: m[0],
        title: officialTitle || row.title.split(":")[0] || "Aula",
        level: row.level,
        module: row.module,
        lessonNumber,
      });
    }
  }
  return map;
}

function lessonAttachment(details: LessonDetails, minute?: string | null): ChatAttachment {
  const showcase = SHOWCASE_NAMES[details.level];
  const minuteLabel = minute?.trim() || "0:00";
  return {
    kind: "lesson",
    url: details.url,
    lessonId: details.lessonId,
    title: details.title,
    location: `${ROTULO_NIVEL} ${details.level}${showcase ? ` (${showcase})` : ""} · Módulo ${details.module} · Aula ${details.lessonNumber} · minuto ${minuteLabel}`,
  };
}

function cleanLessonUrls(reply: string) {
  return reply
    .replace(new RegExp(LESSON_URL_RE.source, "gi"), "")
    .replace(/[ \t]+([.,;:!?])/g, "$1")
    .replace(/:\s*(?=\n|$)/g, ".")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

/** Atalho de execução respondido na hora (lista em src/oferta/atalhos.ts). */
function detectAtalho(text: string) {
  return ATALHOS_EXECUCAO.find((a) => a.re.test(text)) ?? null;
}

function detectSupportCase(text: string): string | null {
  return CASOS_ATENDIMENTO_HUMANO.find((c) => c.re.test(text))?.nota ?? null;
}

const sendSchema = z.object({
  conversationId: z.string().uuid(),
  content: z.string().trim().min(1).max(2000),
  intent: z.string().trim().max(60).optional().nullable(),
  /** Aparelho (dupla checagem: por onde ela entrou neste aparelho). */
  deviceId: z.string().trim().min(6).max(64).optional().nullable(),
  attachment: z
    .object({
      path: z.string().trim().min(3).max(400),
      name: z.string().trim().min(1).max(200),
      size: z
        .number()
        .int()
        .nonnegative()
        .max(8 * 1024 * 1024),
      mimeType: z.string().trim().max(120),
    })
    .nullable()
    .optional(),
});

const MATERIAL_INTENT_RE =
  /(material|materiais|arquivo|apostila|pdf|planilha|template|preset|lut|pack|download|baixar|anexo|link\s+d[oa])/i;

const MEMORY_FIELDS =
  "current_stage, main_difficulties, last_guidance, recommended_action, action_result, risk_level, next_action, current_difficulty, stuck_reason, last_evolution";

/** Carrega tudo que o chat precisa: produtos, memória e a conversa do próprio aluno. */
export const getChatBootstrap = createServerFn({ method: "GET" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    const { supabase, userId } = context;

    const [{ data: profile }, { data: productRows }, { data: memory }] = await Promise.all([
      supabase.from("profiles").select("name, email").eq("id", userId).maybeSingle(),
      supabase.from("user_products").select("product").eq("user_id", userId).eq("active", true),
      supabase.from("student_memory").select(MEMORY_FIELDS).eq("user_id", userId).maybeSingle(),
    ]);

    const products = (productRows ?? [])
      .map((r) => r.product as Product)
      .filter((p) => (PRODUCTS as readonly string[]).includes(p));

    let { data: conversation } = await supabase
      .from("conversations")
      .select("id, human_takeover_at")
      .eq("user_id", userId)
      .order("updated_at", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (!conversation) {
      const inserted = await supabase
        .from("conversations")
        .insert({ user_id: userId, title: "Conversa" })
        .select("id, human_takeover_at")
        .single();
      if (inserted.error) throw new Error("Não consegui abrir sua conversa. Tente novamente.");
      conversation = inserted.data;
    }

    const { data: messages } = await supabase
      .from("messages")
      .select("id, role, content, created_at, metadata")
      .eq("conversation_id", conversation.id)
      .order("created_at", { ascending: true })
      .limit(200);

    return {
      profile: { name: profile?.name ?? null, email: profile?.email ?? null },
      products,
      memory: (memory as MemoryRow | null) ?? null,
      conversationId: conversation.id,
      humanTakeover: Boolean(conversation.human_takeover_at),
      messages: (messages ?? []).map((m) => ({
        id: m.id,
        role: m.role as "user" | "assistant",
        content: m.content,
        createdAt: m.created_at,
        attachments: parseAttachments(m.metadata),
        human: Boolean((m.metadata as Record<string, unknown> | null)?.["human"]),
      })),
      welcome: IDENTITY.welcome,
    };
  });

/** Começa um atendimento do zero. A conversa anterior continua guardada no painel. */
export const startNewConversation = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .handler(async ({ context }) => {
    const { supabase, userId } = context;
    const { data, error } = await supabase
      .from("conversations")
      .insert({ user_id: userId, title: "Conversa" })
      .select("id")
      .single();
    if (error || !data) throw new Error("Não consegui abrir uma nova conversa.");
    return { conversationId: data.id };
  });

/** Mensagens anteriores a esta data seguem regras antigas e não entram no histórico do modelo. */
const RULES_UPDATED_AT = "2026-09-25T00:00:00Z";

export const sendChatMessage = createServerFn({ method: "POST" })
  .middleware([requireSupabaseAuth])
  .inputValidator((data: unknown) => sendSchema.parse(data))
  .handler(async ({ data, context }) => {
    const { supabase, userId } = context;

    // A conversa precisa ser do próprio aluno (RLS + checagem explícita).
    const { data: conversation } = await supabase
      .from("conversations")
      .select("id")
      .eq("id", data.conversationId)
      .eq("user_id", userId)
      .maybeSingle();
    if (!conversation) throw new Error("Conversa não encontrada.");

    // Produtos SEMPRE revalidados no backend — nunca vindos do frontend.
    const { data: productRows } = await supabase
      .from("user_products")
      .select("product")
      .eq("user_id", userId)
      .eq("active", true);
    const products = (productRows ?? []).map((r) => r.product as Product);

    // Trava nova (não existia no MGA): sem nenhum produto ativo, não conversa.
    // Fecha o caminho de quem cria conta direto pela API do Supabase sem ter comprado.
    if (products.length === 0) {
      throw new Error("Seu acesso não está ativo. Saia e entre de novo com o e-mail da sua compra.");
    }

    const { supabaseAdmin } = await import("@/integrations/supabase/client.server");

    // Dupla checagem (MSI, decisão d de 09/10): quem entrou pelo nome ou WhatsApp não recebe link de
    // acesso direto; o alerta de acesso vai para o painel com a etiqueta "conferir identidade".
    let entradaVia: Promise<string | null> | null = null;
    const comoEntrou = () =>
      (entradaVia ??= import("./access.server")
        .then(({ ultimaEntrada }) => ultimaEntrada(supabaseAdmin, userId, data.deviceId))
        .catch(() => null));
    const camposDeConferencia = async () => {
      const via = await comoEntrou();
      return { entrada_via: via, conferir_identidade: viaPrecisaConferir(via) };
    };

    // Alerta de dificuldade de acesso (só painel; não muda a resposta do bot).
    let accessAlerted = false;
    try {
      const { isAccessComplaint, shouldMarkReopened } = await import("./access-alert");
      if (isAccessComplaint(data.content)) {
        const { data: prev } = await supabaseAdmin
          .from("access_alerts")
          .select("status")
          .eq("user_id", userId)
          .limit(500);
        await supabaseAdmin.from("access_alerts").insert({
          user_id: userId,
          conversation_id: data.conversationId,
          trigger_text: data.content.slice(0, 1000),
          reopened: shouldMarkReopened(prev ?? []),
          ...(await camposDeConferencia()),
        });
        accessAlerted = true;
      }
    } catch (e) {
      console.error("access_alert_failed", e);
    }

    // Alerta de venda (MSI): pergunta de preço ou de como comprar. A resposta continua sendo
    // POLITICAS.respostaPreco ("essa informação é com o time"); a IA só diz que avisou o time
    // quando o alerta foi gravado de verdade (salesAlerted vai para o contexto do prompt).
    let salesAlerted = false;
    try {
      const { detectSalesInterest } = await import("./sales-alert");
      const interest = detectSalesInterest(data.content);
      if (interest) {
        const { error: salesError } = await supabaseAdmin.from("sales_alerts").insert({
          user_id: userId,
          conversation_id: data.conversationId,
          trigger_text: data.content.slice(0, 1000),
          product: interest.product,
        });
        salesAlerted = !salesError;
      }
    } catch (e) {
      console.error("sales_alert_failed", e);
    }

    // Conversa assumida pela equipe: grava a mensagem do aluno e o bot fica em silêncio.
    const { data: takeover } = await supabaseAdmin
      .from("conversations")
      .select("human_takeover_at")
      .eq("id", data.conversationId)
      .maybeSingle();
    if (takeover?.human_takeover_at) {
      const nowPaused = new Date().toISOString();
      const pausedAttachments: ChatAttachment[] =
        data.attachment && data.attachment.path.startsWith(`${userId}/`)
          ? [{ kind: "image", path: data.attachment.path, name: data.attachment.name, size: data.attachment.size }]
          : [];
      await supabaseAdmin.from("messages").insert({
        conversation_id: data.conversationId,
        user_id: userId,
        role: "user",
        content: data.content,
        detected_intent: data.intent ?? "atendimento_humano",
        created_at: nowPaused,
        metadata: {
          human_takeover: true,
          ...(pausedAttachments.length ? { attachments: pausedAttachments } : {}),
        },
      });
      await supabaseAdmin
        .from("conversations")
        .update({ updated_at: nowPaused, last_message_at: nowPaused })
        .eq("id", data.conversationId);
      return { paused: true as const };
    }

    if (data.intent === INTENT_COMUNIDADE) {
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: COMUNIDADE.mensagem,
        attachment: {
          kind: "support",
          url: communityUrlFor(products),
          label: COMUNIDADE.rotulo,
        },
      });
    }

    const { data: memory } = await supabase
      .from("student_memory")
      .select(MEMORY_FIELDS)
      .eq("user_id", userId)
      .maybeSingle();

    const { data: history } = await supabase
      .from("messages")
      .select("role, content, metadata, created_at")
      .eq("conversation_id", data.conversationId)
      .order("created_at", { ascending: false })
      .limit(20);

    // Anexo: o caminho precisa pertencer ao próprio aluno e o arquivo precisa existir.
    let imageDataUrl: string | null = null;
    let userAttachments: ChatAttachment[] = [];
    if (data.attachment) {
      if (!data.attachment.path.startsWith(`${userId}/`)) {
        throw new Error("Anexo inválido.");
      }
      if (!/^image\/(jpeg|png|webp|heic|heif)$/i.test(data.attachment.mimeType)) {
        throw new Error("Envie uma imagem JPG, PNG ou WEBP.");
      }
      const download = await supabaseAdmin.storage.from("uploads").download(data.attachment.path);
      if (download.error || !download.data) throw new Error("Não consegui ler a imagem enviada.");
      const buffer = await download.data.arrayBuffer();
      const base64 = Buffer.from(buffer).toString("base64");
      imageDataUrl = `data:${data.attachment.mimeType};base64,${base64}`;
      userAttachments = [
        {
          kind: "image",
          path: data.attachment.path,
          name: data.attachment.name,
          size: data.attachment.size,
        },
      ];
    }

    const nowIso = new Date().toISOString();
    await supabaseAdmin.from("messages").insert({
      conversation_id: data.conversationId,
      user_id: userId,
      role: "user",
      content: data.content,
      detected_intent: data.intent ?? null,
      created_at: nowIso,
      metadata: userAttachments.length ? { attachments: userAttachments } : {},
    });

    // Sinais internos de risco — nunca expostos ao aluno.
    const risk = detectRefundRisk(data.content);
    if (risk) {
      await supabaseAdmin.from("risk_alerts").insert({
        user_id: userId,
        conversation_id: data.conversationId,
        risk_level: risk.level,
        reason: `Sinais detectados: ${risk.signals.slice(0, 5).join(", ")}`,
        trigger_text: data.content.slice(0, 500),
      });
    }

    await supabaseAdmin.from("usage_events").insert({
      user_id: userId,
      event_name: "message_sent",
      metadata: { intent: data.intent ?? null, chars: data.content.length },
    });

    const retrieval = await import("./retrieval.server");
    const config = await retrieval.loadAssistantConfig(supabaseAdmin);
    const intents = retrieval.classifyIntents(data.content);

    const [chunks, materials] = await Promise.all([
      retrieval.searchCourseChunks(supabaseAdmin, products, data.content, {
        min: config.minChunks,
        max: config.maxChunks,
      }),
      retrieval.searchMaterials(supabaseAdmin, products, data.content),
    ]);

    const isStart = intents.includes("comecar") || START_RE.test(data.content);
    const adsTechnical = isAdsTechnical(data.content);
    let supportHits = matchSupportAnswers(data.content);
    // Continuação curta ("foi o Facebook que reprovou"): herda o assunto da pergunta anterior.
    if (supportHits.length === 0 && adsTechnical) {
      const prevUser = (history ?? []).find((m) => m.role === "user")?.content ?? "";
      supportHits = matchSupportAnswers(`${prevUser}\n${data.content}`);
    }
    const supportLessons = [...new Set(supportHits.flatMap((h) => h.lessons))];
    const lessonDetails = await loadLessonDetails(supabaseAdmin, [
      ...chunks.map((c) => c.id),
      ...(isStart ? FIRST_LESSONS.map((k) => `${k}-01`) : []),
      ...supportLessons.map((k) => `${k}-01`),
    ]);
    const supportLinks = new Map(
      supportLessons
        .map((k) => [k, lessonDetails.get(k)?.url] as const)
        .filter((e): e is readonly [string, string] => Boolean(e[1])),
    );
    const knowledge = [
      ...supportHits.map((h) => supportAnswerKnowledge(h, supportLinks)),
      ...chunks.map((c) => {
        const details = lessonDetails.get(lessonKey(c.id));
        return `[${c.id} | vitrine ${c.level ?? "?"} | módulo ${c.module ?? "?"}${c.lesson ? ` | aula ${c.lesson}` : ""}${c.topic ? ` | ${c.topic}` : ""}${details ? ` | link da aula: ${details.url}` : " | sem link cadastrado"}]\n${c.title}\n${c.content}`;
      }),
    ];
    if (isStart) {
      const firsts = FIRST_LESSONS.map((k) => lessonDetails.get(k))
        .map((lesson, i) => (lesson ? `${FIRST_LESSONS[i]}: ${lesson.url}` : null))
        .filter(Boolean);
      if (firsts.length)
        knowledge.push(`[primeiras aulas da jornada — links oficiais]\n${firsts.join("\n")}`);
    }

    const wantsMaterial =
      retrieval.wantsMaterialIntent(intents) || MATERIAL_INTENT_RE.test(data.content);
    if (wantsMaterial && materials.length === 0) {
      await supabaseAdmin.from("material_requests").insert({
        user_id: userId,
        conversation_id: data.conversationId,
        query_text: data.content.slice(0, 500),
        terms: extractTerms(data.content),
      });
    }

    const studentName =
      (await supabaseAdmin.from("profiles").select("name").eq("id", userId).maybeSingle()).data
        ?.name ?? null;

    const lastAssistantMetadata = (history ?? []).find(
      (m) =>
        m.role === "assistant" &&
        !((m.metadata as Record<string, unknown> | null)?.["human"]),
    )?.metadata;
    const refundState = readRefundState(lastAssistantMetadata);

    const supportUrl = supportUrlFor(products);

    // Quem já teve o cartão liberado (Ativação, acesso, pagamento ou Meta) recebe o cartão
    // de novo sempre que pedir um humano, sem retenção.
    if (HUMAN_REQUEST_RE.test(data.content)) {
      const { data: prevCards } = await supabaseAdmin
        .from("messages")
        .select("metadata, created_at")
        .eq("user_id", userId)
        .eq("role", "assistant")
        .contains("metadata", { attachments: [{ label: ATENDIMENTO_HUMANO.rotulo }] })
        .order("created_at", { ascending: false })
        .limit(1);
      if (prevCards && prevCards.length > 0) {
        const prevAtt = parseAttachments(prevCards[0]!.metadata).find(
          (a) => a.kind === "support" && a.label === ATENDIMENTO_HUMANO.rotulo,
        );
        const note =
          (prevAtt && "note" in prevAtt && typeof prevAtt.note === "string" && prevAtt.note) ||
          `${NOME_ATIVACAO}, veio do bot`;
        return saveDirectAssistantMessage(supabaseAdmin, {
          conversationId: data.conversationId,
          userId,
          content: fillName(HUMANO_DE_NOVO, firstName(studentName)),
          attachment: {
            kind: "support",
            url: supportUrl,
            label: ATENDIMENTO_HUMANO.rotulo,
            note,
          },
          refundState: { ...refundState, updatedAt: new Date().toISOString() },
        });
      }
    }

    // Ameaça jurídica: texto oficial, sem emoji, sem cartão e sem retenção.
    if (!hasLifeRisk(data.content) && hasLegalThreat(data.content)) {
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: fillName(AMEACA_JURIDICA, firstName(studentName)),
        attachments: [],
        refundState: { ...refundState, updatedAt: new Date().toISOString() },
      });
    }

    // Cobrança de prazo (decisão 30/09): a própria aluna diz que JÁ enviou o pedido.
    // Não entra no 7D nem vai para humano; sem endereço e sem passo a passo.
    if (isDeadlineFollowUp(data.content) && !hasLifeRisk(data.content)) {
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: fillName(COBRANCA_PRAZO, firstName(studentName)),
        attachments: [],
        refundState: { ...refundState, updatedAt: new Date().toISOString() },
        currentUserText: data.content,
        studentName: firstName(studentName),
        extraMetadata: { deadline_followup: true },
      });
    }

    // Depois do aceite (WhatsApp): o bot segue normal; só reenvia o link se ela pedir,
    // e agradece uma vez se ela responder a listinha aqui no chat (fica registrado para a equipe).
    if (refundState.stage === "ativacao_whatsapp" && !hasLifeRisk(data.content) && !isRefundTrigger(data.content)) {
      const name = firstName(studentName);
      if (asksWhatsappLinkAgain(data.content)) {
        return saveDirectAssistantMessage(supabaseAdmin, {
          conversationId: data.conversationId,
          userId,
          content: fillName(WHATSAPP_LINK_DE_NOVO, name),
          attachments: [officialLink("whatsapp_7d")],
          refundState: { ...refundState, updatedAt: new Date().toISOString() },
          currentUserText: data.content,
          studentName: name,
          extraMetadata: { whatsapp_7d: true },
        });
      }
      if (!refundState.whatsappThanked && looksLikeDiagnosisAnswer(data.content)) {
        if (refundState.alertId) {
          await supabaseAdmin
            .from("risk_alerts")
            .update({ trigger_text: `Diagnóstico do aluno (respondido no chat): ${data.content.slice(0, 1500)}` })
            .eq("id", refundState.alertId);
        }
        return saveDirectAssistantMessage(supabaseAdmin, {
          conversationId: data.conversationId,
          userId,
          content: fillName(WHATSAPP_THANKS, name),
          refundState: { ...refundState, whatsappThanked: true, updatedAt: new Date().toISOString() },
          currentUserText: data.content,
          studentName: name,
          extraMetadata: { diagnosis_in_chat: true },
        });
      }
    }

    // Cancelamento/desistência vale como pedido de reembolso; o assunto fica registrado.
    const cancelCtx = cancelContext(data.content, PRODUTO_RECORRENTE ? products.includes(PRODUTO_RECORRENTE) : false);
    if (cancelCtx) {
      refundState.topic = cancelCtx.topic;
      if (cancelCtx.cancelKind === "assinatura" || !refundState.cancelKind) refundState.cancelKind = cancelCtx.cancelKind;
    }

    // Protocolo 7D: decidido inteiramente no servidor, com os scripts oficiais.
    const flowRunning = !isFlowStale(refundState) && !isNewRefundRequest(refundState, data.content);
    // Dúvida técnica de anúncios/Meta (ou resposta oficial do suporte) nunca entra no 7D.
    // Pedido efetivo de cancelamento/reembolso: o 7D vem antes das respostas oficiais.
    const effectiveRequest = isRefundTrigger(data.content) && !isHypotheticalRefund(data.content);
    const technicalBypass = adsTechnical || (supportHits.length > 0 && !effectiveRequest && !isCancelRequest(data.content));
    if (
      hasLifeRisk(data.content) ||
      (!technicalBypass && (flowRunning || isRefundTrigger(data.content)))
    ) {
      const name = firstName(studentName);
      // A classificação da mensagem atual sempre vence qualquer estado antigo,
      // inclusive “encerrado / endpoint vermelho”.
      const outcome = isHypotheticalRefund(data.content)
        ? flowRunning
          ? advanceFlow(refundState, data.content, name)
          : startFlow(data.content, name, cancelCtx)
        : flowRunning
          ? advanceFlow(refundState, data.content, name)
          : startFlow(data.content, name, cancelCtx);
      if (outcome.state && refundState.topic && !outcome.state.topic) {
        outcome.state = { ...outcome.state, topic: refundState.topic, cancelKind: refundState.cancelKind ?? null };
      }

      // Trava final antes do banco: N152 só pode ser persistido no quarto pedido
      // explícito no presente. Ela cobre qualquer saída da máquina de estados.
      const guarded = guardRefundOutput({
        content: outcome.content,
        state: outcome.state,
        currentUserText: data.content,
        name,
      });
      const followUpContent = guarded.followUpContent ?? outcome.followUpContent;
      const guardedFollowUp = followUpContent
        ? guardRefundOutput({
            content: followUpContent,
            state: guarded.state,
            currentUserText: data.content,
            name,
          })
        : null;

      // Alerta para o time no clique do SIM; o diagnóstico é anexado no mesmo alerta.
      let alertId = outcome.state.alertId;
      if (outcome.events?.activationAccepted && !alertId) {
        const inserted = await supabaseAdmin
          .from("risk_alerts")
          .insert({
            user_id: userId,
            conversation_id: data.conversationId,
            risk_level: "high",
            reason: `${ATIVACAO_ALERTA_PREFIXO} — rota ${outcome.state.route ?? "?"} · produtos: ${products.join(", ") || "-"}`,
            trigger_text: `Aluno aceitou a ${NOME_ATIVACAO} no bot.`,
            status: "pending",
            accept_origin: outcome.events.accept?.origin ?? "botão",
            accept_text: outcome.events.accept?.text ?? data.content.slice(0, 300),
            accept_node: outcome.events.accept?.node ?? null,
          })
          .select("id")
          .maybeSingle();
        alertId = inserted.data?.id ?? null;
        // Avisa o time por push: quem tiver notificação ativa recebe na hora.
        try {
          const { adminUserIds, sendPushToUsers } = await import("./push.server");
          const admins = await adminUserIds(supabaseAdmin);
          await sendPushToUsers(supabaseAdmin, admins, {
            title: `Nova ${NOME_ATIVACAO}`,
            body: `${studentName ?? "Um aluno"} aceitou o 7D`,
            url: "/admin?tab=alerts",
            tag: "ativacao-7d",
          });
        } catch {
          // push é complementar: nunca bloqueia a resposta do chat
        }
      }
      let insistAlertId = outcome.state.insistAlertId ?? null;
      if (outcome.events?.insistence) {
        const n = outcome.events.insistence;
        const isCancel = (outcome.state.topic ?? refundState.topic) === "cancelamento";
        const reason = isCancel
          ? `7D - cancelamento · insistência ${Math.min(n, 4)}/4${n >= 4 ? " · encaminhamento de cancelamento entregue" : ""}`
          : `7D - reembolso - insistência ${Math.min(n, 4)}/4${n >= 4 ? " · e-mail de reembolso entregue" : ""}`;
        if (insistAlertId) {
          await supabaseAdmin
            .from("risk_alerts")
            .update({
              reason,
              trigger_text: data.content.slice(0, 500),
              risk_level: n >= 4 ? "critical" : "high",
            })
            .eq("id", insistAlertId);
        } else {
          const ins = await supabaseAdmin
            .from("risk_alerts")
            .insert({
              user_id: userId,
              conversation_id: data.conversationId,
              risk_level: n >= 4 ? "critical" : "high",
              reason,
              trigger_text: data.content.slice(0, 500),
              status: "pending",
            })
            .select("id")
            .maybeSingle();
          insistAlertId = ins.data?.id ?? null;
        }
      }
      if (outcome.events?.diagnosis && alertId) {
        await supabaseAdmin
          .from("risk_alerts")
          .update({ trigger_text: `Diagnóstico do aluno: ${outcome.events.diagnosis}` })
          .eq("id", alertId);
      }

      const flowAttachments: ChatAttachment[] = [];
      if (guarded.support ?? outcome.support) {
        const support = guarded.support ?? outcome.support;
        flowAttachments.push({
          kind: "support",
          url: supportUrl,
          label: ATENDIMENTO_HUMANO.rotulo,
          note: support?.note ?? null,
        });
      }
      const guardedReplies = guarded.audit.decision === "blocked" ? guarded.replies : outcome.replies;
      if (guardedReplies.length) {
        flowAttachments.push({ kind: "replies", options: guardedReplies });
      }

      if (guardedFollowUp) {
        await saveDirectAssistantMessage(supabaseAdmin, {
          conversationId: data.conversationId,
          userId,
          content: guarded.content,
          attachments: [],
          refundState: {
            ...guarded.state,
            alertId,
            insistAlertId,
            updatedAt: new Date().toISOString(),
          },
          currentUserText: data.content,
          studentName: name,
          refundGuardAudit: guarded.audit,
        });
      }

      // Sequência do aceite: cada mensagem é gravada inteira, em ordem (link nunca partido).
      if (outcome.extras?.length && guarded.audit.decision !== "blocked") {
        const finalState = { ...guarded.state, alertId, insistAlertId, updatedAt: new Date().toISOString() };
        const all = [{ content: guarded.content, links: [] as OfficialLinkKey[] }, ...outcome.extras];
        const base = Date.now();
        let last: Awaited<ReturnType<typeof saveDirectAssistantMessage>> | null = null;
        for (let i = 0; i < all.length; i++) {
          const m = all[i]!;
          const isLast = i === all.length - 1;
          last = await saveDirectAssistantMessage(supabaseAdmin, {
            conversationId: data.conversationId,
            userId,
            content: m.content,
            attachments: [...(m.links ?? []).map(officialLink), ...(isLast ? flowAttachments : [])],
            refundState: finalState,
            currentUserText: data.content,
            studentName: name,
            refundGuardAudit: guarded.audit,
            createdAt: new Date(base + i * 1000).toISOString(),
            ...((m.links ?? []).includes("whatsapp_7d") ? { extraMetadata: { whatsapp_7d: true } } : {}),
          });
        }
        if (outcome.events?.whatsappSent && alertId) {
          await supabaseAdmin.from("risk_alerts").update({ whatsapp_sent_at: new Date(base).toISOString() }).eq("id", alertId);
        }
        return last!;
      }

      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: guardedFollowUp?.content ?? guarded.content,
        attachments: flowAttachments,
        refundState: {
          ...(guardedFollowUp?.state ?? guarded.state),
          alertId,
          insistAlertId,
          updatedAt: new Date().toISOString(),
        },
        currentUserText: data.content,
        studentName: name,
        refundGuardAudit: guardedFollowUp?.audit ?? guarded.audit,
      });
    }

    // Botão com resposta pronta (MSI): o servidor responde sem IA, com os botões e os cartões das aulas.
    const botao = data.intent ? QUICK_ACTIONS.find((a) => a.intent === data.intent && a.resposta) : undefined;
    if (botao?.resposta) {
      const attachments: ChatAttachment[] = (botao.resposta.links ?? []).map((key) => officialLink(key));
      const aulas = botao.resposta.aulas ?? [];
      if (aulas.length) {
        const details = await loadLessonDetails(supabaseAdmin, aulas.map((a) => `${a}-01`));
        for (const a of aulas) {
          const d = details.get(a);
          if (d) attachments.push(lessonAttachment(d, null));
        }
      }
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: fillName(botao.resposta.texto, firstName(studentName)),
        attachments,
        refundState: { ...refundState, updatedAt: new Date().toISOString() },
        extraMetadata: { quick_action: botao.intent },
      });
    }

    // Casos oficiais sem link humano (MSI: o WhatsApp só sai na Ativação aceita). O servidor responde
    // com o texto fixo e registra no painel: acesso → aba Acessos; pagamento → aba Alertas.
    const humanCase = serverHandledHumanCase(data.content);
    if (humanCase) {
      try {
        if (humanCase.painel === "acessos" && !accessAlerted) {
          const { shouldMarkReopened } = await import("./access-alert");
          const { data: prev } = await supabaseAdmin.from("access_alerts").select("status").eq("user_id", userId).limit(500);
          await supabaseAdmin.from("access_alerts").insert({
            user_id: userId,
            conversation_id: data.conversationId,
            trigger_text: data.content.slice(0, 1000),
            reopened: shouldMarkReopened(prev ?? []),
            ...(await camposDeConferencia()),
          });
        }
        if (humanCase.painel === "alertas") {
          await supabaseAdmin.from("risk_alerts").insert({
            user_id: userId,
            conversation_id: data.conversationId,
            risk_level: "high",
            reason: humanCase.nota,
            trigger_text: data.content.slice(0, 500),
          });
        }
      } catch (e) {
        console.error("human_case_alert_failed", e);
      }
      // Entrou pelo nome ou WhatsApp: ela fica sabendo que a equipe confere antes de reenviar o acesso.
      const via = humanCase.painel === "acessos" ? await comoEntrou() : null;
      const resposta = viaPrecisaConferir(via)
        ? `${humanCase.resposta}\n\n${textoDuplaChecagem(via)}`
        : humanCase.resposta;
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: fillName(resposta, firstName(studentName)),
        refundState: { ...refundState, updatedAt: new Date().toISOString() },
        extraMetadata: { human_case: humanCase.nota, ...(viaPrecisaConferir(via) ? { conferir_identidade: via } : {}) },
      });
    }

    // Atalho de execução (no MGA: Payt sem conta / sem afiliação): passos na hora, sem esperar o atendente.
    const atalho = supportHits.length > 0 ? null : detectAtalho(data.content);
    if (atalho) {
      const name = firstName(studentName);
      const attachments: ChatAttachment[] = atalho.links.map((key) => officialLink(key));
      if (atalho.aula) {
        const details = (await loadLessonDetails(supabaseAdmin, [`${atalho.aula}-01`])).get(atalho.aula);
        if (details) attachments.push(lessonAttachment(details, null));
      }
      const sc = detectSupportCase(data.content);
      if (sc) {
        attachments.push({
          kind: "support",
          url: supportUrl,
          label: ATENDIMENTO_HUMANO.rotulo,
          note: sc,
        });
      }
      return saveDirectAssistantMessage(supabaseAdmin, {
        conversationId: data.conversationId,
        userId,
        content: fillName(atalho.texto, name),
        attachments,
        refundState: { ...refundState, updatedAt: new Date().toISOString() },
      });
    }

    const systemPrompt = buildSystemPrompt(
      {
        products,
        studentName,
        memory: (memory as MemoryRow | null) ?? null,
        intent: data.intent ?? null,
        intents,
        knowledge,
        basePrompt: config.systemPrompt,
        voiceGuide: config.voiceGuide,
        refundState,
        salesAlerted,
      },
      PROMPT_BLOCKS,
    );

    const chatHistory = (history ?? [])
      .filter((m) => m.created_at >= RULES_UPDATED_AT)
      .slice()
      .reverse()
      .map((m) => ({ role: m.role as "user" | "assistant", content: m.content }));

    let result: {
      reply: string;
      usage?: {
        model: string;
        promptTokens: number | null;
        completionTokens: number | null;
        totalTokens: number | null;
      };
      diagnosis?: string | null;
      recommended_action?: string | null;
      memory_updates?: Record<string, unknown> | null;
      materials?: string[] | null;
      handoff?: boolean;
      handoff_product?: string | null;
      handoff_note?: string | null;
      community_link?: boolean;
      lesson_refs?: { id: string; minute?: string | null }[] | null;
      refund_state?: RefundFlowState | null;
    };

    try {
      result = await callAI(systemPrompt, [
        ...chatHistory,
        { role: "user", content: data.content, imageDataUrl },
      ]);
    } catch (error) {
      console.error("[chat] AI error", error);
      throw new Error("Não consegui responder agora. Tenta de novo em alguns segundos.");
    }

    // Só materiais realmente liberados para este aluno podem virar cartão de download.
    const assistantAttachments: ChatAttachment[] = (result.materials ?? [])
      .map((id) => materials.find((m) => m.id === id || m.slug === id))
      .filter((m): m is (typeof materials)[number] => Boolean(m))
      .slice(0, 4)
      .map((m) => ({
        kind: "material" as const,
        materialId: m.id,
        name: m.file_name ?? m.title,
        size: m.file_size,
      }));

    // Resposta oficial do suporte: as aulas indicadas por ela são as únicas que viram cartão.
    const citedLessons =
      supportHits.length > 0
        ? supportLessons.map((id) => ({ id, minute: "0:00" }))
        : isStart
          ? FIRST_LESSONS.map((id) => ({ id, minute: "0:00" }))
          : (result.lesson_refs ?? []);
    const allowedLessonIds = new Set([
      ...chunks.map((chunk) => lessonKey(chunk.id)),
      ...(isStart ? FIRST_LESSONS : []),
      ...supportLessons,
    ]);
    const seenLessonIds = new Set<string>();
    const lessonAttachments = citedLessons
      .map((reference) => ({ ...reference, id: lessonKey(reference.id) }))
      .filter((reference) => {
        if (!allowedLessonIds.has(reference.id) || seenLessonIds.has(reference.id)) return false;
        seenLessonIds.add(reference.id);
        return true;
      })
      .map((reference) => {
        const details = lessonDetails.get(reference.id);
        return details ? lessonAttachment(details, reference.minute) : null;
      })
      .filter((attachment): attachment is ChatAttachment => attachment !== null)
      .slice(0, 3);
    assistantAttachments.push(...lessonAttachments);

    // Print de exemplo que acompanha uma resposta oficial (subido em Materiais).
    for (const hit of supportHits) {
      if (!hit.materialTitle) continue;
      const { data: mats } = await supabaseAdmin
        .from("support_materials")
        .select(retrieval.MATERIAL_FIELDS)
        .ilike("title", `${hit.materialTitle}%`)
        .eq("active", true)
        .limit(5);
      const mat = ((mats ?? []) as unknown as import("./retrieval.server").MaterialRow[]).find(
        (m) => retrieval.materialAllowed(m, products),
      );
      if (mat && !assistantAttachments.some((a) => a.kind === "material" && a.materialId === mat.id)) {
        assistantAttachments.push({
          kind: "material",
          materialId: mat.id,
          name: mat.file_name ?? mat.title,
          size: mat.file_size,
        });
      }
    }

    if (result.community_link || data.intent === INTENT_COMUNIDADE) {
      assistantAttachments.push({
        kind: "support",
        url: communityUrlFor(products),
        label: COMUNIDADE.rotulo,
      });
    }

    // Cartão de atendimento humano fora do 7D: só nos três casos oficiais.
    const supportCase = detectSupportCase(data.content);
    if (supportCase) {
      assistantAttachments.push({
        kind: "support",
        url: supportUrl,
        label: ATENDIMENTO_HUMANO.rotulo,
        note: supportCase,
      });
    }

    const prices = await getAiPrices(supabaseAdmin);
    const usage = result.usage ?? null;
    const costUsd = usage
      ? Math.round(
          (((usage.promptTokens ?? 0) / 1_000_000) * prices.input +
            ((usage.completionTokens ?? 0) / 1_000_000) * prices.output) *
            1_000_000,
        ) / 1_000_000
      : null;

    let replyText = cleanLessonUrls(result.reply);
    // Nota do print que acompanha uma resposta oficial (ex.: "o print é da oferta MGV...").
    const hasMaterial = assistantAttachments.some((a) => a.kind === "material");
    for (const hit of supportHits) {
      if (hasMaterial && hit.materialTitle && hit.materialNote && !replyText.includes(hit.materialNote)) {
        replyText += `\n\n${hit.materialNote}`;
      }
    }
    const guardedAi = guardRefundOutput({
      content: replyText,
      state: refundState,
      currentUserText: data.content,
      name: firstName(studentName),
    });
    const aiLinks = extractOfficialLinks(guardedAi.content, { products });
    guardedAi.content = aiLinks.content;
    const guardedAiAttachments: ChatAttachment[] =
      guardedAi.audit.decision === "blocked"
        ? [{ kind: "replies" as const, options: guardedAi.replies }]
        : mergeLinkAttachments(assistantAttachments, aiLinks.links);

    const assistantInsert = await supabaseAdmin
      .from("messages")
      .insert({
        model: usage?.model ?? null,
        prompt_tokens: usage?.promptTokens ?? null,
        completion_tokens: usage?.completionTokens ?? null,
        total_tokens: usage?.totalTokens ?? null,
        cost_usd: costUsd,
        conversation_id: data.conversationId,
        user_id: userId,
        role: "assistant",
        content: guardedAi.content,
        detected_intent: data.intent ?? null,
        diagnosis: result.diagnosis ?? null,
        recommended_action: result.recommended_action ?? null,
        metadata: {
          ...(guardedAiAttachments.length ? { attachments: guardedAiAttachments } : {}),
          // O estado do 7D é só do servidor: a IA nunca liga nem mantém o Endpoint Vermelho.
          refund_state: { ...guardedAi.state, endpoint: false },
          refund_guard: guardedAi.audit,
        },
      })
      .select("id, content, created_at, metadata")
      .single();

    if (assistantInsert.error) throw new Error("Não consegui salvar a resposta.");

    await supabaseAdmin
      .from("conversations")
      .update({ updated_at: new Date().toISOString(), last_message_at: new Date().toISOString() })
      .eq("id", data.conversationId);

    await updateMemory(supabaseAdmin, userId, {
      updates: result.memory_updates ?? null,
      lastGuidance: result.reply.slice(0, 500),
      recommendedAction: result.recommended_action ?? null,
      risk,
      currentRisk: (memory as MemoryRow | null)?.risk_level ?? "low",
    });

    return {
      id: assistantInsert.data.id,
      role: "assistant" as const,
      content: assistantInsert.data.content,
      createdAt: assistantInsert.data.created_at,
      attachments: parseAttachments(assistantInsert.data.metadata),
    };
  });

/* ------------------------------------------------------------------ */

type AdminClient = Awaited<typeof import("@/integrations/supabase/client.server")>["supabaseAdmin"];

async function saveDirectAssistantMessage(
  admin: AdminClient,
  args: {
    conversationId: string;
    userId: string;
    content: string;
    attachment?: ChatAttachment;
    attachments?: ChatAttachment[];
    refundState?: RefundFlowState;
      currentUserText?: string;
      studentName?: string;
      refundGuardAudit?: RefundOutputGuard["audit"];
      extraMetadata?: Record<string, unknown>;
      createdAt?: string;
  },
) {
  const now = args.createdAt ?? new Date().toISOString();
  const list = args.attachments ?? (args.attachment ? [args.attachment] : []);
  const guarded = guardRefundOutput({
    content: args.content,
    state: args.refundState ?? null,
    currentUserText: args.currentUserText ?? "",
    name: args.studentName ?? "",
  });
  const directLinks = extractOfficialLinks(guarded.content, { products: "todos" });
  guarded.content = directLinks.content;
  const safeList: ChatAttachment[] =
    guarded.audit.decision === "blocked"
      ? [{ kind: "replies" as const, options: guarded.replies }]
      : mergeLinkAttachments(list, directLinks.links);
  const { data, error } = await admin
    .from("messages")
    .insert({
      conversation_id: args.conversationId,
      user_id: args.userId,
      role: "assistant",
      content: guarded.content,
      created_at: now,
      metadata: {
        ...(safeList.length ? { attachments: safeList } : {}),
        ...(args.refundState ? { refund_state: guarded.state } : {}),
        refund_guard: guarded.audit.decision === "blocked" ? guarded.audit : (args.refundGuardAudit ?? guarded.audit),
        ...(args.extraMetadata ?? {}),
      },
    })
    .select("id, content, created_at, metadata")
    .single();
  if (error) throw new Error("Não consegui salvar a resposta.");
  await admin
    .from("conversations")
    .update({ updated_at: now, last_message_at: now })
    .eq("id", args.conversationId);
  return {
    id: data.id,
    role: "assistant" as const,
    content: data.content,
    createdAt: data.created_at,
    attachments: parseAttachments(data.metadata),
  };
}

/**
 * Busca trechos APROVADOS da base oficial, respeitando os produtos do aluno.
 * Enquanto nenhum PDF foi processado, retorna vazio — nada é inventado.
 */
function extractTerms(question: string) {
  return question
    .toLowerCase()
    .replace(/[^\p{L}\p{N}\s]/gu, " ")
    .split(/\s+/)
    .filter((w) => w.length > 4)
    .slice(0, 4);
}

/** Materiais de apoio liberados para os produtos do aluno, filtrados pelo pedido. */
async function fetchMaterials(admin: AdminClient, products: Product[], question: string) {
  const terms = extractTerms(question);
  let query = admin
    .from("support_materials")
    .select("id, title, description, lesson_ref, file_name, file_size, keywords")
    .eq("active", true)
    .or(`product.is.null,product.in.(${products.join(",") || PRODUTO_PADRAO})`)
    .limit(8);

  if (terms.length > 0) {
    const filters = terms
      .flatMap((t) => [`title.ilike.%${t}%`, `description.ilike.%${t}%`, `lesson_ref.ilike.%${t}%`])
      .join(",");
    query = query.or(filters);
  }

  const { data } = await query;
  return data ?? [];
}

async function updateMemory(
  admin: AdminClient,
  userId: string,
  args: {
    updates: Record<string, unknown> | null;
    lastGuidance: string;
    recommendedAction: string | null;
    risk: { level: "medium" | "high" | "critical"; signals: string[] } | null;
    currentRisk: string;
  },
) {
  const allowed = ["current_stage", "main_difficulties", "action_result"] as const;

  // Memória de execução: só textos curtos e booleanos confirmados pelo aluno.
  const textFields = [
    "next_action",
    "current_difficulty",
    "stuck_reason",
    "last_evolution",
  ] as const;

  const patch: Record<string, unknown> = {
    last_guidance: args.lastGuidance,
    recommended_action: args.recommendedAction,
    updated_at: new Date().toISOString(),
  };

  for (const key of allowed) {
    const value = args.updates?.[key];
    if (value !== undefined && value !== null && value !== "") patch[key] = value;
  }

  for (const key of textFields) {
    const value = args.updates?.[key];
    if (typeof value === "string" && value.trim()) patch[key] = value.trim().slice(0, 300);
  }

  if (args.risk) {
    const order = { low: 0, medium: 1, high: 2, critical: 3 } as const;
    const current = order[args.currentRisk as keyof typeof order] ?? 0;
    if (order[args.risk.level] > current) patch["risk_level"] = args.risk.level;
    patch["dissatisfaction_signals"] = args.risk.signals;
  }

  if (typeof patch["last_evolution"] === "string") {
    patch["last_progress_at"] = new Date().toISOString();
  }

  // upsert: no MGA a ficha da memória nunca era criada (gatilho desligado), então o
  // .update() não gravava nada. Aqui a ficha é criada na primeira resposta.
  await admin
    .from("student_memory")
    .upsert({ user_id: userId, ...patch } as never, { onConflict: "user_id" });
}

function readRefundState(metadata: unknown): RefundFlowState {
  if (!metadata || typeof metadata !== "object") return EMPTY_FLOW;
  const value = (metadata as Record<string, unknown>)["refund_state"];
  if (!value || typeof value !== "object") return EMPTY_FLOW;
  return { ...EMPTY_FLOW, ...(value as Partial<RefundFlowState>) };
}

const AI_MODEL = "desconhecido";

/** Preços por milhão de tokens (editáveis em assistant_config). */
export async function getAiPrices(client: AdminClient): Promise<{ input: number; output: number }> {
  const { data } = await client
    .from("assistant_config")
    .select("key, value")
    .in("key", ["ai_price_input_per_mtok", "ai_price_output_per_mtok"]);
  const map = new Map<string, number>();
  for (const row of (data ?? []) as { key: string; value: unknown }[]) {
    const n = typeof row.value === "number" ? row.value : Number(row.value);
    if (Number.isFinite(n)) map.set(row.key, n);
  }
  return {
    input: map.get("ai_price_input_per_mtok") ?? 0,
    output: map.get("ai_price_output_per_mtok") ?? 0,
  };
}

async function callAI(
  systemPrompt: string,
  messages: { role: "user" | "assistant"; content: string; imageDataUrl?: string | null }[],
) {
  const { runAI } = await import("./ai-provider.server");
  const out = await runAI({ use: "chat", system: systemPrompt, messages });
  const raw = out.raw;
  const usage = {
    model: out.model ?? AI_MODEL,
    promptTokens: out.usage.promptTokens,
    completionTokens: out.usage.completionTokens,
    totalTokens: out.usage.totalTokens,
  };

  try {
    const parsed = JSON.parse(raw) as {
      reply?: string;
      diagnosis?: string;
      recommended_action?: string;
      memory_updates?: Record<string, unknown>;
      materials?: unknown;
      handoff?: boolean;
      handoff_product?: string | null;
      handoff_note?: string | null;
      community_link?: boolean;
      lesson_refs?: unknown;
      refund_state?: RefundFlowState | null;
    };
    if (!parsed.reply) throw new Error("resposta sem campo reply");
    return {
      reply: parsed.reply,
      diagnosis: parsed.diagnosis ?? null,
      recommended_action: parsed.recommended_action ?? null,
      memory_updates: parsed.memory_updates ?? null,
      materials: Array.isArray(parsed.materials)
        ? parsed.materials.filter((m): m is string => typeof m === "string")
        : null,
      handoff: parsed.handoff === true,
      handoff_product: parsed.handoff_product ?? null,
      handoff_note: parsed.handoff_note ?? null,
      community_link: parsed.community_link === true,
      lesson_refs: Array.isArray(parsed.lesson_refs)
        ? parsed.lesson_refs
            .map((reference) => {
              if (typeof reference === "string") return { id: reference, minute: null };
              if (!reference || typeof reference !== "object") return null;
              const value = reference as Record<string, unknown>;
              if (typeof value["id"] !== "string") return null;
              return {
                id: value["id"],
                minute: typeof value["minute"] === "string" ? value["minute"] : null,
              };
            })
            .filter(
              (reference): reference is { id: string; minute: string | null } => reference !== null,
            )
        : null,
      refund_state: parsed.refund_state ?? null,
      usage,
    };
  } catch {
    return {
      reply: raw.trim() || IDENTITY.humanCheck,
      diagnosis: null,
      recommended_action: null,
      memory_updates: null,
      materials: null,
      handoff: false,
      handoff_product: null,
      handoff_note: null,
      community_link: false,
      lesson_refs: null,
      refund_state: null,
      usage,
    };
  }
}
