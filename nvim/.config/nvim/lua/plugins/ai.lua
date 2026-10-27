-- AI-powered coding assistance plugins

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    -- Leave <Tab> to nvim-cmp; copilot reads this when it is sourced, so it must be set in init.
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      -- The plugin starts its client on VimEnter, which has already passed when InsertEnter loads it.
      vim.fn["copilot#Init"]()

      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Accept Copilot suggestion",
      })
      vim.keymap.set("i", "<M-k>", "<ESC>:Copilot panel<cr>", { noremap = true, desc = "Open Copilot panel" })
    end,
  },
}
