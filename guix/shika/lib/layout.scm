;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika lib layout)
  #:use-module (gnu system keyboard))

(define-public %shika-layout
  (keyboard-layout "us,ru" "colemak,"
		               #:options '("grp:alt_shift_toggle")))
