# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="" # agnoster

fpath=($ZSH/custom/plugins $fpath)

plugins=(
	git
	virtualenv
	pip
	python
	golang
	osx
	brew
	autojump
	vagrant
	terraform
        docker
	docker-compose
	tmux
)

source $ZSH/oh-my-zsh.sh
source $(which virtualenvwrapper.sh) 2>/dev/null

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

if [ -f ~/.balabit.sh ]; then
    . ~/.balabit.sh
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

# Enable powerline in ZSH
powerline-daemon -q
. ${POWERLINE_EGG}/powerline/bindings/zsh/powerline.zsh

# Enable autojump project
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

# Enable marker
[[ -s "$HOME/.local/share/marker/marker.sh" ]] && source "$HOME/.local/share/marker/marker.sh"

# added by travis gem
[ -f /Users/vn0vt4j/.travis/travis.sh ] && source /Users/vn0vt4j/.travis/travis.sh

# Add extra bash completions
source /usr/local/etc/bash_completion.d/az
