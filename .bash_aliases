if [ -n "$(uname -a | grep -i Darwin)" ]; then
    alias ls='LC_COLLATE=C ls'
    alias ll='LC_COLLATE=C ls -l'
    alias la='LC_COLLATE=C ls -la'
else
    alias ls='LC_COLLATE=C ls --group-directories-first --color=auto'
    alias ll='LC_COLLATE=C ls --group-directories-first -l'
    alias la='LC_COLLATE=C ls --group-directories-first -la'
fi

alias gs='git status'
alias gd='git diff -b'
alias gb='git branch -a'

alias tree='tree --dirsfirst'
alias tt='tree -L 2'

alias st='svn status --ignore-externals | grep .git -v'
