;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config substitutes))

(define-public %koshi-subs
  '("https://cache-cdn.guix.moe"
    "https://ci.guix.moe"
    "https://ci.guix.gnu.org"
    "https://substitutes.nonguix.org"
    "https://hydra-guix-129.guix.gnu.org/"
    "https://bordeaux.guix.gnu.org"))

(define-public %koshi-subs-urls
  (string-append "--substitute-urls=\""
                 (string-join %koshi-subs " ") "\""))
