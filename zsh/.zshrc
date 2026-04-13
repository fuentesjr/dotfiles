typeset -U PATH

export GOPATH=$HOME/go
export BUN_INSTALL="$HOME/.bun"
export EDITOR="nvim"
# export GPG_TTY=$(tty)

export PATH="$HOME/.local/bin:$GOPATH/bin:$HOME/.opencode/bin:$HOME/.antigravity/antigravity/bin:$BUN_INSTALL/bin:$PATH"

eval "$(/usr/local/bin/brew shellenv)"

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='--height 70% --border'
fi

# Personal aliases
alias ls="eza --group-directories-first --icons=always --color=always"
alias ll="ls -al"
alias zshrc="nvim ~/.zshrc"
alias be="bundle exec"
alias vimf="nvim \$(fzf)"
alias showpath='echo "$PATH" | tr ":" "\n"'

# Completions (cached, refreshed every 24h)
autoload -U compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

command -v jj &>/dev/null && source <(jj util completion zsh)
command -v but &>/dev/null && eval "$(but completions zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Tool managers
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
command -v mise &>/dev/null && eval "$(mise activate zsh)"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
