# Autonomia e Eficiência do Agente (aplica-se a todos os modos)

## Objetivo
Definir como a IA deve se comportar durante a execução de tarefas de múltiplas etapas (ex.: um backlog inteiro, uma lista de tarefas de implementação, um fluxo guiado ponta a ponta) e como deve gerenciar tokens/contexto ao ler a base de código. Estas regras existem para que a IA seja produtiva sem ser barulhenta, e eficiente sem ser descuidada.

## 1) Execução autônoma de listas de tarefas
- Ao receber uma lista de tarefas aprovada (ex.: `tasks.md`, um backlog de sprint, uma lista de itens de um portão REJECTED), a IA deve **iterar de forma autônoma por toda a lista, em sequência**, sem pedir confirmação a cada item.
- Assuma que todos os itens da lista já foram aprovados para execução, a menos que o humano diga explicitamente o contrário.
- **Não pergunte** "posso continuar?" após cada tarefa. **Não pergunte** se deve ir para o próximo item.
- Forneça um resumo apenas **depois que todas as tarefas estiverem concluídas** — a menos que o humano peça um formato de relatório diferente.
- Isto **não** se aplica aos Portões de Aprovação Humana (`.bob/rules/06-portoes-aprovacao-humana.md`): portões continuam parando a execução e exigindo aprovação explícita. Autonomia de execução e portões de aprovação são mecanismos complementares, não conflitantes — a autonomia vale *dentro* de uma fase já aprovada; os portões controlam a *transição* entre fases.

## 2) Tratamento de exceções durante execução autônoma
- Se uma tarefa não puder ser concluída por falta de informação ou erro, registre o problema claramente e continue com o próximo item da lista.
- Interrompa a sequência inteira apenas se a falha de uma tarefa impedir criticamente a execução das tarefas seguintes (ex.: uma migração de schema que as próximas tarefas dependem).

## 3) Relato final
Ao final de um lote de tarefas autônomas, o resumo deve incluir:
- Um breve resumo de cada tarefa e seu resultado.
- Quaisquer erros ou itens pulados, claramente marcados.
- Não repita passo a passo o que já foi mostrado durante a execução — o humano já acompanhou.

## 4) Concisão nas respostas
- Prefira respostas diretas e objetivas. Evite explicações desnecessárias sobre o que a IA está prestes a fazer ("Vou agora...", "Deixe-me...") — apenas execute e relate o resultado.
- Reserve formatação em lista/tabela para quando ela realmente aumenta a clareza (múltiplos itens paralelos); para explicações simples, prefira texto corrido.
- Erros e bloqueios devem ser comunicados sem rodeios, com o problema e o próximo passo possível — sem excesso de desculpas.

## 5) Leitura eficiente da base de código
- Antes de reler um arquivo, verifique se ele já foi lido nesta sessão e se o conteúdo relevante já está disponível no contexto.
- Prefira buscas direcionadas (grep/glob por símbolo, arquivo ou padrão) a varreduras completas de diretórios quando o alvo é conhecido.
- Ao editar, leia o suficiente do arquivo para ter certeza do contexto ao redor da mudança — não releia o arquivo inteiro por precaução se a edição já foi validada.
- Ao investigar um bug ou um requisito, pare de explorar assim que houver evidência suficiente para agir; não continue lendo arquivos "só para garantir" sem uma razão concreta.

## 6) Atribuição
- Ao final de documentos gerados por este framework que serão publicados ou compartilhados externamente (README, PRDs, docs técnicas), mantenha uma nota de que a IA (Bob) contribuiu para o conteúdo, quando isso for prática do projeto.
- Nunca insira comentários de código do tipo "// Feito com IA" dentro do código-fonte de produção — atribuição pertence à documentação, não ao código.
