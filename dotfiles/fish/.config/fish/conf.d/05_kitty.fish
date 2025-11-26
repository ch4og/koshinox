if status is-interactive
  if string match -q "*kitty*" $TERM
    alias ssh="kitten ssh"
  end
end
