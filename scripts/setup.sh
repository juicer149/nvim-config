#!/bin/bash

set -e

echo "Startar setup av utvecklingsmiljö..."

# 1. Installera curl om det inte finns
echo "Installerar curl (om det saknas)..."
sudo apt update
sudo apt install -y curl

# 2. Node.js + npm (via NodeSource)
echo "Installerar Node.js LTS..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# 3. Pyright (Python LSP)
echo "Installerar pyright..."
sudo npm install -g pyright

# 4. Go LSP
echo "Installerar gopls..."
go install golang.org/x/tools/gopls@latest

# 5. Lägg till Go bin i PATH om det inte redan finns
if ! grep -q 'export PATH="$HOME/go/bin:$PATH"' ~/.bashrc; then
  echo 'export PATH="$HOME/go/bin:$PATH"' >> ~/.bashrc
  echo "Lade till Go bin i ~/.bashrc"
fi

# 6. C LSP
echo "Installerar clangd..."
sudo apt install -y clangd

# 7. HTML/CSS/JSON LSP (vscode-langservers-extracted)
echo "Installerar HTML/CSS/JSON LSP (vscode-html-language-server)..."
sudo npm install -g vscode-langservers-extracted

echo "Setup klar! Starta om terminalen eller kör:"
echo "source ~/.bashrc"
echo
echo "Kom ihåg att köra install_nvim_latest.sh om du inte redan har NeoVim v0.10+"

