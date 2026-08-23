fish_vi_key_bindings
bind ctrl-right forward-word
bind ctrl-left backward-word
bind alt-right nextd-or-forward-word
bind alt-left prevd-or-backward-word
bind -M insert \e\x7f backward-kill-word
bind -M insert \e\[127\;2u backward-kill-word
bind ctrl-alt-h backward-kill-word
bind alt-delete kill-word
