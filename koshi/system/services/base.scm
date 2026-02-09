;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services base)
  #:use-module (gnu)
  #:use-module (gnu services sysctl)
  #:use-module (koshi system services config guix)
  #:use-module (koshi system services config sysctl))

(define-public %koshi-base-services
  (modify-services %base-services
    (guix-service-type config =>
                       (make-koshi-guix-configuration config))
    (sysctl-service-type config =>
                         (make-koshi-sysctl-configuration config))))
