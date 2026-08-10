# Skill: Fluxo Guiado Ponta a Ponta (Descoberta → PR)

## Objetivo
Orquestrar automaticamente a sequência completa do PDLC para um único item de trabalho, encadeando os modos e skills na ordem correta, parando apenas nos Portões de Aprovação Humana já definidos (`.bob/rules/06-portoes-aprovacao-humana.md`). Esta skill traz para o .Bob o padrão de "skill guarda-chuva" (`-go`) usado em frameworks avançados de SDD: o humano descreve o que quer construir uma vez, e a IA conduz o restante do fluxo sem exigir que ele invoque manualmente cada fase.

## Quando usar
- No início de um item de trabalho novo, quando o humano descreve em linguagem natural o que quer construir.
- Quando o humano diz algo como "toca esse fluxo do início ao fim" ou invoca `/fluxo-guiado-e2e`.

## Pré-condição
Se `architecture/constituicao.md` não existir, execute primeiro a skill `governanca-constituicao` (bootstrap) antes de continuar.

## Sequência (OBRIGATÓRIA, sem pausas de confirmação entre etapas — apenas nos portões)

Cada etapa indica o modo responsável entre colchetes. Sempre que a etapa
seguinte precisar de um modo diferente do atual, siga a "Regra de transição
entre modos" abaixo.

1. **[discovery] Descoberta** (opcional, mas recomendada se o pedido for vago): gere o brief de descoberta em `discovery/`, crie o portão `00-discovery.md`. **Pare no portão.**
2. **[product-owner] PRD**: use a skill `po-prd-gate`. **Pare no portão.**
3. **[product-owner] Backlog**: use a skill `po-backlog-gate`. **Pare no portão.**
4. **[architect] ADR** (se a mudança tiver impacto arquitetural): use a skill `arch-adr-gate`. **Pare no portão.**
5. **[designer] Design** (se o item de trabalho tocar interface — tela nova, componente novo, mudança visual ou correção de usabilidade/acessibilidade): use a skill `design-ui-gate` no **Modo A — Especificar**. **Pare no portão de design (`03-design.md`).**
   Se o item não tocar interface, declare explicitamente "sem impacto de design" e siga para a etapa 6.
6. **[sprint-planner] Sprint** (opcional): gere a fatia de sprint em `delivery/`. **Pare no portão, se seu fluxo usa este portão.**
7. **[developer] Desenvolvimento**: implemente com testes, seguindo `.bob/rules-developer/*`, a especificação de design aprovada (`design/<CHAVE_DO_ITEM>/design-spec.md`, quando houver) e a Definição de Pronto (`.bob/rules/03-definicao-de-pronto.md`). Execute as tarefas de forma autônoma, conforme `.bob/rules/09-autonomia-e-eficiencia-do-agente.md`.
8. **[tester] Testes**: valide os critérios de aceite, amplie a cobertura, documente evidências em `tests/`.
9. **[designer] Revisão de UI** (somente se a etapa 5 foi executada): use a skill `design-ui-gate` no **Modo B — Revisar** para validar a interface implementada contra a especificação aprovada. Não siga com achados CRÍTICOS ou ALTOS em aberto.
10. **[security] Segurança**: revise CVE/dependências, atualize `security/cve-review.md` e o modelo de ameaças se aplicável.
11. **[doc-writer] Documentação**: gere/atualize a especificação técnica em `docs/`.
12. **[revisor-qualidade] Revisão holística**: use a skill `revisao-final-holistica` para validar tudo antes do PR.
13. **[developer] PR**: use a skill `dev-pr-create`. **Pare no portão de PR.**
14. **Pronto para release** (opcional): portão final de sign-off.

## Regra de transição entre modos (OBRIGATÓRIA)
A troca de modo é sempre **manual**, feita pelo próprio desenvolvedor —
NÃO tente chamar `switch_mode` nem qualquer variante (ex.:
`mcp__bob-ide__switch_mode`; isso não existe e não deve ser usado).
Sempre que a próxima etapa da sequência acima pertencer a um modo diferente
do atual, ao terminar a etapa corrente e passar o portão dela (quando
houver um), dê instruções claras de dois passos:
1) Diga qual modo o desenvolvedor deve selecionar manualmente no seletor
   de modos (o slug indicado entre colchetes na próxima etapa, ex.:
   `product-owner`, `architect`, `designer`, `developer`, `tester`,
   `security`, `doc-writer`, `revisor-qualidade`), e por quê (o que foi
   concluído e o que essa próxima etapa vai fazer).
2) Diga o que ele deve escrever como primeira mensagem naquele modo para
   retomar o fluxo (ex.: "continue o fluxo guiado a partir do backlog
   aprovado"), já que o novo modo não sabe automaticamente que deve
   continuar de onde parou.
Algumas restrições de edição são por modo (ex.: `discovery` só edita
`discovery/` e portões de descoberta/recursos; `doc-writer` só edita
`.md`/`docs/`) — por isso a troca de modo não é só cosmética, é necessária
para poder escrever nos arquivos da próxima etapa.

## Regras de execução
- Não pare entre etapas para pedir "posso continuar?" — pare **apenas** nos portões definidos, conforme `.bob/rules/06-portoes-aprovacao-humana.md`, e nas trocas de modo manuais indicadas acima.
- Se um portão for REJECTED, volte para a etapa correspondente (trocando de modo de volta, se necessário), ajuste o artefato, redefina o portão para PENDING e continue o fluxo a partir dali — não reinicie do zero.
- Se, em qualquer etapa, um artefato entrar em conflito com a constituição do projeto, pare imediatamente e sinalize o conflito (ver `.bob/rules/08-constituicao-do-projeto.md`), independentemente de haver um portão formal ali.
- Relate o progresso de forma concisa: qual etapa foi concluída, qual artefato foi gerado, e em qual portão o fluxo está aguardando aprovação — sem repetir o conteúdo completo dos artefatos já mostrados.

## Saídas
Ao final de uma execução completa (ou até o ponto onde parou aguardando aprovação):
- Lista dos artefatos criados/atualizados nesta execução.
- Status de cada portão (APPROVED / PENDING / REJECTED).
- Próximo passo esperado.
