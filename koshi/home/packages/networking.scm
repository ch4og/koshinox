;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages networking)
  #:use-module (gnu packages))

(define-public %koshi-networking-home-packages
  (specifications->packages (list "bind:utils"
                                  "blueman"
                                  "bluez"
                                  "curl"
                                  "filezilla"
                                  "nftables"
                                  "qbittorrent-enhanced"
                                  "rclone"
                                  "s3cmd"
                                  "zapret")))
