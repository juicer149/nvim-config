#!/usr/bin/env bash
set -euo pipefail

echo "[nvim] Installing language servers and tooling"

# --------------------------------------------------
# Helpers
# --------------------------------------------------
has() {
  command -v "$1" >/dev/null 2>&1
}

apt_install() {
  sudo apt install -y "$@"
}

npm_install() {
  sudo npm install -g "$@"
}

# --------------------------------------------------
# Declarative requirements
# --------------------------------------------------

APT_PKGS=(
  curl
  clangd
)

NPM_PKGS=(
  pyright
  vscode-langservers-extracted
)

GO_PKGS=(
  golang.org/x/tools/gopls@latest
)

# --------------------------------------------------
# APT packages
# --------------------------------------------------
MISSING_APT=()
for pkg in "${APT_PKGS[@]}"; do
  has "$pkg" || MISSING_APT+=("$pkg")
done

if [ "${#MISSING_APT[@]}" -ne 0 ]; then
  echo "[apt] Installing: ${MISSING_APT[*]}"
  sudo apt update
  apt_install "${MISSING_APT[@]}"
fi

# --------------------------------------------------
# Node.js (prerequisite for npm LSPs)
# --------------------------------------------------
if ! has node; then
  echo "[node] Installing Node.js LTS"
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

# --------------------------------------------------
# npm-based LSPs
# --------------------------------------------------
MISSING_NPM=()
for pkg in "${NPM_PKGS[@]}"; do
  has "$pkg" || MISSING_NPM+=("$pkg")
done

if [ "${#MISSING_NPM[@]}" -ne 0 ]; then
  echo "[npm] Installing: ${MISSING_NPM[*]}"
  npm_install "${MISSING_NPM[@]}"
fi

# --------------------------------------------------
# Go-based LSPs
# --------------------------------------------------
if has go && ! has gopls; then
  echo "[go] Installing gopls"
  go install "${GO_PKGS[@]}"
  echo "[note] Ensure \$HOME/go/bin is in PATH"
fi

echo "[nvim] LSP installation complete"
