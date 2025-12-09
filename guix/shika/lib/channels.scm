;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika lib channels)
  #:use-module (guix)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))

(define-public shika-chs
  (list (channel
         (name 'guix)
         (url "https://git.guix.gnu.org/guix.git")
         (branch "master")
         (commit "7b861c82613cc1aa4da3755ff235361533a75e60")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))

        (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix.git")
         (branch "master")
         (commit "d741f41eca0a04694775118eedaa332ffa1a26f8")
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))

	      (channel
	       (name 'quickshell)
	       (url "https://github.com/ch4og/quickshell.git")
	       (branch "master")
	       (commit "95364813e0882ea87955eec8d67a6bb5b74341d4"))

        (channel
         (name 'aagl)
         (url "https://codeberg.org/ch4og/aagl-guix.git")
         (branch "main")
         (commit "e1a0794a3a4cbc2038d629e7e28efc7557470a3d")
         (introduction
          (make-channel-introduction
           "1055d880e124d69a2aef85cac98a813d442a55fa"
           (openpgp-fingerprint
            "7C9E 7EBA 828C 58DF DACE  5BED 4DCC 7AB7 FC75 319B"))))))

shika-chs
