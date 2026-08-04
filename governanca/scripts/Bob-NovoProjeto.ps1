<#
.SYNOPSIS
  Cria um projeto novo a partir do esqueleto cacheado por Instalar-Bob.ps1
  (Windows).

.DESCRIPTION
  Este script é o equivalente "de linha de comando" do modo Oráculo -- útil
  quando você quer criar o esqueleto sem depender da IA/IDE primeiro, ou quer
  automatizar isso (ex.: num script de onboarding de time). Diferente do
  Oráculo, ele não baixa nada da rede -- usa o cache já instalado em
  %USERPROFILE%\.bob\templates\desenvolvimento\.

  Pré-requisito: já ter rodado .\Instalar-Bob.ps1 nesta máquina.

.PARAMETER NomeDoProjeto
  Nome da pasta do projeto novo, criada no diretório atual.

.EXAMPLE
  # Repositório já clonado localmente
  .\Bob-NovoProjeto.ps1 meu-projeto

.EXAMPLE
  # Direto da URL, sem baixar nada como arquivo antes: baixa o texto do
  # script, cria um scriptblock a partir dele e invoca passando o nome do
  # projeto como argumento posicional (que o bloco "param()" abaixo recebe
  # normalmente).
  $ib = irm https://raw.githubusercontent.com/bootcampwxo/framework/main/governanca/scripts/Bob-NovoProjeto.ps1
  & ([scriptblock]::Create($ib)) meu-projeto
#>

param(
    [Parameter(Mandatory = $true)]
    [string]$NomeDoProjeto
)

$ErrorActionPreference = "Stop"
# Evita que o PowerShell 7.3+ trate mensagens normais de progresso do git em
# stderr como erro fatal mesmo quando o comando teve sucesso.
$global:PSNativeCommandUseErrorActionPreference = $false

$TemplateDir = Join-Path $env:USERPROFILE ".bob\templates\desenvolvimento"

if (-not (Test-Path $TemplateDir)) {
    Write-Host "ERRO: $TemplateDir não existe."
    Write-Host "Rode .\Instalar-Bob.ps1 primeiro (uma vez por máquina)."
    exit 1
}

if (Test-Path $NomeDoProjeto) {
    Write-Host "ERRO: já existe algo chamado '$NomeDoProjeto' no diretório atual."
    exit 1
}

Write-Host "==> Criando $NomeDoProjeto\ a partir do esqueleto cacheado"
New-Item -ItemType Directory -Path $NomeDoProjeto | Out-Null
Copy-Item -Path (Join-Path $TemplateDir "*") -Destination $NomeDoProjeto -Recurse -Force

Push-Location $NomeDoProjeto
try {
    if (-not (Test-Path ".git")) {
        $gitEmail = git config user.email 2>$null
        if (-not $gitEmail) {
            $gitEmail = git config --global user.email 2>$null
        }
        if (-not $gitEmail) {
            Write-Host "AVISO: git não tem 'user.email'/'user.name' configurados globalmente. Configure com:"
            Write-Host '  git config --global user.email "voce@empresa.com"'
            Write-Host '  git config --global user.name "Seu Nome"'
            Write-Host "antes de continuar, senão o commit de bootstrap abaixo vai falhar."
        }
        git init --quiet
        git add -A
        git commit --quiet -m "chore: bootstrap inicial via Bob-NovoProjeto"
        if ($LASTEXITCODE -ne 0) {
            throw "git commit falhou (código de saída $LASTEXITCODE) -- verifique se 'user.email'/'user.name' estão configurados (ver aviso acima)."
        }
        Write-Host "==> Repositório git inicializado com o commit de bootstrap."
    }
    else {
        Write-Host "==> Já existe um .git aqui -- pulei o git init."
    }
}
finally {
    Pop-Location
}

Write-Host ""
Write-Host "Projeto '$NomeDoProjeto' pronto."
Write-Host ""
Write-Host "Próximos passos:"
Write-Host "  1. Abra a pasta '$NomeDoProjeto' na sua IDE (File > Open Folder), se ainda não estiver nela."
Write-Host "  2. Troque manualmente para o modo Governança no seletor de modos."
Write-Host "  3. Escreva esta mensagem para dar início ao processo:"
Write-Host '     "estabelecer a constituição do projeto (princípios de engenharia, qualidade, arquitetura e segurança)"'
