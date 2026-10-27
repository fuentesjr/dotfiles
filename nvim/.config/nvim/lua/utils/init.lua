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

return M
