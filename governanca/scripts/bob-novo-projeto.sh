#!/usr/bin/env bash
# bob-novo-projeto.sh — cria um projeto novo a partir do esqueleto cacheado
# por ./instalar-bob.sh em ~/.bob/templates/desenvolvimento/ (macOS/Linux).
#
# Este script é o equivalente "de linha de comando" do modo 🔮 Oráculo — útil
# quando você quer criar o esqueleto sem depender da IA/IDE primeiro, ou quer
# automatizar isso (ex.: num script de onboarding de time). Diferente do
# Oráculo, ele não baixa nada da rede — usa o cache já instalado.
#
# Pré-requisito: já ter rodado ./instalar-bob.sh (ou o equivalente via
# curl) nesta máquina.
#
# Uso (repositório já clonado localmente):
#   ./bob-novo-projeto.sh <nome-do-projeto>
#
# Uso (direto da URL, sem clonar nada antes — o "--" separa as opções do
# bash das opções do script; <nome-do-projeto> vira o argumento $1 do
# script mesmo lendo de stdin):
#   curl -fsSL https://raw.githubusercontent.com/bootcampwxo/framework/main/governanca/scripts/bob-novo-projeto.sh | bash -s -- <nome-do-projeto>

set -euo pipefail

TEMPLATE_DIR="$HOME/.bob/templates/desenvolvimento"

if [ "$#" -ne 1 ]; then
  echo "Uso: bob-novo-projeto.sh <nome-do-projeto>"
  echo "(ou: curl -fsSL .../bob-novo-projeto.sh | bash -s -- <nome-do-projeto>)"
  exit 1
fi

PROJECT_NAME="$1"

if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "ERRO: $TEMPLATE_DIR não existe."
  echo "Rode ./instalar-bob.sh primeiro (uma vez por máquina)."
  exit 1
fi

if [ -e "$PROJECT_NAME" ]; then
  echo "ERRO: já existe algo chamado '$PROJECT_NAME' no diretório atual."
  exit 1
fi

echo "==> Criando $PROJECT_NAME/ a partir do esqueleto cacheado"
mkdir -p "$PROJECT_NAME"
cp -R "$TEMPLATE_DIR/." "$PROJECT_NAME/"

cd "$PROJECT_NAME"

if [ ! -d .git ]; then
  if ! git config user.email >/dev/null 2>&1 && ! git config --global user.email >/dev/null 2>&1; then
    echo "AVISO: git não tem 'user.email'/'user.name' configurados. Configure com:"
    echo "  git config --global user.email \"voce@empresa.com\""
    echo "  git config --global user.name \"Seu Nome\""
    echo "antes de continuar, senão o commit de bootstrap abaixo vai falhar."
  fi
  git init --quiet
  git add -A
  git commit --quiet -m "chore: bootstrap inicial via bob-novo-projeto"
  echo "==> Repositório git inicializado com o commit de bootstrap."
else
  echo "==> Já existe um .git aqui — pulei o git init."
fi

echo ""
echo "Projeto '$PROJECT_NAME' pronto."
echo ""
echo "Próximos passos:"
echo "  1. Abra a pasta '$PROJECT_NAME' na sua IDE (File > Open Folder), se ainda não estiver nela."
echo "  2. Troque manualmente para o modo 🏛️ Governança no seletor de modos."
echo "  3. Escreva esta mensagem para dar início ao processo:"
echo "     \"estabelecer a constituição do projeto (princípios de engenharia, qualidade, arquitetura e segurança)\""
