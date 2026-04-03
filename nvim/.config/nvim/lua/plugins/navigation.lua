-- Navigation plugins
return {
  -- File explorer (modernized NERDTree)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { ",,", "<cmd>NvimTreeToggle<cr>", desc = "Toggle File Tree" },
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
    event = "VeryLazy",
    dependencies = { "tpope/vim-repeat" },
    config = function()
      require("leap").create_default_mappings()
    end,
  },

  -- Code outline via LSP/treesitter
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Toggle Outline" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
      layout = {
        min_width = 30,
        default_direction = "right",
      },
      filter_kind = false,
    },
  },

  -- CamelCase motion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    config = function()
      vim.g.camelcasemotion_key = "<leader>"
    end,
  },
}
