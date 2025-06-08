# User configuration

# export GPG_TTY=$(tty) ## So that are git commits get auto signed
#

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export PATH="$HOME/.local/bin:$PATH"
export GOPATH=$HOME/go
export EDITOR="nvim"
export ARCHFLAGS="-arch x86_64"
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='--height 70% --border'
fi
export DISABLE_SPRING=true

# Personal aliases
alias ll="ls -al"
alias zshrc="nvim ~/.zshrc"
alias be="bundle exec"
alias vimf="vim \$(fzf)"
alias claude="/Users/sal/.claude/local/claude"

# jujutsu completion
autoload -U compinit
compinit
source <(jj util completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

eval "$(/usr/local/bin/brew shellenv)"
eval "$(rbenv init - --no-rehash zsh)"
