;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages video)
  #:use-module (gnu packages))

(define-public %koshi-video-home-packages
  (specifications->packages (list "kdenlive"
                                  "mpv-nvidia"
                                  "obs-with-cef-nvidia"
                                  "obs-wlrobs"
                                  "yt-dlp")))
