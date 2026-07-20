;; -*- mode: scheme -*-
;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config channels)
  #:use-module (guix)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))

(define-public %koshi-chs
  (list (channel
          (name 'nonguix)
          (url "https://gitlab.com/nonguix/nonguix")
          (branch "master")
          (commit "3b66965566fe8c96edb5a41fd39a9e5a90ad9b61")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'shikanox)
          (url "https://codeberg.org/ch4og/shikanox.git")
          (branch "main")
          (commit "b864d1d70f525bd83bb77a9dd2d52af5957bbd42")
          (introduction
           (make-channel-introduction
            "fe3b5f72aa676c69f4d43507bdd18fb051906917"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'aagl)
          (url "https://codeberg.org/ch4og/aagl-guix.git")
          (branch "main")
          (commit "1dabcc7a5981bd397191321e233dede3572ca924")
          (introduction
           (make-channel-introduction
            "1055d880e124d69a2aef85cac98a813d442a55fa"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'bluebox)
          (url "https://codeberg.org/lapislazuli/bluebox")
          (branch "main")
          (commit "71628770c8612c041e06672f34c0c8e6fc67c13c")
          (introduction
           (make-channel-introduction
            "63350484aaacc362aea28fb14236019fced4050f"
            (openpgp-fingerprint
             "5132 3571 CEED 988F 52FC  467C 6F98 DBF3 EA7F 4B37"))))
        (channel
          (name 'guix)
          (url "https://codeberg.org/ch4og/guix")
          (branch "fix-nix")
          (commit "9663835164b4d961a23540e2a1fb8fc5f1d6c2fa")
          (introduction
           (make-channel-introduction
            "9663835164b4d961a23540e2a1fb8fc5f1d6c2fa"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))))

%koshi-chs
