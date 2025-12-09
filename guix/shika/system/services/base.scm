;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services base)
  #:use-module (gnu)
  #:use-module (gnu services sysctl)
  #:use-module (shika system services config guix)
  #:use-module (shika system services config sysctl))

(define-public %shika-base-services
  (modify-services
   %base-services
   (guix-service-type config => (make-shika-guix-configuration config))
   (sysctl-service-type config => (make-shika-sysctl-configuration config))))
