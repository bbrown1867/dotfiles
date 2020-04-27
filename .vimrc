set nocompatible

syntax on

set autoindent
if (&ft == 'Makefile')
    set tabstop=8
    set shiftwidth=8
else
    set tabstop=4
    set shiftwidth=4
    set expandtab
endif

set wrapscan
set hlsearch

set title
set showmode
set showmatch
set number
set relativenumber

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

no <up> <Nop>
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>

ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>

let cmd='make'
map <F1>  :!gentags<CR>:cs add cscope.out<CR>
map <F3>  :execute '!' . g:cmd <enter>
map <F4>  :execute '! ls -la' <enter>
map <F5>  :execute '! tree' <enter>

autocmd VimLeave * :execute '! rm -rf cscope.out cscope/'

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'joe-skb7/cscope-maps'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()
