;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home packages apps)
  #:use-module (guix utils)
  #:use-module (gnu packages))

(define-public %koshi-apps-home-packages
  (specifications->packages
   (list "blueman"
         "emacs-pgtk"
         "eog"
         "file-roller"
         "filezilla"
         "foot"
         "gimp"
         "kdenlive"
         "libreoffice"
         "mpv-nvidia"
         "obs-nvidia"
         "obs-wlrobs"
         "pavucontrol"
         "pcmanfm"
         "qbittorrent-enhanced"
         "remmina"
         "senpai"
         "spotatui"
         "torbrowser"
         "uxplay"
         "virt-manager")))
