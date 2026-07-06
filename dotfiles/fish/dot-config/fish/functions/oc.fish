function oc -d "Wrapper for opencode"
    if test (count $argv) -eq 0
        opencode
    else if test "$argv[1]" = "s"
        opencode session list --format json --pure | cat - | jq -r '.[] | "\(.id)  \(.title)"' | cat - | fzf --prompt="opencode session> " | read -l picked
        if test -n "$picked"
            set -l session_id (string split '  ' -- $picked)[1]
            opencode -s $session_id
        end
    else if test "$argv[1]" = "run"
        opencode run $argv[2..]
    else
        opencode $argv
    end
end
