-- Git-related plugins
return {
  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "+" },
        change       = { text = "~" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local opts = { buffer = bufnr, silent = true }

        vim.keymap.set("n", "]h", gs.next_hunk, vim.tbl_extend("force", opts, { desc = "Next git hunk" }))
        vim.keymap.set("n", "[h", gs.prev_hunk, vim.tbl_extend("force", opts, { desc = "Prev git hunk" }))
        vim.keymap.set("n", "<leader>hs", gs.stage_hunk, vim.tbl_extend("force", opts, { desc = "Stage hunk" }))
        vim.keymap.set("n", "<leader>hr", gs.reset_hunk, vim.tbl_extend("force", opts, { desc = "Reset hunk" }))
        vim.keymap.set("n", "<leader>hp", gs.preview_hunk, vim.tbl_extend("force", opts, { desc = "Preview hunk" }))
        vim.keymap.set("n", "<leader>hb", function() gs.blame_line({ full = true }) end, vim.tbl_extend("force", opts, { desc = "Blame line" }))
      end,
    },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
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

}
