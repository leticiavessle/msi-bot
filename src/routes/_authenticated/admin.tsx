import { createFileRoute, Link } from "@tanstack/react-router";
import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState, type ReactNode } from "react";
import {
  BarChart3,
  BellRing,
  BookOpen,
  CheckCircle2,
  CircleDollarSign,
  Circle,
  Cpu,
  FolderOpen,
  FileText,
  Gauge,
  KeyRound,
  LibraryBig,
  MessagesSquare,
  ShieldAlert,
  ShoppingBag,
  Trash2,
  Upload,
  UserCheck,
  Users,
  UsersRound,
} from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { AccessPanel } from "@/components/admin/AccessPanel";
import { WebhooksPanel } from "@/components/admin/WebhooksPanel";
import { NotificationsPanel } from "@/components/admin/NotificationsPanel";
import { OverviewPanel } from "@/components/admin/OverviewPanel";
import { ActivationQueuePanel } from "@/components/admin/ActivationQueuePanel";
import { UsersPanel } from "@/components/admin/UsersPanel";
import { AlertsPanel } from "@/components/admin/AlertsPanel";
import { AccessAlertsPanel } from "@/components/admin/AccessAlertsPanel";
import { countAccessAlerts } from "@/lib/dr/access-alerts.functions";
import { SalesAlertsPanel } from "@/components/admin/SalesAlertsPanel";
import { countSalesAlerts } from "@/lib/dr/sales-alerts.functions";
import { AnalyticsPanel } from "@/components/admin/AnalyticsPanel";
import { CostsPanel } from "@/components/admin/CostsPanel";
import { ConversationsPanel } from "@/components/admin/ConversationsPanel";
import { GroupedConversationsPanel } from "@/components/admin/GroupedConversationsPanel";
import { MaterialsPanel } from "@/components/admin/MaterialsPanel";
import { CatalogPanel } from "@/components/admin/CatalogPanel";
import { AdminShell, type NavItem } from "@/components/admin/AdminShell";
import { ReportsPanel } from "@/components/admin/ReportsPanel";
import { AiSettingsPanel } from "@/components/admin/AiSettingsPanel";
import { EmptyState, Panel, StatusBadge, buttonPrimary, fieldClass } from "@/components/admin/ui";
import { MARCA, PRODUCTS, type Product } from "@/lib/dr/config";
import { NOME_ATIVACAO } from "@/oferta/protocolo-7d";
import { getAdminOverview } from "@/lib/dr/admin-analytics.functions";
import { listActivationQueue } from "@/lib/dr/activation-queue.functions";
import {
  createKnowledgeDocument,
  deleteKnowledgeDocument,
  getAdminStatus,
  listKnowledgeDocuments,
  setDocumentApproval,
} from "@/lib/dr/admin.functions";

type BaseType = "official_editor_dr" | "real_questions" | "official_faq" | "refund_risk";

type TabKey =
  | "reports"
  | "overview"
  | "users"
  | "conversations"
  | "grouped"
  | "alerts"
  | "access_alerts"
  | "sales_alerts"
  | "activation"
  | "analytics"
  | "costs"
  | "access"
  | "materials"
  | "catalog"
  | "webhooks"
  | "notifications"
  | "docs"
  | "ai_settings";

const NAV: { key: TabKey; label: string; icon: ReactNode; description: string }[] = [
  {
    key: "reports",
    label: "Relatórios",
    icon: <FileText className="size-4" />,
    description: "Relatórios diários das 08h e 17h e status do envio no WhatsApp.",
  },
  {
    key: "overview",
    label: "Visão geral",
    icon: <Gauge className="size-4" />,
    description: "Presença, engajamento e risco em tempo real.",
  },
  {
    key: "users",
    label: "Usuários",
    icon: <Users className="size-4" />,
    description: "Alunos, produtos e histórico individual.",
  },
  {
    key: "conversations",
    label: "Conversas",
    icon: <MessagesSquare className="size-4" />,
    description: "Histórico completo das conversas com o assistente.",
  },
  {
    key: "grouped",
    label: "Conversas agrupadas",
    icon: <UsersRound className="size-4" />,
    description: "Uma linha por pessoa, pela atividade mais recente.",
  },
  {
    key: "alerts",
    label: "Alertas",
    icon: <ShieldAlert className="size-4" />,
    description: "Sinais de insatisfação e risco de reembolso.",
  },
  {
    key: "access_alerts",
    label: "Acessos",
    icon: <KeyRound className="size-4" />,
    description: "Alunas com dificuldade para entrar na área de membros ou no bot (e-mail › CPF › nome › WhatsApp).",
  },
  {
    key: "sales_alerts",
    label: "Vendas",
    icon: <ShoppingBag className="size-4" />,
    description: "Alunas que perguntaram preço, desconto, parcelamento ou como comprar um produto.",
  },
  {
    key: "activation",
    label: `${NOME_ATIVACAO} (7D)`,
    icon: <UserCheck className="size-4" />,
    description: "Pessoas que aceitaram iniciar o Dia 1 e aguardam atendimento.",
  },
  {
    key: "analytics",
    label: "Analytics",
    icon: <BarChart3 className="size-4" />,
    description: "Volume, horários e temas mais perguntados.",
  },
  {
    key: "costs",
    label: "Custos",
    icon: <CircleDollarSign className="size-4" />,
    description: "Custo de IA por dia, por aluno e projeção mensal.",
  },
  {
    key: "access",
    label: "Acessos",
    icon: <KeyRound className="size-4" />,
    description: "Sessões, dispositivos e possível compartilhamento.",
  },
  {
    key: "materials",
    label: "Materiais",
    icon: <FolderOpen className="size-4" />,
    description: "Materiais de apoio enviados pelo assistente.",
  },
  {
    key: "catalog",
    label: "Catálogo",
    icon: <LibraryBig className="size-4" />,
    description: `Base da ${MARCA.nomeProduto}, ferramentas e verificação de links.`,
  },
  {
    key: "webhooks",
    label: "Webhooks",
    icon: <KeyRound className="size-4" />,
    description: "Eventos recebidos da Hubla e liberações automáticas.",
  },
  {
    key: "notifications",
    label: "Notificações",
    icon: <BellRing className="size-4" />,
    description: "Avisos push para os alunos com notificação ativa.",
  },
  {
    key: "docs",
    label: "Base",
    icon: <BookOpen className="size-4" />,
    description: "Documentos oficiais que alimentam o assistente.",
  },
  {
    key: "ai_settings",
    label: "Configurações > IA",
    icon: <Cpu className="size-4" />,
    description: "Qual IA o bot usa, chaves, modelos e consumo.",
  },
];

const BASE_TYPES: { value: BaseType; label: string }[] = [
  { value: "official_editor_dr", label: `Base oficial ${MARCA.nomeProduto}` },
  { value: "official_faq", label: "FAQ oficial" },
  { value: "real_questions", label: "Perguntas reais de alunos" },
  { value: "refund_risk", label: "Risco de reembolso" },
];

export const Route = createFileRoute("/_authenticated/admin")({
  head: () => ({
    meta: [
      { title: `Painel administrativo — ${MARCA.nomeAssistente}` },
      {
        name: "description",
        content:
          "Gestão de alunos, conversas, alertas de risco, materiais e base oficial do assistente.",
      },
      { property: "og:title", content: `Painel administrativo — ${MARCA.nomeAssistente}` },
      {
        property: "og:description",
        content: "Gestão de alunos, conversas, alertas e base oficial do assistente.",
      },
      { property: "og:type", content: "website" },
      { name: "twitter:card", content: "summary" },
    ],
  }),
  component: AdminPage,
});

function AdminPage() {
  const queryClient = useQueryClient();
  const status = useServerFn(getAdminStatus);
  const list = useServerFn(listKnowledgeDocuments);
  const create = useServerFn(createKnowledgeDocument);
  const approve = useServerFn(setDocumentApproval);
  const remove = useServerFn(deleteKnowledgeDocument);
  const overviewFn = useServerFn(getAdminOverview);
  const activationQueueFn = useServerFn(listActivationQueue);

  const { data: admin, isLoading: loadingStatus } = useQuery({
    queryKey: ["admin-status"],
    queryFn: () => status(),
  });

  const { data: docs } = useQuery({
    queryKey: ["knowledge-documents"],
    queryFn: () => list(),
    enabled: Boolean(admin?.isAdmin),
  });

  const { data: overview } = useQuery({
    queryKey: ["admin-overview"],
    queryFn: () => overviewFn(),
    enabled: Boolean(admin?.isAdmin),
    refetchInterval: 60_000,
  });

  const { data: activationQueue } = useQuery({
    queryKey: ["activation-queue"],
    queryFn: () => activationQueueFn(),
    enabled: Boolean(admin?.isAdmin),
    refetchInterval: 60_000,
  });

  const accessCountFn = useServerFn(countAccessAlerts);
  const { data: accessCount } = useQuery({
    queryKey: ["access-alerts-count"],
    queryFn: () => accessCountFn(),
    enabled: Boolean(admin?.isAdmin),
    refetchInterval: 60_000,
  });

  const salesCountFn = useServerFn(countSalesAlerts);
  const { data: salesCount } = useQuery({
    queryKey: ["sales-alerts-count"],
    queryFn: () => salesCountFn(),
    enabled: Boolean(admin?.isAdmin),
    refetchInterval: 60_000,
  });

  const [tab, setTab] = useState<TabKey>("reports");
  const [title, setTitle] = useState("");
  const [baseType, setBaseType] = useState<BaseType>("official_editor_dr");
  const [product, setProduct] = useState<Product | "">("");
  const [file, setFile] = useState<File | null>(null);
  const [error, setError] = useState<string | null>(null);

  const invalidate = () => queryClient.invalidateQueries({ queryKey: ["knowledge-documents"] });

  const upload = useMutation({
    mutationFn: async () => {
      if (title.trim().length < 2) throw new Error("Dê um título ao documento.");
      let storagePath: string | null = null;
      if (file) {
        if (file.type !== "application/pdf") throw new Error("Envie um arquivo PDF.");
        if (file.size > 50 * 1024 * 1024) throw new Error("O PDF deve ter até 50MB.");
        const path = `${crypto.randomUUID()}.pdf`;
        const { error: uploadError } = await supabase.storage
          .from("knowledge")
          .upload(path, file, { contentType: "application/pdf" });
        if (uploadError) throw new Error("Falha ao enviar o PDF.");
        storagePath = path;
      }
      await create({
        data: {
          title: title.trim(),
          baseType,
          product: product === "" ? null : product,
          storagePath,
          source: file?.name ?? null,
        },
      });
    },
    onSuccess: async () => {
      setTitle("");
      setFile(null);
      setError(null);
      await invalidate();
    },
    onError: (err) => setError(err instanceof Error ? err.message : "Não consegui salvar."),
  });

  if (loadingStatus) {
    return <p className="p-6 text-sm text-muted-foreground">Carregando…</p>;
  }

  if (!admin?.isAdmin) {
    return (
      <div className="flex min-h-[100dvh] flex-col items-center justify-center gap-3 px-6 text-center">
        <h1 className="text-lg font-semibold">Área restrita</h1>
        <p className="text-sm text-muted-foreground">
          Esta área é exclusiva da equipe da {MARCA.nomeProduto}.
        </p>
        <Link to="/chat" className="text-sm font-medium text-primary">
          Voltar ao chat
        </Link>
      </div>
    );
  }

  const current = NAV.find((n) => n.key === tab) ?? NAV[0]!;
  const items: NavItem<TabKey>[] = NAV.map((n) => ({
    key: n.key,
    label: n.label,
    icon: n.icon,
    ...(n.key === "alerts" && overview?.pendingAlerts ? { badge: overview.pendingAlerts } : {}),
    ...(n.key === "access_alerts" && accessCount ? { badge: accessCount } : {}),
    ...(n.key === "sales_alerts" && salesCount ? { badge: salesCount } : {}),
    ...(n.key === "activation" && activationQueue?.length
      ? { badge: activationQueue.length }
      : {}),
  }));

  return (
    <AdminShell
      items={items}
      active={tab}
      onSelect={setTab}
      title={current.label}
      description={current.description}
      {...(typeof overview?.onlineNow === "number" ? { online: overview.onlineNow } : {})}
    >
      {tab === "reports" ? <ReportsPanel /> : null}
      {tab === "overview" ? <OverviewPanel /> : null}
      {tab === "users" ? <UsersPanel /> : null}
      {tab === "conversations" ? <ConversationsPanel /> : null}
      {tab === "grouped" ? <GroupedConversationsPanel /> : null}
      {tab === "alerts" ? <AlertsPanel /> : null}
      {tab === "access_alerts" ? <AccessAlertsPanel /> : null}
      {tab === "sales_alerts" ? <SalesAlertsPanel /> : null}
      {tab === "activation" ? <ActivationQueuePanel /> : null}
      {tab === "analytics" ? <AnalyticsPanel /> : null}
      {tab === "costs" ? <CostsPanel /> : null}
      {tab === "access" ? <AccessPanel /> : null}
      {tab === "materials" ? <MaterialsPanel /> : null}
      {tab === "catalog" ? <CatalogPanel /> : null}
      {tab === "webhooks" ? <WebhooksPanel /> : null}
      {tab === "notifications" ? <NotificationsPanel /> : null}
      {tab === "ai_settings" ? <AiSettingsPanel /> : null}

      {tab === "docs" ? (
        <div className="flex flex-col gap-5">
          <Panel className="p-5">
            <h3 className="mb-4 text-sm font-semibold">Novo documento</h3>
            <div className="flex flex-col gap-3">
              <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                Título
                <input
                  value={title}
                  onChange={(e) => setTitle(e.target.value)}
                  placeholder={`Ex.: FAQ oficial da ${MARCA.nomeProduto}`}
                  maxLength={160}
                  className={fieldClass}
                />
              </label>
              <div className="grid gap-3 sm:grid-cols-2">
                <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                  Tipo de base
                  <select
                    value={baseType}
                    onChange={(e) => setBaseType(e.target.value as BaseType)}
                    className={fieldClass}
                  >
                    {BASE_TYPES.map((b) => (
                      <option key={b.value} value={b.value}>
                        {b.label}
                      </option>
                    ))}
                  </select>
                </label>
                <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                  Produto
                  <select
                    value={product}
                    onChange={(e) => setProduct(e.target.value as Product | "")}
                    className={fieldClass}
                  >
                    <option value="">Todos os produtos</option>
                    {PRODUCTS.map((p) => (
                      <option key={p} value={p}>
                        {p}
                      </option>
                    ))}
                  </select>
                </label>
              </div>
              <label className="flex flex-col gap-1.5 text-xs font-medium text-muted-foreground">
                Arquivo PDF (até 50MB)
                <input
                  type="file"
                  accept="application/pdf"
                  onChange={(e) => setFile(e.target.files?.[0] ?? null)}
                  className="text-xs text-muted-foreground file:mr-3 file:rounded-lg file:border-0 file:bg-muted file:px-3 file:py-2 file:text-xs file:text-foreground"
                />
              </label>
              {error ? <p className="text-xs text-destructive">{error}</p> : null}
              <button
                type="button"
                disabled={upload.isPending}
                onClick={() => upload.mutate()}
                className={`${buttonPrimary} self-start`}
              >
                <Upload className="size-4" />
                {upload.isPending ? "Enviando…" : "Cadastrar documento"}
              </button>
            </div>
          </Panel>

          {(docs ?? []).length === 0 ? (
            <EmptyState
              icon={<BookOpen className="size-6" />}
              title="Nenhum documento cadastrado"
              description="Envie os PDFs oficiais para o assistente responder com base neles."
            />
          ) : (
            <Panel className="divide-y divide-border/70">
              {(docs ?? []).map((doc) => (
                <article key={doc.id} className="flex items-center gap-3 px-4 py-3">
                  <div className="min-w-0 flex-1">
                    <p className="truncate text-sm font-medium">{doc.title}</p>
                    <p className="text-[11px] text-muted-foreground">
                      {doc.base_type} · {doc.product ?? "todos os produtos"}
                    </p>
                  </div>
                  <StatusBadge tone={doc.approved ? "success" : "warning"}>
                    {doc.approved ? "aprovado" : "pendente"}
                  </StatusBadge>
                  <button
                    type="button"
                    onClick={async () => {
                      await approve({ data: { id: doc.id, approved: !doc.approved } });
                      await invalidate();
                    }}
                    aria-label={doc.approved ? "Remover aprovação" : "Aprovar documento"}
                    className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-foreground"
                  >
                    {doc.approved ? (
                      <CheckCircle2 className="size-4 text-online" />
                    ) : (
                      <Circle className="size-4" />
                    )}
                  </button>
                  <button
                    type="button"
                    onClick={async () => {
                      await remove({ data: { id: doc.id } });
                      await invalidate();
                    }}
                    aria-label="Remover documento"
                    className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-destructive"
                  >
                    <Trash2 className="size-4" />
                  </button>
                </article>
              ))}
            </Panel>
          )}
        </div>
      ) : null}
    </AdminShell>
  );
}
