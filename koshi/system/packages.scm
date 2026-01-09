;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system packages)
  #:use-module (gnu)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim))

(define-public %koshi-system-packages
  (cons* vim
         fish
         openssh
         git
         font-hack
         font-google-noto
         font-google-noto-emoji
         font-google-noto-sans-cjk
         %base-packages))
