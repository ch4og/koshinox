;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services config guix)
  #:use-module (gnu)
  #:use-module (gnu packages package-management)
  #:use-module (shika lib channels)
  #:use-module (shika lib keys)
  #:use-module (shika lib substitutes))

(define-public (make-shika-guix-configuration config)
  (guix-configuration
   (inherit config)
   (channels %shika-chs)
   (guix (guix-for-channels %shika-chs))
   (substitute-urls %shika-subs)
   (extra-options `("--gc-keep-derivations=yes" "--gc-keep-outputs=yes" "--cores=16"))
   (authorized-keys %shika-keys)))
