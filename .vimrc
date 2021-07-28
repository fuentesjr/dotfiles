""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" File: .vimrc
"" Date: 04/01/2010
"" Name: Salvador Fuentes Jr.
"" Info: My personal vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
set showmatch
set nu
set nocp
set ruler

set expandtab
set shiftwidth=2
set softtabstop=2
syntax on

set pastetoggle=<C-l>

filetype off
filetype plugin indent on


"" Commented for now since FNUM keys are taken in Mac Keyboards
" :nmap <F3> :tabnew <C-d>
" nnoremap <F12> :tabn<cr>
" nnoremap <F11> :tabp<cr>
nnoremap = :tabn<cr>
nnoremap - :tabp<cr>
nnoremap q :q<cr>

:nmap <C-v> :tabnew <C-d>
:imap <C-v> <ESC>:tabnew <C-d>

map ,, :NERDTree<cr>
" map <A-t> :NERDTree<cr>
