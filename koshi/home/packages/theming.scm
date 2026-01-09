;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages theming)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-theming-home-packages
  (specifications->packages
   '("bibata-cursor-theme"
     "gnome-themes-extra"
     "murrine"
     "qogir-icon-theme"
     "tokyonight-gtk-theme")))
