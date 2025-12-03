;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages dmenu-bluetooth)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages suckless)
  #:use-module ((guix licenses) #:prefix license:))

(define-public dmenu-bluetooth
  (let ((commit "96e2e3e1dd7ea2d2ab0c20bf21746aba8d70cc46"))
  (package
    (name "dmenu-bluetooth")
    (version (git-version "0.0.0" "0" commit))
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/Layerex/dmenu-bluetooth")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0qhssjs0jwk56wya1i8f32f9ysjrjaaj1kkn3q5rpz5xd9fqyvfh"))))
    (build-system copy-build-system)
    (arguments
     `(#:install-plan '(("dmenu-bluetooth" "bin/"))))
    (inputs (list bluez))
    (home-page "https://github.com/Layerex/dmenu-bluetooth")
    (synopsis
     "A dmenu menu that uses bluetoothctl to connect to bluetooth devices and display status.")
    (description
     "A script that generates a dmenu (or other) menu that uses bluetoothctl to connect to bluetooth devices and display status info.")
    (license license:gpl3))))

dmenu-bluetooth
