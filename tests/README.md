# tests/

Estrutura de testes do projeto (obrigatória — não invente uma estrutura diferente se o repositório já usa outra):

- `unit/` — testes unitários (obrigatórios para toda nova lógica)
- `integration/` — testes de integração (obrigatórios quando um limite/boundary é afetado: API, banco de dados, fila, sistema de arquivos, rede)
- `e2e/` — testes ponta a ponta (opcionais, recomendados para fluxos críticos de usuário)
- `_modelos/` — modelos de teste prontos para copiar:
  - [`plano-de-testes.md`](_modelos/plano-de-testes.md) — plano de testes por item de trabalho
  - [`mapeamento-criterios-aceite.md`](_modelos/mapeamento-criterios-aceite.md) — mapeamento de cada critério de aceite (Dado/Quando/Então) para um teste
  - [`evidencia-de-teste.md`](_modelos/evidencia-de-teste.md) — evidência de teste para incluir na resposta/PR
  - [`modelo_teste_unitario.py`](_modelos/modelo_teste_unitario.py) — exemplo de teste unitário (padrão AAA: Arrange/Act/Assert)
  - [`modelo_teste_integracao.py`](_modelos/modelo_teste_integracao.py) — exemplo de teste de integração (com mock de dependência externa)

Veja as regras completas do modo Testador em [`../.bob/rules-tester/01-testador.md`](../.bob/rules-tester/01-testador.md).

## Regra de ouro
Nenhum cenário de critério de aceite pode ficar sem teste mapeado. Se um cenário não puder ser automatizado, documente os passos manuais exatos e o motivo.
