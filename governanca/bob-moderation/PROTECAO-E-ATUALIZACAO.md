# 🔒 Proteção de Arquivos e Atualizações Forçadas

Guia completo para proteger arquivos de moderação e garantir atualizações centralizadas.

---

## ⚠️ O Problema

### Cenário Atual (Sem Proteção)
```
Usuário instala Bob → Arquivos em ~/.bob/config/
↓
Usuário pode editar: blocked-terms.txt
↓
Usuário remove termos que não quer ser monitorado
↓
❌ Sistema de moderação comprometido
```

### Riscos
- ❌ Usuário pode deletar termos bloqueados
- ❌ Usuário pode desabilitar monitoramento
- ❌ Usuário pode modificar política
- ❌ Atualizações não são forçadas
- ❌ Sem garantia de conformidade

---

## ✅ Soluções Implementáveis

## Solução 1: Proteção de Arquivos (Básica)

### Implementação

Adicionar ao `install.sh`:

```bash
# Após instalar arquivos, proteger contra modificação
protect_files() {
  echo "🔒 Protegendo arquivos de configuração..."

  # Tornar arquivos somente leitura
  chmod 444 "$CONFIG_DIR/blocked-terms.txt"
  chmod 444 "$CONFIG_DIR/moderation-policy.md"
  chmod 444 "$CONFIG_DIR/alert-config.yaml"

  # Tornar scripts executáveis mas não editáveis
  chmod 555 "$SCRIPTS_DIR/content-monitor.sh"
  chmod 555 "$SCRIPTS_DIR/generate-report.sh"
  chmod 555 "$SCRIPTS_DIR/check-compliance.sh"
  chmod 555 "$SCRIPTS_DIR/send-alert.sh"

  # Proteger diretório de configuração
  chmod 555 "$CONFIG_DIR"

  echo "✓ Arquivos protegidos"
}

# Chamar após instalação
protect_files
```

### Resultado
```bash
# Usuário tenta editar
nano ~/.bob/config/blocked-terms.txt
# Erro: Permission denied

# Usuário tenta deletar
rm ~/.bob/config/blocked-terms.txt
# Erro: Permission denied

# Usuário tenta modificar permissões
chmod 777 ~/.bob/config/blocked-terms.txt
# Funciona! ❌ Ainda não é seguro o suficiente
```

**Limitação:** Usuário ainda pode usar `chmod` para modificar permissões.

---

## Solução 2: Verificação de Integridade (Intermediária)

### Implementação

Criar script de verificação de hash:

```bash
#!/bin/bash
# ~/.bob/scripts/verify-integrity.sh

BOB_HOME="$HOME/.bob"
CONFIG_DIR="$BOB_HOME/config"
HASH_FILE="$BOB_HOME/.integrity.sha256"

# Calcular hash dos arquivos críticos
calculate_hash() {
  find "$CONFIG_DIR" -type f -exec sha256sum {} \; | sort > /tmp/current_hash.txt
}

# Verificar se hash mudou
verify_integrity() {
  if [ ! -f "$HASH_FILE" ]; then
    echo "⚠️  Arquivo de integridade não encontrado"
    return 1
  fi

  calculate_hash

  if ! diff -q "$HASH_FILE" /tmp/current_hash.txt > /dev/null; then
    echo "🚨 ALERTA: Arquivos de configuração foram modificados!"
    echo "Detalhes:"
    diff "$HASH_FILE" /tmp/current_hash.txt

    # Enviar alerta
    bash ~/.bob/scripts/send-alert.sh "INTEGRITY_VIOLATION"

    # Restaurar arquivos originais
    echo "Restaurando arquivos originais..."
    curl -fsSL https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main/install.sh | bash --update --force

    return 1
  fi

  echo "✓ Integridade verificada"
  return 0
}

verify_integrity
```

### Adicionar ao Cron

```bash
# Verificar integridade a cada hora
0 * * * * bash ~/.bob/scripts/verify-integrity.sh >> ~/.bob/logs/integrity.log 2>&1
```

### Resultado
- ✅ Detecta modificações em arquivos
- ✅ Alerta administrador
- ✅ Restaura arquivos automaticamente
- ⚠️  Usuário pode desabilitar cron

---

## Solução 3: Arquivos Centralizados (Avançada) ⭐ RECOMENDADA

### Conceito

Em vez de copiar arquivos para `~/.bob/`, **ler diretamente do Git**:

```
Usuário executa monitor → Script lê do GitHub
↓
https://raw.githubusercontent.com/ORG/bob-moderation/main/config/blocked-terms.txt
↓
Sempre versão mais recente
Usuário não pode modificar
```

### Implementação

Modificar `content-monitor.sh`:

```bash
#!/bin/bash
# ~/.bob/scripts/content-monitor.sh (versão centralizada)

# URLs centralizadas (sempre lê do Git)
REPO_URL="https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main"
BLOCKED_TERMS_URL="$REPO_URL/config/blocked-terms.txt"
POLICY_URL="$REPO_URL/config/moderation-policy.md"

BOB_HOME="$HOME/.bob"
LOGS_DIR="$BOB_HOME/logs"
VIOLATIONS_LOG="$LOGS_DIR/violations.log"
BOB_LOG="$HOME/.bob/logs/bob.log"

# Cache local (atualizado a cada execução)
CACHE_DIR="$BOB_HOME/.cache"
mkdir -p "$CACHE_DIR"

# Baixar termos bloqueados do Git (sempre versão mais recente)
download_blocked_terms() {
  curl -fsSL "$BLOCKED_TERMS_URL" -o "$CACHE_DIR/blocked-terms.txt" 2>/dev/null

  if [ $? -ne 0 ]; then
    echo "⚠️  Erro ao baixar termos bloqueados do repositório central"
    # Usar cache anterior se disponível
    if [ ! -f "$CACHE_DIR/blocked-terms.txt" ]; then
      echo "❌ Nenhum cache disponível. Abortando."
      exit 1
    fi
    echo "ℹ️  Usando cache local"
  fi
}

# Sempre baixar versão mais recente
download_blocked_terms

# Ler termos bloqueados (do cache atualizado)
mapfile -t terms < <(grep -v '^#' "$CACHE_DIR/blocked-terms.txt" | grep -v '^$')

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
    grep -i -B 3 -A 3 -E "$term" "$BOB_LOG" >> "$VIOLATIONS_LOG"
    echo "---" >> "$VIOLATIONS_LOG"
  fi
done

if [ $violations_found -gt 0 ]; then
  echo "⚠️  $violations_found violação(ões) detectada(s)"
  echo "Detalhes em: $VIOLATIONS_LOG"

  if [ -f "$SCRIPTS_DIR/send-alert.sh" ]; then
    bash "$SCRIPTS_DIR/send-alert.sh" "$violations_found"
  fi
else
  echo "✓ Nenhuma violação detectada"
fi
```

### Vantagens
- ✅ **Sempre versão mais recente** - Lê do Git a cada execução
- ✅ **Usuário não pode modificar** - Arquivos não estão localmente
- ✅ **Atualizações instantâneas** - Admin faz push, todos recebem
- ✅ **Auditável** - Git mantém histórico de mudanças
- ✅ **Sem necessidade de "update"** - Automático

### Desvantagens
- ⚠️  Requer conexão com internet
- ⚠️  Dependência do GitHub/GitLab

---

## Solução 4: Sistema de Assinatura Digital (Máxima Segurança)

### Conceito

Assinar arquivos digitalmente para garantir autenticidade:

```bash
# Admin assina arquivos
gpg --sign blocked-terms.txt

# Script verifica assinatura antes de usar
gpg --verify blocked-terms.txt.sig
```

### Implementação Completa

#### 1. Admin Gera Chave GPG

```bash
# Gerar chave GPG
gpg --full-generate-key

# Exportar chave pública
gpg --armor --export admin@empresa.com > bob-moderation-public.key

# Adicionar ao repositório
git add bob-moderation-public.key
git commit -m "Add GPG public key"
git push
```

#### 2. Admin Assina Arquivos

```bash
# Assinar arquivos críticos
gpg --detach-sign --armor config/blocked-terms.txt
gpg --detach-sign --armor config/moderation-policy.md
gpg --detach-sign --armor config/alert-config.yaml

# Adicionar assinaturas ao Git
git add config/*.asc
git commit -m "Add digital signatures"
git push
```

#### 3. Script Verifica Assinatura

```bash
#!/bin/bash
# ~/.bob/scripts/verify-signature.sh

REPO_URL="https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main"
CACHE_DIR="$HOME/.bob/.cache"
PUBLIC_KEY="$CACHE_DIR/bob-moderation-public.key"

# Baixar chave pública (uma vez)
if [ ! -f "$PUBLIC_KEY" ]; then
  curl -fsSL "$REPO_URL/bob-moderation-public.key" -o "$PUBLIC_KEY"
  gpg --import "$PUBLIC_KEY"
fi

# Baixar arquivo e assinatura
download_and_verify() {
  local file=$1
  local url="$REPO_URL/$file"
  local sig_url="$url.asc"

  # Baixar arquivo
  curl -fsSL "$url" -o "$CACHE_DIR/$(basename $file)"

  # Baixar assinatura
  curl -fsSL "$sig_url" -o "$CACHE_DIR/$(basename $file).asc"

  # Verificar assinatura
  if gpg --verify "$CACHE_DIR/$(basename $file).asc" "$CACHE_DIR/$(basename $file)" 2>/dev/null; then
    echo "✓ Assinatura válida: $file"
    return 0
  else
    echo "❌ ASSINATURA INVÁLIDA: $file"
    echo "🚨 ALERTA DE SEGURANÇA: Arquivo pode ter sido adulterado!"

    # Enviar alerta crítico
    bash ~/.bob/scripts/send-alert.sh "SIGNATURE_INVALID"

    return 1
  fi
}

# Verificar todos os arquivos críticos
download_and_verify "config/blocked-terms.txt"
download_and_verify "config/moderation-policy.md"
download_and_verify "config/alert-config.yaml"
```

### Vantagens
- ✅ **Máxima segurança** - Criptografia de chave pública
- ✅ **Detecta adulteração** - Qualquer modificação invalida assinatura
- ✅ **Não repudiável** - Apenas admin pode assinar
- ✅ **Padrão da indústria** - GPG é amplamente usado

---

## 🔄 Fluxo de Atualização Forçada

### Cenário: Admin Adiciona Novo Termo Bloqueado

#### Passo 1: Admin Atualiza Git

```bash
# Admin edita arquivo
cd bob-moderation-repo
nano config/blocked-terms.txt

# Adiciona novo termo
echo "novo-termo-malicioso" >> config/blocked-terms.txt

# Commit e push
git add config/blocked-terms.txt
git commit -m "Add novo-termo-malicioso to blocked list"
git push
```

#### Passo 2: Usuários Recebem Automaticamente

**Com Solução 3 (Centralizada):**
```
Próxima execução do monitor (1 hora) →
Script baixa do Git →
Novo termo já está ativo →
✅ Atualização automática
```

**Com Solução 1 ou 2 (Local):**
```
Admin envia comunicado →
Usuários executam: curl ... | bash --update →
Arquivos atualizados →
✅ Atualização manual
```

#### Passo 3: Verificação

```bash
# Admin verifica quem está atualizado
# (Requer telemetria - ver próxima seção)
```

---

## 📊 Telemetria e Compliance

### Rastrear Versões Instaladas

Adicionar ao `content-monitor.sh`:

```bash
# Enviar heartbeat com versão instalada
send_heartbeat() {
  local version=$(cat ~/.bob/.version 2>/dev/null || echo "unknown")
  local hostname=$(hostname)
  local user=$(whoami)

  # Enviar para servidor central (opcional)
  curl -s -X POST "https://bob-telemetry.empresa.com/heartbeat" \
    -H "Content-Type: application/json" \
    -d "{
      \"hostname\": \"$hostname\",
      \"user\": \"$user\",
      \"version\": \"$version\",
      \"timestamp\": \"$(date -u +%Y-%m-%dT%H:%M:%SZ)\"
    }" > /dev/null 2>&1 || true
}

# Executar a cada monitoramento
send_heartbeat
```

### Dashboard de Compliance

Admin pode ver:
- ✅ Quem está com versão atualizada
- ⚠️  Quem está com versão antiga
- ❌ Quem não está enviando heartbeat (possível desinstalação)

---

## 🎯 Recomendação Final

### Para Máxima Segurança

**Combine as soluções:**

1. **Solução 3 (Centralizada)** - Arquivos sempre do Git
2. **Solução 4 (Assinatura)** - Verificar autenticidade
3. **Telemetria** - Monitorar compliance
4. **Proteção de Arquivos** - Dificultar modificação local

### Implementação Recomendada

```bash
# 1. Arquivos centralizados (lê do Git)
# 2. Verificação de assinatura
# 3. Heartbeat de telemetria
# 4. Proteção local (chmod 444)
# 5. Verificação de integridade (cron)
```

### Resultado

- ✅ Usuário **não pode** modificar termos bloqueados
- ✅ Atualizações são **automáticas** e **instantâneas**
- ✅ Admin tem **visibilidade** de compliance
- ✅ Sistema é **auditável** e **seguro**

---

## 📝 Exemplo Prático Completo

### Arquivo: `install-secure.sh`

```bash
#!/bin/bash

# Instalação com máxima segurança

REPO_URL="https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main"
BOB_HOME="$HOME/.bob"

# 1. Criar estrutura
mkdir -p "$BOB_HOME"/{scripts,.cache,logs}

# 2. Instalar script de monitoramento (versão centralizada)
curl -fsSL "$REPO_URL/scripts/content-monitor-secure.sh" -o "$BOB_HOME/scripts/content-monitor.sh"
chmod 555 "$BOB_HOME/scripts/content-monitor.sh"

# 3. Instalar verificador de assinatura
curl -fsSL "$REPO_URL/scripts/verify-signature.sh" -o "$BOB_HOME/scripts/verify-signature.sh"
chmod 555 "$BOB_HOME/scripts/verify-signature.sh"

# 4. Baixar chave pública GPG
curl -fsSL "$REPO_URL/bob-moderation-public.key" -o "$BOB_HOME/.cache/public.key"
gpg --import "$BOB_HOME/.cache/public.key"

# 5. Configurar cron (monitoramento + verificação)
(crontab -l 2>/dev/null; echo "0 * * * * bash $BOB_HOME/scripts/content-monitor.sh") | crontab -
(crontab -l 2>/dev/null; echo "*/15 * * * * bash $BOB_HOME/scripts/verify-signature.sh") | crontab -

# 6. Proteger arquivos
chmod 555 "$BOB_HOME/scripts"
chmod 444 "$BOB_HOME/.cache/public.key"

echo "✅ Instalação segura concluída!"
echo ""
echo "Características:"
echo "  ✓ Arquivos lidos diretamente do Git"
echo "  ✓ Verificação de assinatura digital"
echo "  ✓ Proteção contra modificação local"
echo "  ✓ Atualizações automáticas"
echo "  ✓ Telemetria de compliance"
```

---

## ✅ Checklist de Segurança

### Implementação Básica
- [ ] Arquivos com permissão 444 (somente leitura)
- [ ] Scripts com permissão 555 (executável, não editável)
- [ ] Verificação de integridade (hash)

### Implementação Intermediária
- [ ] Arquivos centralizados (lê do Git)
- [ ] Atualização automática a cada execução
- [ ] Alertas de modificação

### Implementação Avançada
- [ ] Assinatura digital (GPG)
- [ ] Verificação de autenticidade
- [ ] Telemetria de compliance
- [ ] Dashboard de monitoramento

---

## 📞 Suporte

**Dúvidas sobre segurança?**
- Email: security@empresa.com
- Slack: #bob-security

---

**Versão:** 1.0.0
**Última Atualização:** 2026-05-20
**Nível de Segurança:** Máximo
