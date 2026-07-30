# Definição de Pronto (Definition of Done) (aplica-se a todos os modos)

Um item de backlog está "Pronto" somente se TODOS os itens abaixo se aplicarem:

## Funcional
- Os critérios de aceite foram atendidos e são comprovadamente verificáveis.

## Qualidade de código
- O código segue as convenções do repositório.
- Nenhuma complexidade desnecessária foi introduzida.

## Testes
- Testes unitários adicionados/atualizados para a nova lógica.
- Testes de integração/e2e adicionados quando o comportamento cruza limites (boundaries) (API, banco de dados, fila, sistema de arquivos, rede).
- Os testes são determinísticos e executáveis.

## Segurança
- Validação de entrada considerada.
- Implicações de autenticação/autorização revisadas, quando relevante.
- Segredos não registrados em log nem commitados.
- Dependências consideradas quanto a problemas conhecidos (nota: documente apenas o que for conhecido a partir de ferramentas/saídas do repositório).

## Documentação
- Documentação voltada ao usuário atualizada (se o comportamento mudou).
- Runbook atualizado (se o comportamento operacional/de implantação mudou).

## Prontidão operacional
- Observabilidade considerada (logs/métricas/tracing), quando aplicável.
- Modos de falha considerados e documentados.

## Pacote de revisão
- A descrição do PR inclui: O quê/Por quê, Como, Testes, Risco, Rollback, Documentação, Notas de segurança.
