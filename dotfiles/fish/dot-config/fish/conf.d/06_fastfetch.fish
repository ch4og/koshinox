if status is-interactive
    if test "$SHLVL" -eq 1; or begin
        test -n "$TMUX"
        and test "$SHLVL" -eq 2
    end
        if not string match -q "linux" $TERM
            echo ""
            if string match -q "*ghostty*" $TERM; or string match -q "*kitty*" $TERM
                fastfetch --logo-type kitty
            else
                fastfetch
            end
        end
    end
end
