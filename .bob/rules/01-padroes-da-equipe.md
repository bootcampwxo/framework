# Padrões da Equipe (aplica-se a todos os modos)

## Missão
Entregar incrementos pequenos e testáveis de valor para o cliente em um ciclo contínuo de DevOps, com aprovações humanas claras nos pontos-chave de decisão.

## Arquivos e pastas de referência (fonte da verdade)

### Descoberta & Visão (PDLC inicial)
- `discovery/work-items/<CHAVE_DO_ITEM>/`
  - `discovery-brief.md` (obrigatório)
  - `mvp-scope.md` (obrigatório)
  - `competitive-landscape.md` (opcional; quando pesquisa de concorrência é solicitada)
  - `resourcing-plan.md` (opcional; quando planejamento de equipe/contratação é necessário)
  - `job-description-<papel>.md` (opcional; quando contratação é necessária)
  - `onboarding-and-access.md` (opcional; quando necessidades de onboarding/acesso/ferramentas são definidas)

### Requisitos (PRDs)
- **Índice de PRD:** `prd.md` (aponta para os PRDs por item de trabalho)
- **PRD por item de trabalho:** `prd/<CHAVE_DO_ITEM>.md`

### Backlog
- **Índice de Backlog:** `backlog.md` (aponta para os backlogs por item de trabalho)
- **Backlog por item de trabalho:** `backlog/<CHAVE_DO_ITEM>.md`

### Decisões de arquitetura
- `architecture/adr/`

### Design (UI/UX)
- `design/design-system.md` (registro vivo do design system — um por repositório)
- `design/<CHAVE_DO_ITEM>/design-spec.md` (obrigatório quando o item toca interface)
- `design/<CHAVE_DO_ITEM>/revisao-de-ui.md` (achados da revisão da UI implementada)

### Plano de sprint
- `delivery/sprint-plan.md`

### Modelo de ameaças e evidências de segurança
- `security/threat-model.md`
- `security/cve-review.md`
- `security/compliance-notes.md`

### Documentação de engenharia (especificações de feature)
- `docs/<nome-da-feature>-technical-spec.md` (ou `docs/technical-specs/<nome-da-feature>-technical-spec.md` se usar subpasta)

### Pull Requests (PRs)
- **Rascunho de descrição de PR (interno):** `pr/<CHAVE_DO_ITEM>-pr-draft.md`
- **Link/registro do PR (opcional):** `pr/<CHAVE_DO_ITEM>-pr-link.md`
- **Modelo de PR (recomendado):** `.github/pull_request_template.md`

### Notas de release
- `RELEASE_NOTES.md`

### Portões de aprovação humana (por item de trabalho)
- `gates/<CHAVE_DO_ITEM>/`
  - `00-discovery.md` (recomendado)
  - `00-resourcing.md` (opcional)
  - `01-prd.md`, `02-backlog.md`, `03-adr.md`, `03-design.md` (condicional), `04-sprintplan.md`, `05-pr.md`, `06-release-ready.md` (opcional)
- Ponteiro recomendado: `gates/CURRENT_WORK_ITEM.md`

### Rascunhos/resultados do Jira (opcional)
- `jira/<CHAVE_DO_ITEM>-jira-draft.md`
- `jira/<CHAVE_DO_ITEM>-jira-results.md`
- **Rascunhos/resultados de defeito (opcional):** `jira/TS#########-defect-draft.md`, `jira/TS#########-defect-results.md`

### Engenharia de Produto (problemas de cliente / casos TS)
- `product-engineering/TS#########/`
  - `issue-summary.md`, `investigation-prompt.md`, `root-cause-and-fix.md`, `internal-analysis.md` (opcional), `defect.md` (condicional), `evidence/` (opcional)

Se algum arquivo/pasta obrigatório não existir, crie um esqueleto mínimo em vez de bloquear o trabalho.

## Acordos de trabalho
- Prefira fatias verticais pequenas em vez de grandes mudanças de uma vez só.
- Não invente requisitos, APIs, restrições ou fatos sobre o cliente. Se faltar informação, adicione **Perguntas em Aberto** e documente claramente as suposições.
- Mantenha as edições consistentes com o estilo e os padrões já existentes no repositório.
- Toda mudança deve ser rastreável a um item do backlog (história/bug/tarefa) ou a um caso TS (para Engenharia de Produto).
- Preserve o histórico: nunca sobrescreva aprovações de outros itens de trabalho; use a pasta correta `gates/<CHAVE_DO_ITEM>/`.

## Portões de aprovação humana (comportamento obrigatório)
- Use portões escopados por item de trabalho: `gates/<CHAVE_DO_ITEM>/...`
- **A descoberta deve ser aprovada** (`00-discovery.md` = APPROVED) antes de iniciar o trabalho de PRD (quando artefatos de descoberta forem produzidos).
- **O plano de recursos deve ser aprovado** (`00-resourcing.md` = APPROVED) antes de agir sobre mudanças de contratação/equipe (quando artefatos de recursos forem produzidos).
- **O PRD deve ser aprovado** (`01-prd.md` = APPROVED) antes de atualizar `backlog/<CHAVE_DO_ITEM>.md`.
- **O backlog deve ser aprovado** (`02-backlog.md` = APPROVED) antes de iniciar ADR/design/planejamento de sprint/desenvolvimento.
- **A especificação de design deve ser aprovada** (`03-design.md` = APPROVED) antes de a implementação da interface começar (quando o item de trabalho tocar interface).
- **O PR deve ser aprovado** (`05-pr.md` = APPROVED) antes das etapas finais de merge/prontidão para release.
- Em cada portão, pare e solicite aprovação se o Status estiver PENDING ou REJECTED.
- Se rejeitado: atualize os artefatos, redefina o portão para PENDING e solicite revisão novamente.

## Política opcional de publicação no Jira
- O envio para o Jira é sempre opcional e só deve acontecer depois que `gates/<CHAVE_DO_ITEM>/02-backlog.md` estiver APPROVED.
- Sempre crie um rascunho e peça adesão explícita antes de qualquer ação via MCP da Atlassian.
- Evite dados sensíveis/de cliente e referências a código interno no Jira, a menos que confirmado explicitamente como apenas interno.

## Guardrail de segurança do cliente/PI para Engenharia de Produto
- As saídas voltadas ao cliente NÃO devem incluir trechos de código-fonte, caminhos de repositório ou nomes internos de classes/funções.
- Referências a nível de código só podem aparecer em artefatos apenas internos (ex.: `internal-analysis.md`).
- Relatórios TS voltados ao cliente não devem incluir referências a código; mantenha-as nos arquivos apenas internos.

## Formato de comunicação (sempre)
Ao responder, inclua:
1) O que você fez
2) Onde você escreveu (caminhos de arquivo)
3) Como verificar (comandos ou passos)
4) Riscos / pendências (se houver)
5) Status do portão (se um portão foi criado ou está bloqueando o progresso)

## Segurança das mudanças
- Faça commits incrementais.
- Prefira mudanças reversíveis.
- Evite refatorações não relacionadas, a menos que sejam necessárias para a história.
