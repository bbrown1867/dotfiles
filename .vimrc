syntax on

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

set autoindent
if (&ft == 'Makefile')
    set tabstop=8
    set shiftwidth=8
else
    set tabstop=4
    set shiftwidth=4
    set expandtab
endif

set t_Co=256
set nocompatible
set wrapscan
set hlsearch
set gdefault
set title
set showmode
set showmatch
set number
set relativenumber
set encoding=utf-8
set backspace=indent,eol,start
set foldmethod=syntax
set foldlevelstart=3

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey
if has('macunix') && system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
    colorscheme codedark
    let g:airline_theme='dark'
else
    set background=light
    colorscheme PaperColor
    let g:airline_theme='papercolor'
endif

let cmd='make'
map <F3> :execute '!' . g:cmd <enter>
map <F4> :execute '! ls -la' <enter>
map <F5> :execute '! tree -L 2' <enter>

let mapleader = ";"
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l
nnoremap <leader>f :bn<Cr>
nnoremap <leader>a :bp<Cr>
nnoremap <leader>p :GFiles<Cr>

let g:airline#extensions#tabline#enabled = 1
