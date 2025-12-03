;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages uxplay)
  #:use-module (guix packages)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages avahi)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages gstreamer)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:))

(define-public uxplay
  (package
   (name "uxplay")
   (version "1.72.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/FDH2/UxPlay")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "1my76bcdfx5p8fpw6jl22r6j3f6lwccrq3mn747mm50fnrl1lxn5"))))
   (build-system cmake-build-system)
   (arguments '(#:tests? #f)) ;; tests do not exist
   (native-inputs `(,pkg-config))
   (inputs (list avahi
                 gst-plugins-base
                 gstreamer
                 libplist
                 libx11
	               openssl))
   (propagated-inputs (list gst-plugins-base
                            gst-plugins-good
                            gst-plugins-bad
                            gst-libav))
   (home-page "https://github.com/FDH2/UxPlay")
   (synopsis "AirPlay Unix mirroring server")
   (description
    "This project is a GPLv3 open source unix AirPlay2 Mirror server for Linux, macOS, and *BSD.")
   (license license:gpl3)))

uxplay
