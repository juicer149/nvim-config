#!/usr/bin/env bash
set -euo pipefail

echo "[nvim] Installing language servers, parsers, and tooling"

has() {
  command -v "$1" >/dev/null 2>&1
}

apt_install() {
  sudo apt install -y "$@"
}

npm_install() {
  sudo npm install -g "$@"
}

APT_PKGS=(
  curl
  git
  tar
  build-essential
  gcc
  g++
  clangd
)

GO_PKGS=(
  golang.org/x/tools/gopls@latest
)

MISSING_APT=()
for pkg in "${APT_PKGS[@]}"; do
  has "$pkg" || MISSING_APT+=("$pkg")
done

if [ "${#MISSING_APT[@]}" -ne 0 ]; then
  echo "[apt] Installing: ${MISSING_APT[*]}"
  sudo apt update
  apt_install "${MISSING_APT[@]}"
fi

if ! has node; then
  echo "[node] Installing Node.js LTS"
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

if ! has npm; then
  echo "[error] npm not found after Node.js install"
  exit 1
fi

if ! has tree-sitter; then
  echo "[npm] Installing tree-sitter-cli"
  npm_install tree-sitter-cli
fi

if ! has pyright; then
  echo "[npm] Installing pyright"
  npm_install pyright
fi

if ! has vscode-html-language-server || ! has vscode-css-language-server; then
  echo "[npm] Installing vscode-langservers-extracted"
  npm_install vscode-langservers-extracted
fi

if has go && ! has gopls; then
  echo "[go] Installing gopls"
  go install "${GO_PKGS[@]}"
  echo "[note] Ensure \$HOME/go/bin is in PATH"
fi

echo "[nvim] Tooling installation complete"
