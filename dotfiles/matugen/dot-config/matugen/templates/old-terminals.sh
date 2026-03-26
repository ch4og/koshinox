#!/usr/bin/env bash

COLOR_SCRIPT="$HOME/.config/term-colors.sh"
buffer="$(bash "$COLOR_SCRIPT")"

succ=0

for pts in /dev/pts/*; do
    [[ -w "$pts" ]] || continue

    if timeout 0.1s bash -c 'exec 3>"$1"; printf "%s" "$2" >&3' _ "$pts" "$buffer" 2>/dev/null; then
        ((succ++))
    fi
done

if [[ -t 1 ]]; then
    printf "%s" "$buffer"
    ((succ++))
fi

echo "Successfully applied colors to $succ terminals."
