import { useMutation, useQuery, useQueryClient } from "@tanstack/react-query";
import { useServerFn } from "@tanstack/react-start";
import { useState } from "react";
import { CheckCircle2, Circle, Pencil, Trash2, Upload } from "lucide-react";
import { supabase } from "@/integrations/supabase/client";
import { PRODUCTS, type Product } from "@/lib/dr/config";
import { formatBytes } from "@/lib/dr/attachments";
import {
  createMaterial,
  deleteMaterial,
  listMaterialRequests,
  listMaterials,
  setMaterialActive,
  updateMaterial,
} from "@/lib/dr/admin-materials.functions";

export function MaterialsPanel() {
  const queryClient = useQueryClient();
  const list = useServerFn(listMaterials);
  const create = useServerFn(createMaterial);
  const toggle = useServerFn(setMaterialActive);
  const remove = useServerFn(deleteMaterial);
  const requests = useServerFn(listMaterialRequests);

  const { data: materials } = useQuery({ queryKey: ["admin-materials"], queryFn: () => list() });
  const { data: missing } = useQuery({
    queryKey: ["admin-material-requests"],
    queryFn: () => requests(),
  });

  const [title, setTitle] = useState("");
  const [description, setDescription] = useState("");
  const [keywords, setKeywords] = useState("");
  const [lessonRef, setLessonRef] = useState("");
  const [product, setProduct] = useState<Product | "">("");
  const [file, setFile] = useState<File | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [editing, setEditing] = useState<string | null>(null);

  const invalidate = () => queryClient.invalidateQueries({ queryKey: ["admin-materials"] });

  const upload = useMutation({
    mutationFn: async () => {
      if (title.trim().length < 2) throw new Error("Dê um título ao material.");
      if (!file) throw new Error("Selecione o arquivo do material.");
      if (file.size > 100 * 1024 * 1024) throw new Error("O arquivo deve ter até 100MB.");
      const safeName = file.name.replace(/[^\w.\-]+/g, "_");
      const path = `materials/${crypto.randomUUID()}-${safeName}`;
      const { error: uploadError } = await supabase.storage
        .from("knowledge")
        .upload(path, file, { contentType: file.type || "application/octet-stream" });
      if (uploadError) throw new Error("Falha ao enviar o arquivo.");
      await create({
        data: {
          title: title.trim(),
          description: description.trim() || null,
          keywords: keywords
            .split(",")
            .map((k) => k.trim())
            .filter((k) => k.length >= 2)
            .slice(0, 20),
          product: product === "" ? null : product,
          lessonRef: lessonRef.trim() || null,
          storagePath: path,
          fileName: file.name,
          fileSize: file.size,
          mimeType: file.type || null,
        },
      });
    },
    onSuccess: async () => {
      setTitle("");
      setDescription("");
      setKeywords("");
      setLessonRef("");
      setFile(null);
      setError(null);
      await invalidate();
    },
    onError: (err) => setError(err instanceof Error ? err.message : "Não consegui salvar."),
  });

  return (
    <div className="flex flex-col gap-6">
      <section className="rounded-2xl border border-border bg-surface p-4">
        <h2 className="mb-3 text-sm font-semibold">Novo material de apoio</h2>
        <div className="flex flex-col gap-3">
          <input
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="Título (ex.: Pack de presets — Aula 4)"
            maxLength={160}
            className="min-h-11 rounded-xl border border-border bg-background px-3 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
          />
          <textarea
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="Descrição curta: para que serve e quando indicar"
            maxLength={500}
            rows={2}
            className="rounded-xl border border-border bg-background px-3 py-2 text-sm outline-none focus-visible:ring-2 focus-visible:ring-ring"
          />
          <div className="grid gap-3 sm:grid-cols-2">
            <input
              value={keywords}
              onChange={(e) => setKeywords(e.target.value)}
              placeholder="Palavras-chave (separadas por vírgula)"
              className="min-h-11 rounded-xl border border-border bg-background px-3 text-sm"
            />
            <input
              value={lessonRef}
              onChange={(e) => setLessonRef(e.target.value)}
              placeholder="Aula / módulo (ex.: Módulo 2 - Aula 4)"
              className="min-h-11 rounded-xl border border-border bg-background px-3 text-sm"
            />
          </div>
          <select
            value={product}
            onChange={(e) => setProduct(e.target.value as Product | "")}
            className="min-h-11 rounded-xl border border-border bg-background px-3 text-sm"
          >
            <option value="">Todos os alunos</option>
            {PRODUCTS.map((p) => (
              <option key={p} value={p}>
                {p}
              </option>
            ))}
          </select>
          <input
            type="file"
            onChange={(e) => setFile(e.target.files?.[0] ?? null)}
            className="text-xs text-muted-foreground file:mr-3 file:rounded-lg file:border-0 file:bg-muted file:px-3 file:py-2 file:text-xs file:text-foreground"
          />
          {error ? <p className="text-xs text-destructive">{error}</p> : null}
          <button
            type="button"
            disabled={upload.isPending}
            onClick={() => upload.mutate()}
            className="inline-flex min-h-11 items-center justify-center gap-2 rounded-xl bg-primary text-sm font-semibold text-primary-foreground disabled:opacity-50"
          >
            <Upload className="size-4" />
            {upload.isPending ? "Enviando…" : "Cadastrar material"}
          </button>
        </div>
      </section>

      <section className="flex flex-col gap-2">
        <h2 className="text-sm font-semibold">Materiais cadastrados</h2>
        {(materials ?? []).length === 0 ? (
          <p className="text-sm text-muted-foreground">Nenhum material cadastrado ainda.</p>
        ) : null}
        {(materials ?? []).map((m) => (
          <div key={m.id} className="flex flex-col gap-2">
          <article
            className="flex items-center gap-3 rounded-xl border border-border bg-surface px-4 py-3"
          >
            <div className="min-w-0 flex-1">
              <p className="truncate text-sm font-medium">{m.title}</p>
              <p className="truncate text-[11px] text-muted-foreground">
                {m.file_name} · {formatBytes(m.file_size) || "—"} · {m.product ?? "todos"}
                {m.lesson_ref ? ` · ${m.lesson_ref}` : ""} · {m.active ? "ativo" : "inativo"}
              </p>
              {m.keywords?.length ? (
                <p className="truncate text-[11px] text-muted-foreground">
                  Palavras-chave: {m.keywords.join(", ")}
                </p>
              ) : null}
              {m.updated_by ? (
                <p className="text-[11px] text-muted-foreground">
                  Editado em {new Date(m.updated_at).toLocaleString("pt-BR")}
                </p>
              ) : null}
            </div>
            <button
              type="button"
              onClick={() => setEditing(editing === m.id ? null : m.id)}
              aria-label="Editar material"
              className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-foreground"
            >
              <Pencil className="size-4" />
            </button>
            <button
              type="button"
              onClick={async () => {
                await toggle({ data: { id: m.id, active: !m.active } });
                await invalidate();
              }}
              aria-label={m.active ? "Desativar material" : "Ativar material"}
              className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-foreground"
            >
              {m.active ? (
                <CheckCircle2 className="size-4 text-online" />
              ) : (
                <Circle className="size-4" />
              )}
            </button>
            <button
              type="button"
              onClick={async () => {
                await remove({ data: { id: m.id } });
                await invalidate();
              }}
              aria-label="Remover material"
              className="flex size-9 items-center justify-center rounded-full text-muted-foreground hover:bg-muted hover:text-destructive"
            >
              <Trash2 className="size-4" />
            </button>
          </article>
          {editing === m.id ? (
            <EditMaterial
              material={m}
              onDone={async () => {
                setEditing(null);
                await invalidate();
              }}
            />
          ) : null}
          </div>
        ))}
      </section>

      <section className="flex flex-col gap-2">
        <h2 className="text-sm font-semibold">Materiais pedidos e não encontrados</h2>
        {(missing ?? []).length === 0 ? (
          <p className="text-sm text-muted-foreground">Nenhum pedido sem resposta até agora.</p>
        ) : null}
        {(missing ?? []).map((r) => (
          <article key={r.id} className="rounded-xl border border-border bg-surface px-4 py-3">
            <p className="text-sm">{r.query_text}</p>
            <p className="mt-1 text-[11px] text-muted-foreground">
              {new Date(r.created_at).toLocaleString("pt-BR")}
              {r.terms?.length ? ` · termos: ${r.terms.join(", ")}` : ""}
            </p>
          </article>
        ))}
      </section>
    </div>
  );
}

type EditableMaterial = {
  id: string;
  title: string;
  description: string | null;
  keywords: string[] | null;
  file_name: string | null;
};

function EditMaterial({ material, onDone }: { material: EditableMaterial; onDone: () => void }) {
  const update = useServerFn(updateMaterial);
  const [title, setTitle] = useState(material.title);
  const [description, setDescription] = useState(material.description ?? "");
  const [keywords, setKeywords] = useState((material.keywords ?? []).join(", "));
  const [file, setFile] = useState<File | null>(null);
  const [error, setError] = useState<string | null>(null);

  const save = useMutation({
    mutationFn: async () => {
      if (title.trim().length < 2) throw new Error("Dê um título ao material.");
      let newFile = null;
      if (file) {
        if (file.size > 100 * 1024 * 1024) throw new Error("O arquivo deve ter até 100MB.");
        const safeName = file.name.replace(/[^\w.\-]+/g, "_");
        const path = `materials/${crypto.randomUUID()}-${safeName}`;
        const { error: uploadError } = await supabase.storage
          .from("knowledge")
          .upload(path, file, { contentType: file.type || "application/octet-stream" });
        if (uploadError) throw new Error("Falha ao enviar o novo arquivo.");
        newFile = { storagePath: path, fileName: file.name, fileSize: file.size, mimeType: file.type || null };
      }
      await update({
        data: {
          id: material.id,
          title: title.trim(),
          description: description.trim() || null,
          keywords: Array.from(
            new Set(keywords.split(",").map((k) => k.trim()).filter((k) => k.length >= 2)),
          ).slice(0, 40),
          file: newFile,
        },
      });
    },
    onSuccess: onDone,
    onError: (err) => setError(err instanceof Error ? err.message : "Não consegui salvar."),
  });

  const field = "rounded-xl border border-border bg-background px-3 text-sm";
  return (
    <div className="flex flex-col gap-2 rounded-xl border border-border bg-surface p-3">
      <input value={title} onChange={(e) => setTitle(e.target.value)} maxLength={160} placeholder="Nome" className={`min-h-11 ${field}`} />
      <textarea value={description} onChange={(e) => setDescription(e.target.value)} maxLength={500} rows={2} placeholder="Descrição" className={`py-2 ${field}`} />
      <textarea value={keywords} onChange={(e) => setKeywords(e.target.value)} rows={2} placeholder="Palavras-chave (separadas por vírgula)" className={`py-2 ${field}`} />
      <label className="text-[11px] text-muted-foreground">
        Trocar arquivo (atual: {material.file_name ?? "—"})
        <input type="file" onChange={(e) => setFile(e.target.files?.[0] ?? null)} className="mt-1 block text-xs file:mr-3 file:rounded-lg file:border-0 file:bg-muted file:px-3 file:py-2 file:text-xs file:text-foreground" />
      </label>
      {error ? <p className="text-xs text-destructive">{error}</p> : null}
      <div className="flex gap-2">
        <button type="button" disabled={save.isPending} onClick={() => save.mutate()} className="min-h-10 flex-1 rounded-xl bg-primary text-sm font-semibold text-primary-foreground disabled:opacity-50">
          {save.isPending ? "Salvando…" : "Salvar alterações"}
        </button>
        <button type="button" onClick={onDone} className="min-h-10 rounded-xl border border-border px-4 text-sm">
          Cancelar
        </button>
      </div>
    </div>
  );
}
