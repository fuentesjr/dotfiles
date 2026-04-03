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
        { "<leader>d", group = "Debug" },
        { "<leader>f", group = "Find/Search" },
        { "<leader>t", group = "Test" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git Hunks" },
        { "<leader>l", group = "LSP" },
        { "<leader>x", group = "Diagnostics" },
        { "<leader>z", group = "Notes (zk)" },
        { "<leader>v", group = "Config" },
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
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {},
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
      { "<leader>tn", ":TestNearest<CR>", desc = "Nearest" },
      { "<leader>tf", ":TestFile<CR>", desc = "File" },
      { "<leader>ts", ":TestSuite<CR>", desc = "Suite" },
      { "<leader>tl", ":TestLast<CR>", desc = "Last" },
      { "<leader>tv", ":TestVisit<CR>", desc = "Visit" },
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
    event = "VeryLazy",
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

  -- Hardtime - break bad habits
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      { "<leader>H", "<cmd>Hardtime toggle<cr>", desc = "Toggle Hardtime" },
    },
    opts = {
      max_count = 3,
      disable_mouse = false,
      restriction_mode = "hint",
    },
  },

  -- Note taking
  {
    "mickael-menu/zk-nvim",
    keys = {
      { "<leader>zn", "<cmd>ZkNew { title = vim.fn.input('Title: ') }<cr>", desc = "New note" },
      { "<leader>zf", "<cmd>ZkNotes { sort = { 'modified' } }<cr>", desc = "Find notes" },
      { "<leader>zg", "<cmd>ZkGrep<cr>", desc = "Grep notes" },
      { "<leader>zt", "<cmd>ZkTags<cr>", desc = "Note tags" },
    },
    config = function()
      require("zk").setup({ picker = "telescope" })
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
