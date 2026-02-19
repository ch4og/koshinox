;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config kmscon)
  #:use-module (gnu services base)
  #:use-module (koshi config layout)
  #:use-module (shika packages kmscon)
  #:use-module (guix gexp))

(define-public (generate-koshi-kmscon-configuration tty)
  (kmscon-configuration
    (virtual-terminal tty)
    (hardware-acceleration? #t)
    (keyboard-layout %koshi-layout)
    (kmscon (@ (shika packages kmscon) kmscon))))
