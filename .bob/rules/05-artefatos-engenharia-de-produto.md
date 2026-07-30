# Artefatos de Engenharia de Produto (aplica-se a todos os modos)

As saídas de Engenharia de Produto devem ser escritas em:

product-engineering/TS#########/
(onde TS######### é TS + 9 dígitos)

## Arquivos obrigatórios
- issue-summary.md
- investigation-prompt.md
- root-cause-and-fix.md

## Arquivo condicional (somente Defeito)
- defect.md
  Crie este arquivo **somente quando o resultado for classificado como Defeito**.
  Este arquivo é o registro interno de defeito pronto para o Jira e se torna a **entrada principal** para o modo Desenvolvedor implementar a correção.

## Arquivo opcional apenas interno
- internal-analysis.md
  (pode conter referências a código e caminhos de repositório; nunca compartilhado com o cliente)

## Guardrails
- Artefatos voltados ao cliente (especialmente `root-cause-and-fix.md`) NÃO DEVEM incluir trechos de código-fonte, caminhos de repositório ou nomes internos de classes/funções.
- Referências a nível de código só são permitidas em `internal-analysis.md`.
- Se `defect.md` for criado, ele é apenas interno, a menos que confirmado explicitamente o contrário.

O modo Engenharia de Produto é responsável por esses artefatos e por mantê-los consistentes e atualizados.
