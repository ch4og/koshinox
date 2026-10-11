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
          (commit "c0e1cd5cd22919ebf2f89fc6578f2169ae9f1323")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'shikanox)
          (url "https://codeberg.org/ch4og/shikanox.git")
          (branch "main")
          (commit "b74dcf88ade9b65409c9a24c0272df8c89ab9e69")
          (introduction
           (make-channel-introduction
            "fe3b5f72aa676c69f4d43507bdd18fb051906917"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'aagl)
          (url "https://codeberg.org/ch4og/aagl-guix.git")
          (branch "main")
          (commit "de675099474493f869f5e97421296e13dd33c42e")
          (introduction
           (make-channel-introduction
            "1055d880e124d69a2aef85cac98a813d442a55fa"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'bluebox)
          (url "https://codeberg.org/lapislazuli/bluebox")
          (branch "main")
          (commit "a5b2168123bcc236f79cbb4f1c5d4cf5412ee31d")
          (introduction
           (make-channel-introduction
            "63350484aaacc362aea28fb14236019fced4050f"
            (openpgp-fingerprint
             "5132 3571 CEED 988F 52FC  467C 6F98 DBF3 EA7F 4B37"))))
        (channel
          (name 'guix)
          (url "https://codeberg.org/guix/guix.git")
          (branch "master")
          (commit "40afe823d2f454389c919be6626b6d8a7f20a85f")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

%koshi-chs
