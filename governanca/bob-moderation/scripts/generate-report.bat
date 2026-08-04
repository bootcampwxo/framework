@echo off
REM ============================================================
REM Bob Report Generator - versao Windows (.bat) do generate-report.sh
REM Gera relatorio de conformidade em %USERPROFILE%\.bob\reports\
REM
REM Uso: generate-report.bat [daily|weekly|monthly]
REM ============================================================
setlocal enabledelayedexpansion

set "BOB_HOME=%USERPROFILE%\.bob"
set "LOGS_DIR=%BOB_HOME%\logs"
set "REPORTS_DIR=%BOB_HOME%\reports"
set "VIOLATIONS_LOG=%LOGS_DIR%\violations.log"

if not exist "%REPORTS_DIR%" mkdir "%REPORTS_DIR%" >nul 2>&1

set "PERIOD=%~1"
if "%PERIOD%"=="" set "PERIOD=weekly"

if /i "%PERIOD%"=="daily" (
    set DAYS=1
) else if /i "%PERIOD%"=="weekly" (
    set DAYS=7
) else if /i "%PERIOD%"=="monthly" (
    set DAYS=30
) else (
    echo Uso: generate-report.bat [daily^|weekly^|monthly]
    exit /b 1
)

for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyyMMdd\")"') do set "TODAY=%%i"
for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set "NOW=%%i"

set "REPORT_FILE=%REPORTS_DIR%\compliance-report-%TODAY%.md"

(
echo # Relatorio de Conformidade - Bob
echo.
echo **Periodo:** Ultimos %DAYS% dias
echo **Gerado em:** %NOW%
echo.
echo ## Resumo Executivo
echo.
) > "%REPORT_FILE%"

if exist "%VIOLATIONS_LOG%" (
    set TOTAL_VIOLATIONS=0
    for /f %%C in ('findstr /c:"VIOLACAO DETECTADA" "%VIOLATIONS_LOG%" 2^>nul ^| find /c /v ""') do set TOTAL_VIOLATIONS=%%C

    (
    echo - **Total de violacoes ^(historico^):** !TOTAL_VIOLATIONS!
    echo.
    echo ## Detalhes das Violacoes
    echo.
    ) >> "%REPORT_FILE%"

    type "%VIOLATIONS_LOG%" >> "%REPORT_FILE%"
) else (
    (
    echo - **Total de violacoes:** 0
    echo - **Status:** Nenhuma violacao detectada
    echo.
    ) >> "%REPORT_FILE%"
)

(
echo.
echo ## Recomendacoes
echo.
echo 1. Revisar politica de uso aceitavel com equipe
echo 2. Atualizar lista de termos bloqueados conforme necessario
echo 3. Verificar configuracao de alertas
echo.
echo ---
echo *Relatorio gerado automaticamente pelo Bob Content Moderation System*
) >> "%REPORT_FILE%"

echo Relatorio gerado: %REPORT_FILE%
echo.
type "%REPORT_FILE%"

endlocal
