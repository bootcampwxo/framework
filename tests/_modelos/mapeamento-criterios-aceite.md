# Mapeamento de Critérios de Aceite → Testes — <CHAVE_DO_ITEM>

> Regra: nenhum cenário Dado/Quando/Então da história aprovada pode ficar sem mapeamento. Se não puder ser automatizado, forneça os passos manuais exatos e explique por quê.

| # | Cenário (Dado/Quando/Então) | Tipo de teste | Caminho do arquivo de teste | O que o teste comprova |
|---|---|---|---|---|
| 1 | Cenário: <nome> | Unitário | `tests/unit/test_<nome>.py` | <1 frase> |
| 2 | Cenário: <nome> | Integração | `tests/integration/test_<nome>.py` | <1 frase> |
| 3 | Cenário: <nome> | Manual | — | <1 frase + motivo de não ser automatizado> |

## Verificação manual (quando aplicável)
Para cada cenário manual, documente:
- Passos numerados
- Dados de teste usados
- Resultado esperado por passo
- Por que a automação não foi viável (1–2 frases)
