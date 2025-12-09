;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system filesystems)
  #:use-module (gnu system file-systems))

(define-public %shika-file-systems
  (append (list (file-system
                 (device (uuid "3f026519-10e9-4d92-8253-06558d5d8374"))
                 (mount-point "/")
                 (type "btrfs")
                 (options "compress=zstd,subvol=root"))
                (file-system
                 (device (uuid "3f026519-10e9-4d92-8253-06558d5d8374"))
                 (mount-point "/gnu/store")
                 (type "btrfs")
                 (options "compress=zstd,subvol=gnu-store"))
                (file-system
                 (device (uuid "7c8864a5-1473-4cf2-94f9-9823a5e50ba0"))
                 (mount-point "/home")
                 (type "btrfs")
                 (options "compress=zstd,subvol=home"))
                (file-system
                 (device (uuid "EE1B-9309" 'fat))
                 (mount-point "/boot/efi")
                 (type "vfat")))
          %base-file-systems))
