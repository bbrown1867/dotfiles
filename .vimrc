syntax on

" Plugins

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tomasiser/vim-code-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
call plug#end()

" Spacing

set autoindent
if (&ft == 'Makefile')
    set tabstop=8
    set shiftwidth=8
else
    set tabstop=4
    set shiftwidth=4
    set expandtab
endif

" Basic config

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
set splitright
set splitbelow

" Display

set colorcolumn=81
highlight ColorColumn ctermbg=0 guibg=lightgrey

let g:airline#extensions#tabline#enabled = 1

if has('macunix') && system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
    set background=dark
    colorscheme codedark
    let g:airline_theme='dark'
else
    set background=light
    colorscheme PaperColor
    let g:airline_theme='papercolor'
endif

" Custom functions

function! DisplayWhitespace()
    set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:␣
    set list
endfunction

function! SetupTags()
    if has("cscope")
        ! gentags
        set cscopetag
        set csto=0
        set nocscopeverbose
        cs add cscope.out
    else
        echo "Vim not compiled with cscope"
    endif
endfunction

" Key mappings

let mapleader = ";"

nnoremap <leader>x :bn<Cr>
nnoremap <leader>z :bp<Cr>
nnoremap <leader>p :GFiles<Cr>
nnoremap <leader>f :Rg<Cr>
nnoremap <leader>r :make<Cr>
nnoremap <leader>t :vertical term<Cr>
nnoremap <leader>d :vertical Gdiff<Cr>
nnoremap <leader>w <C-w><C-w>
