# Plano de Testes — <CHAVE_DO_ITEM>

## 1) Escopo
- Item de trabalho / história(s) cobertas:
- Fora de escopo:

## 2) Pré-condições
- [ ] Backlog do item de trabalho aprovado (`gates/<CHAVE_DO_ITEM>/02-backlog.md` = APPROVED)
- [ ] Implementação existe (código presente)

## 3) Estratégia de teste (ordem obrigatória)
1. Testes unitários (obrigatório)
2. Testes de integração (obrigatório se limites/boundaries forem afetados)
3. Testes E2E (opcional, recomendado para fluxos críticos)
4. Verificação manual (somente quando a automação não for viável)

## 4) Riscos e áreas de atenção
- ...

## 5) Ambiente e dados de teste
- Ambiente:
- Massa de dados / fixtures usadas:
- Dependências externas mockadas:

## 6) Critérios de saída (quando considerar os testes concluídos)
- [ ] Todos os cenários de aceite mapeados (ver `mapeamento-criterios-aceite.md`)
- [ ] Testes determinísticos (sem rede, sem flakiness de tempo)
- [ ] Evidência de teste documentada (ver `evidencia-de-teste.md`)

## 7) Comandos para executar
```bash
# exemplo — adapte ao stack do projeto
pytest tests/unit
pytest tests/integration
```
