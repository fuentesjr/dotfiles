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
        -- File/Search operations
        { "<leader>f", group = "Find" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fw", desc = "Grep word under cursor" },
        { "<leader>fb", desc = "Search buffers" },
        { "<leader>fh", desc = "Help tags" },
        { "<leader>sf", desc = "Find files" },
        { "<leader>cb", desc = "Current buffer fuzzy find" },
        
        -- Testing
        { "<leader>t", desc = "Test nearest" },
        { "<leader>T", desc = "Test file" },
        { "<leader>a", desc = "Test suite" },
        { "<leader>l", desc = "Test last" },
        { "<leader>g", desc = "Test visit" },
        
        -- Trouble diagnostics
        { "<leader>x", group = "Trouble" },
        { "<leader>xx", desc = "Toggle trouble" },
        { "<leader>xw", desc = "Workspace diagnostics" },
        { "<leader>xd", desc = "Document diagnostics" },
        { "<leader>xq", desc = "Quickfix list" },
        { "<leader>xl", desc = "Location list" },
        
        -- Configuration
        { "<leader>v", group = "Config" },
        { "<leader>vm", desc = "Edit nvim config" },
        { "<leader>sv", desc = "Source nvim config" },
        { "<leader>vc", desc = "Search config files" },
        { "<leader>zl", desc = "Edit zellij config" },
        { "<leader>cc", desc = "Fix resize issue" },
        
        -- Git
        { "<leader>gh", desc = "Browse on GitHub" },
        { "<leader>lg", desc = "LazyGit" },
        
        -- Utilities
        { "<leader>tb", desc = "Toggle tagbar" },
        { "<leader>ht", desc = "Toggle hardtime" },
        { "<leader>km", desc = "Show keymaps" },
        { "<leader>bb", desc = "Telescope builtin" },
        
        -- Vimux
        { "<leader>vp", desc = "Vimux prompt command" },
        
        -- LSP
        { "<leader>rn", desc = "LSP rename" },
        { "<leader>ca", desc = "Code actions" },
        { "<leader>f", desc = "Format buffer" },
        { "gd", desc = "Go to definition" },
        { "gi", desc = "Go to implementation" },
        { "gr", desc = "Go to references" },
        { "gR", desc = "LSP references (Trouble)" },
        { "K", desc = "Hover documentation" },
      },
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
