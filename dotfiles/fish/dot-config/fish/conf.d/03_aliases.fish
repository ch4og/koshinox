if status is-interactive
  alias ls="eza --icons auto"
  alias ll='eza -l --icons auto'
  alias tree='eza --tree --icons auto'
  alias e='emacsclient -t'
  alias cd='z'
  alias grep='grep --color=auto'
  alias dust='dust -d 1 '
  alias ip='ip -c'
  alias cat='bat -pp'
  alias t='tmux'
  alias lg='lazygit'
  alias ssh='env TERM=xterm-256color ssh'
  abbr -a !! --position anywhere --function last_history_item
end
