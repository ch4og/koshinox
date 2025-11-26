if status is-interactive
  if test -z "$WAYLAND_DISPLAY" && test "$(tty)" = "/dev/tty1"
    exec mango
  end
end

