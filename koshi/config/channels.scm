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
          (commit "7b7b2c47f9c205ad89ddf54293e7756e797f8980")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'shikanox)
          (url "https://codeberg.org/ch4og/shikanox.git")
          (branch "main")
          (commit "26f959441364eccbf6b9a710e7fc81ea808ff11e")
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
          (url "https://git.guix.gnu.org/guix.git")
          (branch "master")
          (commit "3b98aa3889888dd1a69d30bed2a5f1a8519fd06c")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

%koshi-chs
