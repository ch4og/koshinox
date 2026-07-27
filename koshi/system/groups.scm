;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system groups)
  #:use-module (gnu system shadow))

(define-public %koshi-groups
  (cons (user-group
          (name "plugdev")
          (system? #t))
        %base-groups))
