-- Formatting (conform.nvim) and linting (nvim-lint)
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      { "<leader>lf", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format" },
    },
    opts = {
      formatters_by_ft = {
        go = { "gofumpt", "goimports" },
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
        -- Only auto-format filetypes that have a formatter configured. Ruby has none here
        -- because ruby-lsp formats it with the project's RuboCop or Syntax Tree.
        local formatters = require("conform").list_formatters(bufnr)
        if #formatters == 0 and vim.bo[bufnr].filetype ~= "ruby" then return end

        return { timeout_ms = 2000, lsp_format = "fallback" }
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
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "ruff" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function()
          -- Skip linters that aren't installed, as format on save does for formatters.
          -- eslint's cmd is a function that prefers the project's node_modules copy.
          lint.try_lint(nil, {
            filter = function(linter)
              local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
              return vim.fn.executable(cmd) == 1
            end,
          })
        end,
      })
    end,
  },
}
