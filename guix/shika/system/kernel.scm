;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system kernel)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd))

(define-public %shika-kernel linux)

(define-public %shika-initrd microcode-initrd)

(define-public %shika-kernel-arguments
  '("nvidia_drm.modeset=1"
    "module_blacklist=pcspkr,nouveau"))
