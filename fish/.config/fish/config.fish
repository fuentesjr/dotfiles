if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set GPG TTY so that git commits get auto signed
set -x GPG_TTY (tty)

set -x PATH $HOME/.cargo/bin $PATH

alias vfish="vim $HOME/.config/fish/config.fish"
alias be="bundle exec"
alias vimrc="vim $HOME/.vimrc"
alias tmuxconf="vim $HOME/.tmux.conf"
alias ta="tmux attach"

status --is-interactive; and . (nodenv init -|psub)
