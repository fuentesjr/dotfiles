-- Utility plugins
return {

  -- Helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  -- Text manipulation
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },

  {
    "tpope/vim-commentary",
    event = "VeryLazy",
  },

  {
    "tpope/vim-endwise",
    ft = { "ruby", "vim", "sh", "zsh" },
  },

  -- Text objects
  {
    "kana/vim-textobj-user",
    lazy = true,
  },

  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "kana/vim-textobj-user" },
    ft = "ruby",
  },

  -- Testing
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>t", ":TestNearest<CR>", desc = "Test nearest" },
      { "<leader>T", ":TestFile<CR>", desc = "Test file" },
      { "<leader>a", ":TestSuite<CR>", desc = "Test suite" },
      { "<leader>l", ":TestLast<CR>", desc = "Test last" },
      { "<leader>g", ":TestVisit<CR>", desc = "Test visit" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
    end,
  },

  -- Tmux integration
  {
    "preservim/vimux",
    keys = {
      { "<leader>vp", ":VimuxPromptCommand<cr>", desc = "Vimux prompt" },
    },
  },

  {
    "RyanMillerC/better-vim-tmux-resizer",
    config = function()
      vim.g.tmux_resizer_resize_count = 3
      vim.g.tmux_resizer_vertical_resize_count = 3
      vim.g.tmux_resizer_no_mappings = 1

      -- Set up keymaps
      vim.keymap.set("n", "<Esc>h", ":TmuxResizeLeft<cr>", { silent = true })
      vim.keymap.set("n", "<Esc>j", ":TmuxResizeDown<cr>", { silent = true })
      vim.keymap.set("n", "<Esc>k", ":TmuxResizeUp<cr>", { silent = true })
      vim.keymap.set("n", "<Esc>l", ":TmuxResizeRight<cr>", { silent = true })
    end,
  },

  -- Search
  {
    "mileszs/ack.vim",
    cmd = "Ack",
  },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    lazy = true,
  },

  {
    "suketa/nvim-dap-ruby",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "ruby",
    config = function()
      require("dap-ruby").setup()
    end,
  },

  -- Hardtime - break bad habits
  {
    "takac/vim-hardtime",
    event = "VeryLazy",
    config = function()
      vim.g.hardtime_default_on = 1
      vim.g.hardtime_timeout = 1000
      vim.g.hardtime_showmsg = 1
      vim.g.list_of_normal_keys = { "h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_visual_keys = { "h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_insert_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_disabled_keys = {}

      vim.keymap.set("n", "<leader>ht", "<cmd>HardTimeToggle<cr>", { desc = "Toggle hardtime" })
    end,
  },

  -- Note taking
  {
    "mickael-menu/zk-nvim",
    ft = "markdown",
    config = function()
      require("zk").setup()
    end,
  },

  -- Floating terminal
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<A-i>", function() require("FTerm").toggle() end, desc = "Toggle terminal", mode = { "n", "t" } },
    },
    config = function()
      require("FTerm").setup({
        border = "double",
        dimensions = {
          height = 0.9,
          width = 0.9,
        },
      })
    end,
  },
}
