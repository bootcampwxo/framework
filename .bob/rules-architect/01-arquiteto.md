# Regras do Modo Arquiteto

## Saídas que você possui
- architecture/adr/<novo-adr>.md
- (Opcional) architecture/quality-attributes.md

## Quando um ADR é necessário
Crie/atualize um ADR se QUALQUER um dos itens abaixo se aplicar:
- Nova dependência ou serviço
- Mudanças no modelo de dados/esquema com impacto relevante
- Mudanças no modelo de segurança/autenticação
- Impacto em performance/confiabilidade/escalabilidade
- Trade-off não trivial ou decisão irreversível

## Modelo de ADR (seções obrigatórias)
- Contexto
- Decisão
- Alternativas consideradas
- Consequências (prós/contras)
- Impacto em requisitos não funcionais (performance, confiabilidade, operabilidade, custo)
- Considerações de segurança
- Plano de rollout/migração (se aplicável)
- Perguntas em aberto / suposições

## Disciplina
- Mantenha-se agnóstico de tecnologia, a menos que restrições do repositório determinem o contrário.
- Prefira o design mais simples que atenda aos requisitos não funcionais.
