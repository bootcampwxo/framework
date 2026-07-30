# Skill: Backlog do PO + Portão (Por Item de Trabalho, Por Arquivo)

## Objetivo
Criar/atualizar o backlog de um item de trabalho em `backlog/<CHAVE_DO_ITEM>.md`, atualizar o índice `backlog.md`, depois criar um portão de aprovação de backlog e parar.

## Pré-condições
- `gates/<CHAVE_DO_ITEM>/01-prd.md` está APPROVED.

## Passos
1) Determine a CHAVE_DO_ITEM usando a prioridade das regras de portão.
2) Verifique se `gates/<CHAVE_DO_ITEM>/01-prd.md` está APPROVED; se não, pare.
3) Gere `backlog/<CHAVE_DO_ITEM>.md` a partir de `prd/<CHAVE_DO_ITEM>.md` seguindo as regras do PO.
4) Atualize o índice `backlog.md` (adicione/atualize a linha da CHAVE_DO_ITEM).
5) Crie/atualize `gates/<CHAVE_DO_ITEM>/02-backlog.md` com Status: PENDING.
6) Forneça um pacote de revisão e solicite aprovação. Pare.

## Saídas
- `backlog/<CHAVE_DO_ITEM>.md`
- `backlog.md`
- `gates/<CHAVE_DO_ITEM>/02-backlog.md`
