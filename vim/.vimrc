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

set pastetoggle=<C-l>


" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rhubarb'
" Plug 'https://github.com/rhysd/ghpr-blame.vim'
"
""" Themes
" Plug 'arcticicestudio/nord-vim'
Plug 'ghifarit53/tokyonight-vim'

Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'vim-ruby/vim-ruby'
Plug 'preservim/vimux'

""" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Note taking
Plug 'mickael-menu/zk-nvim'

""" LSP
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'

""" Git
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'

" Tree directory navigator
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

""" Motion plugin (moving around in the visible editor area)
Plug 'ggandor/leap.nvim' " https://github.com/ggandor/leap.nvim


""" Search/Finding
" Telescope finder
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
" or                                , { 'branch': '0.1.x' }

" Plugin outside ~/.vim/plugged with post-update hook
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'

" Plug 'https://github.com/christoomey/vim-tmux-navigator'
Plug 'RyanMillerC/better-vim-tmux-resizer'

call plug#end()

" change the leader key from "\" to " " ("," is also popular)
nnoremap <SPACE> <Nop>
let mapleader=" "

" https://github.com/rhysd/ghpr-blame.vim
let g:ghpr_github_auth_token=''

" Airline settings
let g:airline_powerline_fonts=1
let g:airline_theme='light'
let g:airline#extensions#tabline#enabled = 1


" Run Ruby code
autocmd BufRead, *.rb nmap <Leader>r :silent !{ruby %}<cr>

" Reload config after we save changes to it
autocmd BufWritePost .vimrc source $MYVIMRC


" Fzf
" nnoremap <C-p> :Files<CR>
" nnoremap <Leader>f :Rg<CR>
" nnoremap <Leader>b :Buffers<CR>
" nnoremap <Leader>/ :BLines<CR>
" nnoremap <Leader>' :Marks<CR>
" nnoremap <Leader>g :Commits<CR>
" nnoremap <Leader>H :Helptags<CR>
" nnoremap <Leader>hh :History<CR>
" nnoremap <Leader>h: :History:<CR>
" nnoremap <Leader>h/ :History/<CR>
" let g:fzf_layout = { 'down':  '40%'}
" Buffers for the win

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>km <cmd>Telescope keymaps<cr>
nnoremap <leader>bb <cmd>Telescope builtin<cr>
nnoremap <leader>lg <cmd>LazyGit<cr>


" vim config shortcuts
map <leader>vm :vsp ~/.vimrc<CR>
map <leader>sv :source $MYVIMRC<CR>

map = :bn<cr>
map - :bp<cr>
map <S-q> :bd<cr>
map <S-c> :clo<cr>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>

"" Commented for now since FNUM keys are taken in Mac Keyboards
" :nmap <F3> :tabnew <C-d>
" nnoremap <F12> :tabn<cr>
" nnoremap <F11> :tabp<cr>
"nnoremap = :tabn<cr>
"nnoremap - :tabp<cr>
"nnoremap q :q<cr>

:nmap <C-v> :tabnew <C-d>
:imap <C-v> <ESC>:tabnew <C-d>

map ,, :NERDTree<cr>

" https://github.com/RyanMillerC/better-vim-tmux-resizer#configuration
" https://stackoverflow.com/a/8224269
let g:tmux_resizer_resize_count = 3
let g:tmux_resizer_vertical_resize_count = 3
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <Esc>h :TmuxResizeLeft<CR>
nnoremap <silent> <Esc>j :TmuxResizeDown<CR>
nnoremap <silent> <Esc>k :TmuxResizeUp<CR>
nnoremap <silent> <Esc>l :TmuxResizeRight<CR>

set termguicolors
colorscheme tokyonight
" colorscheme nord
