" require'lspconfig'.solargraph.setup{}

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

source ~/.vimrc

lua <<EOF
require('telescope').setup()
require('telescope').load_extension('fzf')
require('leap').set_default_keymaps()
require("zk").setup()
require('dap-ruby').setup()
require('nvim-web-devicons').setup()
EOF
