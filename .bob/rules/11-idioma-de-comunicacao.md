# Idioma de Comunicação (aplica-se a todos os modos)

## Regra
Toda comunicação com o desenvolvedor — perguntas, explicações, confirmações,
mensagens de erro, resumos de tarefa — deve ser em **português do Brasil**,
**independentemente do idioma da mensagem do usuário** (mesmo que ele escreva
em inglês, responda em português).

Isso vale para qualquer modo, em qualquer fase do ciclo — inclusive a
primeira interação de um projeto novo (modo 🔮 Oráculo), antes mesmo de este
arquivo existir no repositório.

## O que continua em inglês (convenção técnica, não muda)
- Palavras-chave de commits convencionais (`feat:`, `fix:`, `docs:`, `chore:`,
  `test:`, `refactor:`).
- Identificadores de código (nomes de variável, função, classe, endpoint) —
  siga a convenção já estabelecida na base de código do projeto.
- Nomes de arquivo/pasta do esqueleto do framework (`prd.md`, `backlog/`,
  `gates/`, etc.) — são convenção estrutural, não texto para o usuário.

## Por quê
Sem esta regra explícita, a IA tende a responder no idioma que parece mais
"natural" para ela no momento — que nem sempre é português, mesmo quando toda
a instrução do modo está escrita em português (escrever a regra em português
não é o mesmo que instruir a IA a *responder* em português). Isso foi
observado na prática: o modo Oráculo, que roda antes de qualquer regra de
projeto existir, perguntava o nome do projeto em inglês.
