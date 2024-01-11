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
""" Git
Plug 'airblade/vim-gitgutter'
Plug 'kdheepak/lazygit.nvim'
Plug 'tpope/vim-fugitive'

""" GitHub
Plug 'tpope/vim-rhubarb'
Plug 'github/copilot.vim'

""" LSP
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'

""" Navigation
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Motion plugin (moving around in the visible editor area)
Plug 'ggandor/leap.nvim' " https://github.com/ggandor/leap.nvim
Plug 'preservim/tagbar'

""" Note taking
Plug 'mickael-menu/zk-nvim'

""" Ruby and Rails
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-rails'
Plug 'kana/vim-textobj-user'
Plug 'pocke/rbs.vim'

""" Search/Finding
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim' , { 'tag': '0.1.5' }
" or                                , { 'branch': '0.1.x' }

""" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Testing
Plug 'vim-test/vim-test'

""" Text Objects!!
" https://blog.carbonfive.com/vim-text-objects-the-definitive-guide
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'bkad/CamelCaseMotion'


""" Themes
" Plug 'arcticicestudio/nord-vim'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }

""" Utilities
Plug 'mfussenegger/nvim-dap'
Plug 'suketa/nvim-dap-ruby'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'preservim/vimux'
Plug 'mileszs/ack.vim'
Plug 'psliwka/vim-smoothie'
Plug 'RyanMillerC/better-vim-tmux-resizer'
" Hardtime helps you break that annoying habit vimmers have of scrolling up and down the page using jjjjj and kkkkk but without compromising the rest of our vim experience.
Plug 'takac/vim-hardtime'

call plug#end()

" change the leader key from "\" to " " ("," is also popular)
nnoremap <SPACE> <Nop>
let mapleader=" "

let g:camelcasemotion_key = '<leader>'

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

" Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>cb <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fw <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>km <cmd>Telescope keymaps<cr>
nnoremap <leader>bb <cmd>Telescope builtin<cr>
nnoremap <leader>lg <cmd>LazyGit<cr>

" Config shortcuts
map <leader>vm :vsp ~/.vimrc<cr>
map <leader>sv :source $MYVIMRC<cr>

" Use tabs to switch between buffers
nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
map <silent> <S-q> :bd<cr>
map <silent> <S-c> :clo<cr>

" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<cr>

:nmap <C-v> :tabnew <C-d>
:imap <C-v> <ESC>:tabnew <C-d>

map ,, :NERDTree<cr>


" vim-startify splash screen setting
let g:startify_change_to_dir = 0
let g:startify_custom_header = startify#pad(split(system('figlet -w 100 [ GitHub / GitCoin ]'), '\n'))

:imap <C-k> <ESC>:Copilot panel<cr>

" https://github.com/RyanMillerC/better-vim-tmux-resizer#configuration
" https://stackoverflow.com/a/8224269
let g:tmux_resizer_resize_count = 3
let g:tmux_resizer_vertical_resize_count = 3
let g:tmux_resizer_no_mappings = 1
nnoremap <silent> <Esc>h :TmuxResizeLeft<cr>
nnoremap <silent> <Esc>j :TmuxResizeDown<cr>
nnoremap <silent> <Esc>k :TmuxResizeUp<cr>
nnoremap <silent> <Esc>l :TmuxResizeRight<cr>

""" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

""" Hack for fixing odd command prompt window resize
nmap <silent> <leader>cc :so $MYVIMRC<cr>:resize<cr>
""" preservim/tagbar
map <Leader>tb :TagbarToggle<cr>

"""" vim-rhubarb
" Open current line on GitHub
nnoremap <Leader>gh :GBrowse!<CR>:GBrowse<CR>
vnoremap <Leader>gh :GBrowse!<CR>gv:GBrowse<CR>

"{{{ Keybinding for visiting the GitHub page of the plugin defined on the current line
augroup Vimrc
    autocmd!
    autocmd FileType vim nnoremap <silent> gp :call OpenPluginHomepage()<CR>
augroup END

function! OpenPluginHomepage() abort
  " Get line under cursor
  let line = getline(".")

  " Matches for instance Plug 'tpope/surround' -> tpope/surround
  " Greedy match in order to not capture trailing comments
  let plugin_name = '\w\+ \([''"]\)\(.\{-}\)\1'

  try
    let repository = matchlist(line, plugin_name)[2]

    " Open the corresponding GitHub homepage with $BROWSER
    " You need to set the BROWSER environment variable in order for this to work
    " For MacOS, you can set the following for opening it in your default
    " browser: 'export BROWSER=open'
    silent exec "!$BROWSER https://github.com/".repository
  catch /.*/
    echo 'No match for "<user>/<repository>" on this line!'
  endtry
endfunction
"}}}

set termguicolors
colorscheme tokyonight
" colorscheme nord
