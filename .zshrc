# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/alexanderkehl/.oh-my-zsh"

bindkey -v
KEYTIMEOUT=1

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
  vi-mode
  zsh-interactive-cd
)
  # web-search

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zconf="vim ~/.zshrc"
alias vconf="vim ~/.vimrc"
alias tconf="vim ~/.tmux.conf"

alias en="trans :en"
alias de="trans :de"
alias r="ranger"
alias chrome="open -a 'Google Chrome'"
alias o="open"
alias cs="cht.sh"
alias nbrew="HOMEBREW_NO_AUTO_UPDATE=1 brew install"
alias uv="~/vim/update-vim.sh"
alias pv="~/vim/pull-vim.sh"
alias ap="bat ~/ApproLogic/ApproLogicNotes.txt"
alias base="node ~/vim/base32.js"
alias n="nvim"
alias vim="nvim"
alias m="mvim"
alias ctags="`brew --prefix`/bin/ctags"
alias ta="tmux attach"
alias ts="tmux ls"
alias tn="tmux new-session -s"
alias cl="clear"
alias g="grunt"
# alias gs="grunt setup"
alias gsd="grunt setup default"
alias pc="tr -d '\n' | pbcopy"
alias pp="pbpaste"
alias tts="tmuxinator start"
alias tk="tmux kill-session -t"
alias t="taskell"
alias updatedoc="bash ~/Work/nano/update_doc.sh"
alias readdoc="bash ~/Work/nano/read_doc.sh"
alias tnode="TS_NODE_FILES=true TS_NODE_TRANSPILE_ONLY=true ts-node"
alias create-module="node ~/Private/cli-creator/dist/index.js"

function cd() {
    emulate -LR zsh
    builtin cd $@ &&
    ll
}

function z() {
    emulate -LR zsh
    builtin z $@ &&
    ll
}

urlencode() {
    echo -n "$1" | node -e "console.log(encodeURIComponent(require('fs').readFileSync(0, 'utf-8')))"
}

urldecode() {
    echo -n "$1" | node -e "console.log(decodeURIComponent(require('fs').readFileSync(0, 'utf-8')))"
}

setopt extended_glob

stty -ixon

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
#
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source ~/vim/shell/completion.zsh
source ~/vim/shell/key-bindings.zsh

export PATH=/usr/local/bin:$PATH

export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh
export PATH="/usr/local/opt/python@3.10/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH=~/.ghcup/bin:$PATH
