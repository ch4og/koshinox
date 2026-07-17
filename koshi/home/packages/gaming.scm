;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gaming)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (koshi config driver)
  #:use-module (nonguix multiarch-container)
  #:use-module (aagl)
  #:use-module (nongnu packages nvidia)
  #:use-module (nongnu packages game-client))

(define-public %koshi-gaming-home-packages
  `(,@(specifications->packages (list "freesmlauncher"
                                      "gamescope"
                                      "mangohud"
                                      "openjdk"
                                      "osu-lazer-bin"
                                      "protonplus-sandbox"))
    ,(nonguix-container->package (heroic-container-for %koshi-driver))
    ,(nonguix-container->package (steam-container-for %koshi-driver))
    ,(the-honkers-railway-launcher-for %koshi-driver)))
