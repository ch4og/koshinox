;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika lib keys)
  #:use-module (guix gexp))

(define-public %shika-keys
  (list
   (plain-file
    "non-guix.pub"
    "(public-key (ecc
       (curve Ed25519)
         (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")
   (plain-file
    "guix-science-nonfree.pub"
    "(public-key (ecc
       (curve Ed25519)
         (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)))")))
