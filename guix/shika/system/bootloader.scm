;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system bootloader)
  #:use-module (guix gexp)
  #:use-module (gnu artwork)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (shika lib layout))

(define-public %shika-bootloader-configuration
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets '("/efi"))
   (keyboard-layout %shika-layout)
   (theme (grub-theme
           (inherit (grub-theme))
           (image (file-append %artwork-repository "/grub/GuixSD-16-9.svg"))
           (gfxmode '("1920x1080x32"))))))
