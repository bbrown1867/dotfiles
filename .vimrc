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
set textwidth=80
set title
set wrap
set wrapscan

" Spacing

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

" Colors

set colorcolumn=81,101,121

if filereadable($HOME.'/.vim/plugged/papercolor-theme/README.md')
    colorscheme PaperColor
endif

if !has('macunix') || system('defaults read -g AppleInterfaceStyle') =~ '^Dark'
    set background=dark
else
    set background=light
endif

" Remaps

let mapleader = ' '

nnoremap <leader>z :bp<Cr>
nnoremap <leader>x :bn<Cr>
nnoremap <leader>w <C-w><C-w>
nnoremap <leader>p :GFiles<Cr>
nnoremap <leader>f :Rg<Cr>
nnoremap <leader>F :Rg <C-R><C-W><Cr>
nnoremap <leader>g :ALEGoToDefinition<Cr>
nnoremap <leader>c :ALEFindReferences<Cr>

" Custom functions

function! DisplayWhitespace()
    set listchars=eol:$,tab:>·,trail:~,extends:>,precedes:<,space:␣
    set list
endfunction

" Config for Airline

let g:airline_theme='papercolor'
let g:airline#extensions#tabline#enabled = 1

" Config for ALE

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

" Config for Cscope

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
