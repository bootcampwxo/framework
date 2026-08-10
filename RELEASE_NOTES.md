# Notas de Release

> Índice de notas de release. Adicione uma seção por versão/entrega, da mais recente para a mais antiga.

## [Não lançado]

### Adicionado
- **Modo 🎨 Designer (UI/UX)** (`.bob/custom_modes.yaml`) — 10º papel do framework. Cobre a fase **Desenhar** do lado da experiência: design tokens, inventário de componentes, matriz de estados, fluxos de usuário, responsividade e acessibilidade WCAG 2.1 AA. Regras em `.bob/rules-designer/01-designer.md`.
- **Skill `design-ui-gate`** (`.bob/skills/design-ui-gate/`) — playbook de duas etapas: **A (Especificar)** produz a especificação de design e para no portão `03-design.md`; **B (Revisar)** valida a UI implementada contra a spec e classifica os achados por severidade.
- **Pasta `design/`** — artefatos de design: `design-system.md`, `<CHAVE_DO_ITEM>/design-spec.md` e `<CHAVE_DO_ITEM>/revisao-de-ui.md`, com modelos em `design/_modelos/`.
- **Portão de Design** — `gates/<CHAVE_DO_ITEM>/03-design.md`, condicional (só quando o item toca interface), no mesmo nível de fase do portão de ADR.

### Alterado
- `.bob/rules/01-padroes-da-equipe.md`, `02-fluxo-agil.md`, `03-definicao-de-pronto.md`, `06-portoes-aprovacao-humana.md` — passam a referenciar os artefatos e o portão de design.
- `.bob/skills/fluxo-guiado-e2e/SKILL.md` — sequência ampliada, com design antes da implementação e revisão de UI depois dos testes.
- `.bob/skills/revisao-final-holistica/SKILL.md` — passa a validar conformidade de design como uma das dimensões.
- Modo Desenvolvedor — passa a implementar interface contra a especificação de design aprovada.

### Corrigido (auditoria de coerência pós-Designer)
- `.bob/rules-product-owner/01-po.md` — novo campo obrigatório "Toca interface" no modelo de história, o ponto mais cedo do fluxo para sinalizar que um item precisa de especificação de design.
- `.bob/rules-sprint-planner/01-planejador-de-sprint.md` e `governanca/custom_modes.yaml` (modo sprint-planner) — passa a verificar esse campo e tratar `03-design.md` não aprovado como dependência bloqueante antes de sequenciar o desenvolvimento.
- `.bob/rules-tester/01-testador.md` — esclarece a divisão de responsabilidade com a revisão de UI do Designer (comportamento vs. conformidade visual/acessibilidade).
- Antes desta correção, um item que tocasse interface só era detectado tarde (trava do Desenvolvedor ou revisão final), nunca durante o planejamento. Detalhes completos no repositório interno.

---

## Modelo de entrada (copie para cada nova release)

## [vX.Y.Z] - AAAA-MM-DD

### Funcionalidade
- Descrição da funcionalidade entregue.

### Impacto para o usuário
- O que muda na prática para quem usa o produto.

### Mudanças que quebram compatibilidade (breaking changes)
- Liste, se houver. Caso não haja, escreva "Nenhuma".

### Passos de migração
- Passos necessários, se houver.

### Problemas conhecidos
- Liste, se houver.
