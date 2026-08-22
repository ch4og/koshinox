;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages qt)
  #:use-module (gnu packages))

(define-public %koshi-qt-home-packages
  (specifications->packages (list "breeze"
                                  "kvantum"
                                  "kvantum5"
                                  "qt5ct"
                                  "qt6ct")))
