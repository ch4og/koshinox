;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config keys)
  #:use-module (gnu)
  #:use-module (guix gexp))

(define-public %koshi-keys
  (cons (plain-file "non-guix.pub"
                    "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
        %default-authorized-guix-keys))
