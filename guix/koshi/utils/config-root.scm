;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi utils config-root))

(define-public config-root
  (dirname (dirname (dirname (dirname (canonicalize-path (current-filename)))))))
