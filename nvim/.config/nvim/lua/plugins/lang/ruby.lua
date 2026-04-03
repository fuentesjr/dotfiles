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

  -- Ruby text objects
  {
    "nelstrom/vim-textobj-rubyblock",
    dependencies = { "kana/vim-textobj-user" },
    ft = "ruby",
  },
}