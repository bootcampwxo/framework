#!/usr/bin/env bash
# instalar-bob.sh — instalação automatizada de estação do Framework .Bob
# (macOS/Linux)
#
# O que este script faz (rode uma vez por máquina de desenvolvedor):
#   1. Clona o espelho público do framework (bootcampwxo/framework) num
#      diretório temporário — sem autenticação, funciona de qualquer rede.
#   2. Instala os 13 modos (custom_modes.yaml) em ~/.bob/settings/ — nunca
#      sobrescreve às cegas: se já existir um arquivo lá, tenta mesclar com
#      segurança (usando python3, se disponível) ou faz backup antes de
#      sobrescrever.
#   3. Instala as 10 skills (playbooks) em ~/.bob/skills/ — Global,
#      confirmado por teste real numa máquina em uso (04/08/2026): skills
#      são reconhecidas pelo Bob-IDE nesse escopo, diferente de
#      rules/rules-<papel>, que continuam por projeto (ver item 4).
#   4. Instala o bloqueio ativo de conteúdo (bob-moderation) em ~/.bob/ --
#      regra em ~/.bob/rules/moderation.md, config em ~/.bob/config/,
#      scripts em ~/.bob/scripts/, e agenda o monitoramento no cron (a cada
#      hora), se crontab estiver disponível. Publicado no espelho público a
#      partir de 04/08/2026, por decisão explícita do responsável pelo
#      framework -- ver nota em governanca/README.md sobre o trade-off
#      (a lista de termos bloqueados fica publicamente visível).
#   5. Guarda uma cópia do esqueleto "por projeto" em
#      ~/.bob/templates/desenvolvimento/ (regras universais, perfis de
#      papel, pastas de artefato — SEM as skills, já instaladas globalmente
#      no passo 3), para uso pelo script irmão bob-novo-projeto.sh.
#
# Uso (repositório já clonado localmente):
#   ./instalar-bob.sh
#
# Uso (direto da URL, sem clonar nada antes — mesmo efeito):
#   curl -fsSL https://raw.githubusercontent.com/bootcampwxo/framework/main/governanca/scripts/instalar-bob.sh | bash
#
# Este script não depende de estar rodando a partir de uma cópia local do
# repositório — ele mesmo clona o que precisa num diretório temporário. Por
# isso funciona igual rodado via `curl | bash` ou a partir do arquivo local.

set -euo pipefail

MIRROR_URL="https://github.com/bootcampwxo/framework.git"
MIRROR_RAW_BASE="https://raw.githubusercontent.com/bootcampwxo/framework/main"
BOB_HOME="$HOME/.bob"
SETTINGS_DIR="$BOB_HOME/settings"
TEMPLATES_DIR="$BOB_HOME/templates/desenvolvimento"
TMP_DIR="$(mktemp -d)"
CLONE_LOG="$(mktemp)"

cleanup() {
  rm -rf "$TMP_DIR" "$CLONE_LOG" 2>/dev/null || true
}
trap cleanup EXIT

echo "==> Clonando o espelho público do Framework .Bob ($MIRROR_URL)..."
if ! git clone --quiet --depth 1 "$MIRROR_URL" "$TMP_DIR/framework" >"$CLONE_LOG" 2>&1; then
  echo "ERRO: não foi possível clonar $MIRROR_URL"
  echo "Saída do git:"
  cat "$CLONE_LOG"
  exit 1
fi

if [ ! -d "$TMP_DIR/framework/.bob" ]; then
  echo "ERRO: o clone terminou mas não parece ter o conteúdo esperado (.bob/ ausente)."
  exit 1
fi

echo "==> Instalando os 13 modos em $SETTINGS_DIR/custom_modes.yaml"
mkdir -p "$SETTINGS_DIR"

NEW_MODES="$TMP_DIR/framework/governanca/custom_modes.yaml"
DEST_MODES="$SETTINGS_DIR/custom_modes.yaml"

if [ ! -f "$NEW_MODES" ]; then
  echo "ERRO: $NEW_MODES não encontrado no espelho — o espelho pode estar desatualizado ou incompleto."
  exit 1
fi

merge_ok=false
if [ -f "$DEST_MODES" ]; then
  if command -v python3 >/dev/null 2>&1 && python3 -c "import yaml" >/dev/null 2>&1; then
    echo "    Já existe um custom_modes.yaml em $DEST_MODES — mesclando com segurança (python3 + PyYAML disponíveis)."
    if python3 - "$DEST_MODES" "$NEW_MODES" <<'PYEOF'
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
    print(f"    Slugs já existentes encontrados ({', '.join(conflicts)}) — "
          f"substituindo pela versão nova do framework nesses slugs. "
          f"Backup do arquivo original salvo em {backup}.")
    dest_modes = [m for m in dest_modes if m["slug"] not in conflicts]

dest_modes.extend(new_modes)
dest["customModes"] = dest_modes

with open(dest_path, "w", encoding="utf-8") as fh:
    yaml.dump(dest, fh, allow_unicode=True, default_flow_style=False, sort_keys=False, width=1000)

print(f"    OK: {len(new_modes)} modo(s) do framework mesclado(s) em {dest_path} "
      f"(total agora: {len(dest_modes)} modo(s)).")
PYEOF
    then
      merge_ok=true
    else
      echo "    AVISO: a mesclagem via python3 falhou — caindo para backup + substituição total."
    fi
  fi

  if [ "$merge_ok" = false ]; then
    BACKUP="$DEST_MODES.backup-$(date +%Y%m%d%H%M%S)"
    echo "    Já existe um custom_modes.yaml em $DEST_MODES (python3/PyYAML indisponível ou mesclagem falhou)."
    echo "    Fazendo backup em $BACKUP e SUBSTITUINDO o arquivo inteiro — se você tinha"
    echo "    modos customizados próprios além dos 12 do framework, recupere-os do backup"
    echo "    e adicione manualmente ao novo arquivo."
    cp "$DEST_MODES" "$BACKUP"
    cp "$NEW_MODES" "$DEST_MODES"
  fi
else
  cp "$NEW_MODES" "$DEST_MODES"
  echo "    OK: nenhum arquivo existia antes — instalado do zero."
fi

SKILLS_SRC="$TMP_DIR/framework/.bob/skills"
SKILLS_DEST="$BOB_HOME/skills"
if [ -d "$SKILLS_SRC" ]; then
  echo "==> Instalando as 10 skills em $SKILLS_DEST (Global)"
  mkdir -p "$SKILLS_DEST"
  cp -R "$SKILLS_SRC/." "$SKILLS_DEST/"
else
  echo "AVISO: $SKILLS_SRC não encontrado no espelho — pulando instalação de skills."
fi

MODERATION_SRC="$TMP_DIR/framework/governanca/bob-moderation"
if [ -d "$MODERATION_SRC" ]; then
  echo "==> Instalando bloqueio ativo de conteúdo (bob-moderation) em $BOB_HOME"
  mkdir -p "$BOB_HOME/rules" "$BOB_HOME/config" "$BOB_HOME/scripts" "$BOB_HOME/logs" "$BOB_HOME/reports" "$BOB_HOME/db"

  # Restaura permissão de escrita antes de copiar -- necessário para que
  # rodar este instalador de novo (atualização) não falhe por causa do
  # somente-leitura aplicado no final desta seção numa instalação anterior.
  chmod u+w "$BOB_HOME/rules/moderation.md" 2>/dev/null || true
  find "$BOB_HOME/config" -maxdepth 1 -type f -exec chmod u+w {} \; 2>/dev/null || true
  find "$BOB_HOME/scripts" -maxdepth 1 -type f -exec chmod u+w {} \; 2>/dev/null || true

  if [ -f "$MODERATION_SRC/rules/moderation.md" ]; then
    cp "$MODERATION_SRC/rules/moderation.md" "$BOB_HOME/rules/moderation.md"
  fi
  if [ -d "$MODERATION_SRC/config" ]; then
    cp -R "$MODERATION_SRC/config/." "$BOB_HOME/config/"
  fi
  if [ -d "$MODERATION_SRC/scripts" ]; then
    cp -R "$MODERATION_SRC/scripts/." "$BOB_HOME/scripts/"
    chmod +x "$BOB_HOME/scripts/"*.sh 2>/dev/null || true
  fi

  # Bloqueia edição pelo usuário: regra, config e scripts viram somente
  # leitura (scripts mantêm o bit de execução, senão o cron/monitoramento
  # para de funcionar). IMPORTANTE: isso é um deterrente, não uma barreira
  # de segurança absoluta -- como o próprio usuário é dono de ~/.bob, ele
  # sempre pode rodar "chmod u+w" de novo e editar. Protege contra edição
  # casual/acidental, não contra alguém com acesso de shell disposto a
  # reverter a permissão.
  chmod 444 "$BOB_HOME/rules/moderation.md" 2>/dev/null || true
  find "$BOB_HOME/config" -maxdepth 1 -type f -exec chmod 444 {} \; 2>/dev/null || true
  find "$BOB_HOME/scripts" -maxdepth 1 -type f -name "*.sh" -exec chmod 555 {} \; 2>/dev/null || true
  find "$BOB_HOME/scripts" -maxdepth 1 -type f ! -name "*.sh" -exec chmod 444 {} \; 2>/dev/null || true

  echo "    OK: regra de moderação + config + scripts instalados (somente leitura)."

  # Agenda o monitoramento no cron, se disponível -- best-effort: sob
  # set -e, uma falha aqui (ex.: sem permissão de escrita em
  # /var/spool/cron, comum em containers/sandboxes) não pode derrubar o
  # script inteiro, por isso o "crontab -" roda dentro de um "if" (nunca
  # como statement solto).
  if command -v crontab >/dev/null 2>&1; then
    if crontab -l 2>/dev/null | grep -q "content-monitor.sh"; then
      echo "    Monitoramento já estava agendado no cron."
    elif ( (crontab -l 2>/dev/null; echo "0 * * * * bash $BOB_HOME/scripts/content-monitor.sh >> $BOB_HOME/logs/monitor.log 2>&1") | crontab - ) 2>/dev/null; then
      echo "    OK: monitoramento automático agendado no cron (a cada hora)."
    else
      echo "    AVISO: não foi possível agendar no cron (sem permissão ou sem daemon de cron neste ambiente)."
      echo "      Rode manualmente quando quiser: bash $BOB_HOME/scripts/content-monitor.sh"
    fi
  else
    echo "    AVISO: 'crontab' não disponível -- rode manualmente quando quiser:"
    echo "      bash $BOB_HOME/scripts/content-monitor.sh"
  fi
else
  echo "AVISO: $MODERATION_SRC não encontrado no espelho -- pulando bob-moderation."
fi

echo "==> Guardando o esqueleto de projeto em $TEMPLATES_DIR"
rm -rf "$TEMPLATES_DIR"
mkdir -p "$TEMPLATES_DIR"

# Copia tudo do espelho, exceto .git/ e a pasta governanca/ (essa só existe
# para dar suporte a este instalador, não faz parte do esqueleto por
# projeto que o comando bob-novo-projeto vai copiar depois).
( cd "$TMP_DIR/framework" && find . -mindepth 1 -maxdepth 1 ! -name ".git" ! -name "governanca" -exec cp -R {} "$TEMPLATES_DIR/" \; )

# .bob/skills/ já foi instalado Global no passo anterior -- remove do
# esqueleto por projeto pra não duplicar (e não gerar confusão sobre qual
# cópia é "a de verdade").
rm -rf "$TEMPLATES_DIR/.bob/skills"

echo ""
echo "Instalação concluída."
echo ""
echo "Confira no seletor de modos da sua IDE: devem aparecer os 13 modos do"
echo "Framework .Bob, incluindo 🔮 Oráculo (reinicie a IDE se necessário)."
echo "As 10 skills também já estão disponíveis globalmente em $SKILLS_DEST."
echo ""
echo "Para criar um projeto novo a partir do esqueleto cacheado, rode (no"
echo "diretório onde o novo projeto deve nascer):"
echo "  curl -fsSL $MIRROR_RAW_BASE/governanca/scripts/bob-novo-projeto.sh | bash -s -- <nome-do-projeto>"
echo ""
echo "Bloqueio ativo de conteúdo (bob-moderation) instalado em $BOB_HOME."
echo "Personalize a lista de termos bloqueados em: $BOB_HOME/config/blocked-terms.txt"
