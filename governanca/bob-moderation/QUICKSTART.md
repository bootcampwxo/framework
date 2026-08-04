# 🚀 Quick Start - Bob Content Moderation

Guia rápido para começar a usar o sistema de moderação de conteúdo do Bob em 5 minutos.

## ⚡ Instalação em 1 Comando

```bash
curl -fsSL https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main/install.sh | bash
```

**Pronto!** O sistema está instalado e configurado.

---

## 📋 Checklist Pós-Instalação

### 1️⃣ Configurar Email do Admin (2 minutos)

```bash
# Editar configuração
nano ~/.bob/config/alert-config.yaml

# Alterar esta linha:
admin_email: "seu-email@empresa.com"

# Salvar: Ctrl+O, Enter, Ctrl+X
```

### 2️⃣ Personalizar Termos Bloqueados (3 minutos)

```bash
# Editar lista de termos
nano ~/.bob/config/blocked-terms.txt

# Adicionar termos específicos da sua empresa
# Exemplo:
echo "nome-projeto-secreto" >> ~/.bob/config/blocked-terms.txt
echo "codigo-interno-xyz" >> ~/.bob/config/blocked-terms.txt
```

### 3️⃣ Testar o Sistema (1 minuto)

```bash
# Verificar se tudo está instalado
bash ~/.bob/scripts/check-compliance.sh

# Deve mostrar:
# ✓ Política de moderação
# ✓ Lista de termos bloqueados
# ✓ Configuração de alertas
# ✓ Script de monitoramento
# ✓ Script de relatórios
```

---

## 🎯 Uso Diário

### Verificar Violações

```bash
# Executar manualmente
bash ~/.bob/scripts/content-monitor.sh

# Saída esperada:
# ✓ Nenhuma violação detectada
# OU
# ⚠️ 3 violação(ões) detectada(s)
```

### Gerar Relatório

```bash
# Relatório semanal
bash ~/.bob/scripts/generate-report.sh weekly

# Relatório mensal
bash ~/.bob/scripts/generate-report.sh monthly
```

### Ver Últimas Violações

```bash
# Ver últimas 10 violações
tail -n 20 ~/.bob/logs/violations.log

# Buscar violações de hoje
grep "$(date +%Y-%m-%d)" ~/.bob/logs/violations.log
```

---

## 🔧 Configurações Avançadas

### Configurar Alertas por Email

```bash
# Editar configuração SMTP
nano ~/.bob/config/alert-config.yaml

# Configurar:
email:
  smtp_server: "smtp.gmail.com"
  smtp_port: 587
  from_address: "bob-alerts@empresa.com"
  use_tls: true
```

### Configurar Slack

```bash
# Editar configuração
nano ~/.bob/config/alert-config.yaml

# Habilitar Slack:
slack:
  enabled: true
  webhook_url: "https://hooks.slack.com/services/SEU/WEBHOOK/URL"
  channel: "#bob-alerts"
```

### Agendar Monitoramento Automático

```bash
# Já está configurado! Executa a cada hora.
# Para verificar:
crontab -l | grep content-monitor

# Para mudar frequência (exemplo: a cada 30 min):
crontab -e
# Alterar para: */30 * * * * bash ~/.bob/scripts/content-monitor.sh
```

---

## 📊 Estrutura de Arquivos

```
~/.bob/
├── config/
│   ├── blocked-terms.txt      # ← Edite aqui os termos
│   ├── moderation-policy.md   # ← Política de uso
│   └── alert-config.yaml      # ← Configuração de alertas
├── scripts/
│   ├── content-monitor.sh     # ← Monitoramento
│   ├── generate-report.sh     # ← Relatórios
│   ├── check-compliance.sh    # ← Verificação
│   └── send-alert.sh          # ← Envio de alertas
├── logs/
│   ├── violations.log         # ← Violações detectadas
│   └── monitor.log            # ← Log do monitor
└── reports/
    └── compliance-report-*.md # ← Relatórios gerados
```

---

## 🆘 Solução de Problemas

### Problema: "Nenhum log encontrado"

```bash
# Verificar se Bob está gerando logs
ls -la ~/.bob/logs/

# Se não existir, criar:
mkdir -p ~/.bob/logs
touch ~/.bob/logs/bob.log
```

### Problema: "Alertas não estão sendo enviados"

```bash
# Verificar se comando 'mail' está disponível
which mail

# Se não estiver, instalar:
# Ubuntu/Debian:
sudo apt-get install mailutils

# macOS:
# Já vem instalado
```

### Problema: "Monitoramento não está rodando"

```bash
# Verificar cron
crontab -l

# Se não estiver, adicionar:
(crontab -l 2>/dev/null; echo "0 * * * * bash ~/.bob/scripts/content-monitor.sh") | crontab -
```

---

## 📚 Comandos Úteis

### Monitoramento

```bash
# Executar monitor
bash ~/.bob/scripts/content-monitor.sh

# Ver log do monitor
tail -f ~/.bob/logs/monitor.log

# Ver violações em tempo real
tail -f ~/.bob/logs/violations.log
```

### Relatórios

```bash
# Gerar relatório diário
bash ~/.bob/scripts/generate-report.sh daily

# Gerar relatório semanal
bash ~/.bob/scripts/generate-report.sh weekly

# Gerar relatório mensal
bash ~/.bob/scripts/generate-report.sh monthly

# Ver último relatório
ls -t ~/.bob/reports/ | head -1 | xargs -I {} cat ~/.bob/reports/{}
```

### Manutenção

```bash
# Verificar conformidade
bash ~/.bob/scripts/check-compliance.sh

# Atualizar sistema
curl -fsSL https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main/install.sh | bash --update

# Limpar logs antigos (>90 dias)
find ~/.bob/logs -name "*.log" -mtime +90 -delete
```

---

## 🎓 Próximos Passos

### 1. Revisar Política com a Equipe
```bash
# Abrir política
cat ~/.bob/config/moderation-policy.md

# Ou no navegador
open ~/.bob/config/moderation-policy.md
```

### 2. Customizar Termos Bloqueados
```bash
# Adicionar termos específicos da empresa
nano ~/.bob/config/blocked-terms.txt
```

### 3. Configurar Integrações
```bash
# Slack, ServiceNow, SIEM, etc.
nano ~/.bob/config/alert-config.yaml
```

### 4. Treinar a Equipe
- Compartilhar política de uso aceitável
- Explicar sistema de monitoramento
- Demonstrar como reportar violações

---

## 📞 Suporte

### Documentação Completa
- [README](README.md) - Visão geral
- [Instalação](docs/INSTALLATION.md) - Guia detalhado
- [Configuração](docs/CONFIGURATION.md) - Todas as opções
- [Troubleshooting](docs/TROUBLESHOOTING.md) - Problemas comuns

### Contato
- **Issues:** https://github.com/SEU-ORG/bob-moderation/issues
- **Email:** bob-support@empresa.com
- **Slack:** #bob-moderation

---

## ✅ Checklist Final

Antes de considerar a instalação completa, verifique:

- [ ] Sistema instalado com sucesso
- [ ] Email do admin configurado
- [ ] Termos bloqueados personalizados
- [ ] Teste de monitoramento executado
- [ ] Cron configurado (monitoramento automático)
- [ ] Equipe informada sobre a política
- [ ] Relatório inicial gerado

**Tudo pronto?** 🎉 Seu sistema de moderação está operacional!

---

## 🔄 Manutenção Regular

### Diariamente
- ✅ Revisar alertas recebidos
- ✅ Investigar violações críticas

### Semanalmente
- ✅ Gerar e revisar relatório semanal
- ✅ Atualizar termos bloqueados se necessário

### Mensalmente
- ✅ Revisar política com stakeholders
- ✅ Analisar tendências de violações
- ✅ Atualizar sistema (se houver nova versão)

### Trimestralmente
- ✅ Auditoria completa do sistema
- ✅ Treinamento de reciclagem da equipe
- ✅ Revisão de integrações

---

**Versão:** 1.0.0
**Última Atualização:** 2026-05-20
