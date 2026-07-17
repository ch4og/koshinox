;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home config)
  #:use-module (nongnu packages nvidia)
  #:use-module (koshi home home)
  #:use-module (koshi config driver))

(define %koshi-home
  (make-koshi-home "ch"))

(define %koshi-home-nvidia
  (replace-mesa %koshi-home #:driver %koshi-driver))

%koshi-home-nvidia
