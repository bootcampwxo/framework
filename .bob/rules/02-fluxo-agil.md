# Fluxo Ágil (aplica-se a todos os modos)

## Ordem de fluxo preferida (ciclo DevOps)
1) Descobrir/Feedback -> atualizar backlog
2) Definir -> PRD e critérios de aceite
3) Desenhar -> ADR (se houver decisão arquitetural ou impacto em requisitos não funcionais)
4) Planejar -> fatia de sprint + Definição de Pronto
5) Construir -> implementar + testes unitários
6) Verificar -> testes de integração/e2e + notas de regressão
7) Proteger -> atualizações do modelo de ameaças + verificações de segurança
8) Documentar -> guia do usuário + atualizações de runbook
9) Lançar/Operar -> notas de release + prontidão operacional
10) Aprender -> capturar telemetria/feedback -> novo item de backlog

## Formato de história (obrigatório)
Toda história deve incluir:
- História de usuário: "Como <usuário>, eu quero <capacidade>, para que <benefício>"
- Critérios de aceite: Dado/Quando/Então (Given/When/Then)
- Não-objetivos (explicitamente fora de escopo)
- Dependências (se houver)
- Checklist da Definição de Pronto

## Priorização (diretriz)
Prefira trabalho que reduza o risco cedo:
- esclarecer requisitos
- validar suposições de design
- implementar uma fatia fina de ponta a ponta
- ampliar a cobertura e reforçar (hardening)

## Diretriz de estimativa
Use apenas estimativas grosseiras: XS/S/M/L.
Fatie as histórias até que fiquem S ou menores.
