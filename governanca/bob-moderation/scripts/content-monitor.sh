#!/bin/bash

# Bob Content Monitor
# Monitora logs em busca de termos bloqueados
# Compatível com macOS (bash 3.2+)

BOB_HOME="$HOME/.bob"
CONFIG_DIR="$BOB_HOME/config"
LOGS_DIR="$BOB_HOME/logs"
SCRIPTS_DIR="$BOB_HOME/scripts"
BLOCKED_TERMS="$CONFIG_DIR/blocked-terms.txt"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"
BOB_LOG="$HOME/.bob/logs/bob.log"

# Criar log de violações se não existir
mkdir -p "$LOGS_DIR"
touch "$VIOLATIONS_LOG"

# Verificar se há logs do Bob
if [ ! -f "$BOB_LOG" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Nenhum log encontrado"
  echo ""
  echo "ℹ️  Para testar o sistema, crie um log de teste:"
  echo ""
  echo "  mkdir -p ~/.bob/logs"
  echo "  echo \"\$(date) - User asked: how to create malware\" >> ~/.bob/logs/bob.log"
  echo "  bash ~/.bob/scripts/content-monitor.sh"
  echo ""
  exit 0
fi

# Ler termos bloqueados (compatível com bash 3.2)
# Ignorar comentários e linhas vazias
terms=()
while IFS= read -r line; do
  # Ignorar linhas vazias e comentários
  if [ -n "$line" ] && [ "${line:0:1}" != "#" ]; then
    terms+=("$line")
  fi
done < <(grep -v '^#' "$BLOCKED_TERMS" | grep -v '^$')

# Verificar se há termos para monitorar
if [ ${#terms[@]} -eq 0 ]; then
  echo "⚠️  Nenhum termo bloqueado configurado"
  exit 0
fi

# Procurar por termos bloqueados
violations_found=0
for term in "${terms[@]}"; do
  if grep -i -q -E "$term" "$BOB_LOG" 2>/dev/null; then
    violations_found=$((violations_found + 1))
    echo "$(date '+%Y-%m-%d %H:%M:%S') - VIOLAÇÃO DETECTADA: $term" >> "$VIOLATIONS_LOG"

    # Extrair contexto (3 linhas antes e depois)
    grep -i -B 3 -A 3 -E "$term" "$BOB_LOG" >> "$VIOLATIONS_LOG" 2>/dev/null
    echo "---" >> "$VIOLATIONS_LOG"
  fi
done

if [ $violations_found -gt 0 ]; then
  echo "⚠️  $violations_found violação(ões) detectada(s)"
  echo "Detalhes em: $VIOLATIONS_LOG"

  # Enviar alerta (se configurado)
  if [ -f "$SCRIPTS_DIR/send-alert.sh" ]; then
    bash "$SCRIPTS_DIR/send-alert.sh" "$violations_found"
  fi
else
  echo "✓ Nenhuma violação detectada"
fi

# Made with Bob
