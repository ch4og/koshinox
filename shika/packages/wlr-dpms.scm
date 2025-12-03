;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages wlr-dpms)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages commencement)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module ((guix licenses) #:prefix license:))

(define-public wlr-dpms
  (let ((commit "b6a4aa82d7760d09a3323c93b02e10eb9eb89a3d"))
  (package
    (name "wlr-dpms")
    (version (git-version "0.0.0" "0" commit))
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://git.sr.ht/~dsemy/wlr-dpms")
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0vgvspzciz829fg5v2h4ma146s8hd78hg576czx6mg8r2jcqndrl"))))
    (build-system gnu-build-system)
    (arguments
     (list
        #:make-flags
        #~(list "PREFIX="
                (string-append "DESTDIR=" #$output))
      #:phases
      #~(modify-phases %standard-phases
          (add-before 'build 'create-cc-symlink
            (lambda _
              (let ((gcc (which "gcc")))
                (when gcc
                  (symlink gcc "cc")
                  (setenv "PATH" (string-append (getcwd) ":" (getenv "PATH")))))))
          (delete 'configure)
          (delete 'check)
          )))
    (native-inputs (list pkg-config wayland gcc-toolchain))
    (home-page "https://git.sr.ht/~dsemy/wlr-dpms")
    (synopsis "'xset dpms on|off' for wlroots compositors")
    (description "Change output power modes in wlroots compositors")
    (license license:expat))))

wlr-dpms
