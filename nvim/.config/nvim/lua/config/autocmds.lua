-- Autocommands configuration
-- Migrated from original .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing spaces on save
local TrimWhitespace = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = TrimWhitespace,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Reload config after saving
local ReloadConfig = augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = ReloadConfig,
  pattern = { "*.lua", "init.lua" },
  callback = function()
    if vim.fn.expand("%:p"):match(vim.fn.stdpath("config")) then
      vim.cmd("source <afile>")
      vim.notify("Config reloaded!")
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

