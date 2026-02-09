;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config sysctl)
  #:use-module (gnu)
  #:use-module (gnu services sysctl))

(define-public (make-koshi-sysctl-configuration config)
  (sysctl-configuration
    (settings (append '(("fs.inotify.max_user_instances" . "8192")
                        ("fs.inotify.max_user_watches" . "524288")
                        ("vm.max_map_count" . "1048576"))
                      %default-sysctl-settings))))
