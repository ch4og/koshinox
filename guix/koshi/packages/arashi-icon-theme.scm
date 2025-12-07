;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi packages arashi-icon-theme)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (gnu packages compression)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

(define-public arashi-icon-theme
  (package
   (name "arashi-icon-theme")
   (version "25.10")
   (source (origin
            (method url-fetch)
            (uri
             (string-append "https://github.com/0hStormy/Arashi"
                            "/releases/download/"
                            version
                            "/Arashi-" version ".zip"))
            (sha256
             (base32
              "18m4h3g2xcncx12c6d46bk4a180d7pqab24n6s5whmw8012n2f1r"))))
   (build-system copy-build-system)
   (native-inputs `(,unzip))
   (arguments
    (list #:phases
          #~(modify-phases %standard-phases
                           (replace 'install
                                    (lambda _
                                      (let* ((icons-dir (string-append #$output "/share/icons")))
                                        (mkdir-p icons-dir)
                                        (copy-recursively "." (string-append icons-dir "/Arashi"))))))))
   (home-page "https://github.com/0hStormy/Arashi")
   (synopsis "Smooth, modern icon set for Linux.")
   (description "Arashi a smooth, modern icon set with a twist!")
   (license license:cc-by-sa4.0)))

arashi-icon-theme
