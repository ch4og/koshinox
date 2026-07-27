;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home services config user-directories)
  #:use-module (gnu home services xdg))

(define-public %koshi-home-download-dir
  "$HOME/downloads")

(define-public %koshi-home-user-directories-configuration
  (home-xdg-user-directories-configuration
    (desktop     "$HOME")
    (documents   "$HOME/documents")
    (download    %koshi-home-download-dir)
    (music       "$HOME")
    (pictures    "$HOME/pictures")
    (publicshare "$HOME")
    (templates   "$HOME")
    (videos      "$HOME/videos")))
