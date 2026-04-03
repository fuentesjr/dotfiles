-- Utility functions
local M = {}

M.reload_config = function()
  local modules_to_clear = {}

  -- Lua caches required modules, so a straight :source won't pick up many config edits.
  for name in pairs(package.loaded) do
    if name == "config"
      or name:match("^config%.")
      or name == "plugins"
      or name:match("^plugins%.")
      or name == "utils"
      or name:match("^utils%.")
    then
      table.insert(modules_to_clear, name)
    end
  end

  for _, name in ipairs(modules_to_clear) do
    package.loaded[name] = nil
  end

  -- Re-run init.lua so bootstrap code and module loading happen in the normal order.
  local init_file = vim.env.MYVIMRC or (vim.fn.stdpath("config") .. "/init.lua")
  local ok, err = pcall(dofile, init_file)

  if ok then
    vim.notify("Config reloaded!")
  else
    vim.notify("Config reload failed:\n" .. err, vim.log.levels.ERROR)
  end
end

-- Function to open plugin homepage (migrated from .vimrc)
M.open_plugin_homepage = function()
  local line = vim.fn.getline(".")
  local plugin_name = [[\w\+ \([''"]\)\(.\{-}\)\1]]
  
  local match = vim.fn.matchlist(line, plugin_name)
  if #match > 0 then
    local repository = match[3]
    if repository then
      local url = "https://github.com/" .. repository
      vim.fn.system("$BROWSER " .. url)
    else
      vim.notify('No match for "<user>/<repository>" on this line!')
    end
  else
    vim.notify('No match for "<user>/<repository>" on this line!')
  end
end

-- Set up the plugin homepage keymap for vim and lua files
vim.api.nvim_create_augroup("UtilsVimrc", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "UtilsVimrc",
  pattern = { "vim", "lua" },
  callback = function()
    vim.keymap.set("n", "gp", M.open_plugin_homepage, {
      buffer = true,
      silent = true,
      desc = "Open plugin homepage"
    })
  end,
})

return M