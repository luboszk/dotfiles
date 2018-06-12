# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="" # agnoster

fpath=($HOME/.zsh/completions /usr/local/share/zsh-completions $fpath)

plugins=(git virtualenv pip python tmux osx brew autojump vagrant terraform \\
         docker docker-compose nikola zsh-completions)

source $ZSH/oh-my-zsh.sh
source $(which virtualenvwrapper.sh) 2>/dev/null

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Ctrl-R for incremental search in both vi modes
bindkey "^R" history-incremental-search-backward

autoload -U select-word-style
select-word-style bash

# Function which activate virtualenv when find .venv file
function chpwd() {
    emulate -L zsh

    if [ -f .venv ]; then
        workon `cat .venv`
    fi
}

# Temporarly disable powerline in ZSH due to the performance issues
# Enable powerline in ZSH
powerline-daemon -q
. ${POWERLINE_EGG}/powerline/bindings/zsh/powerline.zsh

# Enable autojump project
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Enable marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"
