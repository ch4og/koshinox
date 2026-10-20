if status is-interactive; and not set -q TMUX_POPUP
    if test "$SHLVL" -eq 1; or begin
        test -n "$TMUX"
        and test "$SHLVL" -eq 2
    end
        echo ""
        fastfetch
    end
end
