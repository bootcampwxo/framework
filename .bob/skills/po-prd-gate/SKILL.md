# Skill: PRD do PO + Portão (Por Item de Trabalho, Por Arquivo)

## Objetivo
Criar/atualizar o PRD de um item de trabalho em `prd/<CHAVE_DO_ITEM>.md`, atualizar o índice `prd.md`, depois criar um portão de aprovação de PRD e parar.

## Passos
1) Determine a CHAVE_DO_ITEM usando a prioridade das regras de portão.
2) Crie/atualize `prd/<CHAVE_DO_ITEM>.md` seguindo as regras do PO.
3) Atualize o índice `prd.md` (adicione/atualize a linha da CHAVE_DO_ITEM).
4) Crie/atualize `gates/<CHAVE_DO_ITEM>/01-prd.md` com Status: PENDING.
5) Forneça um pacote de revisão e solicite aprovação. Pare.

## Saídas
- `prd/<CHAVE_DO_ITEM>.md`
- `prd.md`
- `gates/<CHAVE_DO_ITEM>/01-prd.md`
