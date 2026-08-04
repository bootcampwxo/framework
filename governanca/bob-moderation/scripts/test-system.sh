#!/bin/bash

# Bob Moderation System - Test Script
# Testa o sistema de moderação criando logs de exemplo
# Compatível com macOS (bash 3.2+)

echo "🧪 Bob Moderation System - Test Script"
echo "======================================"
echo ""

BOB_HOME="$HOME/.bob"
LOGS_DIR="$BOB_HOME/logs"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"

# Criar diretórios necessários
mkdir -p "$LOGS_DIR"

# Criar log de teste do Bob
BOB_LOG="$LOGS_DIR/bob-$(date +%Y%m%d).log"

echo "📝 Criando log de teste: $BOB_LOG"
cat > "$BOB_LOG" << 'EOF'
2026-05-20 12:00:00 - User: rsaragio - Command: list_files
2026-05-20 12:01:00 - User: rsaragio - Command: read_file - File: config.json
2026-05-20 12:02:00 - User: rsaragio - Command: write_to_file - File: test.txt
2026-05-20 12:03:00 - User: rsaragio - Message: "Como faço para rm -rf /"
2026-05-20 12:04:00 - User: rsaragio - Command: execute_command - Command: ls -la
2026-05-20 12:05:00 - User: rsaragio - Message: "Preciso fazer backup dos dados"
2026-05-20 12:06:00 - User: rsaragio - Command: search_files - Pattern: "*.py"
2026-05-20 12:07:00 - User: rsaragio - Message: "Como usar curl para download?"
2026-05-20 12:08:00 - User: rsaragio - Command: apply_diff - File: main.py
2026-05-20 12:09:00 - User: rsaragio - Message: "Vou fazer um teste com malware"
2026-05-20 12:10:00 - User: rsaragio - Command: execute_command - Command: python script.py
EOF

echo "✓ Log de teste criado com 11 entradas"
echo ""

# Executar monitor
echo "🔍 Executando content-monitor.sh..."
echo ""

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/content-monitor.sh" ]; then
  bash "$SCRIPT_DIR/content-monitor.sh"
else
  echo "❌ Erro: content-monitor.sh não encontrado em $SCRIPT_DIR"
  exit 1
fi

echo ""
echo "📊 Resultados:"
echo "=============="

# Verificar violações
if [ -f "$VIOLATIONS_LOG" ]; then
  VIOLATION_COUNT=$(grep -c "VIOLAÇÃO DETECTADA" "$VIOLATIONS_LOG" 2>/dev/null || echo "0")
  echo "✓ Violações detectadas: $VIOLATION_COUNT"
  echo ""

  if [ "$VIOLATION_COUNT" -gt 0 ]; then
    echo "📋 Últimas violações:"
    echo "-------------------"
    tail -n 10 "$VIOLATIONS_LOG"
  fi
else
  echo "✓ Nenhuma violação detectada"
fi

echo ""
echo "📁 Arquivos criados:"
echo "-------------------"
echo "- Log de teste: $BOB_LOG"
echo "- Log de violações: $VIOLATIONS_LOG"
echo ""

echo "🎯 Próximos passos:"
echo "==================="
echo "1. Revisar violações detectadas"
echo "2. Ajustar config/blocked-terms.txt se necessário"
echo "3. Configurar alertas em config/alert-config.yaml"
echo "4. Executar: ./scripts/generate-report.sh daily"
echo ""

echo "✅ Teste concluído!"

# Made with Bob
