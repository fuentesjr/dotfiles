-- UI and theme plugins
return {
  -- Colorschemes
  {
    "dracula/vim",
    name = "dracula",
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

  -- Dev icons (legacy support)
  {
    "ryanoasis/vim-devicons",
    lazy = true,
  },

  -- Statusline
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = "light"
      vim.g["airline#extensions#tabline#enabled"] = 1
      vim.g["airline#extensions#ale#enabled"] = 1
    end,
  },

  {
    "vim-airline/vim-airline-themes",
    lazy = true,
  },

  -- Startify splash screen
  {
    "mhinz/vim-startify",
    config = function()
      vim.g.startify_change_to_dir = 0
      vim.g.startify_custom_header = vim.fn["startify#pad"](
        vim.fn.split(vim.fn.system("figlet -w 100 '[ GitHub / GitCoin ]'"), "\n")
      )
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