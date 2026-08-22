;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages containers)
  #:use-module (gnu packages))

(define-public %koshi-containers-home-packages
  (specifications->packages (list "docker-full"
                                  "passt"
                                  "podman"
                                  "podman-compose"
                                  "slirp4netns")))
