-- Go language support
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        goimports = "gopls",
        gofmt = "gofumpt",
        tag_transform = false,
        test_dir = "",
        comment_placeholder = "   ",
        lsp_cfg = false,
        lsp_gofumpt = true,
        dap_debug = true,
      })
    end,
  },
}
