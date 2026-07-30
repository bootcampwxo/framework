# Skill: Publicação Opcional no Jira via MCP da Atlassian (Por Item de Trabalho)

## Objetivo
Preparar um rascunho do Jira a partir de `backlog.md` e opcionalmente publicá-lo no Jira via MCP da Atlassian após adesão explícita.

## Pré-condições
- `gates/<CHAVE_DO_ITEM>/02-backlog.md` existe e o Status é APPROVED.

## Passos
1) Determine a CHAVE_DO_ITEM usando a ordem de prioridade das regras de portão.
2) Verifique se `gates/<CHAVE_DO_ITEM>/02-backlog.md` está APPROVED. Se não, pare.
3) Crie um Payload de Rascunho do Jira em `jira/<CHAVE_DO_ITEM>-jira-draft.md`:
   - Epics com resultado + escopo
   - Histórias com história de usuário + critérios de aceite + pontos
4) Pergunte: "Deseja publicar no Jira via MCP da Atlassian agora? (sim/não)"
5) Se SIM:
   - Use o MCP da Atlassian para criar epics/histórias
   - Capture as chaves/IDs retornados em `jira/<CHAVE_DO_ITEM>-jira-results.md`
6) Se NÃO:
   - Pare após a criação do rascunho.

## Saída
- `jira/<CHAVE_DO_ITEM>-jira-draft.md`
- `jira/<CHAVE_DO_ITEM>-jira-results.md` (somente se publicado)

## Conclusão
Sempre pare depois de fazer a pergunta sobre o Jira (ou depois de escrever os resultados, se publicado).
