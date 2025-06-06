-- Ruby and Rails support
return {
  -- Ruby syntax and support
  {
    "vim-ruby/vim-ruby",
    ft = "ruby",
  },

  -- Rails support
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },

  -- RBS (Ruby type signatures)
  {
    "pocke/rbs.vim",
    ft = "rbs",
  },

  -- Ruby text objects (already handled in utilities, but kept for clarity)
  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "kana/vim-textobj-user" },
    ft = "ruby",
  },

  -- Ruby DAP support (already in utilities, but kept for organization)
  {
    "suketa/nvim-dap-ruby",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "ruby",
    config = function()
      require("dap-ruby").setup()
    end,
  },
}