-- Autocommands configuration
-- Migrated from original .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing spaces on save
local TrimWhitespace = augroup("TrimWhitespace", { clear = true })
-- Keep formats that intentionally use trailing whitespace readable as-authored.
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

    -- Preserve the cursor/view so cleanup doesn't feel like a jumpy write hook.
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
      -- Re-run the full Lua bootstrap instead of :source so require()'d modules refresh too.
      require("utils").reload_config()
    end
  end,
})

-- Auto reload files when returning to Neovim
local AutoRead = augroup("AutoRead", { clear = true })
autocmd({ "FocusGained", "BufEnter" }, {
  group = AutoRead,
  pattern = "*",
  command = "checktime",
})

-- Toggle relative numbers on focus/mode
local NumberToggle = augroup("NumberToggle", { clear = true })
autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = NumberToggle,
  pattern = "*",
  callback = function()
    if vim.wo.number and vim.fn.mode() ~= "i" then
      vim.wo.relativenumber = true
    end
  end,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = NumberToggle,
  pattern = "*",
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- Highlight on yank
local HighlightYank = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  group = HighlightYank,
  callback = function()
    -- tiny-glimmer provides its own yank animation once loaded.
    if package.loaded["tiny-glimmer"] then
      return
    end

    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})
