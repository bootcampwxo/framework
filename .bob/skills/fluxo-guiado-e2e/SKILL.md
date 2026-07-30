# Skill: Fluxo Guiado Ponta a Ponta (Descoberta → PR)

## Objetivo
Orquestrar automaticamente a sequência completa do PDLC para um único item de trabalho, encadeando os modos e skills na ordem correta, parando apenas nos Portões de Aprovação Humana já definidos (`.bob/rules/06-portoes-aprovacao-humana.md`). Esta skill traz para o .Bob o padrão de "skill guarda-chuva" (`-go`) usado em frameworks avançados de SDD: o humano descreve o que quer construir uma vez, e a IA conduz o restante do fluxo sem exigir que ele invoque manualmente cada fase.

## Quando usar
- No início de um item de trabalho novo, quando o humano descreve em linguagem natural o que quer construir.
- Quando o humano diz algo como "toca esse fluxo do início ao fim" ou invoca `/fluxo-guiado-e2e`.

## Pré-condição
Se `architecture/constituicao.md` não existir, execute primeiro a skill `governanca-constituicao` (bootstrap) antes de continuar.

## Sequência (OBRIGATÓRIA, sem pausas de confirmação entre etapas — apenas nos portões)

1. **Descoberta** (opcional, mas recomendada se o pedido for vago): gere o brief de descoberta em `discovery/`, crie o portão `00-discovery.md`. **Pare no portão.**
2. **Product Owner — PRD**: use a skill `po-prd-gate`. **Pare no portão.**
3. **Product Owner — Backlog**: use a skill `po-backlog-gate`. **Pare no portão.**
4. **Arquiteto — ADR** (se a mudança tiver impacto arquitetural): use a skill `arch-adr-gate`. **Pare no portão.**
5. **Planejador de Sprint** (opcional): gere a fatia de sprint em `delivery/`. **Pare no portão, se seu fluxo usa este portão.**
6. **Desenvolvedor**: implemente com testes, seguindo `.bob/rules-developer/*` e a Definição de Pronto (`.bob/rules/03-definicao-de-pronto.md`). Execute as tarefas de forma autônoma, conforme `.bob/rules/09-autonomia-e-eficiencia-do-agente.md`.
7. **Testador**: valide os critérios de aceite, amplie a cobertura, documente evidências em `tests/`.
8. **Segurança**: revise CVE/dependências, atualize `security/cve-review.md` e o modelo de ameaças se aplicável.
9. **Redator de Documentação**: gere/atualize a especificação técnica em `docs/`.
10. **Revisor de Qualidade (Stakeholder)**: use a skill `revisao-final-holistica` para validar tudo de forma holística antes do PR.
11. **Desenvolvedor — PR**: use a skill `dev-pr-create`. **Pare no portão de PR.**
12. **Pronto para release** (opcional): portão final de sign-off.

## Regras de execução
- Não pare entre etapas para pedir "posso continuar?" — pare **apenas** nos portões definidos, conforme `.bob/rules/06-portoes-aprovacao-humana.md`.
- Se um portão for REJECTED, volte para a etapa correspondente, ajuste o artefato, redefina o portão para PENDING e continue o fluxo a partir dali — não reinicie do zero.
- Se, em qualquer etapa, um artefato entrar em conflito com a constituição do projeto, pare imediatamente e sinalize o conflito (ver `.bob/rules/08-constituicao-do-projeto.md`), independentemente de haver um portão formal ali.
- Relate o progresso de forma concisa: qual etapa foi concluída, qual artefato foi gerado, e em qual portão o fluxo está aguardando aprovação — sem repetir o conteúdo completo dos artefatos já mostrados.

## Saídas
Ao final de uma execução completa (ou até o ponto onde parou aguardando aprovação):
- Lista dos artefatos criados/atualizados nesta execução.
- Status de cada portão (APPROVED / PENDING / REJECTED).
- Próximo passo esperado.
