;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system bootloader)
  #:use-module (guix gexp)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (koshi config layout))

(define-public %koshi-bootloader-configuration
  (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/efi"))
    (keyboard-layout %koshi-layout)))
