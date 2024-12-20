syntax on

" Plugins

call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_fix_on_save = 1
let g:ale_linters = {
    \ 'python': ['jedils', 'flake8', 'pycodestyle'],
    \ 'rust': ['analyzer']
    \ }
let g:ale_fixers = {
    \ '*': ['trim_whitespace'],
    \ 'rust': ['rustfmt']
    \ }
let g:ale_python_flake8_options = '--max-line-length 150'
let g:ale_python_pycodestyle_options = '--max-line-length 150'
let g:ale_rust_analyzer_config = {
    \ 'cargo': {
        \ 'target': 'thumbv7em-none-eabihf'
    \ },
    \ 'check': {
        \ 'allTargets': v:false
    \ }
\ }

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

" General

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
set mouse=nv
set ignorecase
set smartcase

" Display

set colorcolumn=81,101,121
highlight ColorColumn ctermbg=0 guibg=lightgrey

if filereadable($HOME.'/.vim/plugged/papercolor-theme/README.md')
    colorscheme PaperColor
endif

let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1

if !has('macunix') || system('defaults read -g AppleInterfaceStyle') =~ '^Dark'
    set background=dark
else
    set background=light
endif

" Custom functions

function! DisplayWhitespace()
    set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:␣
    set list
endfunction

" Key mappings

let mapleader = ' '

nnoremap <leader>z :bp<Cr>
nnoremap <leader>x :bn<Cr>
nnoremap <leader>w <C-w><C-w>
nnoremap <leader>p :GFiles<Cr>
nnoremap <leader>f :Rg<Cr>
nnoremap <leader>F :Rg <C-R><C-W><Cr>
nnoremap <leader>g :ALEGoToDefinition<Cr>
nnoremap <leader>c :ALEFindReferences<Cr>

" Config and key mappings for cscope

if has('cscope')
    set cscopetag
    set csto=0
    set nocscopeverbose

    if filereadable('cscope.out')
        cs add cscope.out
    elseif $CSCOPE_DB != ''
        cs add $CSCOPE_DB
    endif

    " Go to definition under cursor (override ALEGoToDefinition)
    autocmd FileType c nnoremap <buffer> <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    autocmd FileType cpp nnoremap <buffer> <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>

    " Find functions calling function under cursor (override ALEFindReferences)
    autocmd FileType c nnoremap <buffer> <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    autocmd FileType cpp nnoremap <buffer> <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
endif
