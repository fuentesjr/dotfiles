-- Lazy.nvim plugin manager configuration

require("lazy").setup("plugins", {
  defaults = {
    -- Opt into lazy-loading by default and mark only startup-critical plugins as eager.
    lazy = true, -- should plugins be lazy-loaded?
    version = false, -- always use the latest git commit
  },
  install = {
    missing = true,
    colorscheme = { "dracula", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})