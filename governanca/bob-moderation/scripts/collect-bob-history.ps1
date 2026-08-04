# ============================================================
# Bob Moderation - Coletor de historico real (PowerShell, Windows)
#
# HISTORICO DESTA ABORDAGEM (30/07/2026):
# Tentativa 1: ler tasks/<uuid>/ui_messages.json no globalStorage do
# app ("%APPDATA%\IBM Bob\User\globalStorage\ibm.bob-code\tasks").
# Nao bateu com esta instalacao real - busca por "ui_messages.json"
# em toda a pasta "IBM Bob" nao encontrou nenhum arquivo. Esse mapa
# provavelmente vem de documentacao generica do Cline/Roo-Code (base
# do Bob), nao desta build especifica da IBM.
#
# Tentativa 2 (esta versao): o historico de conversas nesta instalacao
# fica dentro de um banco SQLite:
#   %USERPROFILE%\.bob\db\bob.db (+ bob.db-wal, bob.db-shm)
# Sem uma ferramenta de SQLite instalada (nada de Python nem instalar
# software extra), nao da pra rodar SQL contra esse arquivo. Em vez
# disso, extraimos qualquer texto legivel direto dos bytes do banco -
# a mesma ideia do comando Unix "strings". Isso e suficiente pra
# detectar se um termo bloqueado aparece em algum lugar do banco, mesmo
# sem entender o schema interno.
#
# Limitacoes conhecidas desta abordagem:
# - Nao da pra saber em qual conversa/timestamp exato o termo apareceu
#   - fica "achou en algum lugar do banco", nao "achou na conversa X
#   as 14:32". Para isso seria preciso um leitor de SQLite de verdade.
# - Texto com acentuacao (a,e,a,c etc.) pode cortar no meio, porque
#   UTF-8 multibyte sai da faixa ASCII imprimivel usada aqui - isso NAO
#   afeta a deteccao dos termos de blocked-terms.txt, que sao todos em
#   ingles sem acento (create.*malware, bypass.*security, etc.).
# - Le com FileShare.ReadWrite para funcionar mesmo com o Bob aberto,
#   mas se der erro de acesso, feche o Bob e rode de novo.
#
# Uso:
#   powershell -ExecutionPolicy Bypass -File collect-bob-history.ps1
#   (chamado automaticamente por run-full-audit.bat)
# ============================================================

$ErrorActionPreference = "Stop"

function Get-PrintableStrings {
    param([string]$Path, [int]$MinLength = 6)

    if (-not (Test-Path $Path)) { return @() }

    $stream = [System.IO.File]::Open($Path, [System.IO.FileMode]::Open, [System.IO.FileAccess]::Read, [System.IO.FileShare]::ReadWrite)
    try {
        $bytes = New-Object byte[] $stream.Length
        [void]$stream.Read($bytes, 0, $bytes.Length)
    } finally {
        $stream.Close()
    }

    # ISO-8859-1 (Latin1) = 1 byte -> 1 char, preserva todos os bytes
    # sem lancar erro de encoding invalido (o que UTF8 faria em dados
    # binarios). Usamos GetEncoding("ISO-8859-1") em vez da propriedade
    # estatica [System.Text.Encoding]::Latin1 porque essa propriedade
    # so existe no PowerShell 7+ (.NET moderno) - no PowerShell padrao
    # do Windows (5.1, .NET Framework) ela nao existe e retorna null.
    $latin1 = [System.Text.Encoding]::GetEncoding("ISO-8859-1")
    $text = $latin1.GetString($bytes)
    $pattern = "[\x20-\x7E]{$MinLength,}"
    [regex]::Matches($text, $pattern) | ForEach-Object { $_.Value }
}

$bobHome = Join-Path $env:USERPROFILE ".bob"
$dbDir = Join-Path $bobHome "db"

$dbFiles = @(
    (Join-Path $dbDir "bob.db"),
    (Join-Path $dbDir "bob.db-wal")
) | Where-Object { Test-Path $_ }

if ($dbFiles.Count -eq 0) {
    Write-Host "ERRO: nao encontrei $dbDir\bob.db nem $dbDir\bob.db-wal."
    Write-Host "Confira se o Bob ja foi usado nesta maquina (o banco e criado no primeiro uso real)."
    exit 1
}

Write-Host "Lendo strings legiveis de:"
$dbFiles | ForEach-Object { Write-Host "  - $_" }

$allStrings = New-Object System.Collections.Generic.List[string]
foreach ($f in $dbFiles) {
    Get-PrintableStrings -Path $f -MinLength 6 | ForEach-Object { $allStrings.Add($_) }
}

$logsDir = Join-Path $bobHome "logs"
if (-not (Test-Path $logsDir)) {
    New-Item -ItemType Directory -Path $logsDir -Force | Out-Null
}
$bobLog = Join-Path $logsDir "bob.log"
$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$lines = $allStrings | ForEach-Object { "$ts - DB-STRING: $_" }
Set-Content -Path $bobLog -Value $lines -Encoding UTF8

Write-Host "Strings extraidas: $($allStrings.Count)"
Write-Host "bob.log atualizado: $bobLog"
Write-Host ""
Write-Host "Proximo passo: content-monitor.bat vai rodar sobre esse bob.log atualizado."
