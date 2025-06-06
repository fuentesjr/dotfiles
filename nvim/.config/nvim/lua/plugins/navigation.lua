-- Navigation plugins
return {
  -- File explorer (modernized NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { ",,", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
    },
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        git = {
          enable = true,
          ignore = false,
          timeout = 500,
        },
      })
    end,
  },

  -- Motion plugin (leap)
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").set_default_keymaps()
    end,
  },

  -- Tagbar
  {
    "preservim/tagbar",
    keys = {
      { "<leader>tb", ":TagbarToggle<cr>", desc = "Toggle tagbar" },
    },
  },

  -- CamelCase motion
  {
    "bkad/CamelCaseMotion",
    config = function()
      vim.g.camelcasemotion_key = "<leader>"
    end,
  },
}