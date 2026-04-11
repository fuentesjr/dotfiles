-- Neovim options configuration
-- Migrated from original .vimrc

local opt = vim.opt

-- Compatibility and basic settings
opt.number = true
opt.ruler = true
opt.showmatch = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

-- Auto reload files if they change
opt.autoread = true

-- Terminal colors
opt.termguicolors = true

-- Disable backup and swap files (optional - can be enabled if desired)
-- opt.backup = false
-- opt.writebackup = false
-- opt.swapfile = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Display settings
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.smoothscroll = true
opt.relativenumber = true

-- Split behavior
opt.splitbelow = true
opt.splitright = true

-- Completion settings
opt.completeopt = { "menu", "menuone", "noselect" }

-- Update time for better experience
opt.updatetime = 250

-- Sign column
opt.signcolumn = "yes"

-- Mouse support
opt.mouse = "a"

-- Use the system clipboard for all yank/delete/put operations by default.
opt.clipboard = "unnamedplus"

-- Be explicit about the macOS clipboard provider so copy/paste works even if
-- provider autodetection is inconsistent across terminal environments.
if vim.fn.has("mac") == 1 and vim.fn.executable("pbcopy") == 1 and vim.fn.executable("pbpaste") == 1 then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = {
      ["+"] = "pbcopy",
      ["*"] = "pbcopy",
    },
    paste = {
      ["+"] = "pbpaste",
      ["*"] = "pbpaste",
    },
    cache_enabled = 0,
  }
end
