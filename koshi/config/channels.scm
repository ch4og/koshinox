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
          (commit "1980960f932063f42f97ad3be4b020f68d24e62b")
          (introduction
           (make-channel-introduction
            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
            (openpgp-fingerprint
             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        (channel
          (name 'shikanox)
          (url "https://codeberg.org/ch4og/shikanox.git")
          (branch "main")
          (commit "77f22fc3ab1dbb683d23a82ce43c3d34aa47b09b")
          (introduction
           (make-channel-introduction
            "fe3b5f72aa676c69f4d43507bdd18fb051906917"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'mangowc)
          (url "https://github.com/DreamMaoMao/mangowc")
          (branch "main")
          (commit "6924ca8512090c37d64386bb5e6fabb4a6410ecb"))
        (channel
          (name 'aagl)
          (url "https://codeberg.org/ch4og/aagl-guix.git")
          (branch "main")
          (commit "f28a1e25819337273a65fc1dffa33d3056887102")
          (introduction
           (make-channel-introduction
            "1055d880e124d69a2aef85cac98a813d442a55fa"
            (openpgp-fingerprint
             "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
        (channel
          (name 'bluebox)
          (url "https://codeberg.org/lapislazuli/bluebox")
          (branch "main")
          (commit "f7f3b1565d626099dd68aae20abb36371ab8a9af")
          (introduction
           (make-channel-introduction
            "63350484aaacc362aea28fb14236019fced4050f"
            (openpgp-fingerprint
             "5132 3571 CEED 988F 52FC  467C 6F98 DBF3 EA7F 4B37"))))
        (channel
          (name 'rosenthal)
          (url "https://codeberg.org/hako/rosenthal.git")
          (branch "trunk")
          (commit "9d7be1f81c0d6d3b3248082d129f58bcd351f4b5")
          (introduction
           (make-channel-introduction
            "7677db76330121a901604dfbad19077893865f35"
            (openpgp-fingerprint
             "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7"))))
        (channel
          (name 'guix)
          (url "https://git.guix.gnu.org/guix.git")
          (branch "master")
          (commit "0ce2e759b4ee4e2c57b3d17b6b3789b9a51878ee")
          (introduction
           (make-channel-introduction
            "9edb3f66fd807b096b48283debdcddccfea34bad"
            (openpgp-fingerprint
             "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

%koshi-chs
