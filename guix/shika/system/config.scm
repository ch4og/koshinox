;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system config)
  #:use-module (gnu)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages nvidia)
  #:use-module (nonguix utils)
  #:use-module (shika lib channels)
  #:use-module (shika lib substitutes)
  #:use-module (shika lib layout)
  #:use-module (shika system bootloader)
  #:use-module (shika system filesystems)
  #:use-module (shika system kernel)
  #:use-module (shika system packages)
  #:use-module (shika system services)
  #:use-module (shika system users)
  #:use-module (koshi packages kmscon)
  #:use-module (guix gexp))

(define-public (make-shika-os username hostname timezone locale)
    (operating-system
     (kernel %shika-kernel)
     (initrd %shika-initrd)
     (kernel-arguments %shika-kernel-arguments)
     (host-name hostname)
     (timezone timezone)
     (locale locale)
     (keyboard-layout %shika-layout)
     (bootloader %shika-bootloader-configuration)
     (file-systems %shika-file-systems)
     (users (make-shika-users username))
     (packages %shika-system-packages)
     (services %shika-system-services)
     (name-service-switch %mdns-host-lookup-nss)))

(define-public %shika-os
  (make-shika-os "ch" "noko" "Europe/Moscow" "en_US.utf8"))

(define-public %shika-os-nvidia
  (with-transformation replace-mesa %shika-os)

%shika-os-nvidia
