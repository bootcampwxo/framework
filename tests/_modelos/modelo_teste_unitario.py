"""
Modelo de teste unitário (pytest).

Regras (veja .bob/rules-tester/01-testador.md):
- Cobrir nova lógica de negócio, transições de estado, regras de validação,
  tratamento de erro e lógica de persistência (mockada).
- Testes determinísticos: sem rede, sem dependência de tempo real.
- Um teste de regressão para cada bug corrigido (falha antes, passa depois).

Renomeie este arquivo para: tests/unit/test_<nome_da_funcionalidade>.py
"""
import pytest

# Substitua pelo import real do módulo que está sendo testado, ex.:
# from meu_pacote.minha_funcionalidade import calcular_total


class TestNomeDaFuncionalidade:
    """Agrupe os testes de uma mesma unidade de código em uma classe (opcional, mas organiza bem)."""

    def test_caminho_feliz_retorna_resultado_esperado(self):
        # Arrange (organizar): prepare as entradas e o estado inicial
        entrada = ...

        # Act (agir): execute a unidade de código sob teste
        resultado = ...  # ex.: calcular_total(entrada)

        # Assert (verificar): confirme o resultado esperado
        assert resultado == ...

    def test_entrada_invalida_levanta_erro_de_validacao(self):
        entrada_invalida = ...

        with pytest.raises(ValueError):
            ...  # ex.: calcular_total(entrada_invalida)

    def test_caso_de_borda_lista_vazia(self):
        # Cubra explicitamente os casos de borda conhecidos (vazio, nulo, limite, duplicado)
        entrada = []

        resultado = ...

        assert resultado == ...

    def test_regressao_bug_ts000000000(self):
        """
        Teste de regressão.
        Contexto: descreva o bug corrigido e o cenário que antes falhava.
        Este teste deve falhar na versão anterior à correção e passar depois dela.
        """
        entrada_que_antes_quebrava = ...

        resultado = ...

        assert resultado == ...
