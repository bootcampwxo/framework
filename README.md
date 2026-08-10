# <Nome do Projeto>

> Este repositório usa o **Framework .Bob** (PDLC aumentado por IA, papéis de time via `.bob/custom_modes.yaml`). As seções abaixo documentam como o time trabalha aqui — descreva seu produto acima desta citação.

---

## Para que serve cada pasta

### `.bob/`
O "manual da equipe" e a camada de automação da IA:
- **rules**: padrões universais e específicos por papel
- **skills**: playbooks repetíveis (recomendado)
- **tools**: pequenos scripts de automação (opcional)

### `.github/`
Templates de PR, workflows e convenções de governança do repositório.

### `discovery/`
Artefatos de descoberta em estágio inicial (definição do problema, escopo de MVP, análise competitiva, plano de recursos/contratação).

### `prd/` + `prd.md`
- `prd/` contém os PRDs por item de trabalho.
- `prd.md` é o índice que aponta para eles.

### `backlog/` + `backlog.md`
- `backlog/` contém os backlogs/histórias por item de trabalho.
- `backlog.md` é o índice que aponta para eles.

### `architecture/`
Registros de Decisão de Arquitetura (ADRs) e a constituição do projeto.

### `design/`
Artefatos de design (UI/UX): o design system vivo do projeto (`design-system.md`), a especificação de design por item de trabalho (`<CHAVE_DO_ITEM>/design-spec.md`) e a revisão da UI implementada (`<CHAVE_DO_ITEM>/revisao-de-ui.md`). Modelos prontos em `design/_modelos/`.

### `delivery/`
Planejamento de sprint e artefatos de acompanhamento de entrega.

### `security/`
Modelo de ameaças, notas de revisão de CVE/dependências, notas de conformidade (ex.: expectativas alinhadas a normas de segurança quando aplicável).

### `tests/`
Organização de testes (`tests/unit`, `tests/integration`, opcionalmente `tests/e2e`) e uma pasta `tests/_modelos/` com modelos prontos de plano de testes, mapeamento de critérios de aceite e evidência de teste.

### `docs/`
Documentação técnica de engenharia gerada a partir do código implementado.

### `product-engineering/`
Tratamento de casos de suporte (casos TS) e relatórios de causa raiz seguros para o cliente.

### `gates/`
Portões de aprovação humana (por item de trabalho) que controlam a progressão entre fases.

### `pr/`
Rascunhos/notas de Pull Request (opcional, conforme seu fluxo de trabalho).

### `jira/`
Rascunhos/resultados opcionais de Jira ao publicar via MCP da Atlassian (somente com adesão explícita).

---

## Governança e fluxo guiado

Além dos 9 papéis originais (Descoberta, Product Owner, Arquiteto, Planejador de Sprint, Desenvolvedor, Testador, Segurança, Redator de Documentação, Engenheiro de Produto), o framework inclui três modos e quatro skills adicionais:

- **`governanca`** (modo): estabelece e emenda `architecture/constituicao.md` — os princípios de engenharia, qualidade, arquitetura e segurança não-negociáveis que vinculam todos os demais modos. Veja `.bob/rules/08-constituicao-do-projeto.md`.
- **`designer`** (modo, 🎨): define a identidade visual e a experiência do produto — design tokens, inventário de componentes, matriz de estados, fluxos de usuário, responsividade e acessibilidade — **antes** de o Desenvolvedor implementar, e valida a UI implementada depois. Regras em `.bob/rules-designer/01-designer.md`.
- **`revisor-qualidade`** (modo): faz a validação holística final de um item de trabalho (spec, ADR, design, código, testes, segurança, docs) antes do PR, categorizando achados por severidade.
- **`.bob/skills/governanca-constituicao/`**: cria/emenda a constituição do projeto.
- **`.bob/skills/design-ui-gate/`**: playbook de duas etapas — Modo A (Especificar) produz `design/<CHAVE_DO_ITEM>/design-spec.md` e para no portão `03-design.md`; Modo B (Revisar) valida a interface implementada contra essa especificação.
- **`.bob/skills/fluxo-guiado-e2e/`**: orquestra automaticamente a sequência completa Descoberta → PRD → Backlog → ADR → Design → Dev → Teste → Segurança → Docs → Revisão de UI → Revisão → PR, parando apenas nos portões de aprovação já definidos.
- **`.bob/skills/revisao-final-holistica/`**: a skill usada pelo modo `revisor-qualidade`.

Duas regras universais adicionais:
- **`.bob/rules/09-autonomia-e-eficiencia-do-agente.md`**: como a IA deve executar listas de tarefas aprovadas de forma autônoma, relatar resultados de forma concisa, e ler a base de código de forma eficiente.
- **`.bob/rules/10-uso-de-worktrees-git.md`**: como usar `git worktree` para trabalhar em múltiplos itens em paralelo sem alternar de branch.

---

## Portões de aprovação humana (como funciona a governança)

Os portões (gates) são "semáforos" simples em markdown que impedem a IA de continuar até que um humano aprove.
Fluxo típico usando pastas por item de trabalho:

- `gates/<CHAVE_DO_ITEM>/00-descoberta.md` para descoberta/recursos (opcional)
- `gates/<CHAVE_DO_ITEM>/01-prd.md` antes do backlog
- `gates/<CHAVE_DO_ITEM>/02-backlog.md` antes de design/desenvolvimento
- `gates/<CHAVE_DO_ITEM>/03-adr.md` quando um ADR é necessário
- `gates/<CHAVE_DO_ITEM>/03-design.md` quando o item toca interface (condicional, mesmo nível de fase do ADR)
- `gates/<CHAVE_DO_ITEM>/04-plano-de-sprint.md` se você usa portão de plano de sprint
- `gates/<CHAVE_DO_ITEM>/05-pr.md` antes do merge
- `gates/<CHAVE_DO_ITEM>/06-pronto-para-release.md` sign-off final opcional

---

## Fases de PDLC/DevOps mapeadas para os modos do Bob

Os modos do seu projeto são definidos em `.bob/custom_modes.yaml`.
Use o seguinte modelo mental para rodar o ciclo de ponta a ponta:

**Descobrir → Planejar → Desenhar → Codificar → Testar → Proteger → Documentar → Lançar → Operar/Observar → Aprender**

Mapeamento de exemplo (baseado nos modos definidos):
- **Governar** (transversal, antes de tudo): `governanca`
- **Descobrir**: `discovery` (Descoberta & Visão)
- **Planejar**: `product-owner`
- **Desenhar**: `architect` (decisões técnicas) + `designer` (interface e experiência)
- **Coordenação de sprint**: `sprint-planner`
- **Codificar**: `developer`
- **Testar**: `tester` (comportamento) + `designer` (revisão de UI)
- **Proteger**: `security`
- **Validar** (antes do PR): `revisor-qualidade`
- **Documentar**: `doc-writer`
- **Operar/Suportar**: `product-engineer`

---

## Como rodar o framework (sequência simples)

1) **Governança** (recomendado, uma vez no início): estabeleça a constituição do projeto → `architecture/constituicao.md`
2) **Descoberta** (opcional, mas recomendada): defina escopo + riscos → aprove o portão
3) **Product Owner**: crie o PRD → aprove o portão
4) **Product Owner**: crie o backlog → aprove o portão
5) **Arquiteto** (se necessário): crie o ADR → aprove o portão
5b) **Designer** (se o item tocar interface): crie a especificação de design → aprove o portão `03-design.md`
6) **Planejador de Sprint** (opcional): crie a fatia de sprint → aprove o portão
7) **Desenvolvedor**: implemente com testes, seguindo a especificação de design aprovada
8) **Testador**: verifique os critérios de aceite + amplie os testes
8b) **Designer** (se aplicável): revise a UI implementada contra a especificação
9) **Segurança**: revisão de CVE/dependências + notas de segurança
10) **Redator de Documentação**: gere a especificação técnica a partir do código
11) **Estágio de PR**: crie o PR + aprove o portão de PR
12) **Pronto para release** (opcional): portão final de sign-off
13) **Ciclo de feedback**: se houver incidente/caso de cliente em produção → caso TS de Engenharia de Produto → repita o ciclo de correção

---

## Arquivo de modos: onde vive e como é usado

Os **modos do seu projeto** são fornecidos via `.bob/custom_modes.yaml`.
- garanta que o arquivo esteja onde a sua IDE/agente espera encontrá-lo
- recarregue a IDE para que os modos apareçam
- alterne de modo conforme a fase (Governança/Descoberta/PO/Dev/Teste/Segurança/Docs/etc.)

---

## Primeira verificação recomendada

1) Mude para o modo **Governança** e gere a constituição inicial do projeto.
2) Mude para o modo **Descoberta** e gere um pequeno brief de descoberta.
3) Mude para o modo **Product Owner** e crie um PRD + backlog mínimos para uma feature trivial.
4) Verifique se a IA:
   - escreve os artefatos nas pastas esperadas
   - para nos portões aguardando aprovação
   - usa as estruturas de teste e documentação de forma consistente

---

## Como é o "bom" resultado

- O trabalho é rastreável (chaves de item de trabalho / casos TS)
- As saídas são consistentes (modelos + locais de pasta)
- O risco é pego cedo (testes e segurança "shift-left")
- Os humanos continuam no controle (portões)
- A IA se comporta como uma colega de equipe (modos de papel), não como um chatbot genérico

---

## Estrutura do repositório

```
<nome-do-projeto>/
├── .bob/                        # Configuração do Framework .Bob
│   ├── custom_modes.yaml       # Papéis de membro de equipe de IA
│   ├── rules/                  # Padrões e políticas universais da equipe
│   ├── rules-<papel>/          # Regras específicas por papel (inclui rules-designer/)
│   └── skills/                 # Playbooks reutilizáveis (skills)
├── architecture/                # ADRs + Constituição do projeto
│   ├── adr/                     # Registros de Decisão de Arquitetura
│   ├── constituicao.md          # Princípios não-negociáveis do projeto (gerado pelo modo Governança)
│   └── modelo-constituicao.md   # Modelo de constituição
├── backlog/ + backlog.md       # Backlogs por item de trabalho + índice
├── delivery/                   # Planejamento de sprint
├── design/                      # Design system, specs de UI/UX e revisões de interface
├── discovery/                  # Artefatos de descoberta
├── docs/                       # Especificações técnicas
├── gates/                      # Portões de aprovação humana
├── jira/                       # Integração opcional com Jira
├── pr/                         # Rascunhos de PR
├── prd/ + prd.md                # PRDs por item de trabalho + índice
├── product-engineering/        # Casos de suporte (TS) e causa raiz
├── security/                   # Modelo de ameaças e revisões de segurança
├── tests/                      # Testes + modelos de teste
└── RELEASE_NOTES.md            # Notas de release
```
