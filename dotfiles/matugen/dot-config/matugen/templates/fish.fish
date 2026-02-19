if status is-interactive; and isatty stdout; and not set -q SSH_CLIENT; and string match -vq "linux" $TERM
  sh ~/.config/term-colors.sh
end
