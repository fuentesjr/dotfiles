-- Formatting (conform.nvim) and linting (nvim-lint)
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
        ruby = { "rubocop" },
        lua = { "stylua" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        markdown = { "prettier" },
        python = { "black" },
      },
      format_on_save = function(bufnr)
        -- Only auto-format filetypes that have a formatter configured
        local ft = vim.bo[bufnr].filetype
        local formatters = require("conform").list_formatters(bufnr)
        if #formatters == 0 then return end

        -- Disable auto-format for filetypes where it may be disruptive
        local slow_format_filetypes = {}
        if slow_format_filetypes[ft] then return end

        return { timeout_ms = 2000, lsp_fallback = true }
      end,
    },
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        ruby = { "rubocop" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "ruff" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
