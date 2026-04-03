-- Autocommands configuration
-- Migrated from original .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing spaces on save
local TrimWhitespace = augroup("TrimWhitespace", { clear = true })
local trim_whitespace_exclusions = {
  diff = true,
  gitcommit = true,
  markdown = true,
  text = true,
}

autocmd("BufWritePre", {
  group = TrimWhitespace,
  pattern = "*",
  callback = function(args)
    if trim_whitespace_exclusions[vim.bo[args.buf].filetype] then
      return
    end

    local view = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Reload config after saving
local ReloadConfig = augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = ReloadConfig,
  pattern = { "*.lua", "init.lua" },
  callback = function()
    local current_file = vim.fn.expand("%:p")
    local config_root = vim.fn.stdpath("config")

    if current_file:sub(1, #config_root) == config_root then
      require("utils").reload_config()
    end
  end,
})

-- Highlight on yank
local HighlightYank = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  group = HighlightYank,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

