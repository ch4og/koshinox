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
          "6c0ea215e0bd089bf3b2097e5c59dd726fbbe304")
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
          "d3d216f61fce07e2ea0c5196de8100c09099d0f7")
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
          "b05bc1ce65bdb32b9d2db10ef4e1514c34bf10dd"))
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
          "0cd2d616abef738dfe85cbc2de0d746e0904d570")
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
          "f8d4113975b0b4c8f0367e4f0cf93ca2167b2aa8")
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
          "f2c664190f766b489d12d8e21840d7467ecdabe1")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

%koshi-chs
