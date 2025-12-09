;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services config xorg)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages xorg)
  #:use-module (nongnu packages nvidia))

(define-public %shika-xorg-configuration
  (xorg-configuration
   (modules (cons nvda %default-xorg-modules))
   (drivers '("nvidia"))))
