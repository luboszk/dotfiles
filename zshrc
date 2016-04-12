# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/ # Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

plugins=(git virtualenv pip python tmux osx brew autojump vagrant)

source $ZSH/oh-my-zsh.sh
source $(which virtualenvwrapper.sh)

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Ctrl-R for incremental search in both vi modes
bindkey "^R" history-incremental-search-backward

autoload -U select-word-style
select-word-style bash
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Function which activate virtualenv when find .venv file
function chpwd() {
    emulate -L zsh

    if [ -f .venv ]; then
        workon `cat .venv`
    fi
}

# Enable powerline in ZSH
. $POWERLINE_EGG/powerline/bindings/zsh/powerline.zsh 

# Enable autojump project
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
