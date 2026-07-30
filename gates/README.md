# gates/

Portões de aprovação humana, organizados por item de trabalho: `gates/<CHAVE_DO_ITEM>/`.

- `CURRENT_WORK_ITEM.md` — ponteiro para o item de trabalho ativo (formato: `WorkItem: <CHAVE>`)
- `<CHAVE_DO_ITEM>/00-discovery.md` (recomendado)
- `<CHAVE_DO_ITEM>/00-resourcing.md` (opcional)
- `<CHAVE_DO_ITEM>/01-prd.md`
- `<CHAVE_DO_ITEM>/02-backlog.md`
- `<CHAVE_DO_ITEM>/03-adr.md` (se ADR criado)
- `<CHAVE_DO_ITEM>/04-sprintplan.md` (se usado)
- `<CHAVE_DO_ITEM>/05-pr.md`
- `<CHAVE_DO_ITEM>/06-release-ready.md` (opcional)

Cada arquivo de portão segue este formato (veja modelo em [`_modelos/modelo-portao.md`](_modelos/modelo-portao.md)):

```
Status: PENDING | APPROVED | REJECTED
Owner:
Reviewed At:
Notes:
```

Regras completas em [`.bob/rules/06-portoes-aprovacao-humana.md`](../.bob/rules/06-portoes-aprovacao-humana.md).
