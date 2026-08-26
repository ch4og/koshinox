;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages gtk)
  #:use-module (gnu packages))

(define-public %koshi-gtk-home-packages
  (specifications->packages (list "adw-gtk3-theme"
                                  "adwaita-for-steam"
                                  "breeze-gtk"
                                  "gnome-themes-extra"
                                  "hicolor-icon-theme"
                                  "murrine"
                                  "tokyonight-gtk-theme")))
