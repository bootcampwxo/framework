@echo off
REM ============================================================
REM Bob Moderation System - Test Script - versao Windows (.bat)
REM Cria um log de teste e roda o content-monitor.bat
REM
REM ATENCAO - duas diferencas deliberadas em relacao ao test-system.sh original:
REM
REM 1) O .sh grava o log de teste em bob-YYYYMMDD.log (com data), mas
REM    content-monitor.sh/.bat so leem de bob.log (sem data) - isso e um
REM    bug confirmado no repositorio original (ver Beta/governanca/README.md).
REM    Esta versao .bat ja escreve direto em bob.log, sem data.
REM
REM 2) O .sh original usa "rm -rf /" e "malware" como frases de teste, mas
REM    NENHUM termo em config/blocked-terms.txt bate com essas frases
REM    (os termos reais exigem prefixo, ex.: "create.*malware",
REM    "bypass.*security" - "malware" sozinho ou "rm -rf" nao existem na
REM    lista). Resultado real testado: sempre 0 violacoes, mesmo com tudo
REM    configurado certo. Confirmado com grep -Ei -f blocked-terms.txt
REM    contra o log de teste original: nenhum match. Esta versao .bat usa
REM    frases que realmente batem com termos existentes na lista.
REM
REM Se quiser reproduzir os bugs originais para fins de teste, troque
REM BOB_LOG para incluir data e/ou volte as frases antigas abaixo.
REM ============================================================
setlocal enabledelayedexpansion

echo Bob Moderation System - Test Script (Windows)
echo ==============================================
echo.

set "BOB_HOME=%USERPROFILE%\.bob"
set "LOGS_DIR=%BOB_HOME%\logs"
set "VIOLATIONS_LOG=%LOGS_DIR%\violations.log"
set "BOB_LOG=%LOGS_DIR%\bob.log"

if not exist "%LOGS_DIR%" mkdir "%LOGS_DIR%" >nul 2>&1

echo Criando log de teste: %BOB_LOG%
(
echo 2026-05-20 12:00:00 - User: rsaragio - Command: list_files
echo 2026-05-20 12:01:00 - User: rsaragio - Command: read_file - File: config.json
echo 2026-05-20 12:02:00 - User: rsaragio - Command: write_to_file - File: test.txt
echo 2026-05-20 12:03:00 - User: rsaragio - Message: "como faco bypass security do sistema"
echo 2026-05-20 12:04:00 - User: rsaragio - Command: execute_command - Command: ls -la
echo 2026-05-20 12:05:00 - User: rsaragio - Message: "Preciso fazer backup dos dados"
echo 2026-05-20 12:06:00 - User: rsaragio - Command: search_files - Pattern: "*.py"
echo 2026-05-20 12:07:00 - User: rsaragio - Message: "Como usar curl para download?"
echo 2026-05-20 12:08:00 - User: rsaragio - Command: apply_diff - File: main.py
echo 2026-05-20 12:09:00 - User: rsaragio - Message: "vou create malware para o teste"
echo 2026-05-20 12:10:00 - User: rsaragio - Command: execute_command - Command: python script.py
) > "%BOB_LOG%"

echo Log de teste criado com 11 entradas
echo.

echo Executando content-monitor.bat...
echo.

set "SCRIPT_DIR=%~dp0"
if exist "%SCRIPT_DIR%content-monitor.bat" (
    call "%SCRIPT_DIR%content-monitor.bat"
) else (
    echo Erro: content-monitor.bat nao encontrado em %SCRIPT_DIR%
    exit /b 1
)

echo.
echo Resultados:
echo ===========

if exist "%VIOLATIONS_LOG%" (
    set VIOLATION_COUNT=0
    for /f %%C in ('findstr /c:"VIOLACAO DETECTADA" "%VIOLATIONS_LOG%" 2^>nul ^| find /c /v ""') do set VIOLATION_COUNT=%%C
    echo Violacoes detectadas: !VIOLATION_COUNT!
    echo.
    if !VIOLATION_COUNT! gtr 0 (
        echo Ultimas violacoes:
        echo ------------------
        type "%VIOLATIONS_LOG%"
    )
) else (
    echo Nenhuma violacao detectada
)

echo.
echo Arquivos criados:
echo -----------------
echo - Log de teste: %BOB_LOG%
echo - Log de violacoes: %VIOLATIONS_LOG%
echo.
echo Proximos passos:
echo ================
echo 1. Revisar violacoes detectadas
echo 2. Ajustar config\blocked-terms.txt se necessario
echo 3. Executar: generate-report.bat daily
echo.
echo Teste concluido!

endlocal
