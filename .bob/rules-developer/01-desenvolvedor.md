# Regras do Modo Desenvolvedor

## Responsabilidades
- Implementar a fatia do sprint com mudanças mínimas e revisáveis.
- Adicionar/atualizar testes unitários para a nova lógica.
- Manter o código alinhado às convenções do repositório.
- Manter rastreabilidade com o item de trabalho aprovado (história/bug/tarefa) ou caso TS.

## Pré-checagem de contexto (OBRIGATÓRIA)
Antes de escrever ou modificar código, você DEVE inspecionar o repositório existente para confirmar:
- framework/runtime (ex.: ferramentas e scripts de Node + React)
- convenções de pastas e padrões arquiteturais existentes
- dependências atuais (package.json/lockfile) e utilitários existentes
- padrões existentes para gerenciamento de estado, persistência/armazenamento e testes

### Política de dependências (ESTRITA)
- Reutilize o que já existe sempre que possível.
- NÃO adicione novas dependências por padrão.
- Se uma nova dependência for necessária, justifique explicitamente (nas notas da resposta):
  - por que as dependências/padrões existentes são insuficientes
  - a escolha mínima de dependência
  - quaisquer implicações de segurança/teste

## Checklist de implementação (obrigatório)
- Identifique os limites (boundaries) afetados (API/BD/fila/arquivo/etc.).
- Implemente a menor mudança que satisfaça os critérios de aceite aprovados.
- Atualize ou adicione testes para cada limite afetado (seguindo a abordagem de teste já usada no repositório).
- Evite refatorações amplas, a menos que necessárias para a história.
- Forneça passos claros de "Como verificar".
- Garanta que nenhum segredo ou dado sensível seja adicionado a logs/configurações.

## Formato de saída na resposta (sempre)
- Arquivos alterados
- Comandos para executar
- Notas sobre decisões de design (breve), incluindo justificativa de qualquer nova dependência
- Tarefas/TODOs de acompanhamento

## Fluxo orientado por defeito (handoff de Engenharia de Produto)

### Entrada
Se uma pasta de caso TS contiver:
- `product-engineering/TS#########/defect.md`

Então o modo Desenvolvedor DEVE tratar este arquivo como a fonte primária da verdade para o escopo da correção e sua validação.

### Comportamento obrigatório
1) Leia `defect.md` primeiro.
2) Extraia:
   - passos de reprodução
   - esperado vs. real
   - plano de validação
3) Implemente a correção com escopo mínimo, alinhado ao `defect.md`.
4) Adicione testes que comprovem que o defeito foi corrigido (unitários/integração, conforme apropriado).
5) Atualize a descrição do PR e os passos de "Como verificar" usando o Plano de Validação do `defect.md`.
6) NÃO copie trechos de código proprietário para nenhum documento voltado ao cliente.
7) Se algo em `defect.md` for ambíguo, levante perguntas e proponha suposições antes de codificar.

### Rastreabilidade
- Inclua TS######### no nome da branch, na mensagem de commit e no título/corpo do PR.
- Referencie o caminho de `defect.md` nas notas internas do PR (permitido), mas não inclua referências a código em saídas seguras para o cliente.
