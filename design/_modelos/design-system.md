# Design System — <NOME DO PROJETO>

Registro vivo da identidade visual do projeto. **Fonte única de verdade**: se um valor não está aqui (ou no arquivo de tokens que este documento referencia), ele não deve aparecer hardcoded em componente algum.

- **Versão:**
- **Última atualização:**
- **Base adotada:** <ex.: Carbon Design System v11 / Material 3 / próprio>
- **Arquivo de tokens (fonte de verdade em código):** <ex.: `src/styles/tokens.css`, `tailwind.config.ts`>

---

## 1. Tokens de cor

| Token | Valor | Papel semântico | Contraste verificado |
|---|---|---|---|
| | | ação primária | |
| | | texto primário | |
| | | texto secundário | |
| | | superfície / fundo | |
| | | borda / divisor | |
| | | sucesso | |
| | | aviso | |
| | | erro | |
| | | informação | |

> Regra: cor de ação não é preenchimento decorativo. Estado nunca é comunicado só por cor.

## 2. Tipografia

| Papel | Fonte | Tamanho | Peso | Altura de linha |
|---|---|---|---|---|
| Título de página | | | | |
| Título de seção | | | | |
| Corpo | | | | |
| Corpo pequeno / apoio | | | | |
| Código / metadado | | | | |

- Piso de tamanho para conteúdo principal: <ex.: 16px>
- Comprimento de linha alvo: 45–75 caracteres

## 3. Espaçamento

- **Unidade base:** <ex.: 8px> (meio-passo de 4px quando necessário)
- **Escala:** <ex.: 4, 8, 16, 24, 32, 48, 64>

## 4. Raio, elevação e movimento

| Token | Valor | Uso |
|---|---|---|
| raio | | |
| elevação | | |
| duração | | |
| curva de animação | | |

> Todo movimento respeita `prefers-reduced-motion`.

## 5. Breakpoints

| Nome | Largura | Colunas do grid |
|---|---|---|
| Mobile | | |
| Tablet | | |
| Desktop | | |

## 6. Ícones e marca

- **Biblioteca de ícones oficial:** <ex.: `@carbon/icons-react`>
- **Localização dos assets de marca:** <caminho>
- **Proibido:** emoji ou Unicode como ícone, SVG desenhado à mão, logo aproximado em CSS/texto.

## 7. Inventário de componentes

| Componente | Status | Onde vive | Estados implementados |
|---|---|---|---|
| | estável / em evolução / depreciado | | |

## 8. Verificações automatizadas configuradas

| Verificação | Ferramenta | Onde roda |
|---|---|---|
| Lint de token | | |
| Acessibilidade | | |
| Regressão visual | | |
| Catálogo de componentes | | |

## 9. Histórico de mudanças

| Data | Mudança | Item de trabalho | Impacto em telas existentes |
|---|---|---|---|
| | | | |
