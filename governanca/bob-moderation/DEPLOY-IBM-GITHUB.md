# 🚀 Deploy no GitHub Enterprise IBM

Guia completo para fazer deploy do repositório de moderação no GitHub Enterprise da IBM.

---

## 🎯 Informações do Deploy

**GitHub Enterprise IBM:** https://github.ibm.com
**Sua Conta:** https://github.ibm.com/rsaragio
**Repositório Alvo:** https://github.ibm.com/rsaragio/bob-moderation

---

## ⚠️ IMPORTANTE: Ordem de Execução

**O repositório DEVE ser criado e ter push ANTES de testar a instalação!**

```
❌ ERRADO:
1. Testar curl antes do push
   → Erro 404 (repositório não existe ainda)

✅ CORRETO:
1. Criar repositório no GitHub
2. Fazer push dos arquivos
3. Verificar no browser
4. ENTÃO testar curl
```

---

## 📋 Pré-requisitos

### 1. Verificar Acesso ao GitHub Enterprise IBM

```bash
# Testar conexão SSH
ssh -T git@github.ibm.com

# Deve retornar algo como:
# Hi rsaragio! You've successfully authenticated...
```

**Se der erro:**
```bash
# Gerar chave SSH
ssh-keygen -t ed25519 -C "rsaragio@br.ibm.com"

# Adicionar ao ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub

# Adicionar em: https://github.ibm.com/settings/keys
```

### 2. Configurar Git (se necessário)

```bash
# Configurar nome e email
git config --global user.name "Rodrigo Saragiotto"
git config --global user.email "rsaragio@br.ibm.com"

# Verificar configuração
git config --list | grep user
```

---

## 🚀 Deploy Passo a Passo

### ✅ Passo 1: Criar Repositório no GitHub Enterprise IBM

1. **Acesse:** https://github.ibm.com/new
2. **Preencha:**
   - **Repository name:** `bob-moderation`
   - **Description:** `Sistema de moderação de conteúdo para IBM Bob`
   - **Visibility:**
     - ✅ **Private** (recomendado - termos bloqueados são sensíveis)
     - ⚠️ Public (apenas se não houver dados sensíveis)
   - **Initialize:** ❌ **NÃO** marcar "Add README" (já temos)
3. **Clique em:** "Create repository"

**Resultado:** Você verá uma página com instruções de setup.

---

### ✅ Passo 2: Navegar para o Diretório Local

```bash
cd /Users/rsaragio/git/ibm-bob/bob-security-presentation/bob-moderation-repo
```

---

### ✅ Passo 3: Inicializar Git e Configurar Remote

```bash
# Inicializar Git (se ainda não foi)
git init

# Adicionar remote do GitHub Enterprise IBM
git remote add origin git@github.ibm.com:rsaragio/bob-moderation.git

# Verificar remote
git remote -v
```

**Saída esperada:**
```
origin  git@github.ibm.com:rsaragio/bob-moderation.git (fetch)
origin  git@github.ibm.com:rsaragio/bob-moderation.git (push)
```

---

### ✅ Passo 4: Adicionar Arquivos e Fazer Commit

```bash
# Adicionar todos os arquivos
git add .

# Verificar o que será commitado
git status

# Deve mostrar 12 arquivos:
# - README.md
# - DEPLOY-IBM-GITHUB.md
# - QUICKSTART.md
# - COMO-USAR-NO-GIT.md
# - RESUMO-EXECUTIVO.md
# - INDICE-COMPLETO.md
# - PROTECAO-E-ATUALIZACAO.md
# - install.sh
# - INICIALIZAR-GIT.sh
# - .gitignore
# - config/blocked-terms.txt
# - config/moderation-policy.md
# - config/alert-config.yaml

# Fazer commit inicial
git commit -m "Initial commit: Bob Content Moderation System v1.0.0

- Sistema completo de moderação de conteúdo
- 130+ termos bloqueados pré-configurados
- Scripts de monitoramento automático
- Configuração de alertas e relatórios
- Documentação completa (12 arquivos)
- Guia de proteção e atualizações forçadas
- Suporte para arquivos centralizados (leitura do Git)
- Guia específico para deploy no GitHub Enterprise IBM"
```

---

### ✅ Passo 5: Push para GitHub Enterprise IBM

```bash
# Renomear branch para main
git branch -M main

# Push inicial
git push -u origin main
```

**Saída esperada:**
```
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 8 threads
Compressing objects: 100% (12/12), done.
Writing objects: 100% (15/15), 95.23 KiB | 9.52 MiB/s, done.
Total 15 (delta 0), reused 0 (delta 0), pack-reused 0
To github.ibm.com:rsaragio/bob-moderation.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```

---

## ✅ Verificação do Deploy

### 1. Verificar no Browser

**Acesse:** https://github.ibm.com/rsaragio/bob-moderation

**Você deve ver:**
- ✅ README.md renderizado
- ✅ 12 arquivos no repositório
- ✅ Estrutura de diretórios (config/)
- ✅ Commit inicial visível

### 2. Testar URL Raw

```bash
# Testar acesso ao install.sh
curl -I https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh
```

**Saída esperada:**
```
HTTP/2 200
content-type: text/plain; charset=utf-8
...
```

**Se retornar 404:**
- ⚠️ Repositório ainda não foi criado
- ⚠️ Push ainda não foi feito
- ⚠️ URL está incorreta
- ⚠️ Repositório é privado e precisa de autenticação

### 3. Testar Instalação

**SOMENTE APÓS push bem-sucedido:**

```bash
# Testar instalação
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash
```

**Se der erro 404:**
```bash
# Verificar se repositório existe
curl -I https://github.ibm.com/rsaragio/bob-moderation

# Verificar se arquivo existe
curl -I https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh

# Se repositório é privado, usar token:
curl -I -H "Authorization: token SEU_TOKEN" \
  https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh
```

---

## 🔄 Atualizar URLs nos Scripts

**IMPORTANTE:** Após push bem-sucedido, as URLs já estão corretas!

Os scripts já estão configurados para usar:
```
https://raw.github.ibm.com/rsaragio/bob-moderation/main
```

**Não é necessário alterar nada se você seguiu os passos acima.**

---

## 📦 URLs Finais do Repositório

### Repositório Principal
```
https://github.ibm.com/rsaragio/bob-moderation
```

### Instalação (Comando Final)
```bash
# Repositório Público
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash

# Repositório Privado (com token)
curl -fsSL -H "Authorization: token SEU_TOKEN" \
  https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash
```

### URLs Raw dos Arquivos
```
# Documentação
https://raw.github.ibm.com/rsaragio/bob-moderation/main/README.md
https://raw.github.ibm.com/rsaragio/bob-moderation/main/QUICKSTART.md
https://raw.github.ibm.com/rsaragio/bob-moderation/main/PROTECAO-E-ATUALIZACAO.md

# Configurações
https://raw.github.ibm.com/rsaragio/bob-moderation/main/config/blocked-terms.txt
https://raw.github.ibm.com/rsaragio/bob-moderation/main/config/moderation-policy.md
https://raw.github.ibm.com/rsaragio/bob-moderation/main/config/alert-config.yaml

# Scripts
https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh
```

---

## 🔒 Repositório Privado vs Público

### Se Você Criou como PRIVADO (Recomendado)

**Vantagens:**
- ✅ Termos bloqueados não são públicos
- ✅ Política interna não é exposta
- ✅ Controle de quem pode acessar

**Desvantagem:**
- ⚠️ Usuários precisam de token de acesso

**Solução - Gerar Token:**

1. Acesse: https://github.ibm.com/settings/tokens
2. Clique em "Generate new token"
3. Nome: "Bob Moderation Access"
4. Selecione escopo: **repo** (acesso completo)
5. Clique em "Generate token"
6. **Copie o token** (não será mostrado novamente!)

**Usar token na instalação:**
```bash
export GITHUB_TOKEN="seu_token_aqui"

curl -fsSL -H "Authorization: token $GITHUB_TOKEN" \
  https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash
```

### Se Você Criou como PÚBLICO

**Vantagens:**
- ✅ Instalação mais simples (sem token)
- ✅ Qualquer pessoa da IBM pode acessar

**Desvantagens:**
- ⚠️ Termos bloqueados são visíveis
- ⚠️ Política interna é pública

**Instalação:**
```bash
# Sem token necessário
curl -fsSL https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh | bash
```

---

## 🔧 Troubleshooting

### Erro: "Permission denied (publickey)"

**Causa:** Chave SSH não configurada

**Solução:**
```bash
# Gerar chave SSH
ssh-keygen -t ed25519 -C "rsaragio@br.ibm.com"

# Adicionar ao ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copiar chave pública
cat ~/.ssh/id_ed25519.pub

# Adicionar em: https://github.ibm.com/settings/keys
# Clicar em "New SSH key"
# Colar a chave e salvar
```

### Erro: "Repository not found" ou 404

**Causa 1:** Repositório ainda não foi criado

**Solução:**
```bash
# Criar repositório em: https://github.ibm.com/new
```

**Causa 2:** URL incorreta

**Solução:**
```bash
# Verificar remote
git remote -v

# Deve ser:
# origin  git@github.ibm.com:rsaragio/bob-moderation.git

# Se estiver errado, corrigir:
git remote set-url origin git@github.ibm.com:rsaragio/bob-moderation.git
```

**Causa 3:** Push ainda não foi feito

**Solução:**
```bash
# Fazer push
git push -u origin main
```

### Erro: curl 404 ao testar instalação

**Causa:** Repositório privado ou arquivo não existe

**Solução 1 - Verificar se push foi feito:**
```bash
# Acessar no browser
https://github.ibm.com/rsaragio/bob-moderation

# Se não aparecer, fazer push:
git push -u origin main
```

**Solução 2 - Usar token (se privado):**
```bash
# Gerar token em: https://github.ibm.com/settings/tokens

# Testar com token
curl -I -H "Authorization: token SEU_TOKEN" \
  https://raw.github.ibm.com/rsaragio/bob-moderation/main/install.sh
```

### Erro: "fatal: remote origin already exists"

**Causa:** Remote já foi adicionado

**Solução:**
```bash
# Remover remote existente
git remote remove origin

# Adicionar novamente
git remote add origin git@github.ibm.com:rsaragio/bob-moderation.git
```

---

## ✅ Checklist de Deploy

### Antes do Deploy
- [ ] Acesso ao GitHub Enterprise IBM verificado
- [ ] SSH configurado (ou HTTPS com credenciais)
- [ ] Git configurado (nome e email)
- [ ] Arquivos revisados localmente

### Durante o Deploy
- [ ] Repositório criado no GitHub (https://github.ibm.com/new)
- [ ] `git init` executado
- [ ] Remote adicionado (github.ibm.com)
- [ ] Arquivos adicionados (`git add .`)
- [ ] Commit inicial feito
- [ ] Push para main realizado com sucesso

### Após o Deploy
- [ ] Repositório visível no browser
- [ ] README.md renderizado corretamente
- [ ] 12 arquivos presentes
- [ ] URL raw testada (curl -I)
- [ ] Instalação testada (curl | bash)
- [ ] Colaboradores adicionados (se necessário)
- [ ] Equipe comunicada

---

## 📊 Ordem Correta de Execução

```
1. Criar repositório no GitHub
   ↓
2. git init (local)
   ↓
3. git remote add origin
   ↓
4. git add .
   ↓
5. git commit -m "..."
   ↓
6. git push -u origin main
   ↓
7. Verificar no browser
   ↓
8. Testar curl -I (URL raw)
   ↓
9. Testar instalação (curl | bash)
   ↓
10. ✅ Deploy completo!
```

---

## 🎉 Deploy Completo!

Após seguir estes passos, seu repositório estará:

✅ Hospedado no GitHub Enterprise IBM
✅ Acessível em: https://github.ibm.com/rsaragio/bob-moderation
✅ Pronto para distribuição
✅ Com URLs corretas
✅ Documentado e indexado

### Próximos Passos

1. **Testar instalação** em máquina limpa
2. **Distribuir para equipe piloto** (5-10 pessoas)
3. **Coletar feedback** e ajustar
4. **Rollout completo** para toda organização

---

## 📞 Suporte

**Dúvidas sobre deploy?**
- GitHub Enterprise IBM: https://github.ibm.com/help
- Suporte interno: bob-support@br.ibm.com
- Seu repositório: https://github.ibm.com/rsaragio/bob-moderation

---

**Versão:** 1.0.1
**Última Atualização:** 2026-05-20
**Deploy Target:** GitHub Enterprise IBM (github.ibm.com)
**Status:** ✅ Guia Completo com Troubleshooting
