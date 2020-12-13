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
set backspace=indent,eol,start

set foldmethod=syntax
set foldlevelstart=3

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

let cmd='make'
map <F3>  :execute '!' . g:cmd <enter>
map <F4>  :execute '! ls -la' <enter>
map <F5>  :execute '! tree' <enter>

ino <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'ycm-core/YouCompleteMe'

call plug#end()

" FZF customization
nnoremap <C-p> :Files<Cr>

" YCM customization
let g:ycm_autoclose_preview_window_after_completion = 1
