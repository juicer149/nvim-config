#!/bin/bash

set -e

echo "🧽 Tar bort gammal version av Neovim (om den finns)..."
sudo rm -f /usr/bin/nvim || true

echo "⬇️ Laddar ner senaste stabila NeoVim release..."
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz

echo "📦 Extraherar arkiv..."
tar -xvzf nvim-linux64.tar.gz

echo "📂 Flyttar till /opt..."
sudo rm -rf /opt/nvim-linux64
sudo mv nvim-linux64 /opt/

echo "🔗 Skapar symbolisk länk..."
sudo ln -sf /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

echo "✅ Klart!"
nvim --version

