;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system packages)
  #:use-module (gnu)
  #:use-module (gnu packages docker)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim))

(define-public %shika-system-packages
  (cons* vim
         fish
         openssh
         git
         docker
         font-hack
         font-google-noto
         font-google-noto-emoji
         font-google-noto-sans-cjk
         %base-packages))
