#!/usr/bin/env sh

env ~/.config/mango/scripts/polkit.sh &

swaync &

pywalfox install &

avizo-service &

awww-daemon & awww restore &

waybar -c ~/.config/waybar/mangowm/config.jsonc -s ~/.config/waybar/mangowm/style.css &

wl-clip-persist --clipboard regular --reconnect-tries 0 &

wl-paste --watch cliphist store &

wl-paste --type text --watch xclip -selection clipboard &

env ~/.config/mango/scripts/switch_layouts.sh &

mmsg -d "focusmon,eDP-1"
