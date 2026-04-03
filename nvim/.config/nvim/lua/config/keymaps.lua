-- Keymaps configuration

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local utils = require("utils")

-- Buffer navigation
keymap("n", "<Tab>", function()
  if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("bnext")
end, vim.tbl_extend("force", opts, { desc = "Next buffer (save if modified)" }))

keymap("n", "<S-Tab>", function()
  if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
    vim.cmd("write")
  end
  vim.cmd("bprevious")
end, vim.tbl_extend("force", opts, { desc = "Previous buffer (save if modified)" }))

keymap("n", "<S-q>", ":bd<cr>", vim.tbl_extend("force", opts, { desc = "Delete buffer" }))
keymap("n", "<S-c>", ":clo<cr>", vim.tbl_extend("force", opts, { desc = "Close window" }))

-- Config shortcuts
keymap("n", "<leader>vm", ":vsp ~/.config/nvim/init.lua<cr>", vim.tbl_extend("force", opts, { desc = "Open config" }))
keymap("n", "<leader>vc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find config files" })
keymap("n", "<leader>vr", utils.reload_config, vim.tbl_extend("force", opts, { desc = "Reload config" }))
keymap("n", "<leader>vx", function()
  utils.reload_config()
  vim.cmd("resize")
end, vim.tbl_extend("force", opts, { desc = "Reload config + resize" }))
keymap("n", "<leader>vz", ":vsp ~/.config/zellij/config.kdl<cr>", vim.tbl_extend("force", opts, { desc = "Open Zellij config" }))
