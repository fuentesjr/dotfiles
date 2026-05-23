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
alias ncheat="glow ~/.config/nvim/CHEATSHEET.md"
alias cpconfig="ssh hermes 'cat .hermes/config.yaml' | pbcopy"

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

# bun completions
[ -s "/Users/sal/.bun/_bun" ] && source "/Users/sal/.bun/_bun"


# ${UserConfigDir}/zsh/.zshrc
autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)


# >>> grok installer >>>
export PATH="$HOME/.grok/bin:$PATH"
fpath=(~/.grok/completions/zsh $fpath)
autoload -Uz compinit && compinit -C
# <<< grok installer <<<
