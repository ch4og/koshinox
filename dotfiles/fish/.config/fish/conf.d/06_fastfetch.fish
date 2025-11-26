if status is-interactive
    if string match -q "*kitty*" $TERM
        if test "$SHLVL" -eq 1 && test -z "$IN_NIX_SHELL" && test -z "$GUIX_ENVIRONMENT"
            command -v fastfetch >/dev/null 2>&1 && fastfetch
        end
    end
end
