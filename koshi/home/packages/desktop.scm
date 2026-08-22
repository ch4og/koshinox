;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages desktop)
  #:use-module (gnu packages))

(define-public %koshi-desktop-home-packages
  (specifications->packages (list "equibop"
                                  "file-roller"
                                  "flatpak"
                                  "libreoffice"
                                  "opentabletdriver"
                                  "pcmanfm"
                                  "remmina"
                                  "virt-manager")))
