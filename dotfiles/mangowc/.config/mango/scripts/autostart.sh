#!/usr/bin/env sh

dbus-update-activation-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots

swaync &

swww-daemon & swww restore &

waybar &

wl-clip-persist --clipboard regular --reconnect-tries 0 &

wl-paste --watch cliphist store &

mmsg -d focusmon,eDP-1 &

env ~/.config/mango/scripts/switch_layouts.sh
