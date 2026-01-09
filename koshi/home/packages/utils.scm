;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages utils)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-utils-home-packages
  (specifications->packages
   '("bat"
     "bind:utils"
     "binutils"
     "btop"
     "curl"
     "dust"
     "eza"
     "fastfetch"
     "fd"
     "file"
     "fzf"
     "gnupg"
     "imagemagick"
     "jq"
     "ncurses"
     "pinentry"
     "playerctl"
     "ripgrep"
     "starship"
     "tmux"
     "unzip"
     "xdg-utils"
     "zip"
     "zoxide")))
