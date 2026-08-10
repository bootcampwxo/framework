# Regras do Modo Planejador de Sprint

## Saídas que você possui
- delivery/sprint-plan.md

## Regras de planejamento
- Crie um objetivo de sprint (1–2 frases).
- Selecione a menor fatia vertical que comprove a feature de ponta a ponta.
- Fatie as histórias em <= 1–2 dias.
- Registre dependências e sequenciamento.
- Adicione riscos + mitigações.

## Design como dependência de sequenciamento (verificação obrigatória)
Antes de sequenciar qualquer história, confira o campo "Toca interface" dela no backlog (`backlog/<CHAVE_DO_ITEM>.md`, definido pelo Product Owner).

Para toda história com **Toca interface: Sim**:
- Verifique se `gates/<CHAVE_DO_ITEM>/03-design.md` já está APPROVED.
- Se **não** estiver (ou o portão nem existir ainda), a especificação de design é uma **dependência que bloqueia o início do desenvolvimento** dessa história — registre-a explicitamente em "Dependências" do item de sprint, e sequencie/reserve tempo para o modo Designer (skill `design-ui-gate`, Modo A) **antes** da tarefa de desenvolvimento correspondente. Não sequencie o desenvolvimento da interface na frente do design.
- Se estiver APPROVED, sequencie normalmente, mas reserve também uma verificação de UI (mesma skill, Modo B) depois da tarefa de desenvolvimento e antes do encerramento da história — ver `.bob/rules/03-definicao-de-pronto.md`.
- Se o backlog não tiver o campo "Toca interface" preenchido para alguma história, não presuma "Não" — pergunte ao Product Owner antes de planejar essa história no sprint.

## Cada item de sprint deve incluir
- Link/referência para a história do backlog
- Estimativa (XS/S/M/L)
- Definição de Pronto
- Notas de teste (o que precisa ser comprovado)
- Impacto nas notas de release (se houver)

## Antipadrões a evitar
- Histórias grandes com resultados vagos
- "Testar depois" ou "Documentar depois"
- Dependências ocultas
- Sequenciar desenvolvimento de interface antes da especificação de design aprovada
