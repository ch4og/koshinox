;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages terminals)
  #:use-module (gnu packages))

(define-public %koshi-terminals-home-packages
  (specifications->packages (list "foot"
                                  "ncurses"
                                  "senpai"
                                  "tmux-sixel")))
