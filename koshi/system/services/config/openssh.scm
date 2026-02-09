;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config openssh)
  #:use-module (gnu services ssh)
  #:use-module (gnu packages ssh))

(define-public %koshi-openssh-configuration
  (openssh-configuration (openssh openssh-sans-x)
                         (port-number 2222)))
