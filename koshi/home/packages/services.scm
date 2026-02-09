;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages services)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-services-home-packages
  (specifications->packages (list "bluez"
                                  "pipewire"
                                  "wireplumber"
                                  "nftables"
                                  "zapret")))
