;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system config)
  #:use-module (koshi system os)
  #:use-module (nonguix utils)
  #:use-module (nonguix transformations))

(define-public %koshi-os
  (make-koshi-os "ch" "noko"))

(define-public %koshi-os-nvidia
  ((compose (nonguix-transformation-nvidia)
            (nonguix-transformation-linux))
   %koshi-os))

%koshi-os-nvidia
