# Skill: Especificação de Design + Portão (Por Item de Trabalho)

## Objetivo
Garantir que os princípios de design sejam satisfeitos **ao longo de todo o desenvolvimento**, e não apenas no começo. A skill opera em dois modos complementares:

- **Modo A — Especificar** (fase Desenhar, antes do código): produzir a especificação de design do item de trabalho (tokens, inventário de componentes, matriz de estados, fluxos, responsividade, acessibilidade) e criar o portão de design.
- **Modo B — Revisar** (fase Verificar, depois do código): validar a UI implementada contra a especificação aprovada, categorizando cada achado por severidade.

Sem o Modo A, a implementação inventa a identidade visual. Sem o Modo B, a especificação vira ficção.

## Quando usar
- **Modo A**: depois que `gates/<CHAVE_DO_ITEM>/02-backlog.md` estiver APPROVED e o item de trabalho tocar interface — tela nova, componente novo, mudança de identidade visual ou correção de usabilidade/acessibilidade.
- **Modo B**: depois que o Desenvolvedor concluir a implementação da UI e antes de `revisao-final-holistica`.
- Se o item de trabalho **não** tocar interface, não execute a skill — declare "sem impacto de design" no item e siga o fluxo.

## Pré-condições
- **Modo A**: `gates/<CHAVE_DO_ITEM>/02-backlog.md` existe e o Status é APPROVED.
- **Modo B**: `design/<CHAVE_DO_ITEM>/design-spec.md` existe e `gates/<CHAVE_DO_ITEM>/03-design.md` está APPROVED.

---

## Modo A — Especificar (fase Desenhar)

1) **Determine a CHAVE_DO_ITEM** usando a ordem de prioridade das regras de portão (`.bob/rules/06-portoes-aprovacao-humana.md`).

2) **Verifique se `gates/<CHAVE_DO_ITEM>/02-backlog.md` está APPROVED.** Se não, pare e solicite aprovação.

3) **Execute a pré-checagem de contexto OBRIGATÓRIA** (`.bob/rules-designer/01-designer.md`) — inventarie o que já existe antes de propor qualquer coisa nova:
   - design system e biblioteca de componentes em uso (e versão);
   - tokens já existentes (`tokens.*`, `theme.*`, `:root {`, `tailwind.config.*`, `_variables.scss`);
   - componentes de UI já implementados;
   - breakpoints e padrões de layout já usados;
   - assets de marca versionados (`brand/`, se existir);
   - prática atual de acessibilidade.

   **Registre o resultado dessa inspeção na especificação.** Se o projeto não tiver design system algum, proponha um com justificativa e sinalize como dependência de ADR (modo Arquiteto).

4) **Produza `design/<CHAVE_DO_ITEM>/design-spec.md`** a partir de `design/_modelos/design-spec.md`, cobrindo obrigatoriamente:
   - **Fluxo de usuário** antes das telas: entrada, passos, saída, pontos de decisão e caminhos de falha;
   - **Inventário de componentes**: o que é reutilizado, o que é estendido, o que é novo (com justificativa para cada item novo);
   - **Matriz de estados** de cada componente que carrega/envia dados — vazio, carregando, erro, sucesso, parcial, desabilitado, sem permissão. Nenhuma linha pode ficar vazia;
   - **Tokens** usados e, se necessário, os criados (com o lugar onde passam a viver);
   - **Hierarquia visual**: qual é a ação primária de cada tela;
   - **Responsividade**: comportamento declarado por breakpoint;
   - **Acessibilidade**: checklist WCAG 2.1 AA do item;
   - **Conteúdo de interface**: textos de rótulo, mensagens de erro e estados vazios já redigidos (não deixe "lorem ipsum" nem "TBD" — se o texto depende de decisão de negócio, registre como Pergunta em Aberto);
   - **Dependências** para Arquiteto/Desenvolvedor.

5) **Atualize `design/design-system.md`** (o registro vivo do design system do projeto) se esta especificação introduziu, alterou ou depreciou algum token ou componente compartilhado. Se o arquivo não existir, crie-o a partir de `design/_modelos/design-system.md`.

6) **Crie ou atualize o arquivo de portão**: `gates/<CHAVE_DO_ITEM>/03-design.md` com `Status: PENDING`.

7) **Forneça um pacote de revisão curto** — o que foi decidido, o que foi reutilizado vs. criado, e o que precisa de decisão humana — e solicite aprovação.

### Saída do Modo A
- `design/<CHAVE_DO_ITEM>/design-spec.md`
- `design/design-system.md` (criado/atualizado, quando aplicável)
- `gates/<CHAVE_DO_ITEM>/03-design.md`

### Conclusão do Modo A
Pare depois de criar o portão e solicite aprovação humana. **Não** avance para implementação.

---

## Modo B — Revisar (fase Verificar)

1) **Carregue a especificação aprovada**: `design/<CHAVE_DO_ITEM>/design-spec.md` e `design/design-system.md`.

2) **Inspecione a UI implementada de verdade.** Não revise apenas lendo o código: abra a interface no navegador (o modo Designer tem acesso ao grupo `browser`) ou execute o Storybook, quando existirem. Se não for possível executar a aplicação, declare isso explicitamente na revisão como limitação — não finja que a verificação visual aconteceu.

3) **Valide contra 7 dimensões**, nesta ordem:
   - **Tokens**: existe hex, px, cor ou fonte hardcoded onde deveria haver token?
   - **Componentes**: a implementação reusou o que a spec mandou reusar, ou criou duplicata de algo que já existia?
   - **Estados**: cada estado da matriz está implementado e alcançável? *(Verifique de verdade — force o erro, esvazie a lista, simule a lentidão.)*
   - **Hierarquia e layout**: a ação primária está evidente? O espaçamento segue a grade?
   - **Responsividade**: o layout se reorganiza corretamente em cada breakpoint declarado?
   - **Acessibilidade**: contraste, navegação por teclado, foco visível, rótulos de formulário, semântica, `prefers-reduced-motion`. Rode a ferramenta automatizada do projeto (`axe`, `jest-axe`, Lighthouse) quando existir.
   - **Conteúdo**: as mensagens são as da spec? Alguma expõe stack trace, código de erro cru ou detalhe interno?

4) **Categorize cada achado por severidade**:
   - **CRÍTICO** (bloqueia o PR): barreira de acessibilidade, estado de erro ausente, dado ilegível, ação primária inalcançável.
   - **ALTO**: desvio de token ou componente que gera inconsistência visível no produto.
   - **MÉDIO**: espaçamento fora da grade, hierarquia fraca, texto de interface divergente.
   - **BAIXO/sugestão**: refinamento que não afeta uso nem consistência.

   Cada achado deve ser acionável: arquivo, trecho/linha, impacto para o usuário e como corrigir.

5) **Registre em `design/<CHAVE_DO_ITEM>/revisao-de-ui.md`** (modelo em `design/_modelos/revisao-de-ui.md`).

6) **Não deixe o fluxo seguir com achados CRÍTICOS ou ALTOS não resolvidos.** Roteie a correção para o modo apropriado — Designer para tokens/estilos/estrutura de UI, Desenvolvedor para integração e lógica — aguarde a correção e reexecute a revisão até ficar limpa.

7) **Só então** libere o item para `revisao-final-holistica`.

### Saída do Modo B
- `design/<CHAVE_DO_ITEM>/revisao-de-ui.md` com os achados e severidades.
- Veredito explícito: **UI APROVADA** ou **BLOQUEADA** (com a lista do que falta).

---

## Regras de execução
- Execute os passos internos de cada modo em sequência, sem pedir confirmação a cada um (ver `.bob/rules/09-autonomia-e-eficiencia-do-agente.md`). Pare apenas no portão de design (Modo A) e no veredito (Modo B).
- **Nunca invente** token, ícone, logo ou componente. Se faltar informação de marca, registre como Pergunta em Aberto e use um marcador explícito — nunca uma aproximação silenciosa.
- Se a especificação de design entrar em conflito com a constituição do projeto (`architecture/constituicao.md`), pare imediatamente e sinalize o conflito, independentemente de haver portão ali.
- Se um portão de design for REJECTED, ajuste a especificação, redefina o portão para PENDING e continue a partir dali — não reinicie do zero.
