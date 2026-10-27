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
      formatters = {
        -- prettier loads the project's config and plugins, which are code. conform checks
        -- the condition only after finding prettier, so a machine without it never asks.
        prettier = {
          condition = function(_, ctx) return require("utils").project_trusted(ctx.filename) end,
        },
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
    -- Load at startup, not on a buffer event. Lazy-loading on BufReadPost races filetype
    -- detection: the first file's FileType event fires before the lint autocmd exists.
    lazy = false,
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        go = { "golangcilint" },
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "ruff" },
      }

      -- The stock cmd only checks ./node_modules, which misses an eslint hoisted to a
      -- monorepo root. Search upward from the file instead.
      lint.linters.eslint.cmd = function()
        for dir in vim.fs.parents(vim.api.nvim_buf_get_name(0)) do
          local bin = dir .. "/node_modules/.bin/eslint"
          if vim.uv.fs_stat(bin) then return bin end
        end
        return "eslint"
      end

      -- golangci-lint decides between linting the file and its package once, from Neovim's
      -- startup cwd, so a file outside that module misses symbols from sibling files.
      -- Decide per buffer instead. Patched on first use because loading the linter
      -- spawns golangci-lint and go; args is nil when golangci-lint isn't installed.
      lint.linters.golangcilint = function()
        local linter = require("lint.linters.golangcilint")
        local args = linter.args
        if args and type(args[#args]) == "function" then
          args[#args] = function()
            local file = vim.api.nvim_buf_get_name(0)
            return vim.fs.root(file, "go.mod") and vim.fs.dirname(file) or file
          end
        end
        return linter
      end

      vim.api.nvim_create_autocmd({ "BufWritePost", "FileType", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
        callback = function()
          -- Skip buffers not yet saved: golangci-lint exits with an error on a path that doesn't exist.
          if not vim.uv.fs_stat(vim.api.nvim_buf_get_name(0)) then return end

          -- Run linters from the file's project root, not Neovim's cwd, so eslint finds the
          -- project's config and golangci-lint runs inside the file's module.
          -- The nested list gives the markers equal priority: the nearest one wins.
          local root = vim.fs.root(0, { { "package.json", "go.mod", "pyproject.toml", ".git", ".jj" } })

          -- nvim-lint evaluates linter args with a temporary :cd to root, which drops this
          -- window's :lcd and the tab's :tcd. Put all three levels back afterwards.
          local function dirs()
            return { vim.fn.getcwd(-1, -1), vim.fn.haslocaldir(-1, 0), vim.fn.getcwd(-1, 0),
              vim.fn.haslocaldir(0), vim.fn.getcwd(0) }
          end
          local before = dirs()

          -- Skip linters that aren't installed, as format on save does for formatters.
          -- eslint loads the project's config, which is code, even when it comes from PATH.
          -- Check executable first so a machine without eslint never sees the trust prompt.
          lint.try_lint(nil, {
            cwd = root,
            filter = function(linter)
              local cmd = type(linter.cmd) == "function" and linter.cmd() or linter.cmd
              if vim.fn.executable(cmd) ~= 1 then return false end
              return linter.name ~= "eslint" or require("utils").project_trusted(vim.api.nvim_buf_get_name(0))
            end,
          })

          if not vim.deep_equal(before, dirs()) then
            local mods = { noautocmd = true }
            vim.cmd.cd({ before[1], mods = mods })
            if before[2] == 1 then vim.cmd.tcd({ before[3], mods = mods }) end
            if before[4] == 1 then vim.cmd.lcd({ before[5], mods = mods }) end
          end
        end,
      })
    end,
  },
}
