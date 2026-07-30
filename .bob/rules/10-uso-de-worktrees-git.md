# Uso de Git Worktrees para Trabalho Paralelo (recomendado a todos os modos)

## Objetivo
Permitir que a equipe (humana ou IA) trabalhe em múltiplos itens de trabalho simultaneamente — por exemplo, uma feature em desenvolvimento e uma correção urgente de bug — sem a fricção de alternar de branch constantemente no mesmo diretório de trabalho.

## O que é
Git worktrees permitem ter múltiplos diretórios de trabalho vinculados ao mesmo repositório, cada um numa branch diferente, ao mesmo tempo. Diferente de `git checkout`/`git switch`, você não precisa guardar (`stash`) o trabalho em andamento para começar outro.

## Quando usar
- Uma correção urgente (hotfix) surge enquanto uma feature grande está em andamento.
- Múltiplas features independentes estão sendo desenvolvidas em paralelo pelo mesmo desenvolvedor (ou pela IA agindo em nome dele).
- Você quer manter o ambiente de build/testes de uma branch intocado enquanto explora outra.

## Convenção de nomes
Mantenha o padrão de chave de item de trabalho já usado nos portões (`.bob/rules/06-portoes-aprovacao-humana.md`) também no nome da branch, para que a árvore de artefatos (`prd/`, `backlog/`, `gates/`) continue rastreável:

```
# Bom
git worktree add ../FEAT-busca-tarefas -b FEAT-busca-tarefas

# Evite (não segue o padrão de chave do item de trabalho)
git worktree add ../minha-branch -b feature/algo
```

## Fluxo de exemplo

```bash
# Feature em andamento no repositório principal
cd ~/projetos/meu-produto
# branch atual: FEAT-busca-tarefas

# Bug crítico aparece — cria worktree separado sem interromper a feature
git worktree add ../hotfix-FEAT-login-quebrado -b FEAT-login-quebrado
cd ../hotfix-FEAT-login-quebrado

# Corrija, teste, siga o fluxo normal de PR neste worktree
# Ao voltar para o repositório principal, a feature original continua intacta
cd ~/projetos/meu-produto
```

## Boas práticas
1. **Um worktree por item de trabalho** — evite misturar mais de uma feature/bug no mesmo worktree.
2. **Limpe worktrees após o merge**:
   ```bash
   git worktree remove ../hotfix-FEAT-login-quebrado
   ```
3. **Os artefatos do framework acompanham a branch, não o worktree** — `gates/<CHAVE_DO_ITEM>/`, `prd/<CHAVE_DO_ITEM>.md` etc. continuam vivendo no histórico da branch correspondente; o worktree é apenas onde você trabalha localmente.
4. Para automação, sempre passe a chave do item de trabalho explicitamente em vez de depender de detecção automática de branch.

## Ver também
- `.bob/rules/06-portoes-aprovacao-humana.md` — como a chave do item de trabalho organiza portões e artefatos.
- [Documentação oficial do Git sobre worktrees](https://git-scm.com/docs/git-worktree)
