;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system bootloader)
  #:use-module (guix gexp)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (rosenthal bootloader grub)
  #:use-module (koshi lib layout))

(define-public %koshi-bootloader-configuration
  (bootloader-configuration
    (bootloader grub-efi-luks2-bootloader)
    (targets '("/efi"))
    (keyboard-layout %koshi-layout)
    (theme (grub-theme (inherit (grub-theme))
                       (gfxmode '("1920x1080x32"))))))
