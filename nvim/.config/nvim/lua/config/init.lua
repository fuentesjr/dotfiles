-- Configuration module loader
-- Loads all configuration modules in the correct order

-- Core configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Plugin configuration (must be loaded after options)
require("config.lazy")