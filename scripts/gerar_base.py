#!/usr/bin/env python3
"""Gera a base de aulas da MSI (trechos prontos para a tabela course_chunks) a partir das fichas .docx.

Uso:   python3 scripts/gerar_base.py "MSI - CLAUDE DOCS" base-aulas
Saída: base-aulas/chunks.jsonl      um trecho por linha (colunas de course_chunks + metadados extras)
       base-aulas/aulas/*.md        uma aula por arquivo, com o texto exato que o bot vai ler
       base-aulas/relatorio-base.md contagens, anomalias, "Pontos a validar", preços, decisões
       base-aulas/revisar-grafias.md grafias_extras de cada ficha (viraram palavras-chave)

Adaptado de `MGA - bot/scripts/gerar_base.py`. Diferenças principais:
- as fichas da MSI já vêm estruturadas (Título 1 = aula, Título 2 = seção, Título 3 = subseção),
  então o .docx é lido direto do XML (zipfile), sem textutil, para não perder títulos, listas e tabelas;
- o metadado vem num parágrafo único (`vitrine: "01" ... grafias_extras:`) seguido das grafias em lista;
- "Pontos a validar", "Fontes", "Informações externas (para conferência)" e notas soltas da ficha
  NÃO entram no texto do bot: vão para o relatório;
- as grafias_extras viram `keywords` (busca), nunca texto mostrado;
- o link da aula (sem ?preview=true nem outra query string) e o nome oficial ficam SÓ no trecho -01.

Só usa a biblioteca padrão do Python 3.
"""
import hashlib
import json
import re
import sys
import unicodedata
import zipfile
import xml.etree.ElementTree as ET
from collections import Counter, OrderedDict, defaultdict
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit

ORIGEM = Path(sys.argv[1] if len(sys.argv) > 1 else "MSI - CLAUDE DOCS").expanduser()
DESTINO = Path(sys.argv[2] if len(sys.argv) > 2 else "base-aulas")
VERSAO_BASE = "2026-10-04"
MAX_PALAVRAS = 400  # teto por trecho (texto inteiro do trecho, cabeçalho incluído)

# ---------------------------------------------------------------------------
# Configuração da oferta
# ---------------------------------------------------------------------------

# Vitrine -> produto (chaves de src/oferta/produtos.ts). Vitrine sem produto aqui = o script para.
PRODUTO_POR_VITRINE = {1: "principal", 2: "principal", 3: "principal", 4: "top_demandas"}
NOME_PRODUTO = {"principal": "Método Sócia Invisível (MSI)", "top_demandas": "Top Demandas Accelerator"}
ROTULO_NIVEL = "Vitrine"

# De onde vem o número da vitrine no id (V{n}.M..):
#  "pasta"    -> número da pasta "Vitrine N - ..." (é o mesmo do link: /member/{N}/{módulo}).
#  "metadado" -> campo `vitrine` da ficha. ATENÇÃO: nas fichas as vitrines 2 e 3 vêm como "07" e "08",
#                que não têm produto mapeado (o script pararia).
NUMERO_DA_VITRINE = "pasta"

# Para trocar as referências internas das fichas ("v07 M02 A07") pela numeração usada nos ids.
VITRINE_DO_METADADO_PARA_PASTA = {1: 1, 7: 2, 8: 3}

# Correções de título (só erro óbvio apontado pela própria ficha ou artefato evidente). Tudo vai para o relatório.
TITULO_FORCADO = {
    "V1.M01.A01": (
        "Aula de Boas-Vindas",
        'metadado "AULA DE BOAS VINDAS V2 FINAL" e título da ficha "Aula de Boas-Vindas (V2 Final)": '
        '"V2 FINAL" é marca de versão do arquivo de vídeo; o nome do arquivo .docx ("Quem é a Gabriela...") '
        "é cópia do título da V1.M02.A01. Confirmar o nome oficial na área de membros.",
    ),
    "V2.M06.A04": (
        "Gestão Inteligente: Produtividade e Prazos",
        'o metadado repete o título da Aula 03 ("Arquitetura de Projetos: Do Caos à Execução") e a própria ficha '
        'pede para conferir (titulo_observacao). Usado o nome do arquivo .docx, que bate com o conteúdo '
        "(fazer mais com menos + acompanhamento de prazos). Confirmar na área de membros.",
    ),
}
# " Anterior" no fim do título = texto do botão "Anterior" da área de membros copiado junto
# (a ficha da V2.M05.A03 e da V2.M05.A04 apontam o erro em série no Módulo 05).
TITULO_SUFIXO_ERRADO = re.compile(r"\s+Anterior$")

# Nome de módulo com nota de configuração da plataforma (aparece na pasta e no metadado).
MODULO_NOTA_INTERNA = re.compile(r"\s*-\s*configurar por produto\s*$", re.I)

# Produtos da Gabriela (preço/desconto/parcelamento deles é "com o time").
PRODUTOS_DA_GABRIELA = [
    r"m[ée]todo s[óo]cia invis[íi]vel", r"\bMSI\b", r"top demandas", r"accelerator", r"cofre pix",
    r"rel[âa]mpago", r"s[óo]cia suprema", r"mentoria s[óo]cia", r"s[óo]cia vital[íi]cia", r"vital[íi]cia",
    r"projetos remunerados", r"m[ée]todo gv", r"estrat[ée]gia mpi", r"\bMPR\b",
]
# Ferramentas e plataformas de terceiros citadas nas aulas (preço delas é conteúdo de aula).
TERCEIROS = [
    "Sofia", "Workana", "99Freelas", "99 Freelas", "GetNinjas", "GETNINJAS", "Vinte Pila", "Vinte Conto",
    "VINTE CONTO", "Freelancer", "Upwork", "UpWork", "GrabPoints", "AttaPoll", "Falaí", "Voissy", "MeSeems",
    "Modatta", "ySense", "Ysense", "CapCut", "Canva", "MIS", "PayPal", "Mercado Pago", "WePink", "Wepink",
    "Lightroom", "Photoshop", "InShot", "Snapseed", "plano", "planos", "plataforma", "saque", "sacar", "taxa",
    "comissão", "assinatura", "mensalidade", "desconta", "custo do serviço",
]
PRECO_RE = re.compile(
    r"R\$|US\$|€|\b\d[\d.,]*\s*d[óo]lares\b|desconto|cupom|parcel|\b\d+\s?x\s+de\b|à vista|checkout|mensalidade|/m[êe]s\b",
    re.I,
)
REEMBOLSO_RE = re.compile(r"reembolso(?! de (?:compras|moedas))|garantia de \d+|prazo de garantia|"
                          r"devolv\w* (?:todo )?o seu dinheiro", re.I)

# ---------------------------------------------------------------------------
# Seções: título 2 da ficha -> (código, entra no bot?)
# ---------------------------------------------------------------------------
SECAO_FORA = [  # (regex, código, motivo)
    (re.compile(r"^Pontos a validar$", re.I), "pontos_a_validar", "notas internas não confirmadas"),
    (re.compile(r"^Fontes?$", re.I), "fontes", "lista de fontes externas (pesquisa da ficha)"),
    (re.compile(r"^Informações externas", re.I), "info_externa", "informação de fora da aula, para conferência"),
    (re.compile(r"\(a aula não propõe\)", re.I), "fora_da_aula", "a própria ficha diz que a aula não propõe"),
]
SECAO_DENTRO = [  # (regex, código)
    (re.compile(r"^Resumo$", re.I), "visao_geral"),
    (re.compile(r"^Pontos para o suporte$", re.I), "faq"),
    (re.compile(r"^Procedimento", re.I), "procedimento"),
    (re.compile(r"^(Exercício|Missão|Tarefa|Teste de prontidão)", re.I), "exercicio"),
]

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
R = "{http://schemas.openxmlformats.org/officeDocument/2006/relationships}"
VML_RECT = "{urn:schemas-microsoft-com:vml}rect"
LINK_RE = re.compile(r"\[\[LINK:(.*?)\x1f(.*?)\]\]")  # \x1f separa URL e texto (não confunde com "|" de tabela)
CHAVES_META = ("vitrine", "vitrine_nome", "modulo", "modulo_nome", "aula", "titulo", "titulo_no_material",
               "titulo_observacao", "duracao", "link_area_membros", "tipo", "tipo_esperado_informado",
               "arquivo_enviado", "formato", "grafias_extras")


def nfc(s: str) -> str:
    return unicodedata.normalize("NFC", s or "")


def palavras(t: str) -> int:
    return len(t.split())


# ---------------------------------------------------------------------------
# Leitura do .docx
# ---------------------------------------------------------------------------
def texto_dos_runs(el, rels):
    out = []
    for ch in el:
        if ch.tag == W + "r":
            for x in ch:
                if x.tag == W + "t":
                    out.append(x.text or "")
                elif x.tag == W + "tab":
                    out.append(" ")
                elif x.tag in (W + "br", W + "cr"):
                    out.append(" ")
        elif ch.tag == W + "hyperlink":
            url = rels.get(ch.get(R + "id"), "")
            out.append(f"[[LINK:{url}\x1f{texto_dos_runs(ch, rels)}]]")
        elif ch.tag in (W + "ins", W + "smartTag", W + "sdt", W + "sdtContent", W + "fldSimple"):
            out.append(texto_dos_runs(ch, rels))
    return "".join(out)


def ler_docx(caminho: Path):
    """Devolve a lista de blocos: ('h1'|'h2'|'h3'|'h4', texto) ('p', texto) ('li', nível, numId, formato, texto)
    ('table', linhas) ('hr',)."""
    z = zipfile.ZipFile(caminho)
    rels_xml = z.read("word/_rels/document.xml.rels").decode("utf-8")
    rels = {k: v.replace("&amp;", "&") for k, v in
            re.findall(r'Id="(rId\d+)" Type="[^"]*hyperlink" Target="([^"]+)"', rels_xml)}
    formatos = {}
    if "word/numbering.xml" in z.namelist():
        s = z.read("word/numbering.xml").decode("utf-8")
        abstratos = {}
        for m in re.finditer(r'<w:abstractNum [^>]*w:abstractNumId="(\d+)".*?</w:abstractNum>', s, re.S):
            abstratos[m.group(1)] = dict(re.findall(r'<w:lvl w:ilvl="(\d)".*?<w:numFmt w:val="(\w+)"', m.group(0), re.S))
        for num_id, abs_id in re.findall(r'<w:num w:numId="(\d+)"[^>]*>.*?<w:abstractNumId w:val="(\d+)"', s, re.S):
            formatos[num_id] = abstratos.get(abs_id, {})
    corpo = ET.fromstring(z.read("word/document.xml")).find(W + "body")

    def paragrafo(p):
        estilo = p.find(W + "pPr/" + W + "pStyle")
        estilo = estilo.get(W + "val") if estilo is not None else None
        num = p.find(W + "pPr/" + W + "numPr")
        txt = re.sub(r"[ \t]+", " ", nfc(texto_dos_runs(p, rels))).strip()
        if num is not None and num.find(W + "ilvl") is not None:
            nivel = int(num.find(W + "ilvl").get(W + "val"))
            num_id = num.find(W + "numId").get(W + "val")
            return ("li", nivel, num_id, formatos.get(num_id, {}).get(str(nivel), "bullet"), txt)
        if estilo in ("Heading1", "Heading2", "Heading3", "Heading4"):
            return ("h" + estilo[-1], txt)
        if not txt and p.find(".//" + VML_RECT) is not None:
            return ("hr",)
        return ("p", txt)

    blocos = []
    for el in corpo:
        if el.tag == W + "p":
            blocos.append(paragrafo(el))
        elif el.tag == W + "tbl":
            linhas = []
            for tr in el.iter(W + "tr"):
                celulas = []
                for tc in tr.findall(W + "tc"):
                    partes = [b[-1] for b in (paragrafo(p) for p in tc.iter(W + "p")) if b[0] != "hr" and b[-1]]
                    celulas.append(" / ".join(partes))
                linhas.append(celulas)
            blocos.append(("table", linhas))
    return blocos


def ler_metadado(texto: str) -> dict:
    achados = list(re.finditer(r"(?:^|(?<=\" )|(?<=\s))(" + "|".join(CHAVES_META) + r"):\s*", texto))
    meta = {}
    for i, m in enumerate(achados):
        fim = achados[i + 1].start() if i + 1 < len(achados) else len(texto)
        valor = texto[m.end():fim].strip()
        if valor.startswith('"') and valor.endswith('"'):
            valor = valor[1:-1]
        meta[m.group(1)] = valor.strip()
    return meta


def link_limpo(url: str) -> str:
    """Tira ?preview=true (pré-visualização do administrador), qualquer query string e #fragmento."""
    if not url:
        return ""
    p = urlsplit(url.strip())
    return urlunsplit((p.scheme, p.netloc, p.path.rstrip("/"), "", ""))


# ---------------------------------------------------------------------------
# Texto das seções
# ---------------------------------------------------------------------------
def links_para_texto(linha: str) -> str:
    """No texto do bot: link vira só o texto âncora (URL nunca fica crua no trecho)."""
    return LINK_RE.sub(lambda m: m.group(2).strip(), linha)


def links_para_relatorio(linha: str) -> str:
    def troca(m):
        url, txt = m.group(1), m.group(2).strip()
        return f"{txt} ({url})" if txt else ""
    recuo = re.match(r"\s*", linha).group(0)
    linha = LINK_RE.sub(troca, linha)
    return recuo + re.sub(r"\s{2,}", " ", linha).strip()


def renderizar(blocos, contadores) -> list:
    """Blocos de uma seção -> linhas em markdown simples (listas, tabelas e subtítulos preservados)."""
    linhas = []
    for b in blocos:
        tipo = b[0]
        if tipo == "hr":
            continue
        if tipo in ("h3", "h4"):
            if b[1]:
                linhas.append(("### " if tipo == "h3" else "#### ") + b[1])
        elif tipo == "p":
            if b[1]:
                linhas.append(b[1])
        elif tipo == "li":
            _, nivel, num_id, fmt, txt = b
            if not txt:
                continue
            if fmt == "bullet":
                marcador = "- "
            else:
                chave = (num_id, nivel)
                contadores[chave] = contadores.get(chave, 0) + 1
                for (nid, nv) in list(contadores):  # reinicia os níveis de baixo
                    if nid == num_id and nv > nivel:
                        contadores[(nid, nv)] = 0
                n = contadores[chave]
                marcador = f"{n}. " if fmt != "lowerLetter" else f"{chr(96 + n)}) "
            linhas.append("  " * nivel + marcador + txt)
        elif tipo == "table":
            rows = [[c.replace("|", "/") for c in r] for r in b[1] if any(c.strip() for c in r)]
            if not rows:
                continue
            largura = max(len(r) for r in rows)
            rows = [r + [""] * (largura - len(r)) for r in rows]
            linhas.append("| " + " | ".join(rows[0]) + " |")
            linhas.append("|" + "---|" * largura)
            for r in rows[1:]:
                linhas.append("| " + " | ".join(r) + " |")
    return linhas


VER_VALIDAR = r"(?:[Vv]er|[Vv]eja)\s+(?:também\s+)?(?:o|os)\s+pontos?\s+a\s+validar\b"
LIMPEZAS = [  # (nome, regex, troca) — tiram do texto do bot os apontamentos para seções que não entram
    ("aviso ⚠️ que aponta para 'Pontos a validar'", re.compile(r"\s*⚠️\s*" + VER_VALIDAR + r"[^|\n]*"), ""),
    ("parêntese que aponta para 'Pontos a validar'",
     re.compile(r"\s*\(" + VER_VALIDAR + r"[^()]*(?:\([^()]*\)[^()]*)*\)"), ""),
    ("frase que aponta para 'Pontos a validar' (mantida a orientação que vem depois)",
     re.compile(VER_VALIDAR + r"(?:\s+abaixo)?\s+e\s+(orientar)\b"), lambda m: m.group(1).capitalize()),
    ("frase que aponta para 'Pontos a validar'", re.compile(r"\s*" + VER_VALIDAR + r"[^.|\n]*\.?"), ""),
    ("'(ver abaixo)' que aponta para seção que não entra", re.compile(r"\s*\((?:ver|veja)\s+abaixo\)"), ""),
    ("frase que aponta para alerta/ponto que só existe em 'Pontos a validar'",
     re.compile(r"\s*Ver o (?:alerta|ponto)\b[^.|\n]*?(?:abaixo|deste módulo)\."), ""),
    ("referência a correção que só existe em 'Pontos a validar'", re.compile(r"\s+sem a correção abaixo"), ""),
    ("frase com informação de fonte externa", re.compile(r"\s*Segundo (?:uma |a )?fontes? externas?,?[^.]*\."), ""),
    # Reembolso (regra herdada do MGA: a IA nunca orienta reembolso; quem cuida é o Protocolo 7D no servidor).
    # V1.M02.A02 e A03 ("ritual de passagem") oferecem "pedir reembolso" como saída: fica só o compromisso.
    ("reembolso: escolha 'pedir reembolso ou aceitar' (fica só o compromisso)",
     re.compile(r"decidir entre pedir reembolso \(prazo de 7 dias\) ou aceitar uma condição proposta pela mentora e entrar"),
     "aceitar uma condição proposta pela mentora para entrar"),
    ("reembolso: frase que manda pedir reembolso pelo WhatsApp",
     re.compile(r"\s*Se não quiser fazer isso, deve pedir reembolso[^.]*\."), ""),
    # Nome da expert (decisão de 04/10/2026): o bot chama de "Gabi"; nas gravações aparece "Gabriela Vitorino".
    # Nome da IA (decisão de 08/10/2026, board da retenção): Soffia.ai, não "Sofia".
    ("nome da IA: 'Sofia' vira 'Soffia'", re.compile(r"\bSofia\b"), "Soffia"),
    ("nome da expert: 'Gabriela Vitorino' vira 'Gabi'", re.compile(r"\b(?:Gabriela|Gabi) Vit+orino\b"), "Gabi"),
    ("reembolso: rótulo de caminho que sobrou sozinho", re.compile(r"(?:Caminho A \(seguir no método\)|Opção B):\s*"), ""),
]
# Linha que ainda orienta pedido de reembolso/garantia sai inteira do texto do bot (vai para o relatório).
REEMBOLSO_RE = re.compile(r"reembols", re.I)
REEMBOLSO_PEDIDO_RE = re.compile(r"\b(pedir|pede|peça|peço|solicitar|solicite|garantia|7 dias|política)\b", re.I)
REF_VITRINE_RE = re.compile(r"\bv0?([0-9]{1,2})\s+M(\d{1,2})(?:\s+A(\d{1,2}))?\b")


def limpar_linha(linha: str, removidos: list) -> str:
    linha = links_para_texto(linha)
    original = linha
    for nome, rx, troca in LIMPEZAS:
        def registrar(m, nome=nome, troca=troca):
            removidos.append((nome, m.group(0).strip()))
            return troca(m) if callable(troca) else troca
        linha = rx.sub(registrar, linha)
    if NUMERO_DA_VITRINE == "pasta":
        def ref(m):
            v = VITRINE_DO_METADADO_PARA_PASTA.get(int(m.group(1)))
            if v is None:
                return m.group(0)
            return f"Vitrine {v}, Módulo {int(m.group(2)):02d}" + (f", Aula {int(m.group(3)):02d}" if m.group(3) else "")
        linha = REF_VITRINE_RE.sub(ref, linha)
    if linha != original:
        linha = re.sub(r"[ \t]{2,}", " ", linha)
        linha = re.sub(r"\s+([.,;:!?])", r"\1", linha)
        linha = re.sub(r"\|\s*\|", "| |", linha).rstrip()
        if linha.startswith("|"):
            linha = re.sub(r"(?<=[^\s|])\|", " |", linha)
    return linha


def limpar_secao(linhas: list, removidos: list) -> list:
    saida = []
    for linha in linhas:
        nova = limpar_linha(linha, removidos)
        if REEMBOLSO_RE.search(nova) and REEMBOLSO_PEDIDO_RE.search(nova):
            removidos.append(("reembolso: linha que orienta pedido de reembolso (a IA nunca fala disso; o servidor cuida)",
                              nova.strip()))
            continue
        if nova != links_para_texto(linha):
            so_marcador = re.fullmatch(r"\s*(?:-|\d+\.)\s*", nova)
            so_pergunta = re.fullmatch(r'\s*-\s*"[^"]+"\s*', nova)  # pergunta que ficou sem resposta
            so_rotulo = re.fullmatch(r"\s*(?:-\s*)?(?:⚠️\s*)?[^\s:|][^:|]{0,30}:\s*", nova)  # ex.: "⚠️ Segurança:"
            if so_marcador or not nova.strip():
                continue
            if so_rotulo:
                removidos.append(("rótulo que ficou vazio depois da limpeza", nova.strip()))
                continue
            if so_pergunta:
                removidos.append(("pergunta que ficou sem resposta depois da limpeza", nova.strip()))
                continue
        saida.append(nova)
    return saida


# ---------------------------------------------------------------------------
# Divisão em trechos (até MAX_PALAVRAS, sem cortar item, linha de tabela ou frase)
# ---------------------------------------------------------------------------
def unidades(linhas: list):
    """Agrupa linhas em unidades indivisíveis: item de lista com subitens, linha de tabela, parágrafo.
    Cada unidade guarda o contexto (subtítulo e cabeçalho de tabela) para repetir se cair em outro trecho."""
    out, h3, cab = [], None, None
    i = 0
    while i < len(linhas):
        l = linhas[i]
        if l.startswith("### ") or l.startswith("#### "):
            h3 = l
            cab = None
            out.append({"linhas": [l], "h3": None, "cab": None, "titulo": True})
            i += 1
            continue
        if l.startswith("|"):
            if i + 1 < len(linhas) and re.fullmatch(r"\|(?:---\|)+", linhas[i + 1]):
                cab = [l, linhas[i + 1]]
                out.append({"linhas": cab[:], "h3": h3, "cab": None, "titulo": True})
                i += 2
                continue
            out.append({"linhas": [l], "h3": h3, "cab": cab})
            i += 1
            continue
        cab = None
        bloco = [l]
        i += 1
        # subitens (recuados) e citações (começam com espaço) ficam com o item de cima
        while i < len(linhas) and (linhas[i].startswith("  ") or linhas[i].startswith(" ")) and not linhas[i].startswith("|"):
            bloco.append(linhas[i])
            i += 1
        out.append({"linhas": bloco, "h3": h3, "cab": None})
    return out


def dividir_frases(texto: str, limite: int):
    frases = re.split(r"(?<=[.!?])\s+", texto)
    partes, atual = [], []
    for f in frases:
        if atual and palavras(" ".join(atual + [f])) > limite:
            partes.append(" ".join(atual))
            atual = []
        atual.append(f)
    if atual:
        partes.append(" ".join(atual))
    return partes


def fatiar(linhas: list, limite: int) -> list:
    texto = "\n".join(linhas)
    if palavras(texto) <= limite:
        return [texto]
    partes, atual = [], []
    pendentes = []  # títulos (### ou cabeçalho de tabela) esperando o primeiro item

    def fechar():
        nonlocal atual
        if any(not x.get("titulo") for x in atual):
            partes.append("\n".join(l for x in atual for l in x["linhas"]))
        atual = []

    for u in unidades(linhas):
        if u.get("titulo"):
            pendentes.append(u)
            continue
        bloco = pendentes + [u]
        pendentes = []
        tamanho = palavras("\n".join(l for x in atual + bloco for l in x["linhas"]))
        if atual and tamanho > limite:
            fechar()
            contexto = []
            if not any(x.get("titulo") and x["linhas"][0].startswith("#") for x in bloco) and u["h3"]:
                contexto.append({"linhas": [u["h3"] + " (continuação)"], "titulo": True})
            if not any(x.get("titulo") and x["linhas"][0].startswith("|") for x in bloco) and u["cab"]:
                contexto.append({"linhas": u["cab"][:], "titulo": True})
            bloco = contexto + bloco
        texto_bloco = "\n".join(l for x in bloco for l in x["linhas"])
        if not atual and palavras(texto_bloco) > limite:  # unidade sozinha maior que o teto
            cabeca = [l for x in bloco if x.get("titulo") for l in x["linhas"]]
            corpo = "\n".join(l for x in bloco if not x.get("titulo") for l in x["linhas"])
            for pedaco in dividir_frases(corpo, limite - palavras("\n".join(cabeca))):
                partes.append("\n".join(cabeca + [pedaco]))
            continue
        atual.extend(bloco)
    fechar()
    return partes


# ---------------------------------------------------------------------------
# Grafias -> palavras-chave
# ---------------------------------------------------------------------------
PESSOA_RE = re.compile(r"caso citado|casos citados|casos e exemplos|exemplo de persona|exemplos de prova social|"
                       r"\bmarido\b|contador de", re.I)
ERRO_RE = re.compile(r"erros? de (?:transcrição|fala|pronúncia|digitação)|erro de fala/transcrição|grafias? incertas?|"
                     r"grafia a confirmar|grafias erradas|termo usado na gravação|repetição", re.I)
# Palavra-chave de uma palavra só que aparece em quase toda pergunta: puxaria a aula em qualquer busca.
GENERICAS = {"demanda", "demandas", "subdemandas", "sub-demandas", "sub demandas", "cliente", "contratante", "prazos",
             "entregas", "feedback", "pix", "suporte", "perfil", "cadastro", "projetos", "plataforma", "pagamento",
             "pagamentos", "opiniao", "oportunidades", "servicos", "ofertas", "comunidade", "grupo", "habilidades"}
MODULO_RE = re.compile(r"^(?:m[óo]dulo|mod)\s*\d+$", re.I)


def sem_acento(t: str) -> str:
    n = unicodedata.normalize("NFD", t.lower())
    return "".join(c for c in n if unicodedata.category(c) != "Mn").strip()


def grafias_para_keywords(grafias: list):
    """Cada linha "A / B / C (nota)" vira palavras-chave. Saem: formas que a ficha marca como erro de
    transcrição, nomes de pessoas citadas em casos/depoimentos, termos genéricos e "módulo N"."""
    chaves, avaliacao = [], []
    for linha in grafias:
        if PESSOA_RE.search(linha):
            avaliacao.append((linha, [], "nome de pessoa citada na aula: fica fora das palavras-chave"))
            continue
        aceitas = []
        for var in re.split(r"\s+/\s+", linha):
            notas = re.findall(r"\(([^()]*)\)", var)
            if any(ERRO_RE.search(n) for n in notas):
                continue
            limpa = re.sub(r"\s*\([^()]*\)", "", var)
            limpa = limpa.replace("'", "").replace('"', "").replace("“", "").replace("”", "")
            limpa = re.sub(r"\s+", " ", limpa).strip(" .,:;")
            if len(limpa) < 3 or MODULO_RE.match(limpa) or len(limpa.split()) > 8 or sem_acento(limpa) in GENERICAS:
                continue
            aceitas.append(limpa)
        chaves.extend(aceitas)
        avaliacao.append((linha, aceitas, ""))
    vistos, unicas = set(), []
    for k in chaves:
        n = sem_acento(k)
        if n not in vistos:
            vistos.add(n)
            unicas.append(k)
    return unicas, avaliacao


# ---------------------------------------------------------------------------
# Uma ficha -> estrutura
# ---------------------------------------------------------------------------
def ler_ficha(arq: Path):
    blocos = ler_docx(arq)
    if not any((b[0] != "hr" and b[-1]) for b in blocos):
        return None
    meta, grafias, i = {}, [], 0
    while i < len(blocos):  # parágrafo de metadado + lista de grafias
        b = blocos[i]
        if b[0] == "p" and "vitrine:" in b[1] and "link_area_membros" in b[1]:
            meta = ler_metadado(b[1])
            i += 1
            while i < len(blocos) and blocos[i][0] == "li":
                g = blocos[i][-1].strip()
                if len(g) >= 2 and g[0] == '"' and g[-1] == '"':
                    g = g[1:-1]
                grafias.append(g)
                i += 1
            break
        if b[0] == "h1":
            break
        i += 1
    h1, nav, nav_links, notas_soltas, secoes = "", "", [], [], []
    atual = None
    for b in blocos[i:]:
        if b[0] == "h1" and not h1:
            h1 = b[1]
            continue
        if b[0] == "h2":
            atual = {"titulo": links_para_texto(b[1]).strip(), "blocos": []}
            secoes.append(atual)
            continue
        if atual is None:
            if b[0] == "p" and b[1] and h1 and not nav and "›" in b[1]:
                nav_links = [m.group(1) for m in LINK_RE.finditer(b[1])]
                nav = LINK_RE.sub("", b[1]).replace("Abrir na área de membros", "").strip()
            elif b[0] != "hr" and b[-1] and h1:
                notas_soltas.append(links_para_relatorio(b[-1] if b[0] != "table" else str(b[1])))
            continue
        atual["blocos"].append(b)
    return dict(meta=meta, grafias=grafias, h1=links_para_texto(h1).strip(), nav=nav, nav_links=nav_links,
                notas_soltas=notas_soltas, secoes=secoes)


def assinatura(ficha) -> str:
    """Texto da ficha sem detalhes de formatação (para achar arquivos com o mesmo conteúdo)."""
    partes = [ficha["h1"]] + [s["titulo"] for s in ficha["secoes"]]
    for s in ficha["secoes"]:
        for b in s["blocos"]:
            partes.append(str(b[1]) if b[0] in ("table", "p", "h3", "h4") else (b[-1] if b[0] == "li" else ""))
    return hashlib.sha256("\n".join(partes).encode()).hexdigest()


def classificar_secao(titulo: str):
    for rx, cod, motivo in SECAO_FORA:
        if rx.search(titulo):
            return cod, False, motivo
    for rx, cod in SECAO_DENTRO:
        if rx.search(titulo):
            return cod, True, ""
    return "conteudo", True, ""


def numero(valor):
    m = re.search(r"\d+", valor or "")
    return int(m.group(0)) if m else None


def itens_de_lista(linhas: list):
    """Agrupa um texto de seção em itens de primeiro nível (subitens ficam com o item)."""
    itens, atual = [], None
    for l in linhas:
        if re.match(r"^(?:-|\d+\.) ", l):
            atual = [l]
            itens.append(atual)
        elif atual is not None and (l.startswith(" ") or l.startswith("|")):
            atual.append(l)
        else:
            atual = [l]
            itens.append(atual)
    return itens


# ---------------------------------------------------------------------------
# Principal
# ---------------------------------------------------------------------------
def main():
    if not ORIGEM.is_dir():
        sys.exit(f"Pasta não encontrada: {ORIGEM}")
    DESTINO.mkdir(parents=True, exist_ok=True)
    (DESTINO / "aulas").mkdir(exist_ok=True)
    for velho in (DESTINO / "aulas").glob("*.md"):
        velho.unlink()

    trechos, aulas, problemas, decisoes = [], OrderedDict(), [], []
    divergencias, vazios, duplicadas, bloqueadas = [], [], [], []
    validar, notas_ficha, ajustes, grafias_rel = {}, {}, defaultdict(list), {}
    secoes_vistas = Counter()
    pastas_modulo = {}
    nomes_pessoas = set()
    extras = dict(arquivos=[], nomes_vitrine=defaultdict(set), notas_modulo=set(), hash_vazios=set())

    arquivos = sorted(ORIGEM.rglob("*.docx"), key=lambda p: [nfc(x) for x in p.relative_to(ORIGEM).parts])
    for d in sorted(p for p in ORIGEM.rglob("*") if p.is_dir()):
        rel = [nfc(x) for x in d.relative_to(ORIGEM).parts]
        if len(rel) == 2:
            pastas_modulo[tuple(rel)] = len(list(d.glob("*.docx")))

    for arq in arquivos:
        partes = [nfc(x) for x in arq.relative_to(ORIGEM).parts]
        rel = "/".join(partes)
        v_pasta = numero(re.search(r"Vitrine\s+(\d+)", partes[0]).group(1)) if re.search(r"Vitrine\s+(\d+)", partes[0]) else None
        m_pasta = numero(re.search(r"M[ÓO]DULO\s+(\d+)", partes[1], re.I).group(1)) if re.search(r"M[ÓO]DULO\s+(\d+)", partes[1], re.I) else None
        a_arquivo = re.match(r"\s*(\d+)", partes[-1])
        a_arquivo = int(a_arquivo.group(1)) if a_arquivo else None
        titulo_arquivo = re.sub(r"^\s*\d+\s*-\s*", "", Path(partes[-1]).stem).strip()

        ficha = ler_ficha(arq)
        if ficha is None:
            vazios.append((v_pasta, m_pasta, a_arquivo, rel))
            extras["hash_vazios"].add(hashlib.sha256(zipfile.ZipFile(arq).read("word/document.xml")).hexdigest())
            extras["arquivos"].append((v_pasta, m_pasta, a_arquivo, titulo_arquivo, "", rel))
            continue
        meta = ficha["meta"]
        extras["arquivos"].append((v_pasta, m_pasta, a_arquivo, titulo_arquivo, meta.get("titulo", ""), rel))
        extras["nomes_vitrine"][v_pasta].add(("pasta", re.sub(r"^Vitrine\s+\d+\s*-\s*", "", partes[0]).strip()))
        extras["nomes_vitrine"][v_pasta].add(("metadado", meta.get("vitrine_nome", "")))
        for origem, nome_mod in (("pasta", partes[1]), ("metadado", meta.get("modulo_nome", ""))):
            if MODULO_NOTA_INTERNA.search(nome_mod):
                extras["notas_modulo"].add((v_pasta, m_pasta, origem, nome_mod.strip()))
        v_meta, m_meta, a_meta = numero(meta.get("vitrine")), numero(meta.get("modulo")), numero(meta.get("aula"))
        if v_meta is None or m_meta is None or a_meta is None:
            problemas.append(f"Ficha sem metadado completo (fica fora da base): `{rel}`")
            continue
        vitrine = v_pasta if NUMERO_DA_VITRINE == "pasta" else v_meta
        modulo, aula = m_meta, a_meta
        lid = f"V{vitrine}.M{modulo:02d}.A{aula:02d}"

        # divergências pasta/arquivo × metadado
        if v_meta != v_pasta:
            divergencias.append(("vitrine", lid, f"pasta Vitrine {v_pasta} × metadado vitrine \"{meta.get('vitrine')}\""))
        if m_meta != m_pasta:
            divergencias.append(("módulo", lid, f"pasta Módulo {m_pasta} × metadado modulo \"{meta.get('modulo')}\" (`{rel}`)"))
        if a_arquivo is None:
            divergencias.append(("aula", lid, f"arquivo sem número no nome (`{partes[-1]}`); usado aula \"{meta.get('aula')}\" do metadado"))
        elif a_arquivo != a_meta:
            divergencias.append(("aula", lid, f"arquivo {a_arquivo:02d} (`{partes[-1]}`) × metadado aula \"{meta.get('aula')}\""))

        produto = PRODUTO_POR_VITRINE.get(vitrine)
        if produto is None:
            bloqueadas.append((lid, rel, vitrine))
            continue

        if lid in aulas:
            igual = "conteúdo idêntico" if assinatura(ficha) == assinatura(aulas[lid]["_ficha"]) else "conteúdo diferente"
            duplicadas.append((lid, rel, aulas[lid]["source_file"], igual))
            continue

        # título oficial
        titulo = ficha["h1"] or meta.get("titulo", "") or titulo_arquivo
        if lid in TITULO_FORCADO:
            novo, motivo = TITULO_FORCADO[lid]
            decisoes.append(f"{lid}: título \"{novo}\" ({motivo})")
            titulo = novo
        elif TITULO_SUFIXO_ERRADO.search(titulo):
            novo = TITULO_SUFIXO_ERRADO.sub("", titulo)
            decisoes.append(f"{lid}: título \"{titulo}\" → \"{novo}\" (tirado o \"Anterior\" que veio do botão da área de "
                            "membros; a própria ficha aponta o erro em série no módulo)")
            titulo = novo
        titulo = titulo.replace("“", '"').replace("”", '"')
        meta_titulo = meta.get("titulo", "")
        def chave_titulo(t):
            return re.sub(r"[\W_]+", "", TITULO_SUFIXO_ERRADO.sub("", t).lower())
        if meta_titulo and titulo_arquivo and chave_titulo(titulo_arquivo) not in (chave_titulo(meta_titulo), chave_titulo(titulo)):
            divergencias.append(("título", lid, f"nome do arquivo \"{titulo_arquivo}\" × metadado \"{meta_titulo}\" "
                                                f"(título usado na base: \"{titulo}\")"))

        # nomes de vitrine e módulo (a linha de navegação da ficha tem a grafia mais limpa)
        nav = [x.strip() for x in ficha["nav"].split("›")]
        vitrine_nome = (nav[0] if len(nav) >= 2 else "") or meta.get("vitrine_nome", "") or partes[0]
        modulo_nome = ""
        if len(nav) >= 2:
            modulo_nome = re.sub(r"^M[óo]dulo\s+\d+\s*[–-]\s*", "", nav[1]).strip()
        if not modulo_nome:
            modulo_nome = meta.get("modulo_nome", "")
        modulo_nome = MODULO_NOTA_INTERNA.sub("", modulo_nome)  # tira "- configurar por produto"

        link_bruto = meta.get("link_area_membros", "").strip()
        link = link_limpo(link_bruto)
        if link_bruto and link_bruto != link:
            problemas.append(f"{lid}: link com parâmetro de pré-visualização/consulta `{link_bruto}` (gravado sem: `{link}`)")
        links_nav = {link_limpo(u) for u in ficha["nav_links"] if u}
        if links_nav and link and links_nav != {link}:
            problemas.append(f"{lid}: o link do metadado ({link}) é diferente do hyperlink da ficha ({', '.join(sorted(links_nav))})")
        if not link.startswith("http"):
            problemas.append(f"{lid}: sem link da área de membros")

        duracao = meta.get("duracao", "")
        keywords, avaliacao = grafias_para_keywords(ficha["grafias"])
        grafias_rel[lid] = avaliacao
        for linha in ficha["grafias"]:
            if PESSOA_RE.search(linha):
                for nome in re.split(r"\s+/\s+", re.sub(r"\([^()]*\)", "", linha)):
                    nome = nome.strip()
                    if nome and nome[0].isupper() and len(nome.split()) <= 2:
                        nomes_pessoas.add(nome)
        if ficha["notas_soltas"]:
            notas_ficha[lid] = ficha["notas_soltas"]
        if meta.get("titulo_observacao"):
            notas_ficha.setdefault(lid, []).append("Metadado titulo_observacao: " + meta["titulo_observacao"])

        endereco = f"{vitrine_nome} › Módulo {modulo:02d} – {modulo_nome} › Aula {aula:02d} – {titulo}"
        lesson_info = dict(lesson_id=lid, lesson_number=aula, product_name=NOME_PRODUTO[produto], vitrine=vitrine,
                           vitrine_meta=meta.get("vitrine", ""), vitrine_name=vitrine_nome, module_name=modulo_nome,
                           lesson_title=titulo, duration=duracao, lesson_type=meta.get("tipo", ""), source_file=rel)

        contadores = {}
        resumo_linhas, corpo_secoes = [], []
        removidos = []
        for s in ficha["secoes"]:
            secoes_vistas[s["titulo"]] += 1
            cod, entra, motivo = classificar_secao(s["titulo"])
            linhas = renderizar(s["blocos"], contadores)
            if not entra:
                if cod == "pontos_a_validar":
                    for it in itens_de_lista(linhas):
                        tipo_it = "item" if re.match(r"^(?:-|\d+\.) ", it[0]) else "nota"
                        validar.setdefault(lid, []).append((tipo_it, [links_para_relatorio(x) for x in it]))
                else:
                    validar.setdefault(lid, []).append(("secao", s["titulo"], [links_para_relatorio(x) for x in linhas]))
                continue
            limpas = limpar_secao(linhas, removidos)
            if not limpas:
                continue
            if cod == "visao_geral" and not resumo_linhas:
                resumo_linhas = limpas
            else:
                corpo_secoes.append((cod, s["titulo"], limpas))
        if removidos:
            ajustes[lid] = removidos

        # ---- trechos
        registros = []

        def novo(secao, rotulo, topico, texto, extra=None):
            n = len(registros) + 1
            conteudo = f"{endereco} › {rotulo}\n\n{texto}".strip()
            reg = OrderedDict(
                id=f"{lid}-{n:02d}", product=produto, level=vitrine, module=modulo, lesson=f"{lid} — {titulo}", topic=topico,
                title=titulo, content=conteudo, status="approved", keywords=keywords, source_type="course_lesson",
                source_version=VERSAO_BASE, section=secao, section_label=rotulo, words=palavras(conteudo),
                content_hash=hashlib.sha256(conteudo.encode()).hexdigest()[:16],
                lesson_link=None, **lesson_info)
            if extra:
                reg.update(extra)
            registros.append(reg)

        # Trecho 01 = cartão da aula: nome oficial + onde fica + link + resumo
        ficha_aula = [f"Nome oficial da aula: {titulo}",
                      f"Onde fica: {ROTULO_NIVEL} {vitrine} ({vitrine_nome}), Módulo {modulo:02d} – {modulo_nome}, Aula {aula:02d}"]
        if duracao:
            ficha_aula.append(f"Duração/formato: {duracao}")
        if meta.get("titulo_no_material"):
            ficha_aula.append(f"Título dentro do material (PDF): {meta['titulo_no_material']}")
        if link:
            ficha_aula.append(f"Link na área de membros (abre a página do Módulo {modulo:02d}, onde fica esta aula): {link}")
        cab01 = f"{endereco} › Visão geral da aula\n\n" + "\n".join(ficha_aula) + "\n\nResumo:\n"
        limite01 = MAX_PALAVRAS - palavras(cab01)
        partes_resumo = fatiar(resumo_linhas, limite01) if resumo_linhas else [""]
        primeiro = "\n".join(ficha_aula) + ("\n\nResumo:\n" + partes_resumo[0] if partes_resumo[0] else "")
        novo("visao_geral", "Visão geral da aula", "Visão geral", primeiro, {"lesson_link": link or None})
        for k, parte in enumerate(partes_resumo[1:], 2):
            novo("visao_geral", f"Resumo (parte {k} de {len(partes_resumo)})", "Visão geral", parte)

        for cod, titulo_secao, linhas in corpo_secoes:
            rotulo = titulo_secao
            topico = "FAQ" if cod == "faq" else titulo_secao
            limite = MAX_PALAVRAS - palavras(f"{endereco} › {rotulo} (parte 10 de 10)\n\n")
            partes_txt = fatiar(linhas, limite)
            for k, parte in enumerate(partes_txt, 1):
                rot = rotulo if len(partes_txt) == 1 else f"{rotulo} (parte {k} de {len(partes_txt)})"
                novo(cod, rot, topico, parte)
        trechos.extend(registros)

        aulas[lid] = dict(lid=lid, titulo=titulo, vitrine=vitrine, vitrine_nome=vitrine_nome, modulo=modulo,
                          modulo_nome=modulo_nome, aula=aula, produto=produto, link=link, duracao=duracao,
                          trechos=len(registros), source_file=rel, keywords=keywords, endereco=endereco,
                          tipo=meta.get("tipo", ""), registros=registros, _ficha=ficha)

    # Vitrine sem produto: o script para (nada de chunks.jsonl), só o relatório explica.
    if bloqueadas:
        linhas = ["# Base de aulas NÃO gerada", "",
                  "Há aulas em vitrine sem produto mapeado em `PRODUTO_POR_VITRINE` (scripts/gerar_base.py). "
                  "Mapeie a vitrine e rode de novo.", ""]
        linhas += [f"- {lid} (vitrine {v}): `{rel}`" for lid, rel, v in bloqueadas]
        (DESTINO / "relatorio-base.md").write_text("\n".join(linhas) + "\n", encoding="utf-8")
        sys.exit(f"PAROU: {len(bloqueadas)} aulas em vitrine sem produto. Veja {DESTINO / 'relatorio-base.md'}")

    # ---- saídas
    # Nome da IA também nos títulos de seção e no tópico ("Sofia: o que é" → "Soffia: o que é").
    for t in trechos:
        for campo in ("content", "topic", "title", "section_label"):
            if isinstance(t.get(campo), str):
                t[campo] = re.sub(r"\bSofia\b", "Soffia", t[campo])
    with open(DESTINO / "chunks.jsonl", "w", encoding="utf-8") as f:
        for t in trechos:
            f.write(json.dumps(t, ensure_ascii=False) + "\n")

    for a in aulas.values():
        txt = [f"# {a['lid']} — {a['titulo']}", "",
               f"{a['endereco']}",
               f"Produto: {NOME_PRODUTO[a['produto']]} (`{a['produto']}`) · Duração/formato: {a['duracao'] or '—'}",
               f"Link (só no trecho -01): {a['link'] or '—'}",
               f"Palavras-chave (das grafias_extras, não aparecem no texto): {', '.join(a['keywords']) or '—'}",
               f"Arquivo de origem: `{a['source_file']}`", ""]
        if a["lid"] in validar:
            n = sum(1 for x in validar[a["lid"]] if x[0] == "item")
            txt.append(f"> Ficaram fora do bot: {n} \"Pontos a validar\" e outras notas internas (ver relatorio-base.md).")
            txt.append("")
        for r in a["registros"]:
            corpo = r["content"].split("\n\n", 1)[1] if "\n\n" in r["content"] else r["content"]
            txt += [f"## {r['id']} · {r['section_label']}  ({r['words']} palavras)", "", corpo, ""]
        (DESTINO / "aulas" / f"{a['lid']}.md").write_text("\n".join(txt), encoding="utf-8")

    # ---- conferências
    ids = [t["id"] for t in trechos]
    checagens = OrderedDict()
    checagens["ids únicos"] = len(ids) == len(set(ids))
    checagens["toda aula tem trecho -01"] = all(f"{lid}-01" in set(ids) for lid in aulas)
    checagens["todo trecho -01 tem o link da aula no texto"] = all(
        t["lesson_link"] and t["lesson_link"] in t["content"] for t in trechos if t["id"].endswith("-01"))
    checagens["nenhum link fora do trecho -01"] = not any(
        re.search(r"https?://", t["content"]) for t in trechos if not t["id"].endswith("-01"))
    checagens["nenhum link com ?preview ou query string"] = not any(
        re.search(r"preview|https?://\S+\?", t["content"] + str(t["lesson_link"] or "")) for t in trechos)
    checagens["nenhum 'Pontos a validar' no texto do bot"] = not any(
        re.search(r"pontos? a validar", t["content"], re.I) for t in trechos)
    checagens["nenhuma orientação de pedido de reembolso no texto do bot"] = not any(
        REEMBOLSO_RE.search(t["content"]) and REEMBOLSO_PEDIDO_RE.search(t["content"]) for t in trechos)
    checagens[f"nenhum trecho acima de {MAX_PALAVRAS} palavras"] = all(t["words"] <= MAX_PALAVRAS for t in trechos)
    checagens["todo trecho tem produto mapeado"] = all(t["product"] in NOME_PRODUTO for t in trechos)

    escrever_relatorio(aulas, trechos, problemas, decisoes, divergencias, vazios, duplicadas, validar, notas_ficha,
                       ajustes, secoes_vistas, pastas_modulo, nomes_pessoas, checagens, extras)
    escrever_grafias(grafias_rel, aulas)
    total_validar = sum(sum(1 for x in v if x[0] == "item") for v in validar.values())
    print(f"{len(aulas)} aulas, {len(trechos)} trechos, {len(vazios)} arquivos vazios, {len(duplicadas)} duplicadas, "
          f"{total_validar} pontos a validar; checagens: " + ", ".join(f"{k}={'ok' if v else 'FALHOU'}" for k, v in checagens.items()))
    if not all(checagens.values()):
        sys.exit(1)


# ---------------------------------------------------------------------------
# Relatórios
# ---------------------------------------------------------------------------
def tirar_nomes(texto: str, nomes: set) -> str:
    """No relatório (fora do conteúdo das aulas) os nomes de alunas/pessoas citadas viram [nome]."""
    for nome in sorted(nomes, key=len, reverse=True):
        texto = re.sub(r"(?<![\w-])" + re.escape(nome) + r"(?![\w-])", "[nome]", texto)
    return texto


def escrever_relatorio(aulas, trechos, problemas, decisoes, divergencias, vazios, duplicadas, validar, notas_ficha,
                       ajustes, secoes_vistas, pastas_modulo, nomes_pessoas, checagens, extras):
    nomes = set(nomes_pessoas) | {"Felipe"}
    L = []
    tam = sorted(t["words"] for t in trechos)
    por_vit = Counter(a["vitrine"] for a in aulas.values())
    trechos_vit = Counter(t["level"] for t in trechos)
    total_validar = sum(sum(1 for x in v if x[0] == "item") for v in validar.values())
    L += [f"# Base de aulas da MSI — gerada em {VERSAO_BASE}", "",
          "Gerada por `python3 scripts/gerar_base.py \"MSI - CLAUDE DOCS\" base-aulas` a partir das fichas .docx.", "",
          f"- Aulas na base: **{len(aulas)}**",
          f"- Trechos: **{len(trechos)}**",
          f"- Palavras por trecho: mediana {tam[len(tam) // 2]}, mínimo {tam[0]}, máximo {tam[-1]} (teto {MAX_PALAVRAS})",
          f"- Arquivos .docx lidos: {len(aulas) + len(vazios) + len(duplicadas)} "
          f"({len(vazios)} vazios e {len(duplicadas)} repetido ficaram fora)",
          f"- \"Pontos a validar\" tirados do texto do bot: **{total_validar}** (lista completa no fim deste relatório)",
          f"- Tokens estimados para indexar tudo: ~{sum(len(t['content']) for t in trechos) // 4:,}".replace(",", "."), ""]

    L += ["## Conferência automática", ""]
    L += [f"- {'OK' if ok else 'FALHOU'}: {nome}" for nome, ok in checagens.items()]
    L += [""]

    L += ["## Como importar em `course_chunks`", "",
          "Cada linha de `chunks.jsonl` traz primeiro as colunas da tabela: `id`, `product`, `level` (vitrine), `module`, "
          "`lesson` (código — nome da aula, ex.: `V1.M04.A04 — Ciclo de Pagamento: O que é e Como Funciona`; o cartão usa o nome depois do \" — \"), `topic` (seção), `title` (nome da aula), `content`, `status`, `keywords` "
          "(grafias_extras), `source_type`, `source_version`. Os outros campos (`section`, `words`, `lesson_link`, "
          "`source_file`...) são só para conferência e devem ser ignorados na importação.", "",
          "- O link da aula aparece só no `content` (e no campo `lesson_link`) do trecho `-01`.",
          "- O texto de cada trecho começa com o endereço (vitrine › módulo › aula › seção), como no MGA.", ""]

    L += ["## Aulas e trechos por vitrine e módulo", "",
          "| Vitrine | Produto | Módulo | Nome do módulo | Aulas na base | Trechos | Link do módulo | Fora da base |",
          "|---|---|---|---|---|---|---|---|"]
    por_mod = defaultdict(list)
    for a in aulas.values():
        por_mod[(a["vitrine"], a["modulo"])].append(a)
    fora_mod = defaultdict(list)
    for v, m, a, rel in vazios:
        fora_mod[(v, m)].append(f"A{a:02d} vazia" if a else "vazia")
    for lid, rel, ant, igual in duplicadas:
        v, m = int(lid[1]), int(lid.split(".")[1][1:])
        fora_mod[(v, m)].append(f"arquivo `{Path(rel).name}` repetido")
    nomes_pasta_vazia = {}
    for (vit, mod), qtd in pastas_modulo.items():
        mv, mm = re.search(r"Vitrine\s+(\d+)", vit), re.search(r"M[ÓO]DULO\s+(\d+)", mod, re.I)
        if qtd == 0 and mv and mm:
            fora_mod[(int(mv.group(1)), int(mm.group(1)))].append("pasta sem nenhuma ficha")
            nomes_pasta_vazia[(int(mv.group(1)), int(mm.group(1)))] = re.sub(r"^M[ÓO]DULO\s+\d+\s*-\s*", "", mod, flags=re.I).strip()
    existentes = defaultdict(set)
    for a in aulas.values():
        existentes[(a["vitrine"], a["modulo"])].add(a["aula"])
    for v, m, a, rel in vazios:
        if a:
            existentes[(v, m)].add(a)
    for (v, m), nums in existentes.items():
        faltam = [x for x in range(1, max(nums) + 1) if x not in nums]
        if faltam:
            fora_mod[(v, m)].append("sem ficha: " + ", ".join(f"A{x:02d}" for x in faltam))
    chaves = sorted(set(por_mod) | set(fora_mod))
    for (v, m) in chaves:
        lista = por_mod.get((v, m), [])
        nome = lista[0]["modulo_nome"] if lista else nomes_pasta_vazia.get((v, m), "")
        prod = lista[0]["produto"] if lista else PRODUTO_POR_VITRINE.get(v, "?")
        links_mod = sorted({a["link"].split("demandasinvisiveis.com")[-1] for a in lista if a["link"]})
        L.append(f"| {v} | {prod} | {m:02d} | {nome} | {len(lista)} | {sum(a['trechos'] for a in lista)} | "
                 f"{', '.join(links_mod) or '—'} | {'; '.join(fora_mod.get((v, m), [])) or '—'} |")
    L += ["", "| Vitrine | Aulas | Trechos |", "|---|---|---|"]
    for v in sorted(por_vit):
        L.append(f"| {v} | {por_vit[v]} | {trechos_vit[v]} |")
    L.append(f"| **Total** | **{len(aulas)}** | **{len(trechos)}** |")

    L += ["", "## Trechos por tipo", "", "| Tipo | O que é | Trechos |", "|---|---|---|"]
    explic = {"visao_geral": "Trecho -01 (nome oficial, onde fica, link, resumo) e continuação do resumo",
              "faq": "\"Pontos para o suporte\" da ficha", "procedimento": "Seções \"Procedimento...\"",
              "exercicio": "Exercício, missão, tarefa, teste", "conteudo": "Demais seções de conteúdo da aula"}
    for k, v in Counter(t["section"] for t in trechos).most_common():
        L.append(f"| {k} | {explic.get(k, '')} | {v} |")

    L += ["", "## Mapeamento das seções da ficha", "",
          "Títulos de seção (Título 2) encontrados nas fichas e o que foi feito com cada um:", "",
          "| Seção na ficha | Vezes | Vai para o bot? |", "|---|---|---|"]
    destinos = {"visao_geral": "sim, no trecho -01 (Resumo)", "faq": "sim, trecho \"faq\" (tópico FAQ)",
                "procedimento": "sim, trecho \"procedimento\"", "exercicio": "sim, trecho \"exercicio\"",
                "conteudo": "sim, trecho \"conteudo\" (tópico = título da seção)"}
    unicas = Counter()
    for titulo, n in secoes_vistas.most_common():
        cod, entra, motivo = classificar_secao(titulo)
        if n >= 2 or not entra:
            L.append(f"| {tirar_nomes(titulo, nomes)} | {n} | {destinos.get(cod, f'não — {motivo}')} |")
        else:
            unicas[cod] += 1
    rotulos_unicas = {"conteudo": "títulos de conteúdo que aparecem uma vez só (ex.: \"Os 14 hacks\", \"Sofia: o que é\")",
                      "procedimento": "títulos começados por \"Procedimento\" que aparecem uma vez só",
                      "exercicio": "títulos de exercício/missão/tarefa que aparecem uma vez só"}
    for cod, q in unicas.most_common():
        L.append(f"| outros {q} {rotulos_unicas.get(cod, cod)} | {q} | {destinos[cod]} |")
    L += ["", "Também ficam fora do bot: o parágrafo de metadado, as grafias_extras (viram `keywords`), a linha de "
          "navegação (vira o endereço do trecho), notas soltas da ficha antes da primeira seção e referências internas "
          "do tipo \"ver os pontos a validar\" (lista em \"Ajustes automáticos no texto\")."]

    # ---- anomalias
    L += ["", "## Anomalias nas fichas e nas pastas", ""]
    n = 0

    def item(txt):
        nonlocal n
        n += 1
        L.append(f"{n}. {txt}")

    for v, m, a, rel in vazios:
        item(f"Arquivo vazio, sem nenhum texto (fica fora da base): `{rel}`")
    if len(vazios) > 1 and len(extras["hash_vazios"]) == 1:
        item(f"Os {len(vazios)} arquivos vazios são o mesmo documento em branco (arquivos idênticos).")
    for (vit, mod), qtd in sorted(pastas_modulo.items()):
        if qtd == 0:
            item(f"Pasta sem nenhuma ficha: `{vit}/{mod}`")
    # buracos na numeração
    por_vm = defaultdict(set)
    for a in aulas.values():
        por_vm[(a["vitrine"], a["modulo"])].add(a["aula"])
    for v, m, a, rel in vazios:
        if a:
            por_vm[(v, m)].add(a)
    for (v, m), nums in sorted(por_vm.items()):
        faltam = [x for x in range(1, max(nums) + 1) if x not in nums]
        if faltam:
            item(f"Vitrine {v} Módulo {m:02d}: não há ficha das aulas {', '.join(f'{x:02d}' for x in faltam)} "
                 f"(existem: {', '.join(f'{x:02d}' for x in sorted(nums))})")
    for lid, rel, ant, igual in duplicadas:
        item(f"{lid}: o arquivo `{rel}` tem o metadado da mesma aula que `{ant}` ({igual}). Ficou só o primeiro; "
             "a aula do nome do arquivo ficou sem ficha.")
    for tipo, lid, txt in divergencias:
        if tipo == "vitrine":
            continue
        item(f"{lid}: {tipo} diverge — {txt}")
    vits = Counter((tipo, txt) for tipo, lid, txt in divergencias if tipo == "vitrine")
    for (tipo, txt), q in vits.items():
        item(f"Vitrine: {txt} em {q} aulas. O id usa o número da pasta (que é o mesmo do link /member/N/...). "
             "Ver \"Decisões tomadas sem certeza\".")
    # títulos repetidos
    tit = defaultdict(list)
    for a in aulas.values():
        tit[(a["vitrine"], a["modulo"], a["titulo"].lower())].append(a["lid"])
    for (v, m, t), lids in tit.items():
        if len(lids) > 1:
            item(f"Título repetido dentro do mesmo módulo: {', '.join(lids)} (\"{aulas[lids[0]]['titulo']}\")")
    # links
    por_link = defaultdict(list)
    for a in aulas.values():
        por_link[a["link"]].append(a["lid"])
    for lk, lids in por_link.items():
        mods = {(aulas[x]["vitrine"], aulas[x]["modulo"]) for x in lids}
        if len(mods) > 1:
            item(f"O mesmo link aparece em módulos diferentes: {lk} → {', '.join(lids)}")
    item("Os links das fichas são por MÓDULO, não por aula: todas as aulas de um módulo têm o mesmo link "
         f"({len(por_link)} links diferentes para {len(aulas)} aulas; ex.: /member/1/4 serve às 5 aulas do Módulo 04). "
         "O cartão da aula vai abrir a página do módulo. Se a área de membros tiver link por aula, é preciso trocar "
         "nas fichas.")
    sem_link = [a["lid"] for a in aulas.values() if not a["link"]]
    if sem_link:
        item("Aulas sem link: " + ", ".join(sem_link))
    for p in problemas:
        item(p)
    # mesmo nome de arquivo para aulas diferentes
    grupos = defaultdict(list)
    for v, m, a, t, mt, rel in extras["arquivos"]:
        grupos[(v, re.sub(r"[\W_]+", "", t.lower()))].append((m, a, t, mt, rel))
    for (v, _), lista in grupos.items():
        if len(lista) < 2:
            continue
        mesmo_modulo = len({x[0] for x in lista}) < len(lista)
        titulos_meta = {re.sub(r"[\W_]+", "", x[3].lower()) for x in lista if x[3]}
        if mesmo_modulo or len(titulos_meta) > 1:
            desc = "; ".join(f"Módulo {m:02d} " + (f"arquivo {a:02d}" if a else "arquivo sem número")
                             + (f" (metadado: \"{mt}\")" if mt else " (vazio)")
                             for m, a, t, mt, rel in lista)
            item(f"Vitrine {v}: o nome de arquivo \"{lista[0][2]}\" se repete em aulas diferentes — {desc}")
    for v, nomes_v in sorted(extras["nomes_vitrine"].items()):
        pasta = sorted(n for o, n in nomes_v if o == "pasta")
        meta = sorted(n for o, n in nomes_v if o == "metadado")
        if pasta and meta and [re.sub(r"[\W_]+", "", x.lower()) for x in pasta] != [re.sub(r"[\W_]+", "", x.lower()) for x in meta]:
            item(f"Vitrine {v}: nome da pasta \"{' / '.join(pasta)}\" × nome no metadado \"{' / '.join(meta)}\" "
                 "(na base ficou o nome da linha de navegação da ficha).")
    for v, m, origem, nome_mod in sorted(extras["notas_modulo"]):
        item(f"Vitrine {v} Módulo {m:02d}: o nome do módulo {'na pasta' if origem == 'pasta' else 'no metadado'} traz uma nota de configuração "
             f"(\"{nome_mod}\"). Na base ficou sem a nota.")
    expert = sorted({a["lid"] for a in aulas.values() for r in a["registros"] if re.search(r"Vit+orino", r["content"])}
                    | {a["lid"] for a in aulas.values() if any(re.search(r"Vit+orino", k) for k in a["keywords"])})
    if expert:
        item("A expert aparece como \"Gabriela Vittorino/Vitorino\" (não Soares) no texto ou nas grafias de: "
             + ", ".join(expert) + ". Confirmar o nome que o bot deve usar.")
    if not sem_link:
        item("Nenhuma aula ficou sem link (todas as fichas com texto têm `link_area_membros`).")
    for lid, notas in notas_ficha.items():
        for nota in notas:
            item(f"{lid}: nota da ficha fora das seções (não vai para o bot) — {tirar_nomes(nota, nomes)}")
    nao_tempo = [f"{a['lid']} ({a['duracao']})" for a in aulas.values() if a["duracao"] and not re.fullmatch(r"\d+:\d\d", a["duracao"])]
    if nao_tempo:
        item("Aulas que são material em PDF ou com duração fora do padrão: " + "; ".join(nao_tempo))
    outras = defaultdict(set)
    for a in aulas.values():
        for r in a["registros"]:
            for rx, nome in ((r"m[ée]todo gv", "Método GV"), (r"projetos remunerados|\bMPR\b", "Mentoria Projetos Remunerados (MPR)"),
                             (r"estrat[ée]gia mpi", "Estratégia MPI")):
                if re.search(rx, r["content"], re.I) or any(re.search(rx, k, re.I) for k in a["keywords"]):
                    outras[nome].add(a["lid"])
    for nome, lids in outras.items():
        item(f"Gravação cita nome de outro produto (\"{nome}\"), não Método Sócia Invisível: {', '.join(sorted(lids))}")

    # ---- decisões
    orientacoes = [(a["lid"], l) for a in aulas.values() for r in a["registros"] if r["section"] == "faq"
                   for l in r["content"].split("\n")
                   if re.search(r"[Cc]onfirmar|com a equipe|antes de responder|Não (?:dizer|afirmar|repetir|orientar|prometer)", l)]
    L += ["", "## Decisões tomadas sem certeza (confirmar)", ""]
    L += [f"- {d}" for d in decisoes]
    L += ["- Número da vitrine: as fichas da Vitrine 2 dizem `vitrine: \"07\"` e as da Vitrine 3 `vitrine: \"08\"`. "
          "Usei o número da pasta (1, 2, 3), que é o mesmo do link (/member/2/..., /member/3/...) e o da regra de "
          "produto (Vitrine 1, 2 e 3 → principal). Com o metadado, as vitrines 7 e 8 não teriam produto e o script "
          "pararia. Para mudar: `NUMERO_DA_VITRINE = \"metadado\"` no script (e mapear 7 e 8 em `PRODUTO_POR_VITRINE`).",
          "- Módulo e aula: usei sempre os números do metadado (batem com as pastas; só divergem nos casos listados em "
          "\"Anomalias\").",
          "- Nome oficial da aula = Título 1 da ficha (igual ao metadado `titulo`, só com aspas/travessões arrumados), "
          "exceto as correções acima. Nas aulas em que o nome do arquivo .docx diverge do metadado (lista em "
          "\"Anomalias\"), ficou o metadado.",
          "- Nomes de vitrine e de módulo vêm da linha de navegação da ficha (\"Método Sócia Invisível › Módulo 04 – "
          "Anatomia das Demandas Lucrativas\"), que tira as maiúsculas e o \"- configurar por produto\" do Módulo 06 "
          "da Vitrine 2.",
          "- \"Pontos para o suporte\" entram no bot (são as perguntas e respostas da ficha, como o FAQ do MGA), "
          "como um trecho por seção (dividido se passar de 400 palavras), com tópico \"FAQ\" para a palavra "
          "\"suporte\" não puxar esses trechos em toda pergunta.",
          "- Seções \"Informações externas ... (para conferência)\" e \"Fontes\" ficam fora do bot (não são conteúdo de "
          "aula e a própria ficha pede conferência). Frases \"Segundo fonte externa...\" dentro das seções que entram "
          "também saíram. Tudo isso está na lista de \"Pontos a validar\" de cada aula.",
          "- \"Exercício sugerido (a aula não propõe)\" ficou fora (a ficha diz que não é da aula). \"Exercício sugerido "
          "(implícito na aula)\" entrou.",
          "- Avisos de cautela escritos dentro das seções que entram (ex.: \"⚠️ Não verificado\" nas afirmações sobre a "
          "WePink, \"Não dizer que é completamente gratuita\") foram mantidos: reduzem risco de promessa.",
          "- Referências internas das fichas do tipo \"v07 M02 A07\" viraram \"Vitrine 2, Módulo 02, Aula 07\".",
          "- Grafias que a ficha marca como erro de transcrição de outra frase (ex.: \"instabilidade\" por "
          "\"estabilidade\") e nomes de pessoas de casos/depoimentos NÃO viraram palavras-chave (piorariam a busca). "
          "Ficam listados em `revisar-grafias.md`.",
          "- Conteúdo sobre reembolso dentro das aulas (V1.M02.A02 e V1.M02.A03) foi mantido como está na ficha; ver "
          "\"Temas sensíveis\".",
          f"- Os \"Pontos para o suporte\" trazem {len(orientacoes)} linhas escritas para a equipe, em "
          f"{len({i for i, _ in orientacoes})} aulas (ex.: \"Confirmar o procedimento com a equipe antes de responder\", "
          "\"Não dizer que é completamente gratuita\"). Entraram como estão: orientam a IA a não afirmar o que a aula não "
          "garante. Se preferir, a dona do produto pode reescrever essas linhas como resposta pronta."]

    # ---- motor
    L += ["", "## Ajustes no app para esta base (situação em 04/10/2026)", "",
          "- Feito: `LESSON_URL_RE` (aulas.ts) aceita as duas áreas de membros (demandasinvisiveis e sociasuprema).",
          "- Feito: `NOMES_DOS_NIVEIS` (aulas.ts) com as Vitrines 1 a 4; produto `top_demandas` já existe no banco.",
          "- Feito: `lesson` vai no formato `código — nome da aula`, que é o que o motor usa para o nome no cartão.",
          "- Falta: `PRIMEIRAS_AULAS` (aulas.ts). Sugestão: `V1.M01.A01`, `V1.M02.A01`, `V1.M02.A02` (a V1.M02.A04 está vazia).",
          "- O prompt (02-restricoes.md) proíbe informar preço de produto. As aulas citam preços de ferramentas de "
          "terceiros (lista abaixo); se a regra valer também para elas, o bot vai se recusar a repetir esses valores."]

    # ---- preços
    gab = re.compile("|".join(PRODUTOS_DA_GABRIELA), re.I)
    ter = re.compile("|".join(r"\b" + re.escape(t) + r"\b" for t in TERCEIROS), re.I)
    achados_gab, achados_ter, achados_ex = [], [], []
    for a in aulas.values():
        for r in a["registros"]:
            corpo = r["content"].split("\n\n", 1)[-1]
            for linha in corpo.split("\n"):
                if not PRECO_RE.search(linha):
                    continue
                trecho = tirar_nomes(re.sub(r"\s+", " ", linha).strip(), nomes)
                trecho = trecho if len(trecho) <= 180 else trecho[:177] + "..."
                if gab.search(linha):
                    achados_gab.append((r["id"], trecho))
                elif ter.search(linha) and not re.search(r"caso citado|\bganh(?:a|ou|am)\b|fatur", linha, re.I):
                    achados_ter.append((r["id"], trecho))
                else:
                    achados_ex.append((r["id"], trecho))
    L += ["", "## Preço, desconto, cupom e parcelamento", "",
          "Busca feita em todo o texto que vai para o bot (R$, US$, €, dólar, desconto, cupom, parcela, \"12x de\", "
          "à vista, checkout, mensalidade, /mês) e classificada pelo nome do produto citado na mesma linha.", "",
          "### Produtos da própria Gabriela (MSI, Top Demandas Accelerator, Cofre PIX Relâmpago, Mentoria Sócia Suprema, Sócia Vitalícia)", ""]
    if achados_gab:
        L += [f"- {i}: {t}" for i, t in achados_gab]
    else:
        L += ["- Nenhuma aula cita preço, desconto, cupom ou parcelamento desses produtos. Os nomes Top Demandas, "
              "Cofre PIX, Sócia Suprema e Sócia Vitalícia não aparecem em nenhuma ficha. A política \"essa informação é "
              "com o time\" não conflita com a base."]
    L += ["", "### Ferramentas e plataformas de terceiros (conteúdo de aula)", ""]
    agrup = defaultdict(list)
    for i, t in achados_ter:
        agrup[i.rsplit("-", 1)[0]].append((i, t))
    for lid in sorted(agrup):
        L.append(f"- **{lid}** ({aulas[lid]['titulo']}):")
        L += [f"  - {i}: {t}" for i, t in agrup[lid]]
    L += ["", "Atenção: na V1.M01.A01 os planos da Sofia (trimestral e anual) são apresentados como \"condição "
          "exclusiva desta aula\", com link de Plano Premium abaixo do vídeo. Tratei como ferramenta de terceiro, "
          "como combinado; confirmar se a Sofia não é vendida pela própria Gabriela."]
    L += ["", "### Valores que são exemplo de precificação ou de ganho citado na aula (não são preço de produto)", "",
          f"{len(achados_ex)} linhas, em {len({i.rsplit('-', 1)[0] for i, _ in achados_ex})} aulas: "
          + ", ".join(sorted({i.rsplit('-', 1)[0] for i, _ in achados_ex})) + "."]

    # ---- temas sensíveis
    sens = defaultdict(list)
    for a in aulas.values():
        for r in a["registros"]:
            for linha in r["content"].split("\n\n", 1)[-1].split("\n"):
                if REEMBOLSO_RE.search(linha):
                    t = tirar_nomes(re.sub(r"\s+", " ", linha).strip(), nomes)
                    sens[a["lid"]].append(f"{r['id']}: {t if len(t) <= 200 else t[:197] + '...'}")
    L += ["", "## Temas sensíveis no texto que vai para o bot", "",
          "Reembolso, garantia e cancelamento são do Protocolo 7D (servidor). Estas linhas das aulas falam disso; o "
          "prompt já proíbe a IA de orientar reembolso, mas vale a dona do produto revisar:", ""]
    for lid, linhas in sens.items():
        L.append(f"- **{lid}** ({aulas[lid]['titulo']}):")
        L += [f"  - {x}" for x in linhas]
    L += ["", "A aula V1.M02.A02 diz que o prazo de reembolso é de 7 dias: confirmar com `garantia` em `src/oferta/marca.ts`."]

    # ---- pontos a validar
    L += ["", f"## Pontos a validar ({total_validar}), aula por aula", "",
          "Notas internas das fichas, NÃO confirmadas. Nenhuma delas entrou no texto do bot. Junto ficam as seções "
          "\"Informações externas\" e \"Fontes\" e as notas soltas. Nomes de alunas citadas aparecem como [nome].", ""]
    for lid in sorted(validar, key=lambda x: list(aulas).index(x) if x in aulas else 999):
        itens = validar[lid]
        n_it = sum(1 for x in itens if x[0] == "item")
        titulo = aulas[lid]["titulo"] if lid in aulas else ""
        L += [f"### {lid} — {titulo} ({n_it})", ""]
        for x in itens:
            if x[0] in ("item", "nota"):
                L += [tirar_nomes(l, nomes) for l in x[1]]
            else:
                L += ["", f"Seção \"{x[1]}\" (fora do bot):", ""] + [tirar_nomes(l, nomes) for l in x[2]]
        L.append("")

    # ---- ajustes automáticos
    L += ["## Ajustes automáticos no texto", "",
          "Pedaços tirados das seções que entram no bot porque apontavam para \"Pontos a validar\", para seções que "
          "ficaram fora ou para fontes externas:", ""]
    for lid, lista in ajustes.items():
        L.append(f"- **{lid}**: " + " · ".join(f"“{tirar_nomes(t, nomes)}”" for _, t in lista))

    # ---- lista de aulas
    L += ["", "## Aulas", "", "| Aula | Título | Trechos | Produto | Duração | Link |", "|---|---|---|---|---|---|"]
    for a in aulas.values():
        L.append(f"| {a['lid']} | {a['titulo']} | {a['trechos']} | {a['produto']} | {a['duracao']} | {a['link'] or 'FALTA'} |")
    (DESTINO / "relatorio-base.md").write_text("\n".join(L) + "\n", encoding="utf-8")


def escrever_grafias(grafias_rel, aulas):
    L = ["# Grafias extras das fichas", "",
         "As `grafias_extras` de cada ficha **não aparecem no texto do bot**: viraram `keywords` dos trechos da aula "
         "(ajudam a busca a achar a aula quando a aluna escreve o nome de outro jeito).", "",
         "Regras usadas:",
         "- cada linha `A / B / C` vira as palavras-chave A, B e C (notas entre parênteses saem);",
         "- **ficam fora** as formas que a ficha marca como erro de transcrição (\"X (erro de transcrição de 'Y')\"), "
         "grafias incertas e termos genéricos da gravação (ex.: \"mentoria\"), porque puxariam aulas erradas;",
         "- **ficam fora** \"módulo N\" (a busca já trata \"módulo 4\") e nomes de pessoas citadas em casos e "
         "depoimentos (aqui aparecem omitidos);",
         "- **ficam fora** palavras soltas genéricas demais, que puxariam a aula em quase toda pergunta: "
         + ", ".join(sorted(GENERICAS)) + ";",
         "- o motor compara cada palavra da pergunta com o texto da palavra-chave inteira, então uma palavra-chave "
         "com várias palavras (ex.: \"pagamento das demandas\") também é achada por cada palavra dela;",
         "- o nome da expert, do professor de CapCut e de pessoas públicas (Virginia Fonseca) foram mantidos.", "",
         "Legenda: ✅ virou palavra-chave · ⛔ ficou fora.", ""]
    for lid, avaliacao in grafias_rel.items():
        if lid not in aulas:
            continue
        L.append(f"## {lid} — {aulas[lid]['titulo']}")
        for linha, aceitas, motivo in avaliacao:
            if motivo:
                L.append(f"- ⛔ (linha com nome de pessoa citada na aula — omitida)")
                continue
            partes = [p.strip() for p in re.split(r"\s+/\s+", linha)]
            saida = []
            for p in partes:
                limpa = re.sub(r"\s*\([^()]*\)", "", p).replace("'", "").replace('"', "").strip(" .,:;")
                ok = limpa in aceitas
                saida.append(("✅ " if ok else "⛔ ") + p)
            L.append("- " + " / ".join(saida))
        L.append("")
    (DESTINO / "revisar-grafias.md").write_text("\n".join(L), encoding="utf-8")


if __name__ == "__main__":
    main()
