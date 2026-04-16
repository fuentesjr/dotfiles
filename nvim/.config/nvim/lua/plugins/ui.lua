-- UI and theme plugins
return {
  -- Colorschemes
  {
    "dracula/vim",
    name = "dracula",
    -- Load the colorscheme early so later UI plugins inherit the intended highlights.
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("dracula")
    end,
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function()
      require("nvim-web-devicons").setup()
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
          section_separators = { left = "", right = "" },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        tabline = {
          lualine_a = { "buffers" },
          lualine_z = { "tabs" },
        },
      })
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      if vim.fn.executable("figlet") == 1 then
        dashboard.section.header.val =
          vim.fn.split(vim.fn.system("figlet -w 100 '[ GitHub / GitCoin ]'"), "\n")
      else
        dashboard.section.header.val = { "[ GitHub / GitCoin ]" }
      end

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
        dashboard.button("c", "  Config", ":Telescope find_files cwd=" .. vim.fn.stdpath("config") .. "<CR>"),
        dashboard.button("l", "󰒲  Lazy", ":Lazy<CR>"),
        dashboard.button("q", "  Quit", ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
    end,
  },

  -- Animated visual feedback for edits
  {
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10,
    config = function()
      require("tiny-glimmer").setup({
        disable_warnings = true,
        hijack_ft_disabled = { "alpha", "snacks_dashboard" },
        overwrite = {
          yank = {
            enabled = true,
            default_animation = "fade",
          },
          paste = {
            enabled = true,
            default_animation = "reverse_fade",
          },
          search = {
            enabled = true,
            default_animation = "pulse",
          },
          undo = {
            enabled = false,
          },
          redo = {
            enabled = false,
          },
        },
      })
    end,
  },
}
