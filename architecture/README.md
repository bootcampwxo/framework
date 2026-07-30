# architecture/

Decisões de arquitetura do projeto — e, agora, também a constituição do projeto.

- `adr/` — Registros de Decisão de Arquitetura (ADRs), um arquivo por decisão: `adr/<numero>-<titulo-curto>.md`
- `adr/modelo-adr.md` — modelo pronto para copiar ao criar um novo ADR
- `constituicao.md` — os princípios de engenharia, qualidade, arquitetura e segurança não-negociáveis do projeto; autoridade máxima sobre todos os demais artefatos
- `modelo-constituicao.md` — modelo pronto para copiar ao iniciar a constituição de um novo projeto/workspace

Um ADR deve ser criado quando: uma nova dependência/serviço é introduzido, há mudança de modelo de dados/esquema com impacto, mudança no modelo de segurança/autenticação, impacto em performance/confiabilidade/escalabilidade, ou uma decisão não trivial/irreversível é tomada.

Veja as regras completas em [`.bob/rules-architect/01-arquiteto.md`](../.bob/rules-architect/01-arquiteto.md).

Cada ADR relevante deve ter um portão associado em `gates/<CHAVE_DO_ITEM>/03-adr.md`.

A constituição deve ser criada antes do primeiro PRD e emendada apenas via o modo Governança. Veja as regras completas em [`.bob/rules/08-constituicao-do-projeto.md`](../.bob/rules/08-constituicao-do-projeto.md) e a skill [`.bob/skills/governanca-constituicao/SKILL.md`](../.bob/skills/governanca-constituicao/SKILL.md).
