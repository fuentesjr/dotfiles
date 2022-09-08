set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc

lua <<EOF
require('telescope').load_extension('fzf')
require('leap').set_default_keymaps()
require("zk").setup()
require('dap-ruby').setup()
-- require'lspconfig'.solargraph.setup{}
EOF