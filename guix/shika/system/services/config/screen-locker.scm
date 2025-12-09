;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services config screen-locker)
  #:use-module (gnu services xorg)
  #:use-module (gnu packages wm)
  #:use-module (guix gexp))

(define-public %shika-screen-locker-configuration
  (screen-locker-configuration
   (name "swaylock")
   (program (file-append swaylock-effects "/bin/swaylock"))
   (using-pam? #t)
   (using-setuid? #f)))
