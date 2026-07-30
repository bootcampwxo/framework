# product-engineering/

Investigação de problemas reportados por clientes (casos TS), organizados em `TS#########/` (TS + 9 dígitos).

Arquivos obrigatórios por caso:
- `issue-summary.md`
- `investigation-prompt.md`
- `root-cause-and-fix.md` (seguro para o cliente — sem referências a código)

Arquivos condicionais/opcionais:
- `defect.md` (somente se a classificação for Defeito; apenas interno)
- `internal-analysis.md` (opcional; apenas interno)
- `evidence/` (opcional)

Modelos prontos em [`_modelos/`](_modelos/).

Veja as regras completas em [`.bob/rules-product-engineer/pe.md`](../.bob/rules-product-engineer/pe.md) e o guardrail de segurança do cliente em [`.bob/rules/05-artefatos-engenharia-de-produto.md`](../.bob/rules/05-artefatos-engenharia-de-produto.md).
