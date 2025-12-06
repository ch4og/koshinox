#!/usr/bin/env bash

targets="starrail.exe"
declare -A state

mmsg -w | while read monitor field value; do
    [ "$field" = "appid" ] || continue
    prev="${state[$monitor]}"
    if echo "$value" | grep -qE "^($targets)$"; then
        [ "$prev" != "in" ] && mmsg -d "setoption,xkb_rules_variant,"
        state[$monitor]="in"
    else
        [ "$prev" = "in" ] && mmsg -d "setoption,xkb_rules_variant,colemak,"
        state[$monitor]="out"
    fi
done
