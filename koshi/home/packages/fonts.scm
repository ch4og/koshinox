;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages fonts)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-fonts-home-packages
  (specifications->packages (list "font-awesome-nonfree"
                                  "fontforge"
                                  "font-google-noto"
                                  "font-google-noto-emoji"
                                  "font-google-noto-sans-cjk"
                                  "font-microsoft-web-core-fonts")))
