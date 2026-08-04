#!/bin/bash

#############################################
# Bob Content Moderation - Installation Script
# Versão: 1.0.0
# Descrição: Instala sistema completo de moderação
#############################################

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configurações
REPO_URL="https://raw.githubusercontent.com/rsaragio/bob-moderation/main"
BOB_HOME="$HOME/.bob"
CONFIG_DIR="$BOB_HOME/config"
SCRIPTS_DIR="$BOB_HOME/scripts"
LOGS_DIR="$BOB_HOME/logs"
REPORTS_DIR="$BOB_HOME/reports"

# Funções auxiliares
print_header() {
  echo -e "${BLUE}========================================${NC}"
  echo -e "${BLUE}$1${NC}"
  echo -e "${BLUE}========================================${NC}"
}

print_success() {
  echo -e "${GREEN}✓${NC} $1"
}

print_error() {
  echo -e "${RED}✗${NC} $1"
}

print_warning() {
  echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
  echo -e "${BLUE}ℹ${NC} $1"
}

# Verificar se é atualização
UPDATE_MODE=false
if [[ "$1" == "--update" ]]; then
  UPDATE_MODE=true
fi

# Banner
clear
print_header "Bob Content Moderation - Instalação"
echo ""
echo "Este script irá instalar:"
echo "  • Política de moderação de conteúdo"
echo "  • Lista de termos bloqueados"
echo "  • Scripts de monitoramento"
echo "  • Sistema de alertas"
echo "  • Gerador de relatórios"
echo ""

if [ "$UPDATE_MODE" = true ]; then
  print_info "Modo de atualização ativado"
  echo ""
fi

# Confirmar instalação
if [ "$UPDATE_MODE" = false ]; then
  read -p "Deseja continuar? (s/n) " -n 1 -r
  echo ""
  if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
    print_error "Instalação cancelada"
    exit 1
  fi
fi

echo ""
print_header "Iniciando Instalação"
echo ""

# 1. Criar estrutura de diretórios
print_info "Criando estrutura de diretórios..."
mkdir -p "$CONFIG_DIR"
mkdir -p "$SCRIPTS_DIR"
mkdir -p "$LOGS_DIR"
mkdir -p "$REPORTS_DIR"
print_success "Diretórios criados"

# 2. Baixar arquivos de configuração
print_info "Baixando arquivos de configuração..."

# Política de moderação
curl -fsSL "$REPO_URL/config/moderation-policy.md" -o "$CONFIG_DIR/moderation-policy.md" 2>/dev/null || {
  print_warning "Criando política padrão localmente"
  cat > "$CONFIG_DIR/moderation-policy.md" << 'EOF'
# Política de Uso Aceitável - IBM Bob

## 1. Propósito
Esta política define o uso aceitável do assistente de IA Bob.

## 2. Usos Proibidos
- Criar código malicioso (malware, ransomware, vírus)
- Bypass de controles de segurança
- Roubo ou exfiltração de dados
- Conteúdo ofensivo, discriminatório ou ilegal
- Violação de propriedade intelectual

## 3. Monitoramento
Todas as interações são monitoradas para conformidade.

## 4. Consequências
Violações podem resultar em:
- Advertência formal
- Suspensão temporária
- Revogação permanente de acesso
- Ações disciplinares conforme política da empresa

## 5. Contato
Dúvidas: bob-compliance@empresa.com
EOF
}
print_success "Política de moderação instalada"

# Lista de termos bloqueados
curl -fsSL "$REPO_URL/config/blocked-terms.txt" -o "$CONFIG_DIR/blocked-terms.txt" 2>/dev/null || {
  print_warning "Criando lista de termos padrão localmente"
  cat > "$CONFIG_DIR/blocked-terms.txt" << 'EOF'
# Lista de Termos Bloqueados
# Formato: um termo por linha (regex suportado)

# Segurança Maliciosa
bypass.*security
hack.*into
steal.*credentials
steal.*password
create.*malware
create.*virus
create.*ransomware
keylogger
backdoor.*access
sql.*injection
xss.*attack
csrf.*attack

# Exfiltração de Dados
exfiltrate.*data
leak.*database
dump.*credentials
extract.*secrets

# Conteúdo Ofensivo (adicione conforme necessário)
# [Adicione termos específicos da sua organização]

# Violação de Compliance
bypass.*audit
hide.*logs
delete.*evidence
tamper.*records
EOF
}
print_success "Lista de termos bloqueados instalada"

# Configuração de alertas
curl -fsSL "$REPO_URL/config/alert-config.yaml" -o "$CONFIG_DIR/alert-config.yaml" 2>/dev/null || {
  print_warning "Criando configuração de alertas padrão"
  cat > "$CONFIG_DIR/alert-config.yaml" << 'EOF'
# Configuração de Alertas

# Email do administrador
admin_email: "admin@example.com"

# Níveis de severidade
severity_levels:
  critical: 1  # Alerta imediato
  high: 2      # Alerta em 1 hora
  medium: 3    # Alerta diário
  low: 4       # Alerta semanal

# Ações por severidade
actions:
  critical:
    - send_email
    - create_ticket
    - notify_slack
  high:
    - send_email
    - create_ticket
  medium:
    - send_email
  low:
    - add_to_report

# Configuração de email (opcional)
email:
  smtp_server: "smtp.empresa.com"
  smtp_port: 587
  from_address: "bob-alerts@empresa.com"
  use_tls: true

# Configuração Slack (opcional)
slack:
  webhook_url: "https://hooks.slack.com/services/YOUR/WEBHOOK/URL"
  channel: "#bob-alerts"
EOF
}
print_success "Configuração de alertas instalada"

# 3. Baixar scripts de monitoramento
print_info "Baixando scripts de monitoramento..."

# Script principal de monitoramento
curl -fsSL "$REPO_URL/scripts/content-monitor.sh" -o "$SCRIPTS_DIR/content-monitor.sh" 2>/dev/null || {
  print_warning "Criando script de monitoramento localmente"
  cat > "$SCRIPTS_DIR/content-monitor.sh" << 'EOFSCRIPT'
#!/bin/bash

# Bob Content Monitor
# Monitora logs em busca de termos bloqueados

BOB_HOME="$HOME/.bob"
CONFIG_DIR="$BOB_HOME/config"
LOGS_DIR="$BOB_HOME/logs"
BLOCKED_TERMS="$CONFIG_DIR/blocked-terms.txt"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"
BOB_LOG="$HOME/.bob/logs/bob.log"

# Criar log de violações se não existir
touch "$VIOLATIONS_LOG"

# Ler termos bloqueados (ignorar comentários e linhas vazias)
mapfile -t terms < <(grep -v '^#' "$BLOCKED_TERMS" | grep -v '^$')

# Verificar se há logs do Bob
if [ ! -f "$BOB_LOG" ]; then
  echo "$(date '+%Y-%m-%d %H:%M:%S') - Nenhum log encontrado"
  exit 0
fi

# Procurar por termos bloqueados
violations_found=0
for term in "${terms[@]}"; do
  if grep -i -q -E "$term" "$BOB_LOG"; then
    violations_found=$((violations_found + 1))
    echo "$(date '+%Y-%m-%d %H:%M:%S') - VIOLAÇÃO DETECTADA: $term" >> "$VIOLATIONS_LOG"

    # Extrair contexto (3 linhas antes e depois)
    grep -i -B 3 -A 3 -E "$term" "$BOB_LOG" >> "$VIOLATIONS_LOG"
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
EOFSCRIPT
}
chmod +x "$SCRIPTS_DIR/content-monitor.sh"
print_success "Script de monitoramento instalado"

# Script de geração de relatórios
curl -fsSL "$REPO_URL/scripts/generate-report.sh" -o "$SCRIPTS_DIR/generate-report.sh" 2>/dev/null || {
  print_warning "Criando script de relatórios localmente"
  cat > "$SCRIPTS_DIR/generate-report.sh" << 'EOFSCRIPT'
#!/bin/bash

# Bob Report Generator
# Gera relatórios de conformidade

BOB_HOME="$HOME/.bob"
LOGS_DIR="$BOB_HOME/logs"
REPORTS_DIR="$BOB_HOME/reports"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"

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
  TOTAL_VIOLATIONS=$(grep -c "VIOLAÇÃO DETECTADA" "$VIOLATIONS_LOG" || echo "0")
  RECENT_VIOLATIONS=$(grep "VIOLAÇÃO DETECTADA" "$VIOLATIONS_LOG" | \
    awk -v days=$DAYS '$1 >= systime() - (days * 86400)' | \
    wc -l || echo "0")

  cat >> "$REPORT_FILE" << EOF
- **Total de violações (histórico):** $TOTAL_VIOLATIONS
- **Violações no período:** $RECENT_VIOLATIONS

## Detalhes das Violações

EOF

  # Adicionar últimas violações
  tail -n 50 "$VIOLATIONS_LOG" >> "$REPORT_FILE"
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
cat "$REPORT_FILE"
EOFSCRIPT
}
chmod +x "$SCRIPTS_DIR/generate-report.sh"
print_success "Script de relatórios instalado"

# Script de verificação de conformidade
curl -fsSL "$REPO_URL/scripts/check-compliance.sh" -o "$SCRIPTS_DIR/check-compliance.sh" 2>/dev/null || {
  print_warning "Criando script de conformidade localmente"
  cat > "$SCRIPTS_DIR/check-compliance.sh" << 'EOFSCRIPT'
#!/bin/bash

# Bob Compliance Checker
# Verifica se sistema de moderação está funcionando

BOB_HOME="$HOME/.bob"
CONFIG_DIR="$BOB_HOME/config"
SCRIPTS_DIR="$BOB_HOME/scripts"

echo "🔍 Verificando Sistema de Moderação..."
echo ""

# Verificar arquivos essenciais
checks_passed=0
checks_failed=0

check_file() {
  if [ -f "$1" ]; then
    echo "✓ $2"
    checks_passed=$((checks_passed + 1))
  else
    echo "✗ $2 - FALTANDO"
    checks_failed=$((checks_failed + 1))
  fi
}

check_file "$CONFIG_DIR/moderation-policy.md" "Política de moderação"
check_file "$CONFIG_DIR/blocked-terms.txt" "Lista de termos bloqueados"
check_file "$CONFIG_DIR/alert-config.yaml" "Configuração de alertas"
check_file "$SCRIPTS_DIR/content-monitor.sh" "Script de monitoramento"
check_file "$SCRIPTS_DIR/generate-report.sh" "Script de relatórios"

echo ""
echo "Resultado: $checks_passed/$((checks_passed + checks_failed)) verificações passaram"

if [ $checks_failed -eq 0 ]; then
  echo "✓ Sistema de moderação está completo"
  exit 0
else
  echo "⚠️  Sistema de moderação está incompleto"
  echo "Execute: bash install.sh --update"
  exit 1
fi
EOFSCRIPT
}
chmod +x "$SCRIPTS_DIR/check-compliance.sh"
print_success "Script de conformidade instalado"

# Script de envio de alertas
cat > "$SCRIPTS_DIR/send-alert.sh" << 'EOFSCRIPT'
#!/bin/bash

# Bob Alert Sender
# Envia alertas de violações

VIOLATIONS_COUNT="$1"
CONFIG_DIR="$HOME/.bob/config"
ALERT_CONFIG="$CONFIG_DIR/alert-config.yaml"

# Extrair email do admin (parsing simples de YAML)
ADMIN_EMAIL=$(grep "admin_email:" "$ALERT_CONFIG" | cut -d'"' -f2)

# Enviar email (requer mailx ou sendmail configurado)
if command -v mail &> /dev/null; then
  echo "⚠️  $VIOLATIONS_COUNT violação(ões) detectada(s) no Bob" | \
    mail -s "Bob - Alerta de Moderação" "$ADMIN_EMAIL"
  echo "✓ Alerta enviado para $ADMIN_EMAIL"
else
  echo "⚠️  Comando 'mail' não disponível. Configure SMTP para alertas automáticos."
fi
EOFSCRIPT
chmod +x "$SCRIPTS_DIR/send-alert.sh"
print_success "Script de alertas instalado"

# 4. Configurar monitoramento automático
echo ""
print_info "Configurando monitoramento automático..."

# Verificar se já existe no cron
if crontab -l 2>/dev/null | grep -q "content-monitor.sh"; then
  print_warning "Monitoramento já configurado no cron"
else
  # Adicionar ao cron (executa a cada hora)
  (crontab -l 2>/dev/null; echo "0 * * * * bash $SCRIPTS_DIR/content-monitor.sh >> $LOGS_DIR/monitor.log 2>&1") | crontab -
  print_success "Monitoramento automático configurado (executa a cada hora)"
fi

# 5. Resumo da instalação
echo ""
print_header "Instalação Concluída!"
echo ""
echo "📁 Arquivos instalados em: $BOB_HOME"
echo ""
echo "📋 Próximos passos:"
echo ""
echo "1. Personalizar termos bloqueados:"
echo "   nano $CONFIG_DIR/blocked-terms.txt"
echo ""
echo "2. Configurar email do administrador:"
echo "   nano $CONFIG_DIR/alert-config.yaml"
echo ""
echo "3. Testar monitoramento:"
echo "   bash $SCRIPTS_DIR/content-monitor.sh"
echo ""
echo "4. Gerar relatório:"
echo "   bash $SCRIPTS_DIR/generate-report.sh"
echo ""
echo "5. Verificar conformidade:"
echo "   bash $SCRIPTS_DIR/check-compliance.sh"
echo ""
print_success "Sistema de moderação pronto para uso!"
echo ""
