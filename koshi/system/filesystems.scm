;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og. com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system filesystems)
  #:use-module (gnu)
  #:use-module (shika utils filesystems))

(define-public %koshi-mapped-devices
  (list (mapped-device
          (source (uuid "a2c0fca8-06a8-4eae-9bbc-55b75ca47c69"))
          (target "root")
          (type luks-device-mapping))
        (mapped-device
          (source (uuid "66750ef3-48ad-42c7-82a6-ec8ca931c5c3"))
          (target "home")
          (type luks-device-mapping))))

(define-public %koshi-file-systems
  (cons* (luks-btrfs #:device "root"
                     #:mount-point "/"
                     #:flags '(no-atime)
                     #:compress '(#t force)
                     #:subvol "root"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "root"
                     #:mount-point "/gnu/store"
                     #:flags '(no-atime)
                     #:compress '(#t force)
                     #:subvol "gnu-store"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "root"
                     #:mount-point "/nix"
                     #:flags '(no-atime)
                     #:compress '(#t force)
                     #:subvol "nix"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "root"
                     #:mount-point "/var/log"
                     #:compress #f
                     #:subvol "log"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "home"
                     #:mount-point "/home"
                     #:compress #t
                     #:subvol "home"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "home"
                     #:mount-point "/games"
                     #:compress #t
                     #:subvol "games"
                     #:mapped-devices %koshi-mapped-devices)

         (luks-btrfs #:device "home"
                     #:mount-point "/swap"
                     #:flags '(no-atime)
                     #:compress #f
                     #:subvol "swap"
                     #:mapped-devices %koshi-mapped-devices)

         (file-system
           (device (uuid "350C-92A0" 'fat))
           (mount-point "/efi")
           (type "vfat"))

         %base-file-systems))

(define-public %koshi-swap-devices
  (list (swap-space
          (target "/swap/swapfile")
          (dependencies (filter (file-system-mount-point-predicate "/swap")
                                %koshi-file-systems)))))
