#!/usr/bin/env bash
# ============================================================
# Bob Moderation - Auditoria completa (macOS/Linux)
#
# Equivalente ao run-full-audit.bat (Windows). Roda os dois passos
# que faltavam pra auditoria funcionar com dados reais:
#   1) collect-bob-history.sh - extrai texto legivel direto do banco
#      SQLite onde o Bob guarda o historico de verdade
#      (~/.bob/db/bob.db / bob.db-wal) e regrava ~/.bob/logs/bob.log
#      com esse conteudo.
#   2) content-monitor.sh - roda a deteccao de sempre (regex contra
#      config/blocked-terms.txt) sobre esse bob.log atualizado.
#
# Este e o script pra agendar (cron / launchd no macOS) - agendar
# ESTE arquivo, nao o content-monitor.sh sozinho, senao ele roda
# sempre sobre um bob.log desatualizado ou vazio.
#
# Uso:
#   bash run-full-audit.sh
# ============================================================

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "============================================"
echo "Bob Moderation - Auditoria completa"
echo "============================================"
echo ""

echo "[1/2] Coletando historico real das conversas..."
bash "$SCRIPT_DIR/collect-bob-history.sh"
collect_status=$?

if [ $collect_status -ne 0 ]; then
  echo "ERRO: falha ao coletar historico. Abortando antes do content-monitor."
  exit 1
fi

echo ""
echo "[2/2] Rodando content-monitor.sh..."
echo ""
bash "$SCRIPT_DIR/content-monitor.sh"

echo ""
echo "Auditoria completa concluida."
