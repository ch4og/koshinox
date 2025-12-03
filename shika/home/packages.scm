;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika home packages))
(use-modules (guix utils)
             (gnu packages)
             (gnu packages wm)
             (gnu packages dns)
             (guix transformations)
             (nongnu packages nvidia)
             (quickshell))
(define transform
  (options->transformation '((with-graft . "mesa=nvda"))))

(append (append (specifications->packages '("bind:utils")) `(,quickshell-git))
        (map transform
             (map specification->package
                  '("bat"
                    "blueman"
                    "bluez"
                    "bibata-cursor-theme"
                    "btop"
                    "cliphist"
                    "curl"
                    "direnv"
                    "dmenu-bluetooth"
                    "emacs-no-x"
                    "eog"
                    "eza"
                    "fastfetch"
                    "fd"
                    "file"
                    "file-roller"
                    "filezilla"
                    "firefox"
                    "font-awesome-nonfree"
                    "fontforge"
                    "font-google-noto"
                    "font-google-noto-sans-cjk"
                    "font-google-noto-emoji"
                    "fzf"
                    "ghostty"
                    "gnupg"
                    "grim"
                    "grimblast"
                    "heroic-nvidia"
                    "hyprpicker"
                    "imagemagick"
                    "jq"
                    "jujutsu"
                    "kdenlive"
                    "krita"
                    "lazygit"
                    "libreoffice"
                    "mangowc"
                    "mpv"
                    "ncurses"
                    "network-manager-applet"
                    "networkmanager-dmenu"
                    "nftables"
                    "orchis-theme"
                    "pavucontrol"
                    "pcmanfm"
                    "pinentry"
                    "pipewire"
                    "playerctl"
                    "protonup"
                    "qbittorrent-enhanced"
                    "remmina"
                    "reuse"
                    "ripgrep"
                    "rofi"
                    "slurp"
                    "starship"
                    "steam"
                    "swappy"
                    "swaybg"
                    "swaylock-effects"
                    "swaynotificationcenter"
                    "swww"
                    "tmux"
                    "torbrowser"
                    "uxplay"
                    "unzip"
                    "virt-manager"
                    "waybar-experimental"
                    "wireplumber"
                    "wl-clipboard"
                    "wtype"
                    "xdg-desktop-portal"
                    "xdg-desktop-portal-gtk"
                    "xdg-desktop-portal-wlr"
                    "xdg-utils"
                    "zapret"
                    "zip"
                    "zoxide"))))

