#!/usr/bin/env sh

dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

swaync &

swww-daemon & swww restore &

env ~/.config/mango/scripts/waybar.sh &

wl-clip-persist --clipboard regular --reconnect-tries 0 &

wl-paste --watch cliphist store &

wl-paste --type text --watch xclip -selection clipboard &

env ~/.config/mango/scripts/switch_layouts.sh
