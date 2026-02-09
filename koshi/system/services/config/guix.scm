;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config guix)
  #:use-module (gnu)
  #:use-module (gnu packages package-management)
  #:use-module (koshi lib channels)
  #:use-module (koshi lib keys)
  #:use-module (koshi lib substitutes))

(define-public (make-koshi-guix-configuration config)
  (guix-configuration (inherit config)
                      (channels %koshi-chs)
                      (guix (guix-for-channels %koshi-chs))
                      (substitute-urls %koshi-subs)
                      (extra-options `("--gc-keep-derivations=yes"
                                       "--gc-keep-outputs=yes"
                                       "--cores=16"))
                      (authorized-keys %koshi-keys)))
