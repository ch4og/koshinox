;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gaming)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (aagl)
  #:use-module (nongnu packages nvidia))

(define-public %koshi-gaming-home-packages
  `(,@(specifications->packages (list "freesmlauncher"
                                      "gamescope"
                                      "heroic-nvidia-new-feature"
                                      "mangohud"
                                      "openjdk"
                                      "osu-lazer-bin"
                                      "protonplus-sandbox"
                                      "steam-nvidia-new-feature"
                                      "the-honkers-railway-launcher-nvidia-new-feature"))))
