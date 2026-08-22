;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages)
  #:use-module (guix utils)
  #:use-module (koshi home packages audio)
  #:use-module (koshi home packages compression)
  #:use-module (koshi home packages containers)
  #:use-module (koshi home packages desktop)
  #:use-module (koshi home packages development)
  #:use-module (koshi home packages fonts)
  #:use-module (koshi home packages games)
  #:use-module (koshi home packages graphics)
  #:use-module (koshi home packages gtk)
  #:use-module (koshi home packages icons)
  #:use-module (koshi home packages networking)
  #:use-module (koshi home packages password-utils)
  #:use-module (koshi home packages qt)
  #:use-module (koshi home packages terminals)
  #:use-module (koshi home packages textutils)
  #:use-module (koshi home packages video)
  #:use-module (koshi home packages wayland)
  #:use-module (koshi home packages web))

(define (load-category category)
  (module-ref (resolve-interface `(koshi home packages ,category))
              (symbol-append '%koshi- category '-home-packages)))

(define %package-categories
  '(audio
    compression
    containers
    desktop
    development
    fonts
    games
    graphics
    gtk
    icons
    networking
    password-utils
    qt
    terminals
    textutils
    video
    wayland
    web))

(define-public %koshi-home-packages
  (apply append
         (map load-category %package-categories)))
