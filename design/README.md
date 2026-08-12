# design/

Artefatos de design (UI/UX) do produto, produzidos na fase **Desenhar** e validados na fase **Verificar** do ciclo.

Organização:

- `design-system.md` — registro vivo do design system do projeto (tokens, componentes, breakpoints). Um por repositório, não por item de trabalho.
- `<CHAVE_DO_ITEM>/design-spec.md` — especificação de design do item de trabalho (obrigatória quando o item toca interface).
- `<CHAVE_DO_ITEM>/revisao-de-ui.md` — achados da revisão da UI implementada contra a especificação.

Modelos prontos para copiar estão em [`_modelos/`](_modelos/).

O portão correspondente é `gates/<CHAVE_DO_ITEM>/03-design.md`, no mesmo nível de fase do portão de ADR.

Os assets oficiais de identidade visual (logo, paleta de cores, tipografia, ícones) não ficam aqui — vivem em [`brand/`](../brand/README.md), que a pré-checagem obrigatória do Designer inspeciona antes de propor qualquer token novo.

Veja as regras completas em [`.bob/rules-designer/01-designer.md`](../.bob/rules-designer/01-designer.md) e o playbook em [`.bob/skills/design-ui-gate/SKILL.md`](../.bob/skills/design-ui-gate/SKILL.md).
