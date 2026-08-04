@echo off
REM ============================================================
REM Bob Content Monitor - versao Windows (.bat) do content-monitor.sh
REM Monitora %USERPROFILE%\.bob\logs\bob.log em busca de termos bloqueados
REM
REM Diferenca em relacao ao content-monitor.sh original: nenhuma.
REM Le sempre de bob.log (nome fixo, sem data) - igual ao .sh.
REM
REM Limitacao conhecida: os termos de config\blocked-terms.txt usam
REM regex com ".*" (ex.: "bypass.*security"), que o findstr /r suporta.
REM Termos que usem "|", "()" ou "+" NAO sao suportados pelo findstr
REM (regex limitado) - se algum termo assim for adicionado, este script
REM precisaria ser reescrito em PowerShell.
REM ============================================================
setlocal enabledelayedexpansion

set "BOB_HOME=%USERPROFILE%\.bob"
set "CONFIG_DIR=%BOB_HOME%\config"
set "LOGS_DIR=%BOB_HOME%\logs"
set "SCRIPTS_DIR=%BOB_HOME%\scripts"
set "BLOCKED_TERMS=%CONFIG_DIR%\blocked-terms.txt"
set "VIOLATIONS_LOG=%LOGS_DIR%\violations.log"
set "BOB_LOG=%LOGS_DIR%\bob.log"

if not exist "%LOGS_DIR%" mkdir "%LOGS_DIR%" >nul 2>&1
type nul >> "%VIOLATIONS_LOG%"

for /f %%i in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm:ss\")"') do set "NOW=%%i"

if not exist "%BOB_LOG%" (
    echo %NOW% - Nenhum log encontrado
    echo.
    echo Para testar o sistema, crie um log de teste:
    echo.
    echo   echo teste ^>^> "%BOB_LOG%"
    echo   content-monitor.bat
    echo.
    exit /b 0
)

if not exist "%BLOCKED_TERMS%" (
    echo Lista de termos bloqueados nao encontrada: %BLOCKED_TERMS%
    exit /b 1
)

set violations_found=0

for /f "usebackq delims=" %%L in ("%BLOCKED_TERMS%") do (
    set "line=%%L"
    if not "!line!"=="" (
        if not "!line:~0,1!"=="#" (
            findstr /r /i "!line!" "%BOB_LOG%" >nul 2>&1
            if !errorlevel! equ 0 (
                set /a violations_found+=1
                echo %NOW% - VIOLACAO DETECTADA: !line! >> "%VIOLATIONS_LOG%"
                findstr /r /i "!line!" "%BOB_LOG%" >> "%VIOLATIONS_LOG%"
                echo --- >> "%VIOLATIONS_LOG%"
            )
        )
    )
)

if !violations_found! gtr 0 (
    echo AVISO: !violations_found! violacao^(oes^) detectada^(s^)
    echo Detalhes em: %VIOLATIONS_LOG%

    if exist "%SCRIPTS_DIR%\send-alert.bat" (
        call "%SCRIPTS_DIR%\send-alert.bat" !violations_found!
    )
) else (
    echo OK: Nenhuma violacao detectada
)

endlocal
