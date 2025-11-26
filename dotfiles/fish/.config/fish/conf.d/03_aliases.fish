if status is-interactive
  alias ls="eza --icons auto"
  alias ll='eza -l --icons auto'
  alias tree='eza --tree --icons auto'
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
  alias cd='z'
  alias grep='grep --color=auto'
  alias dust='dust -d 1 '
  alias ip='ip -c'
  alias cat='bat -pp'
  alias t='tmux'
  abbr -a !! --position anywhere --function last_history_item
end
