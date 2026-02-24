if status is-interactive
    set should_run 0

    if test "$SHLVL" -eq 1; and not string match -q "linux" $TERM
        set should_run 1
    else if set -q KMS_START_SCRIPT; and test "$SHLVL" -eq 2
        set should_run 1
    end

    if test "$should_run" -eq 1
        if string match -q "*ghostty*" $TERM; or string match -q "*kitty*" $TERM
            fastfetch --logo-type kitty -c ~/.config/fastfetch/autorun.jsonc
        else
            fastfetch -c ~/.config/fastfetch/autorun.jsonc
        end
    end
end
