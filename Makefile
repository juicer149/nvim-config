# ############################################################
# Makefile – Kommandomeny för utvecklingsmiljö
# ############################################################

.DEFAULT_GOAL := help

# ============================================================
# Setup av utvecklingsmiljö
# - Installerar bara om program inte redan finns
# ============================================================
setup: check-node check-pyright check-gopls check-clangd check-html-lsp
	@echo "Setup komplett!"

# ------------------------------------------------------------
# Checks och installationer
# ------------------------------------------------------------
check-node:
	@which node > /dev/null 2>&1 || (echo "🟢 Installerar Node.js..." && curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt install -y nodejs)

check-pyright:
	@which pyright > /dev/null 2>&1 || (echo "🐍 Installerar Pyright..." && sudo npm install -g pyright)

check-gopls:
	@which gopls > /dev/null 2>&1 || (echo "🦫 Installerar gopls..." && go install golang.org/x/tools/gopls@latest && echo 'export PATH="$$HOME/go/bin:$$PATH"' >> ~/.bashrc)

check-clangd:
	@which clangd > /dev/null 2>&1 || (echo "🛠️ Installerar clangd..." && sudo apt install -y clangd)

check-html-lsp:
	@which vscode-html-language-server > /dev/null 2>&1 || (echo "🌐 Installerar vscode-html-language-server..." && sudo npm install -g vscode-langservers-extracted)

# ============================================================
# Neovim senaste version
# ============================================================
nvim:
	@echo "Installerar senaste Neovim..."
	@chmod +x scripts/install_nvim_latest.sh
	@scripts/install_nvim_latest.sh

# ============================================================
# Git-sync
# ============================================================
push:
	@./sync.sh push "update"
pull:
	@./sync.sh pull

# ============================================================
# Hjälptext (default)
# ============================================================
help:
	@echo "Tillgängliga kommandon:"
	@echo "  make setup   – installera LSP och dev-miljö (idempotent)"
	@echo "  make nvim    – installera senaste Neovim"
	@echo "  make push    – pusha ändringar till GitHub"
	@echo "  make pull    – hämta senaste ändringar från GitHub"

