#!/usr/bin/env zsh

# Only allow unique path values
typeset -U PATH

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

# Vim key bindings
bindkey -v

# If installed, setup nvim as default editor
if command -v nvim >/dev/null 2>&1; then
    alias vim="nvim"
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# If installed, setup fzf
if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# Custom aliases
source $HOME/.bash_aliases

# Machine specific config
if [[ -f $HOME/.zshrc.local ]]; then
    source $HOME/.zshrc.local
fi
