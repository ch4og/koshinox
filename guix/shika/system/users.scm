;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system users)
  #:use-module (gnu system shadow)
  #:use-module (gnu packages shells)
  #:use-module (guix gexp))

(define (make-shika-user username)
  (user-account
   (name username)
   (group "users")
   (shell (file-append fish "/bin/fish"))
   (supplementary-groups '("wheel" "seat"
                           "audio" "netdev"
                           "video" "plugdev"
                           "docker"))))

(define-public (make-shika-users username)
  (cons (make-shika-user username) %base-user-accounts))
