#!/bin/bash

#############################################
# Script de Inicialização do Repositório Git
# Bob Content Moderation
#############################################

set -e

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Banner
clear
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Bob Content Moderation${NC}"
echo -e "${BLUE}Inicialização do Repositório Git${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Verificar se Git está instalado
if ! command -v git &> /dev/null; then
  echo -e "${RED}✗ Git não está instalado${NC}"
  echo "Instale o Git primeiro: https://git-scm.com/downloads"
  exit 1
fi

echo -e "${GREEN}✓ Git instalado${NC}"
echo ""

# Perguntar informações do repositório
echo -e "${YELLOW}Configuração do Repositório${NC}"
echo ""

read -p "Nome da organização/usuário no GitHub: " GITHUB_ORG
read -p "Nome do repositório (padrão: bob-moderation): " REPO_NAME
REPO_NAME=${REPO_NAME:-bob-moderation}

read -p "Usar SSH ou HTTPS? (ssh/https, padrão: https): " GIT_PROTOCOL
GIT_PROTOCOL=${GIT_PROTOCOL:-https}

echo ""
echo -e "${BLUE}Configuração:${NC}"
echo "  Organização: $GITHUB_ORG"
echo "  Repositório: $REPO_NAME"
echo "  Protocolo: $GIT_PROTOCOL"
echo ""

read -p "Confirmar? (s/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
  echo -e "${RED}Cancelado${NC}"
  exit 1
fi

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}Inicializando Repositório${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# 1. Inicializar Git
if [ ! -d .git ]; then
  echo -e "${BLUE}1. Inicializando Git...${NC}"
  git init
  echo -e "${GREEN}✓ Git inicializado${NC}"
else
  echo -e "${YELLOW}⚠ Git já inicializado${NC}"
fi
echo ""

# 2. Configurar remote
echo -e "${BLUE}2. Configurando remote...${NC}"

if [ "$GIT_PROTOCOL" = "ssh" ]; then
  REMOTE_URL="git@github.com:$GITHUB_ORG/$REPO_NAME.git"
else
  REMOTE_URL="https://github.com/$GITHUB_ORG/$REPO_NAME.git"
fi

# Remover remote existente se houver
git remote remove origin 2>/dev/null || true

git remote add origin "$REMOTE_URL"
echo -e "${GREEN}✓ Remote configurado: $REMOTE_URL${NC}"
echo ""

# 3. Atualizar URLs no install.sh
echo -e "${BLUE}3. Atualizando URLs no install.sh...${NC}"
sed -i.bak "s|REPO_URL=\".*\"|REPO_URL=\"https://raw.githubusercontent.com/$GITHUB_ORG/$REPO_NAME/main\"|" install.sh
rm install.sh.bak 2>/dev/null || true
echo -e "${GREEN}✓ URLs atualizadas${NC}"
echo ""

# 4. Criar arquivos .example para configs sensíveis
echo -e "${BLUE}4. Criando arquivos .example...${NC}"

# Criar exemplo de alert-config.yaml
if [ -f config/alert-config.yaml ]; then
  cp config/alert-config.yaml config/alert-config.yaml.example
  echo -e "${GREEN}✓ config/alert-config.yaml.example criado${NC}"
fi

# Criar exemplo de blocked-terms.txt
if [ -f config/blocked-terms.txt ]; then
  # Criar versão exemplo sem termos sensíveis
  grep -v "^# Adicione termos específicos" config/blocked-terms.txt > config/blocked-terms.txt.example || true
  echo -e "${GREEN}✓ config/blocked-terms.txt.example criado${NC}"
fi

echo ""

# 5. Adicionar arquivos ao Git
echo -e "${BLUE}5. Adicionando arquivos ao Git...${NC}"
git add .
echo -e "${GREEN}✓ Arquivos adicionados${NC}"
echo ""

# 6. Fazer commit inicial
echo -e "${BLUE}6. Fazendo commit inicial...${NC}"
git commit -m "Initial commit: Bob Content Moderation System v1.0.0

- Sistema completo de moderação de conteúdo
- Scripts de monitoramento automático
- Configuração de alertas
- Geração de relatórios
- Documentação completa"

echo -e "${GREEN}✓ Commit realizado${NC}"
echo ""

# 7. Renomear branch para main
echo -e "${BLUE}7. Configurando branch main...${NC}"
git branch -M main
echo -e "${GREEN}✓ Branch main configurada${NC}"
echo ""

# 8. Instruções finais
echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Repositório Inicializado!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo -e "${YELLOW}Próximos Passos:${NC}"
echo ""
echo "1. Criar repositório no GitHub:"
echo "   https://github.com/new"
echo "   Nome: $REPO_NAME"
echo "   Visibilidade: Private (recomendado)"
echo ""
echo "2. Fazer push inicial:"
echo -e "   ${BLUE}git push -u origin main${NC}"
echo ""
echo "3. Verificar no GitHub:"
echo "   https://github.com/$GITHUB_ORG/$REPO_NAME"
echo ""
echo "4. Distribuir para usuários:"
echo -e "   ${BLUE}curl -fsSL https://raw.githubusercontent.com/$GITHUB_ORG/$REPO_NAME/main/install.sh | bash${NC}"
echo ""
echo -e "${YELLOW}Comandos Úteis:${NC}"
echo ""
echo "# Ver status"
echo "git status"
echo ""
echo "# Fazer alterações"
echo "git add ."
echo "git commit -m \"Descrição das mudanças\""
echo "git push"
echo ""
echo "# Criar tag de versão"
echo "git tag -a v1.0.0 -m \"Version 1.0.0\""
echo "git push --tags"
echo ""
echo -e "${GREEN}Pronto para usar!${NC}"
echo ""

# Made with Bob
