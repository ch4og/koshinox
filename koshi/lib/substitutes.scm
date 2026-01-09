;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi lib substitutes))

(define-public %koshi-subs
  '("https://mirror.yandex.ru/mirrors/guix"
    "https://mirror.sjtu.edu.cn/guix"
    "https://bordeaux.guix.gnu.org"
    "https://nonguix-proxy.ditigal.xyz"
    "https://cache-fi.guix.moe"
    "https://cache-cdn.guix.moe"
    "https://guix.bordeaux.inria.fr"))

(define-public %koshi-subs-urls
  (string-append "--substitute-urls=\""
                 (string-join %koshi-subs " ") "\""))

