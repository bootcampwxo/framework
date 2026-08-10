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

## Design e experiência (quando o item toca interface)
- A especificação de design (`design/<CHAVE_DO_ITEM>/design-spec.md`) foi seguida, ou os desvios estão documentados e aceitos.
- Todos os estados da matriz obrigatória estão implementados e alcançáveis: vazio, carregando, erro, sucesso, desabilitado (e parcial/sem permissão quando aplicável).
- Nenhum valor visual hardcoded onde existe token (cor, tipografia, espaçamento).
- Acessibilidade WCAG 2.1 AA verificada: contraste, navegação por teclado, foco visível, rótulos de formulário, semântica.
- Comportamento responsivo confirmado em todos os breakpoints declarados.
- Mensagens de interface em linguagem humana, sem expor stack trace, código de erro cru ou detalhe interno.
- Componentes novos registrados em `design/design-system.md` (e no catálogo/Storybook, se o projeto tiver).

Se o item **não** tocar interface, declare explicitamente "sem impacto de design" em vez de pular a seção em silêncio.

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
