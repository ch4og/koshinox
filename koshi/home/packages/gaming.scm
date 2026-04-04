;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gaming)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (aagl)
  #:use-module (nongnu packages nvidia)
  #:use-module (shika packages steam))

(define-public %koshi-gaming-home-packages
  `(,@(specifications->packages (list "freesmlauncher"
                                      "gamescope"
                                      "heroic-nvidia@595"
                                      "mangohud"
                                      "openjdk"
                                      "protonplus-sandbox"
                                      "the-honkers-railway-launcher-nvidia@595"))
    ,(steam-gamescope-for nvda-595)))
