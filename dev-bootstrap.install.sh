#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
NVIM_CONFIG="$HOME/.config/nvim"
LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"

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
  echo "[nvim] already installed: $(command -v nvim)"
fi

# --------------------------------------------------
# 2. Config
# --------------------------------------------------

echo "[nvim] linking config"

mkdir -p "$HOME/.config"

if [ -L "$NVIM_CONFIG" ]; then
  rm "$NVIM_CONFIG"
elif [ -e "$NVIM_CONFIG" ]; then
  echo "[error] $NVIM_CONFIG already exists and is not a symlink"
  exit 1
fi

ln -s "$REPO_DIR/config" "$NVIM_CONFIG"

echo "[link] $NVIM_CONFIG -> $REPO_DIR/config"

# --------------------------------------------------
# 3. lazy.nvim
# --------------------------------------------------

if [ ! -d "$LAZY_DIR/.git" ]; then
  echo "[nvim] installing lazy.nvim"

  mkdir -p "$(dirname "$LAZY_DIR")"

  git clone \
    --filter=blob:none \
    https://github.com/folke/lazy.nvim.git \
    --branch=stable \
    "$LAZY_DIR"
else
  echo "[nvim] lazy.nvim already installed"
fi

# --------------------------------------------------
# 4. Tooling & LSPs
# --------------------------------------------------

echo "[nvim] installing tooling"
"$REPO_DIR/scripts/install-lsp.sh"

echo "[editor:nvim] install done"
