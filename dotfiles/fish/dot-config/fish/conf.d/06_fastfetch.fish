if status is-interactive
    if string match -q "*ghostty*" $TERM || string match -q "*kitty*" $TERM
        if test "$SHLVL" -eq 1
            fastfetch --logo-type kitty -c ~/.config/fastfetch/autorun.jsonc
        end
    end
    if string match -q "foot" $TERM
        if test "$SHLVL" -eq 1
            fastfetch -c ~/.config/fastfetch/autorun.jsonc
        end
    end
end
