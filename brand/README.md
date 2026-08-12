# brand/

Assets oficiais de identidade visual do produto — versionados no repositório para que o modo 🎨 Designer nunca precise aproximar, recriar ou "adivinhar" logo, cor ou tipografia.

## Organização sugerida

- `logos/` — arquivos de logo oficiais (SVG/PNG em alta resolução, variações de cor/fundo).
- `paleta-de-cores/` — paleta oficial (hex/RGB), com o papel semântico de cada cor, se já definido (ação primária, sucesso, aviso, erro, etc.).
- `tipografia/` — arquivos de fonte e respectivas licenças de uso.
- `icones/` — conjunto de ícones oficiais da marca (quando distinto do design system usado, ex.: Carbon, Material).
- Um PDF ou link do manual de marca completo, se existir.

## Se o produto ainda não tem marca própria

Esta pasta pode ficar vazia (só com este `README.md`). O modo Designer vai trabalhar apenas com os tokens padrão do design system escolhido (ex.: Carbon, Material, Tailwind) até que uma identidade visual própria seja definida — e vai declarar isso explicitamente na especificação de design, em vez de inventar uma marca.

## Como isso se conecta ao fluxo

A pré-checagem obrigatória do modo Designer (item "Assets de marca" em [`.bob/rules-designer/01-designer.md`](../.bob/rules-designer/01-designer.md)) inspeciona esta pasta **antes** de propor qualquer token, cor, ícone ou componente novo — ver também o playbook [`.bob/skills/design-ui-gate/SKILL.md`](../.bob/skills/design-ui-gate/SKILL.md) (Modo A — Especificar).

**Regra do modo Designer**: "identidade não se aproxima, se referencia" — logo, ícone e ilustração vêm sempre de arquivo oficial versionado aqui, nunca desenhados à mão, aproximados com CSS/texto estilizado ou gerados por IA.

Importe/commite os arquivos desta pasta **antes** de acionar o modo Designer pela primeira vez em um item de trabalho que toca interface.
