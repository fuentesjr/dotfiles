-- Main Neovim configuration entry point
-- Load all configuration modules

-- Set leader key early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

if not vim.tbl_contains(vim.opt.rtp:get(), lazypath) then
  vim.opt.rtp:prepend(lazypath)
end

-- Load configuration modules
require("config")