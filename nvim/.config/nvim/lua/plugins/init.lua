-- Main plugin specifications
-- This file loads all plugin modules

return {
  -- Core plugins that need early loading
  {
    "folke/lazy.nvim",
    tag = "stable",
  },

  -- Load other plugin modules
  { import = "plugins.ui" },
  { import = "plugins.telescope" },
  { import = "plugins.treesitter" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.git" },
  { import = "plugins.lang" },
  { import = "plugins.navigation" },
  { import = "plugins.utilities" },
}