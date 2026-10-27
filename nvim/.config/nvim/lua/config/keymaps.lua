-- Keymaps configuration

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local utils = require("utils")

-- Buffer navigation
keymap("n", "<Tab>", ":bnext<cr>", vim.tbl_extend("force", opts, { desc = "Next buffer" }))
keymap("n", "<S-Tab>", ":bprevious<cr>", vim.tbl_extend("force", opts, { desc = "Previous buffer" }))

-- Leader versions of the old Q and C maps, so the built-in Q and C keep working.
keymap("n", "<leader>Q", ":bd<cr>", vim.tbl_extend("force", opts, { desc = "Delete buffer" }))
keymap("n", "<leader>C", ":clo<cr>", vim.tbl_extend("force", opts, { desc = "Close window" }))

-- Config shortcuts
keymap("n", "<leader>vm", ":vsp ~/.config/nvim/init.lua<cr>", vim.tbl_extend("force", opts, { desc = "Open config" }))
keymap("n", "<leader>vc", function() require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Find config files" })
keymap("n", "<leader>vr", utils.reload_config, vim.tbl_extend("force", opts, { desc = "Reload config" }))
keymap("n", "<leader>vx", function()
  utils.reload_config()
  vim.cmd("resize")
end, vim.tbl_extend("force", opts, { desc = "Reload config + resize" }))
keymap("n", "<leader>vz", ":vsp ~/.config/zellij/config.kdl<cr>", vim.tbl_extend("force", opts, { desc = "Open Zellij config" }))

-- Diagnostics
keymap("n", "<leader>xi", function()
  local inline_enabled = vim.diagnostic.config().virtual_text ~= false

  vim.diagnostic.config({
    virtual_text = inline_enabled and false or { prefix = "●" },
  })

  vim.notify("Inline diagnostics " .. (inline_enabled and "off" or "on"))
end, vim.tbl_extend("force", opts, { desc = "Toggle inline diagnostics" }))

keymap("n", "<leader>xb", function()
  local enabled = vim.diagnostic.is_enabled({ bufnr = 0 })

  vim.diagnostic.enable(not enabled, { bufnr = 0 })
  vim.notify("Buffer diagnostics " .. (enabled and "off" or "on"))
end, vim.tbl_extend("force", opts, { desc = "Toggle buffer diagnostics" }))
