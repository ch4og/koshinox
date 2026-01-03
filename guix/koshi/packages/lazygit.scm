;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi packages lazygit)
  #:use-module (guix packages)
  #:use-module (koshi build-system nix-go)
  #:use-module (guix git-download)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages version-control)
  #:use-module ((guix licenses)
                #:prefix license:))

(define-public lazygit
  (package
   (name "lazygit")
   (version "0.58.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/jesseduffield/lazygit")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256
      (base32 "10xzabdb4ppn0mhb1fjghfib59iwswh191jyais2lbk21z5an5gv"))))
   (build-system nix-go-build-system)
   (arguments
    `(#:vendor-hash "1zajrkrqwmf936lym0m63x5pkjjh35zybvmq9r5ydyhasihz7gf9"
      #:go ,go-1.25
      #:ldflags `("-X" ,(string-append "main.version=" ,version)
                  "-X" "'main.buildSource=ch4og/koshinox Guix channel'")))
   (propagated-inputs (list git-minimal))
   (home-page "https://github.com/jesseduffield/lazygit")
   (synopsis "Simple terminal UI for git commands")
   (description "Simple terminal UI for git commands")
   (license license:expat)))

lazygit

