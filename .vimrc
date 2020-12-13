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

set encoding=utf-8
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

" Complete installation: python3 install.py --clangd-completer --rust-completer
Plug 'ycm-core/YouCompleteMe'

call plug#end()

" FZF customization
nnoremap <C-p> :Files<Cr>

" YCM customization, key mappings similar to cscope
nmap <C-\>d :YcmCompleter GetDoc<CR>
nmap <C-\>g :YcmCompleter GoTo<CR>
nmap <C-\>s :YcmCompleter GoToSymbol <C-R>=expand("<cword>")<CR><CR>	

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_language_server =
\ [
\   {
\     'name': 'rust',
\     'cmdline': ['rust-analyzer'],
\     'filetypes': ['rust'],
\     'project_root_files': ['Cargo.toml']
\   }
\ ]
