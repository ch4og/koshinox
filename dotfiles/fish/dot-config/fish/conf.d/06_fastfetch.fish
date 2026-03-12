if status is-interactive
    if test "$SHLVL" -eq 1; and not string match -q "linux" $TERM
        if string match -q "*ghostty*" $TERM; or string match -q "*kitty*" $TERM
            fastfetch --logo-type kitty -c ~/.config/fastfetch/autorun.jsonc
        else
            fastfetch -c ~/.config/fastfetch/autorun.jsonc
        end
    end
end
