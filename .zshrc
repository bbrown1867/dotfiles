#! /bin/zsh

# Only allow unique path values
typeset -U path

# Automatically enter directories
setopt auto_cd

# Configure history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS

# Configure completion
autoload -Uz compinit
compinit

# Color prompt
PROMPT="%F{cyan}%n%f"
PROMPT+="@"
PROMPT+="%F{blue}${${(%):-%m}#zoltan-}%f"
PROMPT+=" "
PROMPT+="%F{172}%~%f"
PROMPT+=" %# "

# Color ls output
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Set default editor
export EDITOR=vim

# Setup fzf (installed with vim-plug)
export PATH="$HOME/.vim/plugged/fzf/bin:$PATH"
source $HOME/.vim/plugged/fzf/shell/key-bindings.zsh

# Custom aliases
source $HOME/.bash_aliases

# Ripgrep + Vim helper
function rgv {
    readonly pattern=$1
    readonly dir=${2:-"."}
    vim +/$pattern $(rg -l $pattern $dir)
}

# Machine specific config
if [[ -f $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
