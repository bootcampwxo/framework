# governanca/ — conteúdo de estação (instalar uma vez por máquina)

Este arquivo existe só para dar suporte ao **instalador automático** de
estação do Framework .Bob (`instalar-bob.sh` / `Instalar-Bob.ps1`). Diferente
do resto deste repositório — que é o esqueleto copiado **por projeto** — o
conteúdo aqui é instalado **uma vez por máquina de desenvolvedor**, em
`~/.bob/settings/` (ou `%USERPROFILE%\.bob\settings\` no Windows).

## O que tem aqui

### `custom_modes.yaml`

Os 12 modos (papéis de IA) do Framework .Bob, incluindo o modo de bootstrap
🔮 Oráculo, que é justamente o que clona este repositório para começar um
projeto novo. Instale copiando este arquivo para
`~/.bob/settings/custom_modes.yaml`.

## O que **não** está aqui (de propósito)

O repositório interno de origem deste framework também inclui um sistema de
bloqueio ativo de conteúdo sensível (`bob-moderation`), que **não é
espelhado publicamente aqui** porque contém uma lista de termos bloqueados —
publicar essa lista destruiria a própria utilidade dela como controle de
segurança. Se sua organização usa esse sistema, instale-o a partir do
repositório interno correspondente da sua empresa.

Isso significa que o instalador automático deste espelho público cuida
apenas dos 12 modos — o bloqueio de conteúdo, se sua organização tiver um,
continua sendo um passo manual separado.
