#!/usr/bin/env python3
"""
Bob Content Monitor - Coletor de histórico real
=================================================

O `bob-moderation` (content-monitor.sh/.bat) foi escrito assumindo que o
Bob grava as conversas em `~/.bob/logs/bob.log`, em texto plano. Isso é
falso: o Bob (app Electron, provavelmente baseado em VS Code/Cline) grava
cada conversa (task) como uma pasta com UUID, contendo `ui_messages.json`
(o que aparece na tela) e `api_conversation_history.json` (o payload
completo enviado pro LLM), dentro do diretório de dados do app:

  Windows: %APPDATA%\\IBM Bob\\User\\globalStorage\\ibm.bob-code\\tasks\\
  macOS:   ~/Library/Application Support/IBM Bob/User/globalStorage/ibm.bob-code/tasks/
  Linux:   ~/.config/IBM Bob/User/globalStorage/ibm.bob-code/tasks/

Este script lê todas as tasks, extrai o texto de cada mensagem e escreve
um `bob.log` no formato simples que `content-monitor.sh`/`.bat` já sabe
ler (uma linha de texto por mensagem) - sem precisar mudar nada na lógica
de detecção (regex contra config/blocked-terms.txt) nem no rules/
(bloqueio ativo, que já funciona via mecanismo próprio do Bob).

v1 (30/07/2026): reconstrói o bob.log inteiro a cada execução (lê todas
as tasks). Para históricos muito grandes isso pode ficar lento - uma
otimização futura seria guardar um cursor (última task/mensagem já
processada) e só processar o que é novo. Não implementado agora de
propósito (começar simples, otimizar se/quando precisar).

Uso:
    python3 collect-bob-history.py
    (ou, no Windows: python collect-bob-history.py)

Opcional: passar o caminho da pasta "tasks" manualmente, se o script não
achar automaticamente:
    python3 collect-bob-history.py "C:\\Users\\rss\\AppData\\Roaming\\IBM Bob\\User\\globalStorage\\ibm.bob-code\\tasks"
"""

import json
import os
import sys
import platform
from datetime import datetime, timezone


def candidate_task_dirs():
    home = os.path.expanduser("~")
    system = platform.system()
    candidates = []

    if system == "Windows":
        appdata = os.environ.get("APPDATA", os.path.join(home, "AppData", "Roaming"))
        candidates.append(os.path.join(appdata, "IBM Bob", "User", "globalStorage", "ibm.bob-code", "tasks"))
    elif system == "Darwin":
        candidates.append(os.path.join(home, "Library", "Application Support", "IBM Bob",
                                        "User", "globalStorage", "ibm.bob-code", "tasks"))
    else:
        candidates.append(os.path.join(home, ".config", "IBM Bob", "User", "globalStorage", "ibm.bob-code", "tasks"))

    return candidates


def find_tasks_dir(override=None):
    if override:
        if os.path.isdir(override):
            return override
        print(f"AVISO: caminho informado nao existe: {override}", file=sys.stderr)

    for path in candidate_task_dirs():
        if os.path.isdir(path):
            return path

    return None


def bob_home():
    """Onde escrever logs/bob.log - mesma convencao usada pelos scripts .bat/.sh
    (config/rules em ~/.bob, nao no globalStorage do app)."""
    home = os.path.expanduser("~")
    if platform.system() == "Windows":
        return os.path.join(home, ".bob")
    return os.path.join(home, ".bob")


def format_ts(raw_ts):
    """ts costuma vir como epoch em milissegundos (padrao Cline/Roo)."""
    if raw_ts is None:
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    try:
        ts_seconds = float(raw_ts) / 1000.0
        return datetime.fromtimestamp(ts_seconds, tz=timezone.utc).strftime("%Y-%m-%d %H:%M:%S")
    except (ValueError, TypeError, OverflowError):
        return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def collect(tasks_dir):
    lines = []
    task_ids = sorted(
        d for d in os.listdir(tasks_dir)
        if os.path.isdir(os.path.join(tasks_dir, d))
    )

    tasks_ok = 0
    tasks_failed = 0
    messages_total = 0

    for task_id in task_ids:
        ui_file = os.path.join(tasks_dir, task_id, "ui_messages.json")
        if not os.path.isfile(ui_file):
            continue
        try:
            with open(ui_file, "r", encoding="utf-8") as f:
                msgs = json.load(f)
        except (json.JSONDecodeError, OSError) as e:
            tasks_failed += 1
            print(f"AVISO: falha ao ler {ui_file}: {e}", file=sys.stderr)
            continue

        tasks_ok += 1
        for m in msgs:
            text = (m.get("text") or "").strip()
            if not text:
                continue
            role = (m.get("type") or "?").upper()
            ts = format_ts(m.get("ts"))
            # remove quebras de linha para manter 1 linha = 1 mensagem
            # (facilita o grep/findstr do content-monitor)
            flat_text = " ".join(text.split())
            lines.append(f'{ts} - Task: {task_id} - {role}: "{flat_text}"')
            messages_total += 1

    return lines, tasks_ok, tasks_failed, messages_total


def main():
    override = sys.argv[1] if len(sys.argv) > 1 else None
    tasks_dir = find_tasks_dir(override)

    if not tasks_dir:
        print("ERRO: nao encontrei a pasta de tasks do Bob em nenhum dos caminhos padrao:")
        for c in candidate_task_dirs():
            print(f"  - {c}")
        print("\nInforme o caminho manualmente:")
        print("  python3 collect-bob-history.py \"<caminho completo da pasta tasks>\"")
        sys.exit(1)

    print(f"Lendo tasks de: {tasks_dir}")
    lines, tasks_ok, tasks_failed, messages_total = collect(tasks_dir)

    home_bob = bob_home()
    logs_dir = os.path.join(home_bob, "logs")
    os.makedirs(logs_dir, exist_ok=True)
    bob_log = os.path.join(logs_dir, "bob.log")

    with open(bob_log, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + ("\n" if lines else ""))

    print(f"Tasks processadas: {tasks_ok} (falhas: {tasks_failed})")
    print(f"Mensagens escritas: {messages_total}")
    print(f"bob.log atualizado: {bob_log}")
    print("\nProximo passo: rode content-monitor.bat (ou .sh) para checar contra config/blocked-terms.txt")


if __name__ == "__main__":
    main()
