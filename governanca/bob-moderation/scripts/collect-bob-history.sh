#!/usr/bin/env bash
# ============================================================
# Bob Moderation - Coletor de historico real (bash, macOS/Linux)
#
# Equivalente ao collect-bob-history.ps1 (Windows) - mesma tecnica,
# sem dependencia nenhuma alem do que ja vem em qualquer macOS/Linux
# (bash + grep).
#
# HISTORICO: a primeira hipotese (tasks/<uuid>/ui_messages.json no
# globalStorage do app) foi descartada apos busca real na maquina do
# usuario nao encontrar nenhum arquivo desse tipo - o historico real
# fica num banco SQLite:
#   ~/.bob/db/bob.db (+ bob.db-wal, bob.db-shm)
# Sem ferramenta de SQLite instalada, extraimos texto legivel direto
# dos bytes do banco - a mesma ideia do comando "strings", mas usando
# so "grep -a -o" (grep trata o binario como texto e so imprime o
# trecho que bateu no padrao de caracteres imprimiveis). Isso e
# suficiente pra detectar se um termo bloqueado aparece em algum lugar
# do banco, mesmo sem entender o schema interno.
#
# Limitacoes conhecidas (aceitas de proposito - "melhor esforco"):
# - Nao da pra saber em qual conversa/timestamp exato o termo apareceu.
# - Texto acentuado pode cortar no meio (fora da faixa ASCII usada) -
#   nao afeta deteccao dos termos de blocked-terms.txt (todos em ingles
#   sem acento).
#
# Uso:
#   bash collect-bob-history.sh
#   (chamado automaticamente por run-full-audit.sh)
# ============================================================

set -uo pipefail

BOB_HOME="$HOME/.bob"
DB_DIR="$BOB_HOME/db"
LOGS_DIR="$BOB_HOME/logs"
BOB_LOG="$LOGS_DIR/bob.log"

mkdir -p "$LOGS_DIR"

DB_FILES=()
[ -f "$DB_DIR/bob.db" ] && DB_FILES+=("$DB_DIR/bob.db")
[ -f "$DB_DIR/bob.db-wal" ] && DB_FILES+=("$DB_DIR/bob.db-wal")

if [ ${#DB_FILES[@]} -eq 0 ]; then
  echo "ERRO: nao encontrei $DB_DIR/bob.db nem $DB_DIR/bob.db-wal."
  echo "Confira se o Bob ja foi usado nesta maquina (o banco e criado no primeiro uso real)."
  exit 1
fi

echo "Lendo strings legiveis de:"
for f in "${DB_FILES[@]}"; do
  echo "  - $f"
done

TS="$(date '+%Y-%m-%d %H:%M:%S')"

# -a: trata arquivo binario como texto
# -h: nao prefixa com nome do arquivo (usamos varios arquivos)
# -o: so imprime o trecho que bateu no padrao
# [ -~]: intervalo de caracteres imprimiveis ASCII (0x20 a 0x7E)
: > "$BOB_LOG"
count=0
while IFS= read -r line; do
  echo "$TS - DB-STRING: $line" >> "$BOB_LOG"
  count=$((count + 1))
done < <(LC_ALL=C grep -aho '[ -~]\{6,\}' "${DB_FILES[@]}" 2>/dev/null || true)

echo "Strings extraidas: $count"
echo "bob.log atualizado: $BOB_LOG"
echo ""
echo "Proximo passo: content-monitor.sh vai rodar sobre esse bob.log atualizado."
