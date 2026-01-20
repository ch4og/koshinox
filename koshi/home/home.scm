;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home home)
  #:use-module (koshi home services)
  #:use-module (koshi home packages)
  #:use-module (gnu home))

(define-public (make-koshi-home username)
  (home-environment
    (packages %koshi-home-packages)
    (services (make-koshi-home-services username))))
