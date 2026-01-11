#!/usr/bin/env sh

dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

swaync &

swww-daemon & swww restore &

env ~/.config/mango/scripts/waybar.sh &

wl-clip-persist --clipboard regular --reconnect-tries 0 &

wl-paste --watch cliphist store &

env ~/.config/mango/scripts/switch_layouts.sh
