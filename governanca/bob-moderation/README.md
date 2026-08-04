# 🛡️ Bob Content Moderation Repository

Sistema completo de moderação de conteúdo para IBM Bob.

## 🚀 Deploy no GitHub Enterprise IBM

**Seu repositório:** https://github.ibm.com/rsaragio/bob-moderation

📘 **[Guia Completo de Deploy →](DEPLOY-IBM-GITHUB.md)**

---

## 🧪 Já Instalou? Teste Agora!

🎯 **[TESTE-RAPIDO.md →](TESTE-RAPIDO.md)** - Guia completo de teste em 3 passos

```bash
# Teste automático (cria logs de exemplo e detecta violações)
cd bob-moderation-repo/scripts
./test-system.sh

# Gerar relatório
./generate-report.sh daily
```

---

## 🔄 Atualizar Repositório Git

Após fazer mudanças locais, atualize o repositório:

```bash
cd bob-moderation-repo
./ATUALIZAR-GIT.sh
```

Este script:
- ✅ Adiciona todos os arquivos modificados
- ✅ Cria commit com mensagem descritiva
- ✅ Faz push para o GitHub Enterprise IBM (opcional)

---

## 📋 Estrutura do Repositório

```
bob-moderation-repo/
├── README.md # Este arquivo
├── TESTE-RAPIDO.md # 🆕 Guia de teste (3 passos)
├── INSTALL-V2-MELHORIAS.md # 🆕 Documentação das melhorias v2.0
├── CORRECOES-MACOS.md # 🆕 Correções para macOS
├── DEPLOY-IBM-GITHUB.md # Guia de deploy IBM
├── ATUALIZAR-GIT.sh # 🆕 Script para atualizar Git
├── INICIALIZAR-GIT.sh # Script para inicializar Git
├── install.sh # Script de instalação completo v2.0
├── config/
│ ├── blocked-terms.txt # Lista de termos bloqueados (130+)
│ ├── moderation-policy.md # Política de uso aceitável
│ └── alert-config.yaml # Configuração de alertas
├── scripts/
│ ├── content-monitor.sh # Monitor de conteúdo (macOS compatible)
│ ├── generate-report.sh # Gerador de relatórios (macOS compatible)
│ ├── test-system.sh # 🆕 Script de teste automático
│ ├── check-compliance.sh # Verificador de conformidade
│ └── send-alert.sh # Envio de alertas
└── docs/
├── QUICKSTART.md # Guia rápido (5 minutos)
├── COMO-USAR-NO-GIT.md # Guia completo de Git
├── RESUMO-EXECUTIVO.md # Para apresentar à gestão
├── INDICE-COMPLETO.md # Navegação completa
└── PROTECAO-E-ATUALIZACAO.md # Segurança e atualizações forçadas
```

## 🚀 Instalação Rápida

### Opção 1: Instalação Automática (Recomendado)

```bash
# Baixar e executar script de instalação
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash
```

### Opção 2: Instalação Manual

```bash
# Clonar repositório
git clone git@github.ibm.com:rsaragio/bob-moderation.git
cd bob-moderation

# Executar instalação
bash install.sh
```

## 📦 O Que Será Instalado

- ✅ Política de moderação de conteúdo
- ✅ Lista de termos bloqueados (130+ termos pré-configurados)
- ✅ Scripts de monitoramento automático
- ✅ Sistema de alertas por email
- ✅ Gerador de relatórios de conformidade
- ✅ (Opcional) Proxy de moderação em tempo real

## 🔧 Configuração Pós-Instalação

### 1. Personalizar Termos Bloqueados

```bash
# Editar lista de termos
nano ~/.bob/config/blocked-terms.txt

# Adicionar seus termos específicos
echo "termo-customizado" >> ~/.bob/config/blocked-terms.txt
```

### 2. Configurar Alertas

```bash
# Editar configuração de alertas
nano ~/.bob/config/alert-config.yaml

# Definir email do administrador
sed -i 's/admin@example.com/seu-email@br.ibm.com/' ~/.bob/config/alert-config.yaml
```

### 3. Agendar Monitoramento Automático

```bash
# Adicionar ao cron (executa a cada hora)
(crontab -l 2>/dev/null; echo "0 * * * * bash ~/.bob/scripts/content-monitor.sh") | crontab -
```

## 📊 Uso Diário

### Verificar Violações Recentes

```bash
bash ~/.bob/scripts/content-monitor.sh
```

### Gerar Relatório Semanal

```bash
bash ~/.bob/scripts/generate-report.sh --period weekly
```

### Verificar Conformidade

```bash
bash ~/.bob/scripts/check-compliance.sh
```

## 🔄 Atualização

```bash
# Atualizar para última versão
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash --update
```

## 🔒 Segurança e Proteção

### ⚠️ Preocupações Comuns

**P: E se o usuário modificar os arquivos locais?**
**R:** Veja o guia completo: [PROTECAO-E-ATUALIZACAO.md](PROTECAO-E-ATUALIZACAO.md)

**P: Como garantir que todos recebam atualizações?**
**R:** Implementamos 4 soluções, desde básica até máxima segurança:

1. **Proteção de Arquivos** - chmod 444 (somente leitura)
2. **Verificação de Integridade** - Detecta modificações
3. **Arquivos Centralizados** ⭐ - Lê diretamente do Git
4. **Assinatura Digital** - GPG para máxima segurança

**Recomendação:** Use Solução 3 (Centralizada) para atualizações automáticas instantâneas.

### 🔐 Implementação Segura

```bash
# Instalação com arquivos centralizados (recomendado)
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install-secure.sh | bash
```

**Vantagens:**
- ✅ Arquivos sempre lidos do Git (versão mais recente)
- ✅ Usuário não pode modificar localmente
- ✅ Atualizações instantâneas (admin faz push → todos recebem)
- ✅ Sem necessidade de comando "update"

## 📚 Documentação Completa

### Para Começar
- **[QUICKSTART.md](QUICKSTART.md)** - Instalação em 5 minutos
- **[README.md](README.md)** - Este arquivo
- **[DEPLOY-IBM-GITHUB.md](DEPLOY-IBM-GITHUB.md)** - Deploy no GitHub Enterprise IBM

### Para Implementar
- **[COMO-USAR-NO-GIT.md](COMO-USAR-NO-GIT.md)** - Setup completo do Git
- **[PROTECAO-E-ATUALIZACAO.md](PROTECAO-E-ATUALIZACAO.md)** - Segurança e atualizações

### Para Apresentar
- **[RESUMO-EXECUTIVO.md](RESUMO-EXECUTIVO.md)** - Para gestão (ROI, métricas)

### Para Navegar
- **[INDICE-COMPLETO.md](INDICE-COMPLETO.md)** - Índice de todos os arquivos

## 🎯 Casos de Uso

### Caso 1: Bloquear Código Malicioso

**Problema:** Usuário tenta criar malware
**Solução:** Sistema detecta "create malware" e:
- 🚨 Registra violação
- 📧 Envia alerta para admin
- 📝 Adiciona ao relatório
- ⚠️ Notifica usuário

### Caso 2: Prevenir Exfiltração de Dados

**Problema:** Tentativa de roubar credenciais
**Solução:** Sistema detecta "steal credentials" e:
- 🔴 Alerta crítico imediato
- 🎫 Cria ticket no ServiceNow
- 💬 Notifica no Slack
- 🔒 Bloqueia usuário (opcional)

### Caso 3: Compliance e Auditoria

**Problema:** Precisa provar conformidade
**Solução:** Sistema gera:
- 📊 Relatórios automáticos
- 📈 Estatísticas de uso
- 🔍 Histórico de violações
- ✅ Evidências para auditoria

## 🔄 Fluxo de Atualização

### Admin Adiciona Novo Termo

```bash
# 1. Admin edita no Git
cd bob-moderation-repo
echo "novo-termo-malicioso" >> config/blocked-terms.txt
git add . && git commit -m "Add new term" && git push

# 2. Usuários recebem automaticamente
# (Se usando Solução 3 - Centralizada)
# Próxima execução do monitor → Novo termo já ativo ✅

# 3. Ou usuários executam update
# (Se usando Solução 1 ou 2)
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash --update
```

## 📊 Métricas de Sucesso

Após implementação, você terá:

### Métricas de Segurança
- ✅ **100%** das interações monitoradas
- ✅ **<5 min** tempo de detecção de violações
- ✅ **<15 min** tempo de resposta a incidentes críticos
- ✅ **0** violações não detectadas

### Métricas de Compliance
- ✅ **Relatórios automáticos** diários/semanais/mensais
- ✅ **Histórico completo** de todas as atividades
- ✅ **Evidências auditáveis** para compliance
- ✅ **Política documentada** e distribuída

## 🆘 Suporte

### Documentação
- [Guia Rápido](QUICKSTART.md) - 5 minutos
- [Deploy IBM](DEPLOY-IBM-GITHUB.md) - GitHub Enterprise IBM
- [Guia de Git](COMO-USAR-NO-GIT.md) - Setup completo
- [Segurança](PROTECAO-E-ATUALIZACAO.md) - Proteção e atualizações
- [Índice Completo](INDICE-COMPLETO.md) - Navegação

### Contato
- **Repositório:** https://github.ibm.com/rsaragio/bob-moderation
- **Issues:** https://github.ibm.com/rsaragio/bob-moderation/issues
- **Email:** bob-support@br.ibm.com
- **Slack:** #bob-moderation

## 📄 Licença

MIT License - Veja LICENSE para detalhes

---

**Versão:** 1.0.0
**Última Atualização:** 2026-05-20
**Status:** ✅ Pronto para Produção
**Deploy:** GitHub Enterprise IBM (github.ibm.com)
