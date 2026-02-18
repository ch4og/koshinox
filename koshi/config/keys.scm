;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config keys)
  #:use-module (gnu)
  #:use-module (guix gexp))

(define-public %koshi-keys
  (cons* (plain-file "non-guix.pub"
                     "(public-key (ecc (curve Ed25519) (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
         (plain-file "guix-science-nonfree.pub"
                     "(public-key (ecc (curve Ed25519) (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))")
         (plain-file "guix-moe-old.pub"
                     "(public-key (ecc (curve Ed25519) (q #374EC58F5F2EC0412431723AF2D527AD626B049D657B5633AAAEBC694F3E33F9#)))")
         (plain-file "guix-moe.pub"
                     "(public-key (ecc (curve Ed25519) (q #552F670D5005D7EB6ACF05284A1066E52156B51D75DE3EBD3030CD046675D543#)))")
         %default-authorized-guix-keys))
