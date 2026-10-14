;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages games)
  #:use-module (gnu packages)
  #:use-module (koshi config driver)
  #:use-module (nonguix multiarch-container)
  #:use-module (aagl)
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu packages game-client)
  #:use-module (shika packages gamescope))

(define-public %koshi-games-home-packages
  `(,@(specifications->packages (list "prismlauncher-dolly"
                                      "gamescope"
                                      "mangohud"
                                      "openjdk"
                                      "osu-lazer-bin"
                                      "protonplus-sandbox"
                                      "tosu"
                                      "tosu-overlay"))
    ,(heroic-for %koshi-driver #:extra-packages `(("gamescope" ,gamescope)))
    ,(steam-for %koshi-driver #:extra-packages `(("gamescope" ,gamescope)))
    ,(the-honkers-railway-launcher-for %koshi-driver)))
