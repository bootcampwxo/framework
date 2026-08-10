# Especificação de Design — <CHAVE_DO_ITEM>

- **Item de trabalho:** <CHAVE_DO_ITEM>
- **Autor:** Bob (modo Designer)
- **Data:**
- **Status:** Rascunho | Em revisão | Aprovado
- **Portão:** `gates/<CHAVE_DO_ITEM>/03-design.md`

---

## 1. Contexto

**Problema de experiência a resolver:** <o que está difícil, confuso ou impossível para o usuário hoje>

**Usuário-alvo:** <quem>

**Critérios de aceite relacionados:** <referência ao backlog>

---

## 2. Inventário do que já existe (pré-checagem obrigatória)

Preenchido a partir da inspeção real do repositório — não por suposição.

| Item | O que foi encontrado | Caminho |
|---|---|---|
| Design system / biblioteca | <ex.: Carbon v11 / nenhum> | |
| Arquivo de tokens | | |
| Componentes de UI existentes | | |
| Breakpoints já definidos | | |
| Assets de marca | | |
| Prática de acessibilidade | | |

> Se o projeto não tiver design system, registre aqui a proposta e sinalize como dependência de ADR.

---

## 3. Fluxo de usuário

Antes das telas: qual é o caminho da pessoa.

1. **Entrada:** <de onde o usuário vem>
2. **Passos:** <passo a passo até o objetivo>
3. **Pontos de decisão:** <onde o usuário escolhe>
4. **Caminhos de falha:** <o que pode dar errado e para onde vai>
5. **Saída:** <como o usuário sabe que terminou>

---

## 4. Inventário de componentes

| Componente | Reutilizado / Estendido / **Novo** | Origem ou justificativa |
|---|---|---|
| | | |

> Todo componente **Novo** exige justificativa: por que o existente não serve e qual a menor adição possível.

---

## 5. Matriz de estados (OBRIGATÓRIA)

Uma linha por componente/tela que carrega, envia ou depende de dados. **Nenhuma célula pode ficar vazia** — use "n/a" com justificativa quando o estado realmente não existir.

| Componente | Vazio | Carregando | Erro | Sucesso | Parcial | Desabilitado | Sem permissão |
|---|---|---|---|---|---|---|---|
| | | | | | | | |

### Textos de interface
Redija aqui os textos reais — rótulos, mensagens de estado vazio e de erro. Sem "lorem ipsum" e sem "TBD"; se o texto depende de decisão de negócio, registre em Perguntas em Aberto.

| Situação | Texto |
|---|---|
| Estado vazio | |
| Erro de rede | |
| Erro de validação | |
| Confirmação de sucesso | |

---

## 6. Tokens

**Reutilizados:** <lista>

**Criados nesta spec:**

| Token | Valor | Papel semântico | Onde passa a viver |
|---|---|---|---|
| | | | |

---

## 7. Hierarquia visual e layout

- **Ação primária da tela:** <uma só>
- **Ordem de leitura pretendida:** <o que o olho vê primeiro, segundo, terceiro>
- **Unidade de espaçamento:** <ex.: 8px>
- **Densidade:** <confortável / compacta>

---

## 8. Responsividade

| Breakpoint | Largura | Comportamento do layout |
|---|---|---|
| Mobile | | |
| Tablet | | |
| Desktop | | |

- Comportamento de tabelas em tela pequena: <rolagem / empilhamento / colunas prioritárias>
- Teste com conteúdo real: título longo, nome longo, lista vazia, lista grande.

---

## 9. Acessibilidade (WCAG 2.1 AA)

- [ ] Contraste de texto ≥ 4.5:1 (≥ 3:1 para texto grande e componentes)
- [ ] Toda ação alcançável e operável por teclado, em ordem lógica
- [ ] Indicador de foco visível e com contraste suficiente
- [ ] Alvos de toque ≥ 44×44px
- [ ] HTML semântico; ARIA apenas onde o nativo não resolve
- [ ] Todo campo de formulário com `<label>` associado (placeholder não é label)
- [ ] Erros associados ao campo e anunciados em região `aria-live`
- [ ] `alt` significativo; ícones decorativos com `aria-hidden`
- [ ] `prefers-reduced-motion` respeitado
- [ ] Nenhuma informação transmitida apenas por cor
- [ ] Utilizável com 200% de zoom

---

## 10. Dependências para outros modos

| Necessidade | Modo responsável | Status |
|---|---|---|
| | Arquiteto / Desenvolvedor | |

---

## 11. Perguntas em aberto

- <pergunta + quem decide>

---

## 12. Fora de escopo

- <o que esta spec deliberadamente não cobre>
