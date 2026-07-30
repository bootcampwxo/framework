# Constituição do Projeto (aplica-se a todos os modos)

## Objetivo
Estabelecer, antes de qualquer PRD, ADR ou linha de código, o conjunto de princípios **não-negociáveis** do projeto — a autoridade máxima que todas as fases seguintes (Descoberta, PRD, Backlog, ADR, Desenvolvimento, Testes, Segurança, Docs, PR) devem respeitar. Esta regra traz para o Framework .Bob o conceito de "constituição" usado por frameworks avançados de Spec-Driven Development: uma especificação vive sob uma autoridade superior, e essa autoridade é escrita primeiro.

## Por que isso importa
Sem uma constituição explícita, cada papel (PO, Arquiteto, Desenvolvedor, Testador, Segurança) acaba definindo suas próprias regras implícitas de qualidade — o que gera inconsistência entre itens de trabalho. A constituição resolve isso: é escrita **uma vez por projeto** (ou por workspace), raramente muda, e qualquer mudança nela é tratada como um evento de governança, não como um detalhe de implementação.

## Onde vive
- `architecture/constituicao.md` — a constituição vigente do projeto/produto.
- `architecture/modelo-constituicao.md` — modelo em branco para iniciar um novo projeto ou workspace.

## Conteúdo obrigatório
A constituição deve declarar, de forma testável e inequívoca:
1. **Princípios de engenharia** (ex.: cobertura mínima de testes, TDD obrigatório ou não, uso do Carbon Design System, política de dependências).
2. **Padrões de qualidade e Definição de Pronto** (referencie `.bob/rules/03-definicao-de-pronto.md`, não duplique).
3. **Restrições de arquitetura** (ex.: stack aprovada, padrões de dados, requisitos de observabilidade).
4. **Requisitos de segurança e conformidade** não-negociáveis (ex.: nunca commitar segredos, revisão de CVE obrigatória em mudanças de autenticação).
5. **Regras de governança**: como a própria constituição pode ser emendada.

## Versionamento semântico (OBRIGATÓRIO)
Toda mudança na constituição segue versionamento semântico:
- **MAJOR**: remoção ou mudança incompatível de um princípio existente.
- **MINOR**: adição de um novo princípio ou expansão material de um existente.
- **PATCH**: esclarecimentos, correções de texto, sem mudança de intenção.

Registre no rodapé do arquivo:
```
Versão: X.Y.Z | Ratificada em: AAAA-MM-DD | Última emenda: AAAA-MM-DD
```

## Autoridade vinculante (OBRIGATÓRIO)
- Nenhum modo pode aprovar um portão (`.bob/rules/06-portoes-aprovacao-humana.md`) que viole um princípio MUST da constituição — isso é automaticamente tratado como achado **CRÍTICO**.
- Ao detectar um conflito entre um artefato (PRD, ADR, código, plano de testes) e a constituição, o agente deve **parar**, sinalizar o conflito explicitamente ao humano responsável, e não prosseguir até que o conflito seja resolvido (ajustando o artefato ou emendando a constituição conscientemente).
- Mudanças na constituição devem ser propagadas: revise se `.bob/rules/*`, `.bob/custom_modes.yaml` e os modelos em `_modelos/` continuam consistentes com a nova versão.

## Primeira criação (bootstrap)
Se `architecture/constituicao.md` não existir, o primeiro modo a perceber isso (tipicamente Descoberta ou Product Owner) deve:
1. Perguntar ao humano quais princípios não-negociáveis devem constar.
2. Copiar `architecture/modelo-constituicao.md` para `architecture/constituicao.md` e preencher.
3. Definir versão inicial `1.0.0` com `Ratificada em` = data de hoje.
4. Seguir para a fase normal (PRD/Backlog) apenas depois disso.
