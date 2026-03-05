-- Utility plugins
return {

  -- Helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 400,
      spec = {
        -- Search operations
        { "<leader>fg", desc = "Search Text (Live Grep)" },
        { "<leader>fw", desc = "Search Word Under Cursor" },
        { "<leader>fb", desc = "Find Open Buffers" },
        { "<leader>fh", desc = "Find Help Tags" },
        { "<leader>sf", desc = "Find Files" },
        { "<leader>cb", desc = "Search Current Buffer" },
        
        -- Testing
        { "<leader>t", desc = "Run Nearest Test" },
        { "<leader>T", desc = "Run Test File" },
        { "<leader>a", desc = "Run Test Suite" },
        { "<leader>l", desc = "Run Last Test" },
        { "<leader>g", desc = "Visit Last Test File" },
        
        -- Diagnostics (Trouble)
        { "<leader>x", group = "Diagnostics" },
        { "<leader>xx", desc = "Diagnostics: Toggle" },
        { "<leader>xw", desc = "Diagnostics: Workspace" },
        { "<leader>xd", desc = "Diagnostics: Buffer" },
        { "<leader>xq", desc = "Diagnostics: Quickfix List" },
        { "<leader>xl", desc = "Diagnostics: Location List" },
        
        -- Configuration
        { "<leader>v", group = "Config" },
        { "<leader>vm", desc = "Open Neovim Config" },
        { "<leader>sv", desc = "Reload Neovim Config" },
        { "<leader>vc", desc = "Find Config Files" },
        { "<leader>zl", desc = "Open Zellij Config" },
        { "<leader>cc", desc = "Reload Config + Resize" },
        
        -- Git
        { "<leader>gh", desc = "Open on GitHub" },
        { "<leader>lg", desc = "Open LazyGit" },
        
        -- Utilities
        { "<leader>tb", desc = "Toggle Tagbar" },
        { "<leader>ht", desc = "Toggle Hardtime" },
        { "<leader>km", desc = "Find Keymaps" },
        { "<leader>bb", desc = "Find Telescope Pickers" },
        
        -- Vimux
        { "<leader>vp", desc = "Vimux: Prompt Command" },
        
        -- LSP
        { "<leader>rn", desc = "LSP: Rename Symbol" },
        { "<leader>ca", desc = "LSP: Code Action" },
        { "<leader>f", desc = "LSP: Format Buffer" },
        { "gd", desc = "LSP: Go to Definition" },
        { "gi", desc = "LSP: Go to Implementation" },
        { "gr", desc = "LSP: Go to References" },
        { "gR", desc = "LSP: References (Trouble)" },
        { "K", desc = "LSP: Hover Docs" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps",
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

  -- Testing
  {
    "vim-test/vim-test",
    keys = {
      { "<leader>t", ":TestNearest<CR>", desc = "Run Nearest Test" },
      { "<leader>T", ":TestFile<CR>", desc = "Run Test File" },
      { "<leader>a", ":TestSuite<CR>", desc = "Run Test Suite" },
      { "<leader>l", ":TestLast<CR>", desc = "Run Last Test" },
      { "<leader>g", ":TestVisit<CR>", desc = "Visit Last Test File" },
    },
    config = function()
      vim.g["test#strategy"] = "neovim"
    end,
  },

  -- Tmux integration
  {
    "preservim/vimux",
    keys = {
      { "<leader>vp", ":VimuxPromptCommand<cr>", desc = "Vimux: Prompt Command" },
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

  -- Hardtime - break bad habits
  {
    "takac/vim-hardtime",
    event = "VeryLazy",
    keys = {
      { "<leader>ht", "<cmd>HardTimeToggle<cr>", desc = "Toggle Hardtime" },
    },
    config = function()
      vim.g.hardtime_default_on = 1
      vim.g.hardtime_timeout = 1000
      vim.g.hardtime_showmsg = 1
      vim.g.list_of_normal_keys = { "h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_visual_keys = { "h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_insert_keys = { "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>" }
      vim.g.list_of_disabled_keys = {}
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
