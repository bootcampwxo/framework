# Skill: Estabelecer/Emendar a Constituição do Projeto

## Objetivo
Criar (na primeira vez) ou emendar (nas vezes seguintes) `architecture/constituicao.md` — o conjunto de princípios não-negociáveis que vincula todos os modos do Framework .Bob. Ver `.bob/rules/08-constituicao-do-projeto.md` para as regras completas.

## Quando usar
- Início de um novo projeto/workspace, antes do primeiro PRD.
- Quando um princípio fundamental precisa mudar (ex.: nova política de segurança, nova stack aprovada).
- Quando um portão (`.bob/rules/06-portoes-aprovacao-humana.md`) é REJECTED por violar um princípio ainda não documentado — sinal de que a constituição está incompleta.

## Passos

### Se `architecture/constituicao.md` NÃO existir (bootstrap)
1. Pergunte ao humano: *"Quais princípios de engenharia, qualidade, arquitetura e segurança são inegociáveis neste projeto?"*
2. Copie `architecture/modelo-constituicao.md` para `architecture/constituicao.md`.
3. Preencha cada seção com os princípios fornecidos, mais quaisquer princípios adicionais claramente necessários (recomende-os, não os invente silenciosamente).
4. Marque `Versão: 1.0.0`, `Ratificada em: <data de hoje>`, `Última emenda: <data de hoje>`.
5. Verifique se `.bob/rules/03-definicao-de-pronto.md` e os principais modelos (`_modelos/`) permanecem consistentes com os novos princípios; se não, sinalize a inconsistência ao humano.
6. Relate o que foi criado e siga para a fase normal (Descoberta ou PRD).

### Se `architecture/constituicao.md` JÁ existir (emenda)
1. Identifique qual princípio está sendo alterado, adicionado ou removido.
2. Determine o tipo de mudança: MAJOR (mudança/remoção incompatível), MINOR (novo princípio) ou PATCH (esclarecimento).
3. Atualize a versão de acordo, e atualize `Última emenda` para a data de hoje (mantenha `Ratificada em` inalterado).
4. Edite apenas `architecture/constituicao.md` — este modo não deve editar PRDs, ADRs ou código diretamente.
5. Verifique e relate quais outros artefatos (`.bob/rules/*`, modelos, ADRs existentes) podem precisar de revisão por causa da emenda. Não os edite automaticamente; apenas sinalize.
6. Pare e peça confirmação humana antes de considerar a emenda finalizada — mudanças constitucionais sempre exigem aprovação explícita, mesmo fora do fluxo formal de portões.

## Saídas
- `architecture/constituicao.md` (criado ou emendado)
- Um resumo do impacto da mudança (quais outros artefatos podem precisar de revisão)
