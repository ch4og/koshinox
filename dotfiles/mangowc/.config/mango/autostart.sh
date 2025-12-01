#!/usr/bin/env sh

swww-daemon
swww restore
mmsg -d focusmon,eDP-1
sleep 0.3 && waybar
