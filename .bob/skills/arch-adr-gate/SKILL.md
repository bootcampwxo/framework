# Skill: ADR + Portão (Por Item de Trabalho)

## Objetivo
Criar/atualizar um ADR com base em `prd.md` e `backlog.md`, depois criar um portão de aprovação de ADR em `gates/<CHAVE_DO_ITEM>/` e parar.

## Pré-condições
- `gates/<CHAVE_DO_ITEM>/02-backlog.md` existe e o Status é APPROVED.

## Passos
1) Determine a CHAVE_DO_ITEM usando a ordem de prioridade das regras de portão.
2) Verifique se `gates/<CHAVE_DO_ITEM>/02-backlog.md` está APPROVED.
   - Se não, pare e solicite aprovação.
3) Crie/atualize o ADR seguindo as regras do Arquiteto (contexto, decisão, alternativas, consequências, requisitos não funcionais, segurança).
4) Crie ou atualize o arquivo de portão:
   - `gates/<CHAVE_DO_ITEM>/03-adr.md` com Status: PENDING
5) Forneça um pacote de revisão curto e solicite aprovação.

## Saída
- `architecture/adr/<adr-novo-ou-atualizado>.md`
- `gates/<CHAVE_DO_ITEM>/03-adr.md`

## Conclusão
Pare depois de criar o portão e solicite aprovação humana.
