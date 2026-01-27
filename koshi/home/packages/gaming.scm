;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gaming)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-gaming-home-packages
  (specifications->packages
   '("gamescope"
     "heroic-nvidia"
     "an-anime-game-launcher-nvidia"
     "mangohud"
     "openjdk"
     "prismlauncher-dolly"
     "protonplus-sandbox"
     "sleepy-launcher-nvidia"
     "the-honkers-railway-launcher-nvidia"
     "steam-nvidia")))
