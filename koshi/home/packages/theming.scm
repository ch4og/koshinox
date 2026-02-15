;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages theming)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-theming-home-packages
  (specifications->packages (list "adw-gtk3-theme"
                                  "bibata-cursor-theme"
                                  "breeze"
                                  "breeze-gtk"
                                  "gnome-themes-extra"
                                  "kvantum"
                                  "murrine"
                                  "qogir-icon-theme"
                                  "qt5ct"
                                  "qt6ct"
                                  "tokyonight-gtk-theme")))
