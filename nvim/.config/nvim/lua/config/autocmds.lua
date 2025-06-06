-- Autocommands configuration
-- Migrated from original .vimrc

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing spaces on save
local TrimWhitespace = augroup("TrimWhitespace", { clear = true })
autocmd("BufWritePre", {
  group = TrimWhitespace,
  pattern = "*",
  command = ":%s/\\s\\+$//e",
})

-- Reload config after saving
local ReloadConfig = augroup("ReloadConfig", { clear = true })
autocmd("BufWritePost", {
  group = ReloadConfig,
  pattern = { "*.lua", "init.lua" },
  callback = function()
    if vim.fn.expand("%:p"):match(vim.fn.stdpath("config")) then
      vim.cmd("source <afile>")
      vim.notify("Config reloaded!")
    end
  end,
})

-- Highlight on yank
local HighlightYank = augroup("HighlightYank", { clear = true })
autocmd("TextYankPost", {
  group = HighlightYank,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Go formatting (will be moved to language-specific config)
local GoFormat = augroup("GoFormat", { clear = true })
autocmd("BufWritePre", {
  group = GoFormat,
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})