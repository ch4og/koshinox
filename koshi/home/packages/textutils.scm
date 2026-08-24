;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages textutils)
  #:use-module (gnu packages))

(define-public %koshi-textutils-home-packages
  (specifications->packages (list "bat"
                                  "binutils"
                                  "btop-nvidia"
                                  "du-dust"
                                  "eza"
                                  "fastfetch-no-zfs"
                                  "fd"
                                  "file"
                                  "fzf"
                                  "jq"
                                  "lsof"
                                  "pandoc"
                                  "ripgrep"
                                  "ripgrep-all"
                                  "starship"
                                  "stow"
                                  "xdg-user-dirs"
                                  "xdg-utils"
                                  "zoxide")))
