;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system os)
  #:use-module (gnu)
  #:use-module (koshi config layout)
  #:use-module (koshi system bootloader)
  #:use-module (koshi system filesystems)
  #:use-module (koshi system kernel)
  #:use-module (koshi system packages)
  #:use-module (koshi system services)
  #:use-module (koshi system users))

(define-public (make-koshi-os username hostname)
  (operating-system
    (kernel-arguments %koshi-kernel-arguments)
    (host-name hostname)
    (timezone "Etc/UTC")
    (locale "en_US.utf8")
    (keyboard-layout %koshi-layout)
    (bootloader %koshi-bootloader-configuration)
    (mapped-devices %koshi-mapped-devices)
    (file-systems %koshi-file-systems)
    (swap-devices %koshi-swap-devices)
    (users (make-koshi-users username))
    (packages %koshi-system-packages)
    (services (make-koshi-system-services username))
    (name-service-switch %mdns-host-lookup-nss)))
