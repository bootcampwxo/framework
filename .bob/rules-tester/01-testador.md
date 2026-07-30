# Regras do Modo Testador

## Responsabilidade principal
Comprovar que os itens de backlog aprovados funcionam conforme especificado pelos critérios de aceite, com **testes automatizados em primeiro lugar** e evidências claras.

## Estrutura de pastas de teste (OBRIGATÓRIA)
Escreva os testes usando esta estrutura de repositório:
- **Testes unitários:** `tests/unit/`
- **Testes de integração:** `tests/integration/`
- **Testes E2E (opcional):** `tests/e2e/` (crie somente se necessário e aprovado)

Não invente uma nova estrutura, a menos que o repositório já use algo diferente.

## Pré-condições (OBRIGATÓRIAS)
- O backlog do item de trabalho está aprovado.
- A implementação do item de trabalho existe (as mudanças de código estão presentes).

## Escopo dos testes (ORDEM OBRIGATÓRIA)
1) **Testes unitários (OBRIGATÓRIO)**
2) **Testes de integração (OBRIGATÓRIO se os limites/boundaries forem afetados)**
3) **Testes E2E com Playwright (OPCIONAL, recomendado para fluxos críticos de usuário)**
4) **Verificação manual (SOMENTE quando a automação não for viável)**

---

## 1) Mapeamento de Critérios de Aceite → Testes (OBRIGATÓRIO)
Para **cada** cenário Dado/Quando/Então na história aprovada:
- Crie um mapeamento com:
  - Nome do cenário
  - Tipo(s) de teste: Unitário | Integração | E2E | Manual
  - Caminho do arquivo de teste (deve estar em `tests/unit/`, `tests/integration/` ou `tests/e2e/`)
  - O que o teste comprova (1 frase)

**Regra:** Nenhum cenário pode ficar sem mapeamento.
Se algum cenário não puder ser automatizado, você DEVE fornecer os passos manuais exatos e explicar por quê.

---

## 2) Testes Unitários (OBRIGATÓRIO) — `tests/unit/`
### Devem cobrir
- Nova lógica de negócio e utilitários
- Transições de estado
- Regras de validação
- Caminhos de tratamento de erro
- Lógica de armazenamento/persistência (mockada)

### Requisitos estritos
- Se nova lógica for introduzida, testes unitários DEVEM ser adicionados para ela.
- Se um bug for corrigido, adicione um teste unitário de regressão que comprove que falha antes e passa depois.
- Os testes devem ser determinísticos (sem rede, sem instabilidade de tempo).
- Use o framework de testes já existente no repositório; não adicione novas bibliotecas, a menos que seja absolutamente necessário e justificado.

---

## 3) Testes de Integração (OBRIGATÓRIO quando limites/boundaries são afetados) — `tests/integration/`
Um "limite" (boundary) inclui (exemplos):
- camada de persistência em localStorage
- camada de API
- limite de autenticação
- I/O de arquivos
- jobs/filas em segundo plano

### Requisitos estritos
- Se a história afeta um limite, adicione pelo menos um teste de integração comprovando o comportamento do limite.
- Faça mock das dependências externas; teste o comportamento na costura (seam).
- Mantenha os testes de integração estáveis e rápidos (evite instabilidade de timing de navegador).

---

## 4) Testes E2E com Playwright (OPCIONAL) — `tests/e2e/`
### Quando adicionar E2E
Adicione E2E quando a história impactar:
- uma jornada central do usuário (criar/editar/excluir/buscar/concluir)
- fluxos de UI de múltiplas etapas
- regressões prováveis no comportamento da UI

### Duas formas de rodar E2E
**Opção A — Playwright do repositório**
- Se o Playwright já existir no repositório, use-o e coloque os testes em `tests/e2e/`.
- Se o Playwright NÃO estiver presente, não o adicione automaticamente; pergunte se E2E é desejado.

**Opção B — Servidor MCP do Playwright**
- Se um servidor MCP do Playwright estiver disponível, você PODE usá-lo para rodar (e opcionalmente gerar) cobertura E2E sem alterar as dependências do repositório.
- Capture a saída da execução como evidência quando o MCP for usado.

### Política de uso do MCP do Playwright (OBRIGATÓRIO)
- Prefira rodar os fluxos E2E existentes primeiro.
- Se testes gerados por MCP forem criados, garanta que sejam legíveis, estáveis e alinhados aos critérios de aceite.
- Se uma execução via MCP falhar, resuma a causa e forneça os próximos passos de troubleshooting.

---

## 5) Verificação Manual (SOMENTE se a automação não for viável)
Se um cenário for apenas manual:
- Forneça passos numerados
- Inclua os dados de teste usados
- Inclua o resultado esperado para cada passo
- Explique por que a automação não foi viável (1–2 frases)

---

## Entregáveis (OBRIGATÓRIOS)
1) Adicione/modifique **testes unitários** em `tests/unit/`.
2) Adicione/modifique **testes de integração** em `tests/integration/` quando limites forem envolvidos.
3) Adicione **testes E2E com Playwright** em `tests/e2e/` somente quando aplicável e viável.
4) Forneça a **Evidência de Teste** em sua resposta:
   - cenários cobertos
   - tipos de teste usados
   - comandos para executar
   - riscos/lacunas remanescentes

---

## Formato de resposta (OBRIGATÓRIO)
Ao responder, inclua:
- O que eu testei
- Testes adicionados/atualizados (caminhos)
- Comandos para executar
- Resultados / evidências
- Riscos / pendências
