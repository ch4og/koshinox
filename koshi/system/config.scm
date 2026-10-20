;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system config)
  #:use-module (koshi system os)
  #:use-module (koshi config driver)
  #:use-module (gnu packages linux)
  #:use-module (nongnu packages linux)
  #:use-module (nonguix utils)
  #:use-module (nonguix transformations))

(define-public %koshi-os
  ((nonguix-transformation-linux #:linux linux)
   (make-koshi-os "ch" "noko")))

(define-public %koshi-os-nvidia
  (koshi-nvidia-transform
   %koshi-os))

%koshi-os-nvidia
