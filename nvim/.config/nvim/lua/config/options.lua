-- Neovim options configuration
-- Migrated from original .vimrc

local opt = vim.opt

-- Compatibility and basic settings
opt.compatible = false
opt.number = true
opt.ruler = true
opt.showmatch = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2

-- Enable syntax highlighting
vim.cmd("syntax on")

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