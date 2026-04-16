# Neovim Configuration Cheatsheet

Leader key: `Space`

## File Structure

```
~/.config/nvim/
├── init.lua                  # Entry point: leader key, lazy.nvim bootstrap
├── lua/
│   ├── config/
│   │   ├── init.lua          # Loads options -> keymaps -> autocmds -> lazy
│   │   ├── options.lua       # Core vim options (smoothscroll, relativenumber)
│   │   ├── keymaps.lua       # Global keymaps (non-plugin)
│   │   ├── autocmds.lua      # Autocommands (trim whitespace, yank highlight, auto-reload, number toggle)
│   │   └── lazy.lua          # lazy.nvim setup call
│   ├── plugins/
│   │   ├── init.lua          # Imports all plugin modules
│   │   ├── ai.lua            # Copilot
│   │   ├── completion.lua    # nvim-cmp, LuaSnip, friendly-snippets
│   │   ├── debug.lua         # nvim-dap, nvim-dap-ui, dap-go, dap-ruby
│   │   ├── formatting.lua    # conform.nvim (formatting), nvim-lint (linting)
│   │   ├── git.lua           # gitsigns, lazygit, fugitive, rhubarb
│   │   ├── lsp.lua           # nvim-lspconfig, mason, trouble
│   │   ├── navigation.lua    # nvim-tree, leap, aerial.nvim, CamelCaseMotion
│   │   ├── telescope.lua     # Telescope v0.2.2 + fzf-native
│   │   ├── treesitter.lua    # Treesitter + textobjects + endwise
│   │   ├── ui.lua            # dracula, lualine, alpha-nvim, tiny-glimmer
│   │   ├── utilities.lua     # which-key, surround, comment, vim-test, vimux, hardtime, FTerm, zk
│   │   └── lang/
│   │       ├── go.lua        # go.nvim
│   │       └── ruby.lua      # vim-ruby, vim-rails, rbs, textobj-rubyblock
│   └── utils/
│       └── init.lua          # reload_config(), open_plugin_homepage()
```

## Keymap Groups

All keymaps under `<leader>` are organized into coherent groups:

| Prefix | Group | Count |
|--------|-------|-------|
| `Space d` | Debug | 10 |
| `Space f` | Find/Search | 8 |
| `Space t` | Test | 5 |
| `Space g` | Git | 2 |
| `Space h` | Git Hunks | 4 |
| `Space l` | LSP | 2 |
| `Space x` | Diagnostics | 5 |
| `Space z` | Notes (zk) | 4 |
| `Space v` | Config | 6 |

## Buffers & Windows

| Key | Action |
|-----|--------|
| `Tab` | Next buffer (auto-saves if modified) |
| `Shift+Tab` | Previous buffer (auto-saves if modified) |
| `Shift+Q` | Delete buffer |
| `Shift+C` | Close window |

## Find / Search (`Space f`)

| Key | Action |
|-----|--------|
| `Space ff` | Find files (ivy theme) |
| `Space fg` | Live grep |
| `Space fw` | Grep word under cursor |
| `Space fb` | Open buffers (dropdown) |
| `Space fh` | Help tags |
| `Space fc` | Fuzzy find in current buffer |
| `Space fk` | Search keymaps |
| `Space fp` | Browse all Telescope pickers |

### Telescope Insert Mode

| Key | Action |
|-----|--------|
| `Ctrl+j/k` | Move selection down/up |
| `Ctrl+n/p` | Cycle history next/prev |
| `Ctrl+x` | Open in horizontal split |
| `Ctrl+v` | Open in vertical split |
| `Ctrl+t` | Open in new tab |
| `Ctrl+q` | Send all to quickfix |
| `Tab` | Toggle selection |
| `Ctrl+_` | Show which-key help |

## Test (`Space t`)

| Key | Action |
|-----|--------|
| `Space tn` | Run nearest test |
| `Space tf` | Run test file |
| `Space ts` | Run test suite |
| `Space tl` | Run last test |
| `Space tv` | Visit last test file |

## Git (`Space g`)

| Key | Action |
|-----|--------|
| `Space gl` | Open LazyGit |
| `Space gh` | Open file on GitHub (normal + visual) |

### Git Commands (Fugitive)

`:Git`, `:Gstatus`, `:Gblame`, `:Gpush`, `:Gpull`

## Git Hunks (`Space h`)

| Key | Action |
|-----|--------|
| `]h` | Next git hunk |
| `[h` | Previous git hunk |
| `Space hs` | Stage hunk |
| `Space hr` | Reset hunk |
| `Space hp` | Preview hunk |
| `Space hb` | Blame line (full) |

## LSP (`Space l`)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `gi` | Go to implementation |
| `gR` | References (Trouble panel) |
| `K` | Hover documentation |
| `Ctrl+k` | Signature help |
| `Space lr` | Rename symbol |
| `Space la` | Code action |
| `Space lf` | Format buffer (via conform.nvim) |

### LSP Servers (auto-installed via Mason)

- **gopls** -- Go
- **solargraph** -- Ruby
- **lua_ls** -- Lua
- **ts_ls** -- TypeScript/JavaScript

## Formatting & Linting

Format on save is enabled for all configured filetypes. Falls back to LSP if no dedicated formatter is configured.

| Filetype | Formatter | Linter |
|----------|-----------|--------|
| Go | gofumpt, goimports | golangci-lint |
| Ruby | rubocop | rubocop |
| Lua | stylua | -- |
| JS/TS | prettier | eslint |
| Python | black | ruff |
| JSON/YAML/HTML/CSS/Markdown | prettier | -- |

Use `:ConformInfo` to see which formatters are active for the current buffer.

## Debug (`Space d`)

| Key | Action |
|-----|--------|
| `Space db` | Toggle breakpoint |
| `Space dB` | Conditional breakpoint |
| `Space dc` | Continue |
| `Space di` | Step into |
| `Space do` | Step over |
| `Space dO` | Step out |
| `Space dr` | Toggle REPL |
| `Space dl` | Run last debug session |
| `Space dx` | Terminate session |
| `Space du` | Toggle DAP UI |

DAP UI opens/closes automatically when a debug session starts/ends.

### Debugger Adapters

- **Go**: delve (via nvim-dap-go)
- **Ruby**: rdbg (via nvim-dap-ruby)

## Diagnostics (`Space x`)

| Key | Action |
|-----|--------|
| `Space xx` | Toggle diagnostics |
| `Space xw` | Workspace diagnostics |
| `Space xd` | Buffer diagnostics |
| `Space xq` | Quickfix list |
| `Space xl` | Location list |

## Notes (`Space z`)

| Key | Action |
|-----|--------|
| `Space zn` | New note (prompted title) |
| `Space zf` | Find notes (sorted by modified) |
| `Space zg` | Grep across notes |
| `Space zt` | Browse note tags |

Requires [zk](https://github.com/mickael-menu/zk) CLI installed.

## Config (`Space v`)

| Key | Action |
|-----|--------|
| `Space vm` | Open init.lua in vertical split |
| `Space vc` | Search config files |
| `Space vr` | Reload Neovim config |
| `Space vx` | Reload config + fix resize |
| `Space vz` | Open Zellij config |
| `Space vp` | Vimux: prompt command |

## Navigation

| Key | Action |
|-----|--------|
| `,,` | Toggle file tree (nvim-tree) |
| `Space o` | Toggle code outline (aerial.nvim, uses LSP/treesitter) |
| `s{char}{char}` | Leap forward |
| `S{char}{char}` | Leap backward |
| `Space w/b/e` | CamelCase word motions |

## UI / Visual Feedback

Yank and paste use `tiny-glimmer.nvim` animations by default:

- Yank uses `fade`
- Paste uses `reverse_fade`
- Search navigation uses `pulse`
- Undo and redo animations are currently disabled

### TinyGlimmer Commands

`:TinyGlimmer enable`, `:TinyGlimmer disable`, `:TinyGlimmer fade`, `:TinyGlimmer reverse_fade`, `:TinyGlimmer bounce`, `:TinyGlimmer left_to_right`, `:TinyGlimmer pulse`, `:TinyGlimmer rainbow`

## Text Editing

| Key | Action |
|-----|--------|
| `gcc` | Toggle line comment (Comment.nvim) |
| `gc{motion}` | Toggle comment over motion |
| `ys{motion}{char}` | Add surrounding (nvim-surround) |
| `ds{char}` | Delete surrounding |
| `cs{old}{new}` | Change surrounding |

`end`/`endif`/`endfunction` keywords are auto-inserted by treesitter-endwise.

### Treesitter Text Objects

| Key | Action |
|-----|--------|
| `af` / `if` | Around/inside function |
| `ac` / `ic` | Around/inside class |
| `Ctrl+Space` | Init/increment selection |
| `Alt+Space` | Decrement selection |
| `Ctrl+s` | Scope incremental |

## AI / Copilot

| Key | Action |
|-----|--------|
| `Ctrl+k` (insert) | Open Copilot panel |

## Tmux Integration

| Key | Action |
|-----|--------|
| `Esc+h/j/k/l` | Resize pane left/down/up/right |

## Standalone Keymaps

| Key | Action |
|-----|--------|
| `Space ?` | Show buffer-local keymaps (which-key) |
| `Space H` | Toggle Hardtime |
| `Alt+i` | Toggle floating terminal (FTerm) |
| `gp` | Open plugin homepage (in vim/lua files) |

## Autocommands

- **Trim trailing whitespace** on save (except markdown, gitcommit, diff, text)
- **Auto-reload config** when saving any Lua file under `~/.config/nvim/`
- **Highlight on yank** (fallback Visual highlight before lazy UI plugins take over)
- **Auto checktime** on focus gained / buffer enter
- **Number toggle** -- relative numbers in normal mode, absolute in insert mode

## Plugin List

| Plugin | Category | Load |
|--------|----------|------|
| dracula/vim | Theme | startup |
| nvim-lualine/lualine.nvim | Statusline | startup |
| goolord/alpha-nvim | Dashboard | startup |
| rachartier/tiny-glimmer.nvim | Edit animations | VeryLazy |
| nvim-tree/nvim-web-devicons | Icons | lazy |
| nvim-telescope/telescope.nvim | Finder | cmd/keys |
| nvim-treesitter/nvim-treesitter | Syntax | BufRead |
| nvim-treesitter-textobjects | Text objects | dep |
| nvim-treesitter-endwise | Auto-end | InsertEnter |
| neovim/nvim-lspconfig | LSP | BufRead |
| williamboman/mason.nvim | LSP install | cmd |
| folke/trouble.nvim | Diagnostics | cmd/keys |
| stevearc/conform.nvim | Formatting | BufWritePre |
| mfussenegger/nvim-lint | Linting | BufRead |
| hrsh7th/nvim-cmp | Completion | InsertEnter |
| L3MON4D3/LuaSnip | Snippets | lazy |
| lewis6991/gitsigns.nvim | Git signs | BufRead |
| kdheepak/lazygit.nvim | Git UI | keys |
| tpope/vim-fugitive | Git cmds | cmd |
| tpope/vim-rhubarb | GitHub | keys |
| github/copilot.vim | AI | InsertEnter |
| nvim-tree/nvim-tree.lua | File tree | keys |
| stevearc/aerial.nvim | Code outline | keys |
| ggandor/leap.nvim | Motion | VeryLazy |
| bkad/CamelCaseMotion | Motion | VeryLazy |
| mfussenegger/nvim-dap | Debug | keys |
| rcarriga/nvim-dap-ui | Debug UI | dep |
| leoluz/nvim-dap-go | Debug Go | dep |
| suketa/nvim-dap-ruby | Debug Ruby | dep |
| folke/which-key.nvim | Key help | VeryLazy |
| kylechui/nvim-surround | Surround | VeryLazy |
| numToStr/Comment.nvim | Comments | VeryLazy |
| vim-test/vim-test | Testing | keys |
| preservim/vimux | Tmux | keys |
| better-vim-tmux-resizer | Tmux resize | VeryLazy |
| m4xshen/hardtime.nvim | Habit break | VeryLazy |
| mickael-menu/zk-nvim | Notes | keys |
| numToStr/FTerm.nvim | Terminal | keys |
| ray-x/go.nvim | Go | ft |
| vim-ruby/vim-ruby | Ruby | ft |
| tpope/vim-rails | Rails | ft |
