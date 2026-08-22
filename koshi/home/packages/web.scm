;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages web)
  #:use-module (gnu packages))

(define-public %koshi-web-home-packages
  (specifications->packages (list "librewolf"
                                  "pywalfox"
                                  "ublock-origin-icecat"
                                  "webhid-for-firefox"
                                  "webhid-for-firefox-icecat")))
