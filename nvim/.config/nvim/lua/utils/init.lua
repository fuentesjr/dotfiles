-- Utility functions
local M = {}

-- lazy.nvim refuses to run setup twice, so only modules that don't depend on plugins at
-- load time are re-run. Plugin spec changes still need a restart.
local reloadable = { "utils", "config.options", "config.keymaps", "config.autocmds" }

M.reload_config = function()
  -- Lua caches required modules, so a straight :source won't pick up many config edits.
  for _, name in ipairs(reloadable) do
    package.loaded[name] = nil
  end

  for _, name in ipairs(reloadable) do
    local ok, err = pcall(require, name)
    if not ok then
      vim.notify("Config reload failed:\n" .. err, vim.log.levels.ERROR)
      return
    end
  end

  vim.notify("Config reloaded. Restart Neovim to apply plugin changes.")
end

-- eslint, prettier, ts_ls, and ruby-lsp run code from the project, so ask once per project
-- through Neovim's trust list. The project is the repo, else the package. Cache answers
-- because vim.secure.read asks again after "ignore".
local trusted = {}
M.project_trusted = function(path)
  local unit = vim.fs.root(path, { { ".git", ".jj" } }) or vim.fs.root(path, { { "package.json", "Gemfile" } })
  if not unit then return true end
  if trusted[unit] == nil then trusted[unit] = vim.secure.read(unit) == true end
  return trusted[unit]
end

return M
