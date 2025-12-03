;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages networkmanager-dmenu)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (guix licenses)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages python)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages glib))

(define-public networkmanager-dmenu
  (package
   (name "networkmanager-dmenu")
   (version "2.6.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/firecat53/networkmanager-dmenu")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1r57znpd3rkrm836jw2wb1fx82p724r85n8jb1chzi3p8qlhcf9m"))))
   (build-system copy-build-system)

   (inputs (list network-manager glib bash-minimal))
   (propagated-inputs (list python-wrapper python-pygobject))

   (arguments
    `(#:install-plan '(("networkmanager_dmenu" "bin/")
                       ("networkmanager_dmenu.desktop" "share/applications/")
                       ("README.md" "share/doc/networkmanager-dmenu/")
                       ("config.ini.example" "share/doc/networkmanager-dmenu/"))
      #:phases (modify-phases %standard-phases
                              (add-after 'install 'wrap-program
                                         (lambda* (#:key inputs outputs #:allow-other-keys)
                                                  (let* ((out (assoc-ref outputs "out"))
                                                         (nm (assoc-ref inputs "network-manager"))
                                                         (binary (string-append out "/bin/networkmanager_dmenu"))
                                                         (nm-typelib (string-append nm "/lib/girepository-1.0")))
                                                    (wrap-program binary
                                                                  `("GI_TYPELIB_PATH" ":" prefix (,nm-typelib)))))))))

   (home-page "https://github.com/firecat53/networkmanager-dmenu")
   (synopsis "Control NetworkManager via dmenu")
   (description
    "Manage NetworkManager connections with supported launchers instead of nm-applet.")
   (license expat)))

networkmanager-dmenu
