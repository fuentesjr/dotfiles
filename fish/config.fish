if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set GPG TTY so that git commits get auto signed
set -x GPG_TTY (tty)

alias vfish="vim ~/.config/fish/config.fish"
alias be="bundle exec"
alias vimrc="vim ~/.vimrc"
alias tmuxconf="vim ~/.tmux.conf"
