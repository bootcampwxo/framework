<#
.SYNOPSIS
  Instalação automatizada de estação do Framework .Bob (Windows).

.DESCRIPTION
  Rode uma vez por máquina de desenvolvedor:
    1. Clona o espelho público do framework (bootcampwxo/framework) num
       diretório temporário -- sem autenticação, funciona de qualquer rede.
    2. Instala os 12 modos (custom_modes.yaml) em
       %USERPROFILE%\.bob\settings\ -- nunca sobrescreve às cegas: se já
       existir um arquivo lá, tenta mesclar com segurança (usando Python,
       se disponível) ou faz backup antes de sobrescrever.
    3. Guarda uma cópia do esqueleto "por projeto" em
       %USERPROFILE%\.bob\templates\desenvolvimento\, para uso pelo script
       irmão Bob-NovoProjeto.ps1.

  NÃO instala o bloqueio ativo de conteúdo (bob-moderation). Esse sistema
  não é publicado no espelho público de propósito (contém uma lista de
  termos bloqueados). Se sua organização usa isso, instale a partir do
  repositório interno correspondente.

.EXAMPLE
  # Repositório já clonado localmente
  .\Instalar-Bob.ps1

.EXAMPLE
  # Direto da URL, sem baixar nada antes (mesmo efeito) -- "irm" = Invoke-RestMethod, "iex" = Invoke-Expression
  irm https://raw.githubusercontent.com/bootcampwxo/framework/main/governanca/scripts/Instalar-Bob.ps1 | iex
#>

$ErrorActionPreference = "Stop"
# Evita que o PowerShell 7.3+ trate mensagens normais de progresso do git em
# stderr (ex.: "Cloning into '...'...") como erro fatal mesmo quando o
# comando teve sucesso -- julgamos sucesso/falha só por $LASTEXITCODE abaixo.
$global:PSNativeCommandUseErrorActionPreference = $false

$MirrorUrl = "https://github.com/bootcampwxo/framework.git"
$MirrorRawBase = "https://raw.githubusercontent.com/bootcampwxo/framework/main"
$BobHome = Join-Path $env:USERPROFILE ".bob"
$SettingsDir = Join-Path $BobHome "settings"
$TemplatesDir = Join-Path $BobHome "templates\desenvolvimento"
$TmpDir = Join-Path ([System.IO.Path]::GetTempPath()) ("bob-install-" + [System.Guid]::NewGuid().ToString("N"))

function Remove-TmpDir {
    if (Test-Path $TmpDir) {
        Remove-Item -Recurse -Force $TmpDir -ErrorAction SilentlyContinue
    }
}

try {
    Write-Host "==> Clonando o espelho público do Framework .Bob ($MirrorUrl)..."
    git clone --quiet --depth 1 $MirrorUrl $TmpDir
    if ($LASTEXITCODE -ne 0) {
        throw "git clone falhou (código de saída $LASTEXITCODE). Verifique sua conexão com github.com."
    }

    if (-not (Test-Path (Join-Path $TmpDir ".bob"))) {
        throw "O clone terminou mas não parece ter o conteúdo esperado (.bob ausente)."
    }

    Write-Host "==> Instalando os 12 modos em $SettingsDir\custom_modes.yaml"
    New-Item -ItemType Directory -Force -Path $SettingsDir | Out-Null

    $NewModes = Join-Path $TmpDir "governanca\custom_modes.yaml"
    $DestModes = Join-Path $SettingsDir "custom_modes.yaml"

    if (-not (Test-Path $NewModes)) {
        throw "$NewModes não encontrado no espelho -- o espelho pode estar desatualizado ou incompleto."
    }

    if (Test-Path $DestModes) {
        $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
        if (-not $pythonCmd) { $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue }

        $mergeOk = $false
        if ($pythonCmd) {
            & $pythonCmd.Path -c "import yaml" 2>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "    Já existe um custom_modes.yaml em $DestModes -- mesclando com segurança (Python + PyYAML disponíveis)."
                $mergeScript = Join-Path $TmpDir "merge_modes.py"
                @'
import sys, yaml, shutil, datetime

dest_path, new_path = sys.argv[1], sys.argv[2]

with open(dest_path, encoding="utf-8") as fh:
    dest = yaml.safe_load(fh) or {"customModes": []}
with open(new_path, encoding="utf-8") as fh:
    new = yaml.safe_load(fh)

dest_modes = dest.get("customModes", []) or []
dest_slugs = {m["slug"] for m in dest_modes}
new_modes = new["customModes"]

conflicts = [m["slug"] for m in new_modes if m["slug"] in dest_slugs]
if conflicts:
    backup = f"{dest_path}.backup-{datetime.datetime.now():%Y%m%d%H%M%S}"
    shutil.copy(dest_path, backup)
    print(f"    Slugs já existentes encontrados ({', '.join(conflicts)}) -- "
          f"substituindo pela versão nova do framework nesses slugs. "
          f"Backup salvo em {backup}.")
    dest_modes = [m for m in dest_modes if m["slug"] not in conflicts]

dest_modes.extend(new_modes)
dest["customModes"] = dest_modes

with open(dest_path, "w", encoding="utf-8") as fh:
    yaml.dump(dest, fh, allow_unicode=True, default_flow_style=False, sort_keys=False, width=1000)

print(f"    OK: {len(new_modes)} modo(s) mesclado(s) em {dest_path} (total agora: {len(dest_modes)}).")
'@ | Set-Content -Path $mergeScript -Encoding UTF8

                & $pythonCmd.Path $mergeScript $DestModes $NewModes
                if ($LASTEXITCODE -eq 0) {
                    $mergeOk = $true
                } else {
                    Write-Host "    AVISO: a mesclagem via Python falhou -- caindo para backup + substituição total."
                }
            }
        }

        if (-not $mergeOk) {
            $Backup = "$DestModes.backup-$(Get-Date -Format 'yyyyMMddHHmmss')"
            Write-Host "    Já existe um custom_modes.yaml em $DestModes (Python/PyYAML indisponível ou mesclagem falhou)."
            Write-Host "    Fazendo backup em $Backup e SUBSTITUINDO o arquivo inteiro -- se você tinha"
            Write-Host "    modos customizados próprios além dos 12 do framework, recupere-os do backup"
            Write-Host "    e adicione manualmente ao novo arquivo."
            Copy-Item $DestModes $Backup
            Copy-Item $NewModes $DestModes -Force
        }
    } else {
        Copy-Item $NewModes $DestModes
        Write-Host "    OK: nenhum arquivo existia antes -- instalado do zero."
    }

    Write-Host "==> Guardando o esqueleto de projeto em $TemplatesDir"
    if (Test-Path $TemplatesDir) {
        Remove-Item -Recurse -Force $TemplatesDir
    }
    New-Item -ItemType Directory -Force -Path $TemplatesDir | Out-Null

    Get-ChildItem -Path $TmpDir -Force | Where-Object { $_.Name -ne ".git" -and $_.Name -ne "governanca" } | ForEach-Object {
        Copy-Item -Path $_.FullName -Destination $TemplatesDir -Recurse -Force
    }

    Write-Host ""
    Write-Host "Instalação concluída."
    Write-Host ""
    Write-Host "Confira no seletor de modos da sua IDE: devem aparecer os 12 modos do"
    Write-Host "Framework .Bob, incluindo Oráculo (reinicie a IDE se necessário)."
    Write-Host ""
    Write-Host "Para criar um projeto novo a partir do esqueleto cacheado, rode (no"
    Write-Host "diretório onde o novo projeto deve nascer):"
    Write-Host "  `$ib = irm $MirrorRawBase/governanca/scripts/Bob-NovoProjeto.ps1"
    Write-Host "  & ([scriptblock]::Create(`$ib)) <nome-do-projeto>"
    Write-Host ""
    Write-Host "Bloqueio ativo de conteúdo (bob-moderation) NÃO foi instalado por este"
    Write-Host "script -- esse sistema não é publicado no espelho público de propósito."
    Write-Host "Se sua organização usa isso, instale a partir do repositório interno."
}
finally {
    Remove-TmpDir
}
