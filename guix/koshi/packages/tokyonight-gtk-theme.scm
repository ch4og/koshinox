;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi packages tokyonight-gtk-theme)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (gnu packages web)
  #:use-module (guix git-download)
  #:use-module (guix build-system copy)
  #:use-module ((guix licenses) #:prefix license:))

(define-public tokyonight-gtk-theme
  (let ((commit "6c340e058e84c1975a038a8e5d1e384477225dc0"))
    (package
     (name "tokyonight-gtk-theme")
     (version (git-version "0.0.0" "0" commit))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme")
                    (commit commit)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0czbjgawf4sxmbgyq8ja7vbdb16l7fnmi8qpspdw0nys0kvsfzgc"))))
     (build-system copy-build-system)
     (native-inputs `(,sassc))
     (arguments
      (list #:phases
            #~(modify-phases %standard-phases
                             (replace 'install
                                      (lambda _
                                        (let* ((themes-dir (string-append #$output "/share/themes"))
                                               (icons-dir (string-append #$output "/share/icons")))
                                          (mkdir-p themes-dir)
                                          (apply invoke "bash" "themes/install.sh" "-d" `(,themes-dir))
                                          (mkdir-p icons-dir)
                                          (copy-recursively "icons" icons-dir)))))))
     (home-page "https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme")
     (synopsis "GTK theme based on the Tokyo Night colour palette.")
     (description "A GTK theme based on the colours of Folke's great theme: Tokyonight for Neovim
the VinceLiuice's Awesome GTK Themes and the creativity of Gusbemacbe's: Suru Plus Icon Theme.")
     (license license:gpl3))))

tokyonight-gtk-theme
