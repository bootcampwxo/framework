# Skill: Criação de PR pelo Desenvolvedor (Por Item de Trabalho)

## Objetivo
Implementar o item de trabalho aprovado, gerar (ou criar) um PR e parar para revisão humana com um portão de PR.

## Pré-condições (deve verificar)
- `gates/<CHAVE_DO_ITEM>/02-backlog.md` está APPROVED
- Se os portões de ADR ou Plano de Sprint forem usados neste repositório, garanta que:
  - `gates/<CHAVE_DO_ITEM>/03-adr.md` está APPROVED (se existir)
  - `gates/<CHAVE_DO_ITEM>/04-sprintplan.md` está APPROVED (se existir)

## Passos
1) Determine a CHAVE_DO_ITEM via:
   - `gates/CURRENT_WORK_ITEM.md` OU chave fornecida pelo usuário.
2) Implemente a(s) história(s) deste item de trabalho (mudanças mínimas e rastreáveis).
3) Adicione/atualize testes unitários e qualquer scaffolding de teste necessário.
4) Prepare o rascunho da descrição do PR:
   - Escreva `pr/<CHAVE_DO_ITEM>-pr-draft.md`
   - Use os títulos do modelo de PR e inclua:
     - Chave do item de trabalho
     - Escopo (dentro/fora)
     - Como verificar
     - Notas de segurança
     - Link da especificação de docs (planejado ou concluído)
5) Criação do PR (dois modos):
   - Se uma ferramenta MCP de provedor Git estiver disponível, crie uma branch, faça commit, abra o PR e depois escreva:
     - `pr/<CHAVE_DO_ITEM>-pr-link.md` com a URL/ID do PR
   - Se não estiver disponível, pare depois de gerar o rascunho do PR e instrua o usuário a colá-lo na UI do PR.
6) Crie o portão de PR:
   - `gates/<CHAVE_DO_ITEM>/05-pr.md` com Status: PENDING
7) Pare e peça ao humano para revisar o PR e aprovar o portão de PR.

## Saídas
- Mudanças de código + testes
- `pr/<CHAVE_DO_ITEM>-pr-draft.md`
- `pr/<CHAVE_DO_ITEM>-pr-link.md` (opcional, se o PR foi criado)
- `gates/<CHAVE_DO_ITEM>/05-pr.md` (PENDING)

## Conclusão
Pare depois de criar o portão de PR e solicite aprovação para prosseguir para QA/Segurança/Docs e prontidão para release.
