;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config substitutes))

(define-public %koshi-subs
  '("https://ci.guix.gnu.org"
    "https://hydra-guix-129.guix.gnu.org"
    "https://bordeaux.guix.gnu.org"
    "https://nonguix-proxy.ditigal.xyz"
    "https://ci.guix.moe"
    "https://cache-cdn.guix.moe"
    "https://guix.bordeaux.inria.fr"
    "https://mirror.yandex.ru/mirrors/guix"
    "https://mirror.sjtu.edu.cn/guix"))

(define-public %koshi-subs-urls
  (string-append "--substitute-urls=\""
                 (string-join %koshi-subs " ") "\""))
