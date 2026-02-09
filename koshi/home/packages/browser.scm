;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages browser)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-browser-home-packages
  (specifications->packages (list "librewolf"
                                  "adaptive-tab-bar-colour-icecat"
                                  "bitwarden-icecat"
                                  "livemarks-icecat"
                                  "ublock-origin-icecat")))
