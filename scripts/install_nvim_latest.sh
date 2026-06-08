#!/usr/bin/env bash
set -euo pipefail

echo "[nvim] Installing/updating latest stable Neovim"

INSTALL_DIR="/usr/local"
TMP_DIR="$(mktemp -d)"
ARCHIVE_NAME="nvim-linux-x86_64.tar.gz"
EXTRACTED_DIR="nvim-linux-x86_64"
ARCHIVE_URL="https://github.com/neovim/neovim/releases/latest/download/${ARCHIVE_NAME}"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

has() {
  command -v "$1" >/dev/null 2>&1
}

echo "[nvim] current:"
if has nvim; then
  nvim --version | head -n1 || true
else
  echo "not installed"
fi

cd "$TMP_DIR"

echo "[nvim] downloading ${ARCHIVE_URL}"
curl -fL "$ARCHIVE_URL" -o "$ARCHIVE_NAME"

echo "[nvim] extracting"
tar xzf "$ARCHIVE_NAME"

echo "[nvim] removing old /usr/local install"
sudo rm -rf \
  /usr/local/bin/nvim \
  /usr/local/lib/nvim \
  /usr/local/share/nvim \
  /usr/local/man/man1/nvim.1 \
  /usr/local/share/applications/nvim.desktop \
  /usr/local/share/icons/hicolor/128x128/apps/nvim.png

echo "[nvim] installing to ${INSTALL_DIR}"
sudo cp -r "${EXTRACTED_DIR}/"* "$INSTALL_DIR/"

echo "[nvim] installed:"
hash -r
/usr/local/bin/nvim --version | head -n1

if command -v nvim >/dev/null 2>&1; then
  echo "[nvim] resolved path: $(command -v nvim)"
fi
