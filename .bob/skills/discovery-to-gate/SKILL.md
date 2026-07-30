# Skill: Descoberta → Portão (🔭)

## Objetivo
Transformar uma ideia de produto em estágio inicial em um pacote de Descoberta estruturado e parar no portão de aprovação humana de Descoberta antes de o trabalho de PRD/backlog começar.

## Quando usar
- Descoberta de novo produto ou nova funcionalidade importante
- Desejo do cliente ainda pouco claro que precisa de enquadramento do problema + escopo de MVP
- Antes de o Product Owner criar `prd/<CHAVE_DO_ITEM>.md`

## Entradas
- Prompt do usuário (desejo do cliente / declaração do problema)
- Se presente: `gates/CURRENT_WORK_ITEM.md` (chave de item de trabalho preferida)
- Se presente: quaisquer notas existentes em `discovery/work-items/<CHAVE_DO_ITEM>/`

## Pré-condições / Verificações (OBRIGATÓRIO)
1) Determine a `<CHAVE_DO_ITEM>` usando a prioridade:
   - `gates/CURRENT_WORK_ITEM.md`
   - chave fornecida pelo usuário
   - chave derivada `FEAT-<kebab-case>` (registre como suposição)
2) Confirme se a comparação competitiva foi solicitada:
   - Se SIM → produza `competitive-landscape.md` com citações + "Última verificação: AAAA-MM-DD"
   - Se NÃO → pule esta etapa

## Passos (OBRIGATÓRIO)
1) **Entrada & normalização**
   - Extraia o problema, os usuários-alvo, as restrições e os resultados desejados.
   - Se faltarem detalhes, adicione "Perguntas em Aberto" e prossiga com suposições claramente rotuladas.

2) **Criar/atualizar os artefatos de descoberta**
   - Escreva `discovery-brief.md` incluindo:
     - Problema
     - Usuários-alvo
     - Jobs-to-be-done
     - Proposta de valor
     - Principais hipóteses
     - Riscos/incertezas
     - Resultado do MVP
     - Perguntas em Aberto (obrigatório ao final)
   - Escreva `mvp-scope.md` incluindo:
     - Objetivos (mensuráveis)
     - Dentro do escopo
     - Fora do escopo / Não-objetivos
     - Métricas de sucesso
     - Suposições & restrições
     - Próximo passo (handoff para o PRD)

3) **Cenário competitivo (opcional)**
   - Se solicitado, escreva `competitive-landscape.md` com:
     - "Última verificação: AAAA-MM-DD"
     - 3–7 alternativas
     - Fatos (citados) vs. Inferências (raciocinadas)
     - Tabela comparativa (posicionamento, forças, lacunas)
     - Oportunidades de diferenciação
     - Riscos/implicações
     - Perguntas em Aberto + Fontes

4) **Crie o portão de Descoberta + pare**
   - Crie `gates/<CHAVE_DO_ITEM>/00-discovery.md` com:
     - Status: PENDING
     - Owner:
     - Reviewed At:
     - Notes:
   - PARE e solicite aprovação humana.

## Saídas
- Artefatos de descoberta em `discovery/work-items/<CHAVE_DO_ITEM>/`:
  - `discovery-brief.md`
  - `mvp-scope.md`
  - `competitive-landscape.md` (opcional; somente se solicitado)
- Portão:
  - `gates/<CHAVE_DO_ITEM>/00-discovery.md` (PENDING)

## Critérios de conclusão
Esta skill está concluída quando:
- os artefatos de descoberta estão escritos/atualizados, e
- o portão `00-discovery.md` existe e está PENDING, e
- o agente para e solicita aprovação com um pacote de revisão curto:
  - o que mudou
  - onde revisar
  - quais perguntas permanecem (Perguntas em Aberto)
