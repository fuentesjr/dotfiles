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

-- Copy mouse selections to the system clipboard. `clipboard=unnamedplus` already
-- makes yanks use the OS clipboard; this handles the "select with the mouse and it
-- is copied" workflow. Keyboard selections are left alone so the clipboard only
-- changes on an explicit yank.
local function visual_selection_type(mode)
  if mode == "v" or mode == "V" or mode == "\022" then
    return mode
  end
end

local function copy_visual_selection_to_clipboard()
  local mode = vim.fn.mode()
  local selection_type
  local start_pos
  local end_pos

  if visual_selection_type(mode) then
    selection_type = mode
    start_pos = vim.fn.getpos("v")
    end_pos = vim.fn.getpos(".")
  else
    selection_type = vim.fn.visualmode()
    if not visual_selection_type(selection_type) then
      return
    end

    start_pos = vim.fn.getpos("'<")
    end_pos = vim.fn.getpos("'>")
  end

  if start_pos[2] == 0 or end_pos[2] == 0 then
    return
  end

  local ok, lines = pcall(vim.fn.getregion, start_pos, end_pos, { type = selection_type })
  if not ok or #lines == 0 then
    return
  end

  pcall(vim.fn.setreg, "+", lines, selection_type)
end

vim.keymap.set("x", "<LeftRelease>", function()
  vim.schedule(copy_visual_selection_to_clipboard)
  return vim.api.nvim_replace_termcodes("<LeftRelease>", true, false, true)
end, {
  expr = true,
  silent = true,
  desc = "Copy visual selection to system clipboard",
})
