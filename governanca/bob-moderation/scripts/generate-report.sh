#!/bin/bash

# Bob Report Generator
# Gera relatórios de conformidade
# Compatível com macOS (bash 3.2+)

BOB_HOME="$HOME/.bob"
LOGS_DIR="$BOB_HOME/logs"
REPORTS_DIR="$BOB_HOME/reports"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"

# Criar diretório de relatórios
mkdir -p "$REPORTS_DIR"

# Período do relatório (padrão: última semana)
PERIOD="${1:-weekly}"

case $PERIOD in
  daily)
    DAYS=1
    ;;
  weekly)
    DAYS=7
    ;;
  monthly)
    DAYS=30
    ;;
  *)
    echo "Uso: $0 [daily|weekly|monthly]"
    exit 1
    ;;
esac

# Nome do relatório
REPORT_FILE="$REPORTS_DIR/compliance-report-$(date +%Y%m%d).md"

# Gerar relatório
cat > "$REPORT_FILE" << EOF
# Relatório de Conformidade - Bob

**Período:** Últimos $DAYS dias
**Gerado em:** $(date '+%Y-%m-%d %H:%M:%S')

## Resumo Executivo

EOF

# Contar violações
if [ -f "$VIOLATIONS_LOG" ]; then
  TOTAL_VIOLATIONS=$(grep -c "VIOLAÇÃO DETECTADA" "$VIOLATIONS_LOG" 2>/dev/null || echo "0")

  # Calcular data limite (macOS compatible)
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    CUTOFF_DATE=$(date -v-${DAYS}d '+%Y-%m-%d' 2>/dev/null || date '+%Y-%m-%d')
  else
    # Linux
    CUTOFF_DATE=$(date -d "$DAYS days ago" '+%Y-%m-%d' 2>/dev/null || date '+%Y-%m-%d')
  fi

  RECENT_VIOLATIONS=$(grep "VIOLAÇÃO DETECTADA" "$VIOLATIONS_LOG" 2>/dev/null | \
    awk -v cutoff="$CUTOFF_DATE" '$1 >= cutoff' | \
    wc -l | tr -d ' ' || echo "0")

  cat >> "$REPORT_FILE" << EOF
- **Total de violações (histórico):** $TOTAL_VIOLATIONS
- **Violações no período:** $RECENT_VIOLATIONS

## Detalhes das Violações

EOF

  # Adicionar últimas violações
  tail -n 50 "$VIOLATIONS_LOG" >> "$REPORT_FILE" 2>/dev/null
else
  cat >> "$REPORT_FILE" << EOF
- **Total de violações:** 0
- **Status:** ✓ Nenhuma violação detectada

EOF
fi

cat >> "$REPORT_FILE" << EOF

## Recomendações

1. Revisar política de uso aceitável com equipe
2. Atualizar lista de termos bloqueados conforme necessário
3. Verificar configuração de alertas

---
*Relatório gerado automaticamente pelo Bob Content Moderation System*
EOF

echo "✓ Relatório gerado: $REPORT_FILE"
echo ""
cat "$REPORT_FILE"

# Made with Bob
