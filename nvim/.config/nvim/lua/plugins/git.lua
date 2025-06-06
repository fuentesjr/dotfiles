-- Git-related plugins
return {
  -- Git signs in gutter
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Git commands
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- GitHub integration
  {
    "tpope/vim-rhubarb",
    dependencies = { "tpope/vim-fugitive" },
    keys = {
      { "<leader>gh", ":GBrowse!<CR>:GBrowse<CR>", desc = "Open on GitHub", mode = "n" },
      { "<leader>gh", ":GBrowse!<CR>gv:GBrowse<CR>", desc = "Open on GitHub", mode = "v" },
    },
  },

  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.keymap.set("i", "<C-k>", "<ESC>:Copilot panel<cr>", { noremap = true })
    end,
  },
}