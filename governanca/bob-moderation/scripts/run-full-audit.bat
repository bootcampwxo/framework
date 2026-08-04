@echo off
REM ============================================================
REM Bob Moderation - Auditoria completa (Windows)
REM
REM Roda os dois passos que faltavam pra auditoria funcionar com
REM dados reais:
REM   1) collect-bob-history.ps1 - extrai texto legivel direto do
REM      banco SQLite onde o Bob guarda o historico de verdade
REM      (%USERPROFILE%\.bob\db\bob.db / bob.db-wal) e regrava
REM      %USERPROFILE%\.bob\logs\bob.log com esse conteudo (tecnica
REM      tipo "strings" - nao precisa de ferramenta de SQLite nem
REM      Python instalado, so PowerShell puro).
REM   2) content-monitor.bat - roda a deteccao de sempre (regex
REM      contra config\blocked-terms.txt) sobre esse bob.log
REM      atualizado.
REM
REM Este e o script pra agendar no Agendador de Tarefas do Windows
REM (equivalente ao cron do content-monitor.sh original) - agendar
REM ESTE arquivo, nao o content-monitor.bat sozinho, senao ele vai
REM continuar rodando sobre um bob.log desatualizado ou vazio.
REM ============================================================
setlocal

set "SCRIPT_DIR=%~dp0"

echo ============================================
echo Bob Moderation - Auditoria completa
echo ============================================
echo.

echo [1/2] Coletando historico real das conversas...
powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT_DIR%collect-bob-history.ps1"

if %errorlevel% neq 0 (
    echo ERRO: falha ao coletar historico. Abortando antes do content-monitor.
    exit /b 1
)

echo.
echo [2/2] Rodando content-monitor.bat...
echo.
call "%SCRIPT_DIR%content-monitor.bat"

echo.
echo Auditoria completa concluida.

endlocal
