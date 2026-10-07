#!/usr/bin/env sh

xwayland-satellite &

env ~/.config/mango/scripts/polkit.sh &

swaync &
wl-mirror --backend screencopy-shm eDP-1 &

pywalfox install &

avizo-service &

Throne &
qbittorrent &

# Not supported yet
mmsg dispatch "spawn_on_tag,librewolf,2" &
mmsg dispatch "spawn_on_tag,AyuGram,4" &
mmsg dispatch "spawn_on_tag,spotifast,6" &
mmsg dispatch "spawn_on_tag,steam,5" &

awww-daemon & awww restore &

waybar -c ~/.config/waybar/mangowm/config.jsonc -s ~/.config/waybar/mangowm/style.css &

stash watch --persist &

wl-paste --watch xclip -selection clipboard &

env ~/.config/mango/scripts/switch_layouts.sh &

mmsg dispatch "focusmon,eDP-1" &

WebHID-for-Firefox-Server &

tosu &

cli-proxy-api -config /home/ch/.local/share/cli-proxy-api/config.yaml &

pkill -9 -f OpenTabletDriver.Daemon 2>/dev/null; sleep 0.1 && otd-daemon
