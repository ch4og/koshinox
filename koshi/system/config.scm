;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system config)
  #:use-module (koshi system os)
  #:use-module (koshi config driver)
  #:use-module (nongnu packages linux)
  #:use-module (nonguix utils)
  #:use-module (nonguix transformations))

(define-public %koshi-os
  (make-koshi-os "ch" "noko"))

(define-public %koshi-os-nvidia
  ((compose (nonguix-transformation-nvidia #:driver %koshi-driver
                                           #:open-source-kernel-module? #t
                                           #:dynamic-boost? #t
                                           #:remove-nvenc-restriction? #t)
            (nonguix-transformation-linux #:linux linux-7.0))
   %koshi-os))

%koshi-os-nvidia
