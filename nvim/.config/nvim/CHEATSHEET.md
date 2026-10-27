# Neovim Configuration Cheatsheet

Leader key: `Space`

For leader keymaps, press `Space` and wait for which-key. This sheet covers the rest: how to find keymaps, keys outside the leader groups, insert-mode keys, automatic behavior, and commands.

## Find Keymaps

| Key | Shows |
|-----|-------|
| `Space`, then wait | Leader groups and their keys (which-key) |
| `Space ?` | Buffer-local keys (which-key) |
| `Space fk` | Every keymap, searchable (Telescope) |
| `Space fp` | Every Telescope picker |
| `Ctrl+_` (insert) or `?` (normal) in a Telescope prompt | The picker's own keys |

## Keys Outside the Leader

| Key | Action |
|-----|--------|
| `Tab`, `Shift+Tab` | Next, previous buffer |
| `Ctrl+h`, `j`, `k`, `l` | Move between splits and tmux panes |
| `Alt+h`, `j`, `k`, `l` | Resize the split or tmux pane |
| `Alt+i` | Toggle the floating terminal |
| `,,` | Toggle the file tree |
| `s`, `S` | Leap forward, backward |
| `gs` | Leap to another window |
| `gd` | Go to definition |
| `K` | Hover documentation |
| `grr`, `gri`, `gra`, `grn`, `grt` | References, implementation, code action, rename, type definition (Neovim defaults) |
| `gR` | LSP references in Trouble |

## Insert Mode

| Key | Action |
|-----|--------|
| `Tab`, `Shift+Tab` | Next, previous completion item, or jump within a snippet |
| `Enter` | Confirm completion |
| `Ctrl+Space` | Open completion |
| `Ctrl+e` | Close completion |
| `Ctrl+b`, `Ctrl+f` | Scroll completion docs |

## Automatic Behavior

- **Format on save** runs the filetype's formatters from the table below when at least one is installed. `Space lf` formats on demand and falls back to the LSP. Run `:ConformInfo` to see what is installed for the buffer.
- **Ruby** formatting and diagnostics come from ruby-lsp, which picks tools from the project's Gemfile and gemspec:
  - RuboCop formats and lints when a gem whose name starts with `rubocop` is listed, or when RuboCop comes in through another gem and the project has a `.rubocop.yml`.
  - Syntax Tree formats instead when `syntax_tree` is listed and no gem starting with `rubocop` is.
  - Otherwise Ruby files are not formatted or linted.
- **Linting** runs the filetype's linters from the table below on open, on save, and on leaving insert mode. A new file is linted after its first save. Linters run from the nearest folder with a package.json, go.mod, pyproject.toml, .git, or .jj, otherwise from Neovim's current directory. eslint is the nearest `node_modules/.bin/eslint` above the file, else the one on PATH. Go files in a module lint their whole package. Linters that aren't installed are skipped without a message.
- **Trailing whitespace** is trimmed on save, except in markdown, gitcommit, diff, and text buffers.
- **Config reload**: saving a Lua file in the config directory re-runs options, keymaps, and autocmds. Restart Neovim to apply plugin changes.
- **Files changed outside Neovim** reload when Neovim gains focus or you enter the buffer.
- **Relative numbers** turn off in insert mode and in unfocused windows.
- **Mouse selections** are copied to the system clipboard. Keyboard selections reach the clipboard only when you yank.
- **endwise** inserts the closing keyword (`end`, `endif`, `fi`, `done`, and so on) in Ruby, Lua, Vimscript, and Bash.
- **CSV and TSV** buffers open in csvview's table view; `Space cv` toggles it. While the view is on, `]f` and `[f` jump between fields, `]r` and `[r` jump between rows, and `if` and `af` select a field.

| Filetype | Formatter | Linter |
|----------|-----------|--------|
| Go | gofumpt, goimports | golangci-lint |
| Ruby | ruby-lsp (RuboCop or Syntax Tree) | ruby-lsp (RuboCop) |
| Lua | stylua | -- |
| JS, TS | prettier | eslint |
| Python | black | ruff |
| JSON, YAML, HTML, CSS, Markdown | prettier | -- |

## Commands

| Command | Use |
|---------|-----|
| `:G` | Fugitive: git status, or any git subcommand (`:G blame`, `:G push`) |
| `:Lazy` | Plugins, their load triggers, and updates |
| `:Mason` | Install and update LSP servers |
| `:ConformInfo` | Formatters for the current buffer |
| `:checkhealth vim.lsp` | LSP clients attached to the buffer |
| `:CsvViewEnable display_mode=border` | Table view with options; also `:CsvViewDisable`, `:CsvViewInfo` |
| `:TinyGlimmer enable`, `:TinyGlimmer disable` | Turn yank and paste animations on or off |

## External Tools

- `Space z` notes need the [zk](https://github.com/mickael-menu/zk) CLI.
- Ruby needs the `ruby-lsp` gem in each project's Ruby (`gem install ruby-lsp`). Neovim starts it with `mise x -- ruby-lsp`, not through Mason. ruby-lsp starts only for files with a Gemfile, .git, or .jj above them.
- Go debugging needs delve (`dlv`); Ruby debugging needs `rdbg`. The DAP UI opens and closes with the debug session.
- This config doesn't install the formatters and linters in the table; install the ones you use.
