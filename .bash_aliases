#!/usr/bin/env bash

if [ -n "$(uname -a | grep -i darwin)" ]; then
    alias ls="LC_COLLATE=C ls"
    alias ll="LC_COLLATE=C ls -l"
    alias la="LC_COLLATE=C ls -la"
    alias lh="LC_COLLATE=C ls -la $HOME"
else
    alias ls="LC_COLLATE=C ls --group-directories-first --color=auto"
    alias ll="LC_COLLATE=C ls --group-directories-first -l"
    alias la="LC_COLLATE=C ls --group-directories-first -la"
    alias lh="LC_COLLATE=C ls --group-directories-first -la $HOME"
fi

alias gs="git status"
alias gb="git branch -a"
alias gf="git fetch -p"
alias gl="git log"
alias gd="git diff -b"
alias gds="git diff -b --staged"
alias branches="git branch -a | grep $USER"

alias tree="tree --dirsfirst"
alias tt="tree -L 2"
alias tth="tree -L 2 -I Library $HOME"

alias g="grep -rn . -e"
alias gw="grep -rnw . -e"
alias rg="rg --colors 'path:fg:yellow'"

alias cr="check_repos"

alias encrypt="gpg --no-symkey-cache --cipher-algo AES256 -c"
alias decrypt="gpg --no-symkey-cache --cipher-algo AES256"
