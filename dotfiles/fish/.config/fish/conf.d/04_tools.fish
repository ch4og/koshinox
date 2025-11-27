if status is-interactive
    zoxide init fish | source
    fzf --fish | source
    starship init fish | source
end
