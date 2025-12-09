;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system bootloader)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (shika lib layout))

(define-public %shika-bootloader-configuration
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets '("/boot/efi"))
   (keyboard-layout %shika-layout)))
