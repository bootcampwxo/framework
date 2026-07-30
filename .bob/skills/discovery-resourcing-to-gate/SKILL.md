# Skill: Recursos de Descoberta → Portão (🔭)

## Objetivo
Produzir um plano de recursos estruturado (e descrições de vaga opcionais) alinhado ao escopo de descoberta aprovado (e ao PRD/backlog, se disponível), depois parar no portão de aprovação humana de Recursos antes que qualquer ação de contratação/equipe seja considerada final.

## Quando usar
- O usuário pede planejamento de equipe/contratação
- Você precisa dimensionar a capacidade de entrega com base no escopo
- Você precisa de descrições de vaga alinhadas à stack tecnológica do workspace
- Você quer documentar necessidades de onboarding/acesso/ferramentas para novos membros de equipe

## Entradas
- Prompt do usuário (pedido de recursos/contratação)
- Artefatos de descoberta aprovados (preferencial):
  - `discovery/work-items/<CHAVE_DO_ITEM>/discovery-brief.md`
  - `discovery/work-items/<CHAVE_DO_ITEM>/mvp-scope.md`
- Se disponível para dimensionamento de carga de trabalho:
  - `prd/<CHAVE_DO_ITEM>.md`
  - `backlog/<CHAVE_DO_ITEM>.md` (totais de Story Points (Dias))
- Repositórios do workspace para inferência de stack tecnológica (arquivos de pacote/build, CI, infra)

## Pré-condições / Verificações (OBRIGATÓRIO)
1) Determine a `<CHAVE_DO_ITEM>` usando a prioridade:
   - `gates/CURRENT_WORK_ITEM.md`
   - chave fornecida pelo usuário
   - chave derivada `FEAT-<kebab-case>` (registre como suposição)
2) Se `gates/<CHAVE_DO_ITEM>/00-discovery.md` existir e não estiver APPROVED:
   - PARE e solicite a aprovação do portão de descoberta primeiro (não prossiga com recursos).
3) Identifique se o usuário quer:
   - somente planejamento de capacidade, OU
   - plano de contratação + descrições de vaga, OU
   - também um plano de onboarding/acesso/ferramentas

## Passos (OBRIGATÓRIO)
1) **Base do escopo**
   - Leia primeiro o escopo de descoberta (e o PRD/backlog, se presentes).
   - Resuma as entradas de escopo e liste as suposições.

2) **Inferir a stack técnica**
   - Inspecione o workspace para determinar as principais tecnologias:
     - runtime/frameworks (Node/React, etc.)
     - frameworks de teste
     - ferramentas de build/deploy
     - restrições de segurança/conformidade, se visíveis
   - Não adicione detalhes profundos de implementação; apenas o suficiente para os requisitos de equipe.

3) **Estimativa de carga de trabalho**
   - Se `backlog/<CHAVE_DO_ITEM>.md` existir: some os Story Points (Dias) e anote a confiança.
   - Se não houver backlog: forneça uma estimativa de faixa aproximada com confiança + suposições.
   - Anote os principais riscos que poderiam aumentar o esforço.

4) **Recomendar o formato de equipe**
   - Proponha papéis e alocações (papéis de exemplo):
     - Product Owner, Arquiteto, Desenvolvedor, Testador, Segurança, Redator de Documentação, Engenharia de Produto (opcional)
   - Inclua se os papéis são parciais/integrais e quaisquer necessidades de sequenciamento.

5) **Identificar lacunas de contratação**
   - Se a capacidade assumida atual for insuficiente:
     - liste os papéis a contratar/contratar como terceiro/emprestar
     - justifique o motivo (lacuna de capacidade vs. capacidade disponível)
     - sugira prazo e plano de onboarding

6) **Escreva os artefatos de recursos**
   - Escreva `resourcing-plan.md` com:
     - base do escopo + suposições
     - estimativa de carga de trabalho
     - tabela de formato de equipe
     - necessidades de contratação (se houver)
     - riscos/mitigações
     - Perguntas em Aberto
   - Se a contratação for necessária, crie um ou mais:
     - `job-description-<papel>.md`
     Cada um deve incluir missão, responsabilidades, habilidades necessárias (compatíveis com a stack do workspace), diferenciais e critérios de sucesso de 30/60/90 dias.
   - Se onboarding/acesso for solicitado ou implícito, escreva:
     - `onboarding-and-access.md` com necessidades de contas/ferramentas/acesso e um checklist básico de onboarding.

7) **Crie o portão de Recursos + pare**
   - Crie `gates/<CHAVE_DO_ITEM>/00-resourcing.md` com:
     - Status: PENDING
     - Owner:
     - Reviewed At:
     - Notes:
   - PARE e solicite aprovação humana.

## Saídas
- Em `discovery/work-items/<CHAVE_DO_ITEM>/`:
  - `resourcing-plan.md`
  - `job-description-<papel>.md` (opcional)
  - `onboarding-and-access.md` (opcional)
- Portão:
  - `gates/<CHAVE_DO_ITEM>/00-resourcing.md` (PENDING)

## Critérios de conclusão
Esta skill está concluída quando:
- os artefatos de recursos estão escritos/atualizados, e
- o portão `00-resourcing.md` existe e está PENDING, e
- o agente para e solicita aprovação com um pacote de revisão curto:
  - formato de equipe recomendado + necessidades de contratação
  - suposições/confiança da estimativa de carga de trabalho
  - Perguntas em Aberto / riscos
