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

" set tabstop=2
set expandtab
set shiftwidth=2
set softtabstop=2
syntax on

"" Coffee-Script plugin settings
call pathogen#runtime_append_all_bundles()
filetype off
filetype plugin indent on
"let coffee_folding = 1
let coffee_no_trailing_space_error = 1
"let coffee_no_trailing_semicolon_error = 1
let coffee_no_reserved_words_error = 1
"nmap KEY :CoffeeMake<CR>


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

"" Fuzzy Finder Mappings
" map ,t :FuzzyFinderTextMate<cr>
" map ,t :FufFile<cr>

"" Force these plugins to load
" :source ~/.vim/plugin/fuzzyfinder.vim
" :source /opt/local/share/vim/vim72/plugin/fuzzyfinder.vim
" :source ~/.vim/plugin/fuzzyfinder_textmate.vim


"if ! has("gui_running") 
"    set t_Co=256 
"endif 
" feel free to choose :set background=light for a different style 
"set background=dark 
" colors peaksea 

" colorscheme koehler 
" colorscheme blue
" colorscheme darkblue
" colorscheme default
" colorscheme delek
" colorscheme ps_color 
" colorscheme desert
" colorscheme elflord
" colorscheme evening
" colorscheme koehler
" colorscheme morning
" colorscheme murphy
" colorscheme pablo
" colorscheme peachpuff
" colorscheme ron
" colorscheme shine
" colorscheme slate
" colorscheme torte
" colorscheme zellner

