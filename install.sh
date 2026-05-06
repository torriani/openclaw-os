#!/bin/bash
# OpenClaw OS — Instalador
# Copia as 16 skills pra ~/.claude/skills/ do usuario.
# Uso: bash install.sh

set -e

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SOURCE_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

echo "========================================"
echo "  OpenClaw OS — Instalador"
echo "========================================"
echo ""

if [ ! -d "$SKILLS_SRC" ]; then
  echo "ERRO: pasta skills/ nao encontrada em $SOURCE_DIR"
  echo "Voce precisa rodar este script de dentro da pasta openclaw-os/"
  exit 1
fi

mkdir -p "$SKILLS_DST"

INSTALLED=0
SKIPPED=0
for skill_dir in "$SKILLS_SRC"/*/; do
  skill_name=$(basename "$skill_dir")
  target="$SKILLS_DST/$skill_name"

  if [ -d "$target" ]; then
    echo "  [skip] $skill_name (ja existe — apague antes pra reinstalar)"
    SKIPPED=$((SKIPPED+1))
  else
    cp -r "$skill_dir" "$target"
    echo "  [ok]   $skill_name"
    INSTALLED=$((INSTALLED+1))
  fi
done

echo ""
echo "----------------------------------------"
echo "  Instaladas: $INSTALLED"
echo "  Puladas:    $SKIPPED"
echo "----------------------------------------"
echo ""

# Copia recursos compartilhados (templates, checklists, state schema)
RESOURCES_DST="$HOME/coreaios/openclaw-os"
mkdir -p "$RESOURCES_DST"
cp -rn "$SOURCE_DIR/templates" "$RESOURCES_DST/" 2>/dev/null || true
cp -rn "$SOURCE_DIR/checklists" "$RESOURCES_DST/" 2>/dev/null || true
cp -rn "$SOURCE_DIR/state" "$RESOURCES_DST/" 2>/dev/null || true
cp -n "$SOURCE_DIR/MANUAL.html" "$RESOURCES_DST/" 2>/dev/null || true
echo "  Recursos copiados pra $RESOURCES_DST/"
echo "    - templates/ (BOOT, AGENTS, IDENTITY, USER, SOUL)"
echo "    - checklists/"
echo "    - state/state-schema.json"
echo "    - MANUAL.html"
echo ""

if [ $INSTALLED -gt 0 ]; then
  echo "PROXIMO PASSO:"
  echo ""
  echo "  1. Feche e reabra o Claude Code (skills carregam no startup)"
  echo "  2. Digite no prompt:  /openclaw-os:start"
  echo "  3. Siga o passo a passo guiado (~90 min)"
  echo ""
  echo "  Manual completo: $RESOURCES_DST/MANUAL.html"
  echo ""
  echo "  PRE-REQUISITOS antes de rodar /openclaw-os:start:"
  echo "    - VPS Hostinger com Ubuntu 24.04"
  echo "    - Conta ChatGPT (Plus recomendado)"
  echo "    - Telegram instalado no celular"
  echo ""
fi

echo "Instalacao concluida."
