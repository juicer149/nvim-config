#!/usr/bin/env bash
set -euo pipefail

echo "[nvim] Installing latest stable Neovim"

# --------------------------------------------------
# Config
# --------------------------------------------------
INSTALL_DIR="/usr/local"
BIN_DIR="${INSTALL_DIR}/bin"
NVIM_BIN="${BIN_DIR}/nvim"
TMP_DIR="$(mktemp -d)"

# --------------------------------------------------
# Helpers
# --------------------------------------------------
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

has() {
  command -v "$1" >/dev/null 2>&1
}

# --------------------------------------------------
# Preflight
# --------------------------------------------------
if has nvim; then
  CURRENT_VERSION="$(nvim --version | head -n1 || true)"
  echo "[nvim] already installed: ${CURRENT_VERSION}"
  exit 0
fi

# --------------------------------------------------
# Download latest release
# --------------------------------------------------
echo "[nvim] fetching latest release"

ARCHIVE_URL="https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz"

cd "$TMP_DIR"
curl -fL "$ARCHIVE_URL" -o nvim.tar.gz

# --------------------------------------------------
# Extract & install
# --------------------------------------------------
echo "[nvim] extracting"
tar xzf nvim.tar.gz

echo "[nvim] installing to ${INSTALL_DIR}"
sudo cp -r nvim-linux64/* "$INSTALL_DIR/"

# --------------------------------------------------
# Verify
# --------------------------------------------------
if ! has nvim; then
  echo "[error] nvim installation failed"
  exit 1
fi

echo "[nvim] installed successfully:"
nvim --version | head -n1
