;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages wayland)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-wayland-home-packages
  (specifications->packages
   '("cliphist"
     "dmenu-bluetooth"
     "grim"
     "grimblast"
     "hyprpicker"
     "mangowc@git"
     "networkmanager-dmenu"
     "quickshell@git"
     "rofi"
     "slurp"
     "swappy"
     "swaybg"
     "swaylock-effects"
     "swaynotificationcenter"
     "swww"
     "waybar-experimental"
     "wl-clipboard"
     "wl-mirror"
     "wlr-dpms"
     "wtype"
     ;; "xdg-desktop-portal"
     "xdg-desktop-portal-gtk"
     "xdg-desktop-portal-wlr"
     "xeyes")))
