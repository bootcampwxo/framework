# Portões de Aprovação Humana (aplica-se a todos os modos)

## Objetivo
Impor uma progressão estruturada e aprovada por humanos entre as fases. As aprovações devem ser preservadas por item de trabalho (feature/epic/história), nunca sobrescritas.

## Chave do Item de Trabalho (OBRIGATÓRIO)
Todo trabalho com portão deve estar associado a uma Chave de Item de Trabalho.

### Formato (recomendado)
- FEAT-<slug-curto> (feature) ex.: FEAT-busca-tarefas
- EPIC-<slug-curto>
- STORY-<slug-curto>
- Ou a chave do Jira quando disponível (ex.: TM-123)

### Como a Chave do Item de Trabalho é determinada
Use esta ordem de prioridade:
1) Se `gates/CURRENT_WORK_ITEM.md` existir, use-o.
2) Senão, se o usuário fornecer explicitamente uma chave no prompt, use-a.
3) Senão, derive do título do PRD (kebab-case) usando o prefixo FEAT- (e registre isso como suposição).

## Layout de armazenamento dos portões (OBRIGATÓRIO)
Os portões devem ser armazenados por item de trabalho:

gates/<CHAVE_DO_ITEM>/
  00-discovery.md (recomendado)
  00-resourcing.md (opcional)
  01-prd.md
  02-backlog.md
  03-adr.md
  04-sprintplan.md
  05-pr.md
  06-release-ready.md (opcional)

Isso preserva o histórico de cada item de trabalho.

## Formato do arquivo de portão (OBRIGATÓRIO)
Cada arquivo de portão é um pequeno markdown contendo:

Status: PENDING | APPROVED | REJECTED
Owner:
Reviewed At:
Notes:

## Portões obrigatórios e ordem (OBRIGATÓRIO)

0) Portão de Descoberta (recomendado): `gates/<CHAVE_DO_ITEM>/00-discovery.md`
   - Criado após os artefatos de descoberta serem produzidos (estágio Descoberta/Visão).
   - Deve estar APPROVED antes de o trabalho de PRD começar.

0b) Portão de Recursos (opcional): `gates/<CHAVE_DO_ITEM>/00-resourcing.md`
   - Criado quando artefatos de equipe/contratação/recursos são produzidos.
   - Deve estar APPROVED antes de agir sobre mudanças de contratação/equipe.

1) Portão de PRD: `gates/<CHAVE_DO_ITEM>/01-prd.md`
   - Criado depois que `prd/<CHAVE_DO_ITEM>.md` é criado/atualizado (e o índice `prd.md` é atualizado).
   - Deve estar APPROVED antes de criar/atualizar `backlog/<CHAVE_DO_ITEM>.md`.

2) Portão de Backlog: `gates/<CHAVE_DO_ITEM>/02-backlog.md`
   - Criado depois que `backlog/<CHAVE_DO_ITEM>.md` é criado/atualizado (e o índice `backlog.md` é atualizado).
   - Deve estar APPROVED antes do ADR e do planejamento de sprint.

3) Portão de ADR (se um ADR for criado/atualizado): `gates/<CHAVE_DO_ITEM>/03-adr.md`
   - Deve estar APPROVED antes de o desenvolvimento começar.

4) Portão de Plano de Sprint (se um plano de sprint for criado/atualizado): `gates/<CHAVE_DO_ITEM>/04-sprintplan.md`
   - Deve estar APPROVED antes de o desenvolvimento começar.

5) Portão de PR: `gates/<CHAVE_DO_ITEM>/05-pr.md`
   - Criado após o PR ser criado OU após o rascunho de PR ser gerado em `pr/<CHAVE_DO_ITEM>-pr-draft.md`.
   - Deve estar APPROVED antes das etapas finais de merge/prontidão para release.

6) Portão de Release/Pronto (opcional): `gates/<CHAVE_DO_ITEM>/06-release-ready.md`
   - Usado antes do sign-off final de merge/release/demo (checkpoint humano final).

## Comportamento do agente nos portões (OBRIGATÓRIO)
Quando um portão é criado ou encontrado como PENDING/REJECTED:
- PARE e solicite aprovação humana.
- Forneça um "Pacote de Revisão" curto: o que mudou, o que verificar, onde olhar.
- NÃO prossiga até que o portão esteja APPROVED.

Se o portão for REJECTED:
- Pergunte o que precisa mudar.
- Atualize o(s) artefato(s) relevante(s).
- Redefina o portão para PENDING e solicite aprovação novamente.

## Regra de criação de pasta
Se `gates/` ou `gates/<CHAVE_DO_ITEM>/` não existir, crie-o.
