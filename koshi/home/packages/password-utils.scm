;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages password-utils)
  #:use-module (gnu packages))

(define-public %koshi-password-utils-home-packages
  (specifications->packages (list "gnupg"
                                  "openssl"
                                  "pinentry-qt"
                                  "python-yubikey-manager"
                                  "rbw"
                                  "rofi-rbw")))
