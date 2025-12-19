;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika lib substitutes))

(define-public %shika-subs
  '("https://mirror.yandex.ru/mirrors/guix"
    "https://mirror.sjtu.edu.cn/guix"
    "https://bordeaux.guix.gnu.org"
    "https://nonguix-proxy.ditigal.xyz"
    "https://substitutes.nonguix.org"
    "https://guix.bordeaux.inria.fr"))

(define-public %shika-subs-urls
  (string-append "--substitute-urls=\""
                 (string-join %shika-subs " ") "\""))

