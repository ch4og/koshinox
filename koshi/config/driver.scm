;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config driver)
  #:use-module (nonguix transformations)
  #:use-module (nonguix utils)
  #:use-module (nongnu packages nvidia))

(define-public %koshi-driver nvda-new-feature)

(define-public koshi-nvidia-transform
  (nonguix-transformation-nvidia
   #:driver %koshi-driver
   #:open-source-kernel-module? #t))
