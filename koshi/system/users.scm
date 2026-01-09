;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system users)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages shells)
  #:use-module (guix gexp))

(define (make-koshi-user username)
  (user-account
    (name username)
    (group "users")
    (shell (file-append fish "/bin/fish"))
    (supplementary-groups '("wheel" "seat"
                            "audio" "netdev"
                            "video" "plugdev"
                            "input"))))

(define-public (make-koshi-users username)
  (cons (make-koshi-user username) %base-user-accounts))
