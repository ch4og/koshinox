;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config network-manager)
  #:use-module (gnu services networking))

(define-public %koshi-network-manager-configuration
  (network-manager-configuration (dns "dnsmasq")))
