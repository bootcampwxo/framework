#!/bin/bash

#############################################
# Bob Moderation - Git Update Script
# Atualiza o repositório com as melhorias v2.0
#############################################

echo "🔄 Atualizando Repositório Git - Bob Moderation v2.0"
echo "===================================================="
echo ""

# Verificar se estamos em um repositório Git
if [ ! -d ".git" ]; then
  echo "❌ Erro: Este diretório não é um repositório Git"
  echo ""
  echo "Para inicializar o Git, execute:"
  echo "  ./INICIALIZAR-GIT.sh"
  exit 1
fi

# Verificar branch atual
CURRENT_BRANCH=$(git branch --show-current)
echo "📍 Branch atual: $CURRENT_BRANCH"
echo ""

# Mostrar status
echo "📊 Status dos arquivos:"
echo "----------------------"
git status --short
echo ""

# Confirmar atualização
read -p "Deseja adicionar e commitar todas as mudanças? (s/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[SsYy]$ ]]; then
  echo "❌ Atualização cancelada"
  exit 1
fi

echo ""
echo "📝 Adicionando arquivos ao Git..."

# Adicionar todos os arquivos
git add .

echo "✓ Arquivos adicionados"
echo ""

# Criar commit com mensagem descritiva
echo "💾 Criando commit..."
git commit -m "feat: Bob Moderation v2.0 - macOS Compatible

🚀 Melhorias Principais:
- Scripts compatíveis com macOS (bash 3.2+)
- Instalação totalmente automatizada
- Log de teste criado automaticamente
- Teste automático ao final da instalação
- 130+ termos bloqueados

🔧 Correções:
- Removido uso de 'mapfile' (não existe no macOS)
- Reescrito content-monitor.sh para bash 3.2+
- Reescrito generate-report.sh com detecção de SO
- Criado test-system.sh para validação automática

📚 Documentação:
- INSTALL-V2-MELHORIAS.md - Documentação completa das mudanças
- TESTE-RAPIDO.md - Atualizado com instruções v2.0
- CORRECOES-MACOS.md - Explicação técnica das correções
- ATUALIZAR-GIT.sh - Este script

✅ Sistema pronto para produção no macOS e Linux!"

echo "✓ Commit criado"
echo ""

# Mostrar log do último commit
echo "📋 Último commit:"
echo "----------------"
git log -1 --oneline
echo ""

# Perguntar sobre push
read -p "Deseja fazer push para o repositório remoto? (s/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[SsYy]$ ]]; then
  echo ""
  echo "🚀 Fazendo push para $CURRENT_BRANCH..."

  # Verificar se há remote configurado
  if git remote -v | grep -q "origin"; then
    git push origin "$CURRENT_BRANCH"
    echo "✓ Push concluído!"
  else
    echo "⚠️  Nenhum remote 'origin' configurado"
    echo ""
    echo "Para configurar o remote, execute:"
    echo "  git remote add origin https://github.ibm.com/rsaragio/bob-moderation.git"
    echo "  git push -u origin $CURRENT_BRANCH"
  fi
else
  echo ""
  echo "ℹ️  Push não realizado"
  echo ""
  echo "Para fazer push manualmente depois:"
  echo "  git push origin $CURRENT_BRANCH"
fi

echo ""
echo "✅ Atualização do Git concluída!"
echo ""
echo "📊 Resumo:"
echo "---------"
git log -1 --stat
echo ""

# Made with Bob
