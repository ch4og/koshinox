#!/usr/bin/env bash
set -euo pipefail

TEMPLATE="$HOME/.config/waybar/mangowc/template.jsonc"
RUNTIME="/tmp/waybar-generated.jsonc"
STYLE="$HOME/.config/waybar/mangowc/style.css"

cleanup() {
    rm -f "$RUNTIME"
}

trap cleanup EXIT INT TERM

outputs="$(mmsg -O)"

if mmsg -O | grep -qx "HDMI-A-1"; then
    WAYBAR_OUTPUT="HDMI-A-1"
elif mmsg -O | grep -qx "eDP-1"; then
    WAYBAR_OUTPUT="eDP-1"
else
    exit 1
fi

sed "s|@@WAYBAR_OUTPUT@@|$WAYBAR_OUTPUT|g" "$TEMPLATE" > "$RUNTIME"

exec waybar -c "$RUNTIME" -s "$STYLE"
