# 🧪 Teste Rápido - Bob Moderation System

## 🎯 Novidade: install.sh Agora Faz Tudo Automaticamente!

**Versão 2.0** do `install.sh` agora:
- ✅ Instala scripts compatíveis com macOS (bash 3.2+) - **SEM erro de `mapfile`**
- ✅ Cria log de teste do Bob automaticamente
- ✅ Executa teste completo ao final da instalação
- ✅ Mostra violações detectadas imediatamente

### 🚀 Instalação Completa em 1 Comando

```bash
cd bob-moderation-repo
./install.sh
```

**O que acontece:**
1. Cria estrutura de diretórios (`~/.bob/`)
2. Instala 130+ termos bloqueados
3. Instala scripts compatíveis com macOS (sem `mapfile`)
4. Cria log de teste do Bob com 11 entradas
5. Executa teste automático
6. Mostra violações detectadas
7. Configura monitoramento automático (cron)

**Saída esperada:**
```
========================================
Bob Content Moderation - Instalação v2.0
========================================

Este script irá instalar:
  • Política de moderação de conteúdo
  • Lista de 130+ termos bloqueados
  • Scripts de monitoramento (macOS compatible)
  • Sistema de alertas
  • Gerador de relatórios
  • Log de teste do Bob

Deseja continuar? (s/n) s

========================================
Iniciando Instalação
========================================

ℹ Criando estrutura de diretórios...
✓ Diretórios criados
ℹ Baixando arquivos de configuração...
✓ Política de moderação instalada
✓ Lista de 130+ termos bloqueados instalada
✓ Configuração de alertas instalada
ℹ Instalando scripts compatíveis com macOS (bash 3.2+)...
✓ Script de monitoramento instalado (macOS compatible)
✓ Script de relatórios instalado (macOS compatible)
✓ Script de teste instalado
✓ Script de conformidade instalado
✓ Script de alertas instalado

ℹ Criando log de teste do Bob...
✓ Log de teste criado: ~/.bob/logs/bob-20260520.log

ℹ Configurando monitoramento automático...
✓ Monitoramento automático configurado (executa a cada hora)

========================================
Executando Teste Automático
========================================

🧪 Bob Moderation System - Test Script
======================================

📝 Criando log de teste: ~/.bob/logs/bob-20260520.log
✓ Log de teste criado com 11 entradas

🔍 Executando content-monitor.sh...

🔍 Bob Content Monitor - Verificando logs...
✓ Carregados 130 termos bloqueados
✓ Encontrados 1 arquivo(s) de log
📝 Analisando: ~/.bob/logs/bob-20260520.log

⚠️ VIOLAÇÃO DETECTADA!
Termo: rm -rf
Linha: 2026-05-20 12:03:00 - User: rsaragio - Message: "Como faço para rm -rf /"

⚠️ VIOLAÇÃO DETECTADA!
Termo: malware
Linha: 2026-05-20 12:09:00 - User: rsaragio - Message: "Vou fazer um teste com malware"

📊 Resumo:
- Logs analisados: 1
- Violações encontradas: 2
- Log de violações: ~/.bob/logs/violations.log

========================================
Instalação Concluída!
========================================

📁 Arquivos instalados em: ~/.bob

✅ Sistema testado e funcionando!

📋 Próximos passos:

1. Revisar violações detectadas:
   cat ~/.bob/logs/violations.log

2. Gerar relatório de conformidade:
   bash ~/.bob/scripts/generate-report.sh daily

3. Personalizar termos bloqueados:
   nano ~/.bob/config/blocked-terms.txt

4. Configurar email do administrador:
   nano ~/.bob/config/alert-config.yaml

5. Verificar cron (monitoramento automático):
   crontab -l | grep bob

✓ Sistema de moderação pronto para uso!

ℹ Documentação completa: TESTE-RAPIDO.md
```

---

## ✅ Sistema Instalado - Como Testar Novamente?

Se você já executou o `install.sh` e quer testar novamente:

### 📋 Pré-requisitos

- ✓ Sistema instalado em `~/.bob/`
- ✓ Scripts em `~/.bob/scripts/`
- ✓ Configurações em `~/.bob/config/`

### 🚀 Teste Manual em 3 Passos

#### 1️⃣ Executar Script de Teste Automático

```bash
cd bob-moderation-repo/scripts
./test-system.sh
```

**O que este script faz:**
- Cria um log de teste do Bob com 11 entradas
- Inclui 2 violações intencionais ("rm -rf /" e "malware")
- Executa o monitor de conteúdo
- Mostra os resultados

**Saída esperada:**
```
🧪 Bob Moderation System - Test Script
======================================

📝 Criando log de teste: ~/.bob/logs/bob-20260520.log
✓ Log de teste criado com 11 entradas

🔍 Executando content-monitor.sh...

🔍 Bob Content Monitor - Verificando logs...
✓ Carregados 130 termos bloqueados
✓ Encontrados 1 arquivo(s) de log
📝 Analisando: ~/.bob/logs/bob-20260520.log

⚠️ VIOLAÇÃO DETECTADA!
Termo: rm -rf
Linha: 2026-05-20 12:03:00 - User: rsaragio - Message: "Como faço para rm -rf /"

⚠️ VIOLAÇÃO DETECTADA!
Termo: malware
Linha: 2026-05-20 12:09:00 - User: rsaragio - Message: "Vou fazer um teste com malware"

📊 Resumo:
- Logs analisados: 1
- Violações encontradas: 2
- Log de violações: ~/.bob/logs/violations.log

📊 Resultados:
==============
✓ Violações detectadas: 2

📋 Últimas violações:
-------------------
2026-05-20 12:19:28 - VIOLAÇÃO DETECTADA - Termo: rm -rf
2026-05-20 12:19:28 - VIOLAÇÃO DETECTADA - Termo: malware

✅ Teste concluído!
```

#### 2️⃣ Gerar Relatório de Conformidade

```bash
cd bob-moderation-repo/scripts
./generate-report.sh daily
```

**O que este script faz:**
- Analisa violações dos últimos dias
- Gera relatório em Markdown
- Salva em `~/.bob/reports/`

**Saída esperada:**
```
✓ Relatório gerado: ~/.bob/reports/compliance-report-20260520.md

# Relatório de Conformidade - Bob

**Período:** Últimos 1 dias
**Gerado em:** 2026-05-20 12:19:28

## Resumo Executivo

- **Total de violações (histórico):** 2
- **Violações no período:** 2

## Detalhes das Violações

2026-05-20 12:19:28 - VIOLAÇÃO DETECTADA - Termo: rm -rf
2026-05-20 12:19:28 - VIOLAÇÃO DETECTADA - Termo: malware
```

#### 3️⃣ Verificar Arquivos Criados

```bash
# Ver estrutura criada
tree ~/.bob

# Ver logs
cat ~/.bob/logs/bob-*.log

# Ver violações
cat ~/.bob/logs/violations.log

# Ver relatório
cat ~/.bob/reports/compliance-report-*.md
```

---

## 🔄 Teste com Bob Real

### Opção A: Aguardar Uso Normal

O sistema monitora automaticamente a cada hora via cron:
```bash
# Verificar se cron está configurado
crontab -l | grep bob
```

Deve mostrar:
```
0 * * * * ~/.bob/scripts/content-monitor.sh
```

### Opção B: Teste Manual Imediato

1. **Use o Bob normalmente** - faça algumas perguntas
2. **Execute o monitor manualmente:**
```bash
~/.bob/scripts/content-monitor.sh
```
3. **Verifique os resultados:**
```bash
cat ~/.bob/logs/violations.log
```

---

## 📊 Comandos Úteis

### Monitoramento

```bash
# Executar monitor manualmente
~/.bob/scripts/content-monitor.sh

# Ver últimas violações
tail -f ~/.bob/logs/violations.log

# Contar violações hoje
grep "$(date +%Y-%m-%d)" ~/.bob/logs/violations.log | wc -l
```

### Relatórios

```bash
# Relatório diário
~/.bob/scripts/generate-report.sh daily

# Relatório semanal
~/.bob/scripts/generate-report.sh weekly

# Relatório mensal
~/.bob/scripts/generate-report.sh monthly

# Ver último relatório
cat ~/.bob/reports/compliance-report-*.md | tail -50
```

### Configuração

```bash
# Editar termos bloqueados
nano ~/.bob/config/blocked-terms.txt

# Editar política
nano ~/.bob/config/moderation-policy.md

# Editar alertas
nano ~/.bob/config/alert-config.yaml
```

---

## ❓ Perguntas Frequentes

### O Bob precisa ser reiniciado?

**Não!** O sistema de moderação é independente:
- Monitora logs existentes
- Não interfere com o Bob
- Funciona em background via cron

### Precisa iniciar algum serviço?

**Não!** Tudo funciona via:
- **Cron** - execução automática a cada hora
- **Scripts** - execução manual quando necessário

### Como desabilitar temporariamente?

```bash
# Remover do cron
crontab -l | grep -v "content-monitor.sh" | crontab -

# Reabilitar depois
(crontab -l 2>/dev/null; echo "0 * * * * ~/.bob/scripts/content-monitor.sh") | crontab -
```

### Como adicionar novos termos bloqueados?

```bash
# Editar arquivo
nano ~/.bob/config/blocked-terms.txt

# Adicionar termo (um por linha)
echo "novo-termo-perigoso" >> ~/.bob/config/blocked-terms.txt

# Testar imediatamente
~/.bob/scripts/content-monitor.sh
```

---

## 🎯 Próximos Passos

1. ✅ **Executar teste automático** - `./test-system.sh`
2. ✅ **Gerar primeiro relatório** - `./generate-report.sh daily`
3. ✅ **Verificar cron** - `crontab -l`
4. ✅ **Personalizar termos** - editar `blocked-terms.txt`
5. ✅ **Configurar alertas** - editar `alert-config.yaml`

---

## 📞 Suporte

- **Documentação completa:** `README.md`
- **Guia de uso:** `COMO-USAR-NO-GIT.md`
- **Proteção de arquivos:** `PROTECAO-E-ATUALIZACAO.md`
- **Deploy no GitHub:** `DEPLOY-IBM-GITHUB.md`

---

**✨ Sistema pronto para uso!**

O Bob Moderation System está monitorando automaticamente.
Violações serão detectadas e registradas a cada hora.
