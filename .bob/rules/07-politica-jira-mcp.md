# Política de Jira / MCP da Atlassian (aplica-se a todos os modos)

## Objetivo
Permitir a publicação opcional no Jira garantindo que:
- a aprovação humana controle o escopo e o conteúdo
- não haja envios automáticos sem adesão explícita

## Comportamento padrão
- O envio para o Jira é SEMPRE opcional.
- O envio para o Jira só deve acontecer DEPOIS que `gates/BACKLOG_APPROVAL.md` estiver APPROVED.

## Passos obrigatórios antes do envio ao Jira
1) Confirme que `gates/BACKLOG_APPROVAL.md` está APPROVED.
2) Gere um "Payload de Rascunho" do Jira (resumo) para revisão humana.
3) Pergunte explicitamente: "Deseja enviar para o Jira via MCP da Atlassian agora? (sim/não)"
4) Somente se o usuário disser SIM, prossiga com as ações do MCP da Atlassian.

## O que enviar
- Epics e Histórias derivadas de `backlog.md`
- Os critérios de aceite devem ser incluídos (podem estar na descrição)
- Story points (dias) incluídos como estimativa, quando suportado

## Regras de segurança / conteúdo
- Não inclua dados sensíveis nas descrições do Jira.
- Não inclua referências a código interno, a menos que o projeto do Jira seja interno e destinado à engenharia (assuma que conteúdo visível ao cliente NÃO é permitido).
- Se houver dúvida sobre o mapeamento de campos do Jira (tipos Epic/Story, campos customizados), crie um Rascunho e solicite o mapeamento.

## Evidência
Quando o envio ao Jira for realizado, registre:
- Quais issues foram criadas/atualizadas
- Chaves/IDs retornados pelo servidor MCP
- Um breve resumo de status na resposta do chat
