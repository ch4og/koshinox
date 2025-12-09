;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services config sysctl)
  #:use-module (gnu)
  #:use-module (gnu services sysctl))

(define-public (make-shika-sysctl-configuration config)
  (sysctl-configuration
   (settings
    (append
     '(("vm.max_map_count" . "1048576"))
     %default-sysctl-settings))))
