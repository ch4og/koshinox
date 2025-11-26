export SHELL

fundle plugin 'jorgebucaran/replay.fish'
fundle plugin 'pure-fish/pure'
fundle plugin 'gazorby/fish-abbreviation-tips'
fundle plugin 'franciscolourenco/done'
fundle init

replay source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
replay source ~/.profile

gpg-connect-agent updatestartuptty /bye

if status is-interactive
  function last_history_item; echo $history[1]; end
  abbr -a !! --position anywhere --function last_history_item

  zoxide init fish | source
  fzf --fish | source

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
  alias ssh='kitten ssh'
  alias t='tmux'

  if string match -q "*kitty*" $TERM && test "$SHLVL" -eq 1 && test -z "$IN_NIX_SHELL" && test -z "$GUIX_ENVIRONMENT"
      command -v "fastfetch" > /dev/null 2>&1; and fastfetch
  end

  if test -z "$WAYLAND_DISPLAY" && test "$(tty)" = "/dev/tty1"
    exec mango
  end
end

if not status is-interactive
    if set -q SSH_CLIENT
        replay source /etc/profile
    end
end
