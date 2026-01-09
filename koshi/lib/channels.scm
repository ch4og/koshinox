;; -*- mode: scheme -*-
;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi lib channels)
  #:use-module (guix)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))

(define-public %koshi-chs
  (list (channel
          (name 'nonguix)
          (url "https://gitlab.com/nonguix/nonguix")
          (branch "master")
          (commit
           "bd8c5ca23e694be0b1a8cf72f05f81c70b1d7fc5")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'shikanox)
          (url "https://codeberg.org/ch4og/shikanox.git")
          (branch "main")
          (commit
           "7c3ddf9fea6b35183a1a16d6958289372b8ddd89")
          (introduction
           (make-channel-introduction
            "fe3b5f72aa676c69f4d43507bdd18fb051906917"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'mangowc)
          (url "https://github.com/DreamMaoMao/mangowc")
          (branch "main")
          (commit
           "5a714b756278896d74aae892a58ed740b4c2d27b"))
        (channel
          (name 'quickshell)
          (url "https://github.com/ch4og/quickshell.git")
          (branch "master")
          (commit
           "95364813e0882ea87955eec8d67a6bb5b74341d4"))
        (channel
          (name 'aagl)
          (url "https://codeberg.org/ch4og/aagl-guix.git")
          (branch "main")
          (commit
           "0682d68f0677f33d71c203841195ec6a4460e323")
          (introduction
           (make-channel-introduction
            "1055d880e124d69a2aef85cac98a813d442a55fa"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'rosenthal)
          (url "https://codeberg.org/hako/rosenthal.git")
          (branch "trunk")
          (commit
           "f15c27b931bb07cf76d6f8774730860263234676")
          (introduction
           (make-channel-introduction
            "7677db76330121a901604dfbad19077893865f35"
            (openpgp-fingerprint
             "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7"))))
        (channel
          (name 'guix)
          (url "https://git.guix.gnu.org/guix.git")
          (branch "master")
          (commit
           "6913fd701884fad3af579efdc298ae444aeaf57c")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
        (channel
          (name 'nonguix-for-aagl)
          (url "https://gitlab.com/nonguix/nonguix")
          (branch "master")
          (commit
           "bd8c5ca23e694be0b1a8cf72f05f81c70b1d7fc5")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))))

%koshi-chs
