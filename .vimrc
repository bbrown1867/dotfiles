syntax on

set backspace=indent,eol,start
set encoding=utf-8
set hlsearch
set ignorecase
set mouse=nv
set nocompatible
set number
set relativenumber
set showmode
set showmatch
set splitright
set splitbelow
set smartcase
set title
set wrapscan

set smartindent
if (&ft == 'Makefile')
    set shiftwidth=8
    set softtabstop=8
    set tabstop=8
else
    set expandtab
    set shiftwidth=4
    set softtabstop=4
    set tabstop=4
endif

let mapleader = ' '
nnoremap <leader>z :bp<Cr>
nnoremap <leader>x :bn<Cr>
nnoremap <leader>w <C-w><C-w>

function! DisplayWhitespace()
    set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:␣
    set list
endfunction
