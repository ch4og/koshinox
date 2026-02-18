#!/usr/bin/env bash

COLOR_SCRIPT="$HOME/.config/term-colors.sh"

buffer="$(sh "$COLOR_SCRIPT")"

succ=0

for pts in /dev/pts/*; do
    [[ -w "$pts" ]] || continue
    printf "%s" "$buffer" > "$pts" 2>/dev/null && ((succ++))
done

if [[ -t 1 ]]; then
    printf "%s" "$buffer"
    ((succ++))
fi

echo "Successfully applied colors to $succ terminals."
