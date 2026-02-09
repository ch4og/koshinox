;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (koshi home packages apps)
  #:use-module (koshi home packages browser)
  #:use-module (koshi home packages development)
  #:use-module (koshi home packages fonts)
  #:use-module (koshi home packages gaming)
  #:use-module (koshi home packages services)
  #:use-module (koshi home packages theming)
  #:use-module (koshi home packages utils)
  #:use-module (koshi home packages wayland))

(define (load-category category)
  (module-ref (resolve-interface `(koshi home packages ,category))
              (symbol-append '%koshi- category '-home-packages)))

(define %package-categories
  (list apps
        browser
        development
        fonts
        gaming
        services
        theming
        utils
        wayland))

(define-public %koshi-home-packages
  (apply append
         (map load-category %package-categories)))
