#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

# 1. Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  xcode-select --install
  echo ">>> Re-run this script after Xcode CLT finishes installing."
  exit 0
fi

# 2. Homebrew (arch-aware: Apple Silicon /opt/homebrew, Intel /usr/local)
if ! command -v brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3. Bundle install (idempotent)
# If terraform was previously installed directly alongside tenv, remove it first
# to avoid a PATH conflict (tenv provides the terraform shim).
if brew list terraform &>/dev/null && brew list tenv &>/dev/null; then
  echo ">>> Removing direct terraform install — tenv manages terraform versions"
  brew uninstall terraform
fi

brew bundle --file=./Brewfile

# tenv shims need to be linked if terraform was just removed
brew link tenv 2>/dev/null || true

# Docker Desktop (if installed outside of brew) owns /usr/local/bin/docker,
# docker-compose, and kubectl symlinks — overwrite them with brew-managed versions
# so colima + brew CLI is the consistent runtime, not Docker Desktop's bundled CLIs.
brew link --overwrite docker docker-compose kubernetes-cli 2>/dev/null || true

# 4. TPM (tmux plugin manager)
[[ -d ~/.tmux/plugins/tpm ]] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# 5. fzf-git.sh
[[ -d ~/fzf-git.sh ]] || git clone https://github.com/junegunn/fzf-git.sh ~/fzf-git.sh

# 6. bat themes
mkdir -p "$(bat --config-dir)/themes"
[[ -f "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme" ]] || \
  curl -fsSL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme" \
    -o "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
bat cache --build

# 7. mise global tool install
[[ -f ~/.mise.toml ]] && mise install

# 8. tenv — install latest terraform as the default version
tenv tf install latest >/dev/null
tenv tf use latest

# 9. gh extensions (idempotent)
gh extension install dlvhdr/gh-dash 2>/dev/null || true

# 10. Colima default profile (skip if already running)
colima status >/dev/null 2>&1 || colima start --cpu 4 --memory 8

# 11. Stow dotfiles
stow .

echo ""
echo ">>> Bootstrap complete."
echo ""
echo ">>> Next steps:"
echo "    All machines:"
echo "    - Open VSCode → Cmd+Shift+P → 'Settings Sync: Turn On' → sign in with GitHub"
echo ""
echo "    Work machine (M4):"
echo "    - Add to ~/.zshenv:  export DOTFILES_PROFILE=work"
echo "    - Create ~/.gitconfig-work with your work [user] email block"
echo "    - Run: op signin"
echo "    - Run: granted sso login --sso-region <region> --start-url https://<org>.awsapps.com/start"
echo "    - Run: granted sso populate --sso-region <region> --start-url https://<org>.awsapps.com/start"
echo ""
echo "    Personal machine (Intel):"
echo "    - Run: security add-generic-password -a \"\$USER\" -s OPENAI_API_KEY -w '<key>'"
echo "    - Run: security add-generic-password -a \"\$USER\" -s PULUMI_ACCESS_TOKEN -w '<token>'"
