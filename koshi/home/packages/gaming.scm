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
                                      "heroic-nvidia-new-feature"
                                      "mangohud"
                                      "openjdk"
                                      "protonplus-sandbox"
                                      "the-honkers-railway-launcher-nvidia-new-feature"))
    ,(steam-gamescope-for nvda-new-feature)))
