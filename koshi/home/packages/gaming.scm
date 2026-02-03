;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gaming)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (aagl)
  #:use-module (nongnu packages game-client)
  #:use-module (nongnu packages nvidia))

(define-public %koshi-gaming-home-packages
  `(,@(specifications->packages
       '("gamescope"
         "mangohud"
         "openjdk"
         "prismlauncher-dolly"
         "protonplus-sandbox"))
    ,(heroic-for nvdb)
    ,(steam-for nvdb)
    ,(the-honkers-railway-launcher-for nvdb)))
