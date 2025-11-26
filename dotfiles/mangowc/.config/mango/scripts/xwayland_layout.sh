#!/usr/bin/env -S guix shell setxkbmap -- sh


current_layout=$(setxkbmap -query | grep variant | awk '{print $2}')

if [[ "$current_layout" == "colemak," ]]; then
    setxkbmap -model pc105 -layout us,ru -option grp:alt_shift_toggle
else
    setxkbmap -model pc105 -layout us,ru -variant colemak, -option grp:alt_shift_toggle
fi
