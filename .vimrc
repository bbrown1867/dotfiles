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

let cmd='make'
map <F1>  :!gentags<CR>:cs add cscope.out<CR>
map <F3>  :execute '!' . g:cmd <enter>
map <F4>  :execute '! ls -la' <enter>
map <F5>  :execute '! tree' <enter>

ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>

nnoremap <C-p> :GFiles<Cr>

autocmd VimLeave * :execute '! rm -rf cscope.out cscope/'

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'joe-skb7/cscope-maps'
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown'

call plug#end()
