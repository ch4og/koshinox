;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages kmscon)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix build-system meson)
  #:use-module (gnu packages check)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module ((guix licenses) #:prefix license:))


(define-public libtsm
  (package
   (name "libtsm")
   (version "4.3.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/kmscon/libtsm")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0nryrzvphf878y9lpgx3zbm126qqnf4y65qv3rvzhpdj00w100y4"))))
   (build-system meson-build-system)
   (native-inputs (list check
                        libxkbcommon
                        pkg-config))
   (home-page "https://github.com/kmscon/libtsm")
   (synopsis "Terminal-emulator State Machine")
   (description
    "TSM is a state machine for DEC VT100-VT520 compatible
terminal emulators.  It tries to support all common standards while keeping
compatibility to existing emulators like xterm, gnome-terminal, konsole, etc.")
   (license (list license:expat license:lgpl2.1+ license:isc license:bsd-2))))

(define-public kmscon
  (package
   (name "kmscon")
   (version "9.2.1")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/kmscon/kmscon")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "0dspyvjljd23xb1j32ivpvbhpwh4bgm15wgjkywblfnr6rjfmq1j"))))
   (build-system meson-build-system)
   (native-inputs (list pkg-config
                        libxslt
                        docbook-xsl))
   (inputs (list check
                 libxkbcommon
                 elogind
                 libtsm
                 eudev
                 libdrm
                 mesa
                 pango))
   (home-page "https://github.com/kmscon/kmscon")
   (synopsis "Linux KMS/DRM based virtual Console Emulator")
   (description
    "Simple terminal emulator based on linux kernel mode setting (KMS).
It is an attempt to replace the in-kernel VT implementation with a userspace console.")
   (license (list license:expat license:lgpl2.1+ license:bsd-2 license:gpl2+))))

kmscon
