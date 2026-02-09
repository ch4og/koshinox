;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages development)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-development-home-packages
  (specifications->packages (list "direnv"
                                  "jujutsu"
                                  "lazygit"
                                  "maak"
                                  "passt"
                                  "podman"
                                  "podman-compose"
                                  "reuse"
                                  "slirp4netns"
                                  "vscodium"
                                  "wakatime-cli")))
