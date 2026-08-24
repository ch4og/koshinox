if status is-interactive
    zoxide init fish | source
    fzf --fish | source
    starship init fish | source

    if test -n "$TMUX"; and test -n "$DIRENV_DIR"
        set --erase (set --names --export | string match --regex '^DIRENV_.*')
    end

    direnv hook fish | source
end
