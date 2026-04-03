-- UI and theme plugins
return {
  -- Colorschemes
  {
    "dracula/vim",
    name = "dracula",
    -- Load the colorscheme early so later UI plugins inherit the intended highlights.
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Statusline
  {
    "vim-airline/vim-airline",
    lazy = false,
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = "light"
      vim.g["airline#extensions#tabline#enabled"] = 1
    end,
  },

  {
    "vim-airline/vim-airline-themes",
    lazy = true,
  },

  -- Startify splash screen
  {
    "mhinz/vim-startify",
    lazy = false,
    config = function()
      vim.g.startify_change_to_dir = 0
      local header
      -- Prefer a local figlet banner when available, but keep a plain-text fallback.
      if vim.fn.executable("figlet") == 1 then
        header = vim.fn.split(vim.fn.system("figlet -w 100 '[ GitHub / GitCoin ]'"), "\n")
      else
        header = { "[ GitHub / GitCoin ]" }
      end
      vim.g.startify_custom_header = vim.fn["startify#pad"](header)
    end,
  },

  -- Smooth scrolling
  {
    "psliwka/vim-smoothie",
    event = "VeryLazy",
  },

  -- Number toggle
  {
    "jeffkreeftmeijer/vim-numbertoggle",
    event = "VeryLazy",
  },
}
