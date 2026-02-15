;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages wayland)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-wayland-home-packages
  (specifications->packages (list "cliphist"
                                  "dmenu-bluetooth"
                                  "glib:bin"
                                  "grim"
                                  "grimblast"
                                  "gsettings-desktop-schemas"
                                  "hyprpicker"
                                  "mangowc@git"
                                  "mate-polkit"
                                  "matugen-shika"
                                  "networkmanager-dmenu"
                                  "quickshell"
                                  "rofi"
                                  "rofi-rbw"
                                  "setxkbmap"
                                  "slurp"
                                  "swappy"
                                  "swaybg"
                                  "swaylock-effects"
                                  "swaynotificationcenter"
                                  "swww"
                                  "waybar-experimental"
                                  "wayfreeze"
                                  "waypaper"
                                  "wl-clipboard"
                                  "wl-clip-persist"
                                  "wl-mirror"
                                  "wlr-dpms"
                                  "wtype"
                                  "xclip"
                                  ;; "xdg-desktop-portal"
                                  "xdg-desktop-portal-gtk"
                                  "xdg-desktop-portal-wlr"
                                  "xeyes")))
