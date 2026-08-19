#!/usr/bin/env sh

env ~/.config/mango/scripts/polkit.sh &

xwayland-satellite &

swaync &

pywalfox install &

avizo-service &

emacs --daemon &
Throne &


awww-daemon & awww restore &

waybar -c ~/.config/waybar/mangowm/config.jsonc -s ~/.config/waybar/mangowm/style.css &

wl-clip-persist --clipboard regular --reconnect-tries 0 &

wl-paste --watch cliphist store &

wl-paste --type text --watch xclip -selection clipboard &

env ~/.config/mango/scripts/switch_layouts.sh &

mmsg dispatch "focusmon,eDP-1" &

WebHID-for-Firefox-Server &

tosu &

cli-proxy-api -config /home/ch/.local/share/cli-proxy-api/config.yaml &

pkill -9 -f OpenTabletDriver.Daemon 2>/dev/null; sleep 0.1 && otd-daemon
