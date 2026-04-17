-- AI-powered coding assistance plugins

return {
  -- GitHub Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.keymap.set("i", "<M-k>", "<ESC>:Copilot panel<cr>", { noremap = true, desc = "Open Copilot panel" })
    end,
  },
}
