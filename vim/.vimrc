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


" Remove trailing spaces on save
autocmd BufWritePre * :%s/\s\+$//e

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-rhubarb'
" Plug 'https://github.com/rhysd/ghpr-blame.vim'
"
""" Themes
" Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

""" Ruby and Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'


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

""" Utilities
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/vimux'
" Hardtime helps you break that annoying habit vimmers have of scrolling up and down the page using jjjjj and kkkkk but without compromising the rest of our vim experience.
Plug 'takac/vim-hardtime'

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

" Hardtime settings :/
nnoremap <leader>ht <cmd>HardTimeToggle<cr>
let g:hardtime_default_on = 1
let g:hardtime_timeout = 1000
let g:hardtime_showmsg = 1
let g:list_of_normal_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []


" Run Ruby code
autocmd BufRead, *.rb nmap <Leader>r :silent !{ruby %}<cr>

" Reload config after we save changes to it
autocmd BufWritePost .vimrc source $MYVIMRC

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>cb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>km <cmd>Telescope keymaps<cr>
nnoremap <leader>bb <cmd>Telescope builtin<cr>
nnoremap <leader>lg <cmd>LazyGit<cr>

" vim config shortcuts
map <leader>vm :vsp ~/.vimrc<cr>
map <leader>sv :source $MYVIMRC<cr>

nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
map <silent> <S-q> :bd<cr>
map <silent> <S-c> :clo<cr>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<cr>

:nmap <C-v> :tabnew <C-d>
:imap <C-v> <ESC>:tabnew <C-d>

map ,, :NERDTree<cr>

" https://github.com/RyanMillerC/better-vim-tmux-resizer#configuration
" https://stackoverflow.com/a/8224269
let g:tmux_resizer_resize_count = 3
let g:tmux_resizer_vertical_resize_count = 3
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <Esc>h :TmuxResizeLeft<cr>
nnoremap <silent> <Esc>j :TmuxResizeDown<cr>
nnoremap <silent> <Esc>k :TmuxResizeUp<cr>
nnoremap <silent> <Esc>l :TmuxResizeRight<cr>

set termguicolors
colorscheme tokyonight
" colorscheme nord
