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
          "48a8706d44040cc7014f36873dbd834c048aadd3")
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
          "65ced534eec977e40d21619220f4d423802e2388")
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
          "f25161552455d076f0f15cadf522a8b57b829e2f"))
	(channel
         (name 'aagl)
         (url "https://codeberg.org/ch4og/aagl-guix.git")
         (branch "main")
         (commit
          "f28a1e25819337273a65fc1dffa33d3056887102")
         (introduction
          (make-channel-introduction
           "1055d880e124d69a2aef85cac98a813d442a55fa"
           (openpgp-fingerprint
            "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))
	(channel
         (name 'bluebox)
         (url "https://codeberg.org/lapislazuli/bluebox")
         (branch "main")
         (commit
          "f7f3b1565d626099dd68aae20abb36371ab8a9af")
         (introduction
          (make-channel-introduction
           "63350484aaacc362aea28fb14236019fced4050f"
           (openpgp-fingerprint
            "5132 3571 CEED 988F 52FC  467C 6F98 DBF3 EA7F 4B37"))))
	(channel
         (name 'rosenthal)
         (url "https://codeberg.org/hako/rosenthal.git")
         (branch "trunk")
         (commit
          "fdada954a6fa0514fee4b3ddf922c68c48ef890c")
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
          "e81419d1adec9d9094e10f0151f3aca1983ddb31")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))

%koshi-chs
