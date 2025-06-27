-- Keymaps configuration
-- Migrated from original .vimrc

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key is set in init.lua

-- CamelCase motion
vim.g.camelcasemotion_key = "<leader>"

-- Buffer navigation
keymap("n", "<Tab>", function()
  if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("bnext")
end, { noremap = true, silent = true, desc = "Next buffer (save if modified)" })

keymap("n", "<S-Tab>", function()
  if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("bprevious")
end, { noremap = true, silent = true, desc = "Previous buffer (save if modified)" })

keymap("n", "<S-q>", ":bd<cr>", { noremap = true, silent = true, desc = "Delete buffer" })
keymap("n", "<S-c>", ":clo<cr>", { noremap = true, silent = true, desc = "Close window" })

-- Tab navigation
keymap("n", "<C-v>", ":tabnew ", { noremap = true, desc = "New tab" })
keymap("i", "<C-v>", "<ESC>:tabnew ", { noremap = true, desc = "New tab" })

-- nvim-tree toggle
keymap("n", ",,", ":NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "Toggle file tree" })

-- Copilot
keymap("i", "<C-k>", "<ESC>:Copilot panel<cr>", { noremap = true, silent = true, desc = "Open Copilot panel" })

-- Tmux resizer
keymap("n", "<Esc>h", ":TmuxResizeLeft<cr>", { noremap = true, silent = true, desc = "Resize left" })
keymap("n", "<Esc>j", ":TmuxResizeDown<cr>", { noremap = true, silent = true, desc = "Resize down" })
keymap("n", "<Esc>k", ":TmuxResizeUp<cr>", { noremap = true, silent = true, desc = "Resize up" })
keymap("n", "<Esc>l", ":TmuxResizeRight<cr>", { noremap = true, silent = true, desc = "Resize right" })

-- Test commands
keymap("n", "<leader>t", ":TestNearest<CR>", opts)
keymap("n", "<leader>T", ":TestFile<CR>", opts)
keymap("n", "<leader>a", ":TestSuite<CR>", opts)
keymap("n", "<leader>l", ":TestLast<CR>", opts)
keymap("n", "<leader>g", ":TestVisit<CR>", opts)

-- Config shortcuts
keymap("n", "<leader>vm", ":vsp ~/.config/nvim/init.lua<cr>", opts)
keymap("n", "<leader>sv", ":source ~/.config/nvim/init.lua<cr>", opts)
keymap("n", "<leader>vc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Search config files" })
keymap("n", "<leader>zl", ":vsp ~/.config/zellij/config.kdl<cr>", opts)

-- Fix resize issue
keymap("n", "<leader>cc", ":so ~/.config/nvim/init.lua<cr>:resize<cr>", opts)

-- Tagbar
keymap("n", "<leader>tb", ":TagbarToggle<cr>", opts)

-- GitHub browsing
keymap("n", "<leader>gh", ":GBrowse!<CR>:GBrowse<CR>", opts)
keymap("v", "<leader>gh", ":GBrowse!<CR>gv:GBrowse<CR>", opts)

-- Hardtime toggle
keymap("n", "<leader>ht", ":HardTimeToggle<cr>", opts)

-- Vimux
keymap("n", "<leader>vp", ":VimuxPromptCommand<cr>", opts)

-- Telescope keymaps (will be organized in telescope.lua)
keymap("n", "<leader>sf", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>cb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fw", "<cmd>Telescope grep_string<cr>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>km", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>bb", "<cmd>Telescope builtin<cr>", opts)
keymap("n", "<leader>lg", "<cmd>LazyGit<cr>", opts)

-- Trouble
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", opts)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", opts)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", opts)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", opts)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", opts)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", opts)

-- LSP keymaps (will be organized in lsp.lua)
keymap("n", "gd", vim.lsp.buf.definition, opts)
keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "gi", vim.lsp.buf.implementation, opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
keymap("n", "gr", vim.lsp.buf.references, opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, opts)
