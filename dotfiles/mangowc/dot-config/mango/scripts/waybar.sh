#!/usr/bin/env bash
set -euo pipefail

CONFIG="$HOME/.config/waybar/mangowc/config.jsonc"
STYLE="$HOME/.config/waybar/mangowc/style.css"

exec waybar -c "$CONFIG" -s "$STYLE"
