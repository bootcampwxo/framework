# 📦 Como Usar Este Repositório no Git

Guia completo para hospedar e distribuir o sistema de moderação via Git.

---

## 🎯 Visão Geral

Este repositório contém todos os arquivos necessários para implementar moderação de conteúdo no Bob. Você pode:

1. **Hospedar no GitHub/GitLab** - Centralizar os arquivos
2. **Distribuir via Script** - Usuários baixam com 1 comando
3. **Atualizar Facilmente** - Push no Git = atualização para todos
4. **Versionar Mudanças** - Histórico completo de alterações

---

## 📋 Passo a Passo Completo

### 1️⃣ Criar Repositório no GitHub

```bash
# No GitHub, criar novo repositório:
# Nome: bob-moderation
# Descrição: Sistema de moderação de conteúdo para IBM Bob
# Visibilidade: Private (recomendado) ou Public
```

### 2️⃣ Preparar Estrutura Local

```bash
# Navegar para o diretório do repositório
cd /Users/rsaragio/git/ibm-bob/bob-security-presentation/bob-moderation-repo

# Inicializar Git (se ainda não foi)
git init

# Adicionar todos os arquivos
git add .

# Fazer commit inicial
git commit -m "Initial commit: Bob Content Moderation System v1.0.0"
```

### 3️⃣ Conectar ao GitHub

```bash
# Adicionar remote (substitua SEU-ORG e SEU-REPO)
git remote add origin https://github.com/SEU-ORG/bob-moderation.git

# Ou via SSH:
git remote add origin git@github.com:SEU-ORG/bob-moderation.git

# Push inicial
git branch -M main
git push -u origin main
```

### 4️⃣ Atualizar URLs no install.sh

```bash
# Editar install.sh
nano install.sh

# Alterar linha 18:
REPO_URL="https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main"

# Salvar e fazer commit
git add install.sh
git commit -m "Update repository URL"
git push
```

---

## 🚀 Distribuição para Usuários

### Opção 1: Instalação Direta (Recomendado)

Os usuários executam um único comando:

```bash
curl -fsSL https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main/install.sh | bash
```

**Vantagens:**
- ✅ Instalação em 1 comando
- ✅ Sempre baixa versão mais recente
- ✅ Não precisa clonar repositório
- ✅ Funciona em qualquer máquina

### Opção 2: Clone Manual

Para usuários que preferem revisar antes:

```bash
# Clonar repositório
git clone https://github.com/SEU-ORG/bob-moderation.git
cd bob-moderation

# Revisar arquivos
ls -la

# Executar instalação
bash install.sh
```

### Opção 3: Download ZIP

Para ambientes sem Git:

```bash
# Baixar ZIP
curl -L https://github.com/SEU-ORG/bob-moderation/archive/refs/heads/main.zip -o bob-moderation.zip

# Extrair
unzip bob-moderation.zip
cd bob-moderation-main

# Instalar
bash install.sh
```

---

## 🔄 Fluxo de Atualização

### Para Administradores (Você)

```bash
# 1. Fazer alterações nos arquivos
nano config/blocked-terms.txt

# 2. Commit e push
git add .
git commit -m "Add new blocked terms"
git push

# 3. Criar tag de versão (opcional)
git tag -a v1.1.0 -m "Version 1.1.0 - New blocked terms"
git push --tags
```

### Para Usuários Finais

```bash
# Atualizar para última versão
curl -fsSL https://raw.githubusercontent.com/SEU-ORG/bob-moderation/main/install.sh | bash --update

# Ou se já tem o repositório clonado:
cd bob-moderation
git pull
bash install.sh --update
```

---

## 📁 Estrutura do Repositório

```
bob-moderation/
├── README.md                  # Documentação principal
├── QUICKSTART.md               # Guia rápido
├── COMO-USAR-NO-GIT.md         # Este arquivo
├── install.sh                 # Script de instalação
├── LICENSE                    # Licença (MIT recomendado)
├── .gitignore                 # Arquivos a ignorar
│
├── config/                    # Arquivos de configuração
│   ├── blocked-terms.txt      # Lista de termos bloqueados
│   ├── moderation-policy.md   # Política de uso
│   └── alert-config.yaml      # Configuração de alertas
│
├── scripts/                   # Scripts de monitoramento
│   ├── content-monitor.sh     # Monitor principal
│   ├── generate-report.sh     # Gerador de relatórios
│   ├── check-compliance.sh    # Verificador
│   └── send-alert.sh          # Envio de alertas
│
├── proxy/                     # Proxy de moderação (opcional)
│   ├── moderation-proxy.py    # Proxy Python
│   ├── requirements.txt       # Dependências
│   └── config.yaml            # Configuração
│
└── docs/                      # Documentação adicional
    ├── INSTALLATION.md        # Guia de instalação
    ├── CONFIGURATION.md       # Guia de configuração
    └── TROUBLESHOOTING.md     # Solução de problemas
```

---

## 🔐 Segurança e Permissões

### Repositório Privado (Recomendado)

```bash
# No GitHub:
Settings → Danger Zone → Change visibility → Make private

# Adicionar colaboradores:
Settings → Collaborators → Add people
```

**Vantagens:**
- ✅ Termos bloqueados não são públicos
- ✅ Política interna não é exposta
- ✅ Controle de quem pode acessar

### Repositório Público

Se optar por público, **remova informações sensíveis**:

```bash
# Criar versão pública sem dados sensíveis
cp config/blocked-terms.txt config/blocked-terms.example.txt

# Editar exemplo (remover termos específicos da empresa)
nano config/blocked-terms.example.txt

# Adicionar ao .gitignore
echo "config/blocked-terms.txt" >> .gitignore
echo "config/alert-config.yaml" >> .gitignore

# Commit
git add .gitignore config/blocked-terms.example.txt
git commit -m "Add example files, ignore sensitive configs"
```

---

## 🏷️ Versionamento

### Estratégia de Versões

Use **Semantic Versioning** (MAJOR.MINOR.PATCH):

- **MAJOR** (1.0.0 → 2.0.0): Mudanças incompatíveis
- **MINOR** (1.0.0 → 1.1.0): Novas funcionalidades
- **PATCH** (1.0.0 → 1.0.1): Correções de bugs

### Criar Nova Versão

```bash
# 1. Fazer alterações
nano config/blocked-terms.txt

# 2. Commit
git add .
git commit -m "feat: Add 10 new security-related blocked terms"

# 3. Criar tag
git tag -a v1.1.0 -m "Version 1.1.0
- Added 10 new blocked terms
- Updated moderation policy
- Fixed alert script bug"

# 4. Push com tags
git push origin main --tags
```

### Changelog

Manter arquivo `CHANGELOG.md`:

```markdown
# Changelog

## [1.1.0] - 2026-05-21
### Added
- 10 new security-related blocked terms
- Slack integration support

### Changed
- Updated moderation policy with new examples

### Fixed
- Alert script now handles special characters correctly

## [1.0.0] - 2026-05-20
### Added
- Initial release
- Basic content monitoring
- Email alerts
- Report generation
```

---

## 🔧 Customização por Empresa

### Fork para Sua Empresa

```bash
# 1. Fork no GitHub (botão "Fork")

# 2. Clonar seu fork
git clone https://github.com/SUA-EMPRESA/bob-moderation.git
cd bob-moderation

# 3. Customizar
nano config/blocked-terms.txt
nano config/moderation-policy.md

# 4. Commit e push
git add .
git commit -m "Customize for EMPRESA-XYZ"
git push

# 5. Distribuir para sua equipe
# Agora use: https://github.com/SUA-EMPRESA/bob-moderation
```

### Manter Sincronizado com Original

```bash
# Adicionar upstream
git remote add upstream https://github.com/ORIGINAL-ORG/bob-moderation.git

# Buscar atualizações
git fetch upstream

# Merge com suas customizações
git merge upstream/main

# Resolver conflitos se houver
# Depois push
git push origin main
```

---

## 📊 Monitoramento de Uso

### GitHub Insights

No GitHub, você pode ver:
- Quantas pessoas clonaram
- Quantos downloads do install.sh
- Issues abertas
- Pull requests

### Analytics Customizado

Adicionar tracking no install.sh:

```bash
# No início do install.sh, adicionar:
curl -s "https://analytics.empresa.com/track?event=bob-moderation-install&version=1.0.0" > /dev/null 2>&1 || true
```

---

## 🤝 Contribuições

### Aceitar Contribuições da Equipe

Criar `CONTRIBUTING.md`:

```markdown
# Como Contribuir

## Reportar Problemas
- Use GitHub Issues
- Descreva o problema claramente
- Inclua logs se possível

## Sugerir Melhorias
- Abra uma Issue com tag "enhancement"
- Explique o caso de uso

## Enviar Pull Request
1. Fork o repositório
2. Crie branch: `git checkout -b feature/nova-funcionalidade`
3. Commit: `git commit -m "Add nova funcionalidade"`
4. Push: `git push origin feature/nova-funcionalidade`
5. Abra Pull Request
```

---

## 📝 Exemplo Completo de Uso

### Cenário: Empresa XYZ quer implementar moderação

```bash
# 1. Admin cria repositório no GitHub
# Nome: xyz-bob-moderation

# 2. Admin clona este template
git clone https://github.com/TEMPLATE/bob-moderation.git xyz-bob-moderation
cd xyz-bob-moderation

# 3. Admin customiza
nano config/blocked-terms.txt
# Adiciona: "projeto-secreto-xyz", "codigo-interno-123"

nano config/moderation-policy.md
# Atualiza com políticas da XYZ

nano install.sh
# Atualiza REPO_URL para: https://github.com/xyz-corp/xyz-bob-moderation

# 4. Admin faz push
git remote set-url origin https://github.com/xyz-corp/xyz-bob-moderation.git
git add .
git commit -m "Customize for XYZ Corp"
git push -u origin main

# 5. Admin distribui para equipe via email/Slack:
"Para instalar moderação do Bob, execute:
curl -fsSL https://raw.githubusercontent.com/xyz-corp/xyz-bob-moderation/main/install.sh | bash"

# 6. Usuários instalam
curl -fsSL https://raw.githubusercontent.com/xyz-corp/xyz-bob-moderation/main/install.sh | bash

# 7. Admin atualiza termos bloqueados
cd xyz-bob-moderation
nano config/blocked-terms.txt
git add config/blocked-terms.txt
git commit -m "Add 5 new blocked terms"
git push

# 8. Usuários atualizam
curl -fsSL https://raw.githubusercontent.com/xyz-corp/xyz-bob-moderation/main/install.sh | bash --update
```

---

## ✅ Checklist de Implementação

### Antes de Distribuir

- [ ] Repositório criado no GitHub/GitLab
- [ ] Arquivos commitados e pushed
- [ ] URLs atualizadas no install.sh
- [ ] Termos bloqueados customizados
- [ ] Política de uso revisada
- [ ] Configuração de alertas ajustada
- [ ] README atualizado com informações da empresa
- [ ] Testado em máquina limpa
- [ ] Documentação revisada
- [ ] Equipe de segurança aprovou

### Após Distribuição

- [ ] Comunicado enviado para equipe
- [ ] Treinamento agendado
- [ ] Suporte configurado (email/Slack)
- [ ] Monitoramento ativo
- [ ] Processo de atualização documentado

---

## 🆘 Suporte

### Problemas com Git

```bash
# Erro: Permission denied
# Solução: Configurar SSH keys ou usar HTTPS com token

# Erro: Merge conflict
# Solução: Resolver manualmente ou usar git mergetool

# Erro: Large files
# Solução: Usar Git LFS ou remover arquivos grandes
```

### Contato

- **Issues:** https://github.com/SEU-ORG/bob-moderation/issues
- **Email:** bob-support@empresa.com
- **Slack:** #bob-moderation

---

**Versão:** 1.0.0
**Última Atualização:** 2026-05-20
**Autor:** Equipe de Segurança Bob
