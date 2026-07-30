"""
Modelo de teste de integração (pytest).

Regras (veja .bob/rules-tester/01-testador.md):
- Obrigatório quando a história afeta um "limite" (boundary): API, banco de dados,
  fila, sistema de arquivos, autenticação, jobs em segundo plano, etc.
- Faça mock das dependências externas; teste o comportamento na costura (seam).
- Mantenha os testes estáveis e rápidos (evite instabilidade de timing).

Renomeie este arquivo para: tests/integration/test_<nome_do_limite>.py
"""
import pytest
from unittest.mock import MagicMock

# Substitua pelos imports reais, ex.:
# from meu_pacote.repositorio import RepositorioDeTarefas
# from meu_pacote.servico import ServicoDeTarefas


@pytest.fixture
def dependencia_externa_mockada():
    """Mock de uma dependência externa (ex.: banco de dados, API de terceiros, fila)."""
    mock = MagicMock()
    mock.salvar.return_value = True
    mock.buscar.return_value = {"id": 1, "status": "ok"}
    return mock


class TestIntegracaoComLimiteExterno:
    def test_persistencia_grava_e_le_corretamente(self, dependencia_externa_mockada):
        # Arrange
        servico = ...  # ex.: ServicoDeTarefas(repositorio=dependencia_externa_mockada)
        dado = {"titulo": "Exemplo"}

        # Act
        resultado = ...  # ex.: servico.criar(dado)

        # Assert: comportamento no limite (boundary) foi respeitado
        dependencia_externa_mockada.salvar.assert_called_once()
        assert resultado is not None

    def test_falha_da_dependencia_externa_e_tratada_com_seguranca(self, dependencia_externa_mockada):
        # Simula falha da dependência externa (ex.: timeout, erro 500, conexão recusada)
        dependencia_externa_mockada.salvar.side_effect = ConnectionError("timeout simulado")

        servico = ...

        with pytest.raises(Exception):
            ...  # a chamada deve propagar ou tratar o erro de forma previsível

    def test_idempotencia_ou_comportamento_de_retry_quando_aplicavel(self, dependencia_externa_mockada):
        # Se o limite suportar retry/idempotência, valide aqui.
        ...
