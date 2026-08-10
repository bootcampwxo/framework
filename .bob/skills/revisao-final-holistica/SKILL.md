# Skill: Revisão Final Holística (antes do PR)

## Objetivo
Realizar uma última verificação holística de um item de trabalho — PRD, backlog, ADR (se houver), código, testes, segurança e documentação — antes de abrir o PR, em vez de revisar cada artefato isoladamente. Detectar inconsistências entre artefatos, violações da constituição e lacunas de cobertura, categorizando cada achado por severidade.

## Quando usar
- Depois que Desenvolvedor, Testador, Segurança e Redator de Documentação concluíram seu trabalho no item, e antes de `dev-pr-create`.
- Sempre como a penúltima etapa do fluxo guiado ponta a ponta (`fluxo-guiado-e2e`).

## Passos

1) **Carregue os artefatos obrigatórios primeiro**: `prd/<CHAVE_DO_ITEM>.md`, `backlog/<CHAVE_DO_ITEM>.md`, `architecture/constituicao.md`. Carregue artefatos opcionais apenas se necessário (ADR relacionado, plano de sprint).

2) **Valide contra 6 dimensões**, nesta ordem:
   - **Conflitos e quebras**: o código implementado quebra alguma funcionalidade existente, integração ou contrato?
   - **Consistência arquitetural**: a implementação segue o(s) ADR(s) relevante(s) e os padrões de `.bob/rules-architect/`?
   - **Alinhamento com requisitos**: cada critério de aceite do backlog está de fato coberto por teste e comportamento?
   - **Conformidade constitucional**: alguma violação de princípio MUST da constituição (`.bob/rules/08-constituicao-do-projeto.md`)? Isto é **automaticamente CRÍTICO**.
   - **Conformidade de design** (quando o item toca interface): a revisão de UI (`design/<CHAVE_DO_ITEM>/revisao-de-ui.md`) foi executada e está sem achados CRÍTICOS ou ALTOS em aberto? A implementação segue a especificação aprovada em `design/<CHAVE_DO_ITEM>/design-spec.md`? Se o item toca interface e **não existe** revisão de UI, isso é um achado ALTO — roteie para o modo `designer` antes de prosseguir.
   - **Cobertura de testes e documentação**: a Definição de Pronto (`.bob/rules/03-definicao-de-pronto.md`) foi atendida? A especificação técnica em `docs/` reflete o comportamento real?

3) **Categorize cada achado por severidade**: CRÍTICO (bloqueia o PR), ALTO, MÉDIO, BAIXO/sugestão. Cada achado deve ser acionável: arquivo, trecho/linha, impacto, e como mitigar.

4) **Não permita que o fluxo termine com achados CRÍTICOS ou ALTOS não resolvidos.** Roteie a remediação de volta para o modo apropriado (Desenvolvedor para código, Testador para cobertura, Designer para interface/acessibilidade, Redator para docs), aguarde a correção, e reexecute esta revisão até que fique limpa.

5) **Só então** dê o sinal verde para `dev-pr-create` (criação do portão de PR).

## Saídas
- Um resumo dos achados (ou "nenhum achado" se limpo), com severidade e recomendação.
- Veredito explícito: **PRONTO PARA PR** ou **BLOQUEADO** (com a lista do que falta).
- Se solicitado explicitamente, um arquivo opcional `gates/<CHAVE_DO_ITEM>/revisao-holistica.md` documentando os achados — não crie este arquivo por padrão.
