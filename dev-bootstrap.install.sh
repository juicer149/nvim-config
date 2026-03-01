#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[editor:nvim] install start"

# --------------------------------------------------
# 1. Neovim binary
# --------------------------------------------------
if ! command -v nvim >/dev/null 2>&1; then
  echo "[nvim] installing neovim"
  if [ -x "$REPO_DIR/scripts/install_nvim_latest.sh" ]; then
    "$REPO_DIR/scripts/install_nvim_latest.sh"
  else
    echo "[error] install_nvim_latest.sh missing"
    exit 1
  fi
else
  echo "[nvim] already installed"
fi

# --------------------------------------------------
# 2. Tooling & LSPs
# --------------------------------------------------
echo "[nvim] installing tooling"
"$REPO_DIR/scripts/install-lsp.sh"

echo "[editor:nvim] install done"
