# Revisão de UI — <CHAVE_DO_ITEM>

- **Item de trabalho:** <CHAVE_DO_ITEM>
- **Especificação de referência:** `design/<CHAVE_DO_ITEM>/design-spec.md`
- **Revisor:** Bob (modo Designer)
- **Data:**
- **Veredito:** UI APROVADA | BLOQUEADA

---

## Como a verificação foi feita

- [ ] Interface aberta e navegada no navegador
- [ ] Storybook / catálogo de componentes executado
- [ ] Ferramenta automatizada de acessibilidade executada (<qual>)
- [ ] Verificada em todos os breakpoints declarados

> Se a aplicação não pôde ser executada, declare aqui explicitamente. Não registre como verificado o que não foi visto.

---

## Achados

| # | Severidade | Dimensão | Arquivo / trecho | Impacto para o usuário | Como corrigir | Responsável |
|---|---|---|---|---|---|---|
| 1 | CRÍTICO / ALTO / MÉDIO / BAIXO | tokens / componentes / estados / hierarquia / responsividade / acessibilidade / conteúdo | | | | Designer / Desenvolvedor |

### Severidades
- **CRÍTICO** (bloqueia o PR): barreira de acessibilidade, estado de erro ausente, dado ilegível, ação primária inalcançável.
- **ALTO**: desvio de token ou componente que gera inconsistência visível no produto.
- **MÉDIO**: espaçamento fora da grade, hierarquia fraca, texto divergente da spec.
- **BAIXO/sugestão**: refinamento que não afeta uso nem consistência.

---

## Verificação por dimensão

| Dimensão | Resultado | Observação |
|---|---|---|
| Tokens (sem valor hardcoded) | OK / Achado | |
| Componentes (reuso conforme spec) | OK / Achado | |
| Estados (matriz completa e alcançável) | OK / Achado | |
| Hierarquia e layout | OK / Achado | |
| Responsividade | OK / Achado | |
| Acessibilidade (WCAG 2.1 AA) | OK / Achado | |
| Conteúdo de interface | OK / Achado | |

---

## Pendências antes do PR

- <lista do que precisa ser corrigido e por quem>

> O item não segue para `revisao-final-holistica` com achados CRÍTICOS ou ALTOS em aberto.
