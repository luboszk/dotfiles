#!/bin/bash

# Install xcode
echo -e ">>> Installing xcode"
xcode-select --install 2>/dev/null || echo "Already installed, skipping..."

echo -e "\n>>> Installing homebrew"
if ! which brew >/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo -e "Already installed, skipping..."
fi

# Install TPM
echo -e "\n>>> Installing TPM"
mkdir -p ~/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null || echo "Already installed, skipping..."

#########################################
# Common apps to install using Homebrew #
#########################################
appsToInstall=(
  stow # dotfiles manager
  tmux # really?
  wezterm # terminal
  nikitabobko/tap/aerospace # window manager
  bat # better cat
  eza # better ls
  tlrc # better man, rust client to tldr
  zinit # zsh plugin manager
  git-delta # better looking diffs
  fzf # fuzzy finder
  fd # find used by fzf
  zoxide # better cd
  font-meslo-lg-nerd-font # MesloLGS Nerd Font Mono
  jq # json processor
  sketchybar # personal bar manager
  zsh-autosuggestions # autosuggestions for zsh
  zsh-syntax-highlighting # better zsh syntax highlighting
  powerlevel10k # powerlevel until migrated out...
)

for app in ${appsToInstall[@]}; do
  echo -e "\n>>> Installing ${app}"
  brew install ${app} 2>/dev/null && echo "Done"
done

# Setup stuff for bat themes
echo -e "\n>>> Prepare directories and install theme for bat"
mkdir -p "$(bat --config-dir)/themes"

pushd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
popd

bat cache --build
