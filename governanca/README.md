# governanca/ — conteúdo de estação (instalar uma vez por máquina)

Este arquivo existe só para dar suporte ao **instalador automático** de
estação do Framework .Bob (`instalar-bob.sh` / `Instalar-Bob.ps1`). Diferente
do resto deste repositório — que é o esqueleto copiado **por projeto** — o
conteúdo aqui é instalado **uma vez por máquina de desenvolvedor**, em
`~/.bob/settings/` (ou `%USERPROFILE%\.bob\settings\` no Windows).

## O que tem aqui

### `custom_modes.yaml`

Os 13 modos (papéis de IA) do Framework .Bob — incluindo o modo de bootstrap
🔮 Oráculo, que é justamente o que clona este repositório para começar um
projeto novo, e o modo 🎨 Designer (UI/UX), que cobre a fase de desenho de
interface. Instale copiando este arquivo para
`~/.bob/settings/custom_modes.yaml`.

### `bob-moderation/`

Sistema de bloqueio ativo de conteúdo sensível: política de uso aceitável,
lista de termos bloqueados (`config/blocked-terms.txt`) e scripts de
monitoramento que rodam fora do controle da IA. Publicado aqui a partir de
04/08/2026 — decisão explícita de tornar a instalação completa possível numa
máquina nova sem depender de acesso a um repositório interno, mesmo sabendo
que isso reduz a eficácia da lista de termos como segredo. Instalado em
`~/.bob/{rules,config,scripts,logs,reports}` pelo instalador automático
abaixo, com os arquivos travados como somente leitura depois de copiados
(deterrente, não garantia absoluta — ver `scripts/` para os detalhes).

### `scripts/`

`instalar-bob.sh` / `Instalar-Bob.ps1` (instalação de estação: os 13 modos +
skills + bob-moderation) e `bob-novo-projeto.sh` / `Bob-NovoProjeto.ps1`
(clona o esqueleto deste repositório para começar um projeto novo, mesma
lógica usada pelo modo Oráculo).
