-- Utility functions
local M = {}

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

-- Set up the plugin homepage keymap for vim files
vim.api.nvim_create_augroup("UtilsVimrc", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "UtilsVimrc",
  pattern = "vim",
  callback = function()
    vim.keymap.set("n", "gp", M.open_plugin_homepage, { 
      buffer = true, 
      silent = true, 
      desc = "Open plugin homepage" 
    })
  end,
})

return M