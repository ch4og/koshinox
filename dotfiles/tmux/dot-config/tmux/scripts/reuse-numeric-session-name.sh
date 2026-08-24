#!/usr/bin/env sh
set -eu

session_id=${1:?missing session ID}
session_name=$(tmux display-message -p -t "$session_id" '#{session_name}')
session_number=${session_id#\$}

if [ "$session_name" != "$session_number" ]; then
    exit 0
fi

number=0
while [ "$number" -lt "$session_number" ]; do
    if ! tmux has-session -t "=$number" 2>/dev/null; then
        exec tmux rename-session -t "$session_id" "$number"
    fi
    number=$((number + 1))
done
