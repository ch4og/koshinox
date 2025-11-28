;;; SPDX-FileCopyrightText: 2024, 2025 Murilo <murilo@disroot.org>
;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika packages ghostty)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages zig)
  #:use-module (guix build-system zig)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define-public ghostty
  (package
    (name "ghostty")
    (version "1.2.3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/ghostty-org/ghostty")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0z9gljmr3c6484ynxgz3smsx7873pbvsfhpnfgalkb5bj0w8pnfj"))))
    (build-system zig-build-system)
    (arguments
     (list #:tests? #f
           #:install-source? #f
           #:zig zig-0.14
           #:zig-release-type "fast"
           #:zig-build-flags
           #~(list "-Dcpu=baseline"
                   "--prefix"
                   ""
                   "--system"
                   (string-append (getenv "TMPDIR") "/source/zig-cache")
                   "--search-prefix"
                   (ungexp (this-package-input "libadwaita"))
                   "--search-prefix"
                   (ungexp (this-package-input "bzip2"))
                   "-Dpatch-rpath="
                   "-Dgtk-x11=true"
                   "-Dgtk-wayland=true"
                   (string-append "-Dversion-string=" #$version))
           #:modules
           '((guix build zig-build-system)
             (guix build utils)
             (ice-9 match))
           #:phases
           #~(modify-phases %standard-phases
               (delete 'validate-runpath)
               (add-after 'install 'patch-install-files
                 (lambda _
                   (with-directory-excursion #$output
                     (substitute*
                         (list "share/applications/com.mitchellh.ghostty.desktop"
                               "share/dbus-1/services/com.mitchellh.ghostty.service"
                               "lib/systemd/user/app-com.mitchellh.ghostty.service")
                       (("/bin/ghostty")
                        (string-append #$output "/bin/ghostty"))))))
               (add-after 'unpack 'patch-ghostty-exe
                 (lambda _
                   (substitute* "src/build/SharedDeps.zig"
                     (("\"bzip2\"")
                      "\"bz2\""))
                   (substitute* "src/build/GhosttyExe.zig"
                     ((".addExecutable[(][.][{]" all)
                      (string-append all "\n\t.use_lld = false,\n")))))
               (add-after 'unpack 'unpack-zig
                 (lambda _
                   (for-each
                    (match-lambda
                      ((dst src)
                       (let* ((dest (string-append "zig-cache/" dst)))
                         (mkdir-p dest)
                         (if (or (string-suffix? ".tar.gz" src)
                                 (string-suffix? ".tgz" src)
                                 (string-suffix? ".tar.xz" src)
                                 (string-suffix? ".tar.zst" src))
                             (invoke "tar" "-xf" src "-C" dest "--strip-components=1")
                             (copy-recursively src dest)))))
                    `(("vaxis-0.1.0-BWNV_FUICQAFZnTCL11TUvnUr1Y0_ZdqtXHhd51d76Rn"
                       #$(origin
                           (method git-fetch)
                           (uri
                            (git-reference
                              (url "https://github.com/rockorager/libvaxis")
                              (commit "1f41c121e8fc153d9ce8c6eb64b2bbab68ad7d23")))
                           (sha256
                            (base32 "0xihpzj37mhpzxjrfy20z651vxqrqsgkr9iqhv1g7slkyyi7gmkc"))))
                      ("zigimg-0.1.0-lly-O6N2EABOxke8dqyzCwhtUCAafqP35zC7wsZ4Ddxj"
                       #$(origin
                           (method git-fetch)
                           (uri (git-reference
                                  (url "https://github.com/TUSF/zigimg")
                                  (commit "31268548fe3276c0e95f318a6c0d2ab10565b58d")))
                           (file-name "zigimg")
                           (sha256
                            (base32 "1pf0rbyrrxq02dvkxfa9sba1f18bycdgvs2js2mfmkj8c6pmzfd1"))))
                      ("zf-0.10.3-OIRy8aiIAACLrBllz0zjxaH0aOe5oNm3KtEMyCntST-9"
                       #$(origin
                                        ; "zf"
                           (method url-fetch)
                           (uri "https://github.com/natecraddock/zf/archive/7aacbe6d155d64d15937ca95ca6c014905eb531f.tar.gz")
                           (sha256
                            (base32 "1chbgj8d9wxdzsbq7c2d4hvqsn02y22jb5x7lmwbdqkz0wssayyy"))))
                      ("zg-0.13.4-AAAAAGiZ7QLz4pvECFa_wG4O4TP4FLABHHbemH2KakWM"
                       #$(origin
                                        ; "zg"
                           (method git-fetch)
                           (uri
                            (git-reference
                              (url "https://codeberg.org/atman/zg")
                              (commit "4a002763419a34d61dcbb1f415821b83b9bf8ddc")))
                           (file-name "zg")
                           (sha256
                            (base32 "006nxw79n49j43vrxv0dmfql3afds1llq9fil7hbzbp4r3lyb3by"))))
                      ("libxev-0.0.0-86vtc2UaEwDfiTKX3iBI-s_hdzfzWQUarT3MUrmUQl-Q"
                       #$(origin
                                        ; "libxev"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/libxev/archive/7f803181b158a10fec8619f793e3b4df515566cb.tar.gz")
                           (sha256
                            (base32 "0rwj8s6kbvnjk48fyds960nb9zivzjzpzpl9n3x3z191l5h37ai9"))))
                      ("12206ed982e709e565d536ce930701a8c07edfd2cfdce428683f3f2a601d37696a62"
                       #$(origin
                                        ; "mach_glfw"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/mach_glfw-12206ed982e709e565d536ce930701a8c07edfd2cfdce428683f3f2a601d37696a62.tar.gz")
                           (sha256
                            (base32 "1nghcw6hj2dnwvl7sfhpxz0kwjk4nvqmq5cfb63z1wqjcnywh58y"))))
                      ("zig_objc-0.0.0-Ir_SpwsPAQBJgi9YRm2ubJMfdoysSq5gKpsIj3izQ8Zk"
                       #$(origin
                                        ; "zig_objc"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/zig-objc/archive/c9e917a4e15a983b672ca779c7985d738a2d517c.tar.gz")
                           (sha256
                            (base32 "1p74d1sfdaf8hpngy0gwcc88qspphmmjbfkn54djsjp4lzpfayx3"))))
                      ("N-V-__8AAB9YCQBaZtQjJZVndk-g_GDIK-NTZcIa63bFp9yZ"
                       #$(origin
                                        ; "zig_js"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/zig_js-12205a66d423259567764fa0fc60c82be35365c21aeb76c5a7dc99698401f4f6fefc.tar.gz")
                           (sha256
                            (base32 "0gaqqfb125pj62c05z2cpzih0gcm3482cfln50d41xf2aq4mw8vz"))))
                      ("N-V-__8AAKrHGAAs2shYq8UkE6bGcR1QJtLTyOE_lcosMn6t"
                       #$(origin
                                        ; "wayland"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/wayland-9cb3d7aa9dc995ffafdbdef7ab86a949d0fb0e7d.tar.gz")
                           (sha256
                            (base32 "03f574n5w0y6glr7lf8xjd71844qh8kxxb1s3zjpfxj3ivb92hga"))))
                      ("N-V-__8AAKw-DAAaV8bOAAGqA0-oD7o-HNIlPFYKRXSPT03S"
                       #$(origin
                                        ; "wayland_protocols"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/wayland-protocols-258d8f88f2c8c25a830c6316f87d23ce1a0f12d9.tar.gz")
                           (sha256
                            (base32 "1y1h0pmql53x6ixbsycgkzxlxsxqs9fkps754c7ycx8vx3fwmvaw"))))
                      ("N-V-__8AAKYZBAB-CFHBKs3u4JkeiT4BMvyHu3Y5aaWF3Bbs"
                       #$(origin
                                        ; "plasma_wayland_protocols"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/plasma_wayland_protocols-12207e0851c12acdeee0991e893e0132fc87bb763969a585dc16ecca33e88334c566.tar.gz")
                           (sha256
                            (base32 "0hgl1p173pxs50z1p6mjjzcqssn44aq0ip166k56p3nd98hvln2w"))))
                      ("N-V-__8AAIC5lwAVPJJzxnCAahSvZTIlG-HhtOvnM1uh-66x"
                       #$(origin
                                        ; "jetbrains mono"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/JetBrainsMono-2.304.tar.gz")
                           (sha256
                            (base32 "1i2w213919avi0apgbw720wqy0z46a89bwv3b65hkbc2icg6jyn5"))))
                      ("N-V-__8AALiNBAA-_0gprYr92CjrMj1I5bqNu0TSJOnjFNSr"
                       #$(origin
                                        ; "gtk4-layer-shell"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/gtk4-layer-shell-1.1.0.tar.gz")
                           (sha256
                            (base32 "12396gx723ybgq1xp9i02257hsmzqhb5z9b39xdyypha4s0l4a4q"))))
                      ("N-V-__8AAMVLTABmYkLqhZPLXnMl-KyN38R8UVYqGrxqO26s"
                       #$(origin
                                        ; "nerdfonts"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/NerdFontsSymbolsOnly-3.4.0.tar.gz")
                           (sha256
                            (base32 "010d7gkv359qg555d89i4hhgb56c8f69kw5jsx4f5gflaswx2r0i"))))
                      ("N-V-__8AAH0GaQC8a52s6vfIxg88OZgFgEW6DFxfSK4lX_l3"
                       #$(origin
                                        ; "cimgui"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/imgui-1220bc6b9daceaf7c8c60f3c3998058045ba0c5c5f48ae255ff97776d9cd8bfc6402.tar.gz")
                           (sha256
                            (base32 "0q3qxycyl0z64mxf5j24c0g0yhif3mi7qf183rwan4fg0hgd0px0"))))
                      ("N-V-__8AAIrfdwARSa-zMmxWwFuwpXf1T3asIN7s5jqi9c1v"
                       #$(origin
                                        ; "fontconfig"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz")
                           (sha256
                            (base32 "0mcarq6v9k7k9a8is23vq9as0niv0hbagwdabknaq6472n9dv8iv"))))
                      ("N-V-__8AAKLKpwC4H27Ps_0iL3bPkQb-z6ZVSrB-x_3EEkub"
                       #$(origin
                                        ; "freetype"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/freetype-1220b81f6ecfb3fd222f76cf9106fecfa6554ab07ec7fdc4124b9bb063ae2adf969d.tar.gz")
                           (sha256
                            (base32 "035r5bypzapa1x7za7lpvpkz58fxynz4anqzbk8705hmspsh2wj2"))))
                      ("N-V-__8AAG02ugUcWec-Ndp-i7JTsJ0dgF8nnJRUInkGLG7G"
                       #$(origin
                                        ; "harfbuzz"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/harfbuzz-11.0.0.tar.xz")
                           (sha256
                            (base32 "16rb7aazy36pj3xrjy149dd90j9yv7q5jnqx5kz2air1zsx52qzi"))))
                      ("N-V-__8AADcZkgn4cMhTUpIz6mShCKyqqB-NBtf_S2bHaTC-"
                       #$(origin
                                        ; "gettext"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/gettext-0.24.tar.gz")
                           (sha256
                            (base32 "1dqq2ln01mfwr4gblvy0cyvarbqnv09ml5sdhksdlw1xb4ym0669"))))
                      ("N-V-__8AAGmZhABbsPJLfbqrh6JTHsXhY6qCaLAQyx25e0XE"
                       #$(origin
                                        ; "highway"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/highway-66486a10623fa0d72fe91260f96c892e41aceb06.tar.gz")
                           (sha256
                            (base32 "04m21b46h6c4x099r9qb720ql9llpzz8yq3k94i8zq7l7s4zim47"))))
                      ("N-V-__8AAJrvXQCqAT8Mg9o_tk6m0yf5Fz-gCNEOKLyTSerD"
                       #$(origin
                                        ; "libpng"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/libpng-1220aa013f0c83da3fb64ea6d327f9173fa008d10e28bc9349eac3463457723b1c66.tar.gz")
                           (sha256
                            (base32 "0fm0y7543w2gx5sz3zg9i46x1am51c77a554r0zqwpphdjs9bk7y"))))
                      ("N-V-__8AAHffAgDU0YQmynL8K35WzkcnMUmBVQHQ0jlcKpjH"
                       #$(origin
                                        ; "utfcpp"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/utfcpp-1220d4d18426ca72fc2b7e56ce47273149815501d0d2395c2a98c726b31ba931e641.tar.gz")
                           (sha256
                            (base32 "1ksrdf7dy4csazhddi64xahks8jzf4r8phgkjg9hfxp722iniipz"))))
                      ("N-V-__8AAB0eQwD-0MdOEBmz7intriBReIsIDNlukNVoNu6o"
                       #$(origin
                                        ; "zlib"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/zlib-1220fed0c74e1019b3ee29edae2051788b080cd96e90d56836eea857b0b966742efb.tar.gz")
                           (sha256
                            (base32 "0p6h2i9ajdp46lckdpibfqy4vz5nh5r22bqq96mp41k0ydiqis0p"))))
                      ("N-V-__8AABzkUgISeKGgXAzgtutgJsZc0-kkeqBBscJgMkvy"
                       #$(origin
                                        ; "glslang"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/glslang-12201278a1a05c0ce0b6eb6026c65cd3e9247aa041b1c260324bf29cee559dd23ba1.tar.gz")
                           (sha256
                            (base32 "1dcpm70fhxk07vk37f5l0hb9gxfv6pjgbqskk8dfbcwwa2xyv8hl"))))
                      ("N-V-__8AANb6pwD7O1WG6L5nvD_rNMvnSc9Cpg1ijSlTYywv"
                       #$(origin
                                        ; "spirv_cross"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/spirv_cross-1220fb3b5586e8be67bc3feb34cbe749cf42a60d628d2953632c2f8141302748c8da.tar.gz")
                           (sha256
                            (base32 "1qspcsx56v0mddarb6f05i748wsl2ln3d8863ydsczsyqk7nyaxm"))))
                      ("1220056ce228a8c58f1fa66ab778f5c8965e62f720c1d30603c7d534cb7d8a605ad7"
                       #$(origin
                                        ; "utf8proc"
                           (method url-fetch)
                           (uri "https://github.com/JuliaStrings/utf8proc/archive/refs/tags/v2.8.0.tar.gz")
                           (sha256
                            (base32 "1k6f3d5z0ihf969djb4gc2cf39k7r3ycpyhiskkm8vbgzrwhm9m0"))))
                      ("N-V-__8AANodAwDnyHwhlOv5cVRn2rx_dTvija-wy5YtTw1B"
                       #$(origin
                                        ; "iterm2_themes"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/ghostty-themes-20250915-162204-b1fe546.tgz")
                           (file-name "ghostty-themes-20250915-162204-b1fe546.tar.gz")
                           (sha256
                            (base32 "083capiyswhg7m4bqmvrlm2x33z047nzlgwx6ppjdgcljqb8vcpa"))))
                      ("z2d-0.8.1-j5P_Hq8vDwB8ZaDA54-SzESDLF2zznG_zvTHiQNJImZP"
                       #$(origin
                                        ; "z2d"
                           (method url-fetch)
                           (uri "https://github.com/vancluever/z2d/archive/refs/tags/v0.8.1.tar.gz")
                           (sha256
                            (base32 "179xd768g09apv8wj5aiygngj02f63lnrmhzazhyim804qlw6dnh"))))
                      ("1220bc6b9daceaf7c8c60f3c3998058045ba0c5c5f48ae255ff97776d9cd8bfc6402"
                       #$(origin
                                        ; "imgui"
                           (method url-fetch)
                           (uri "https://github.com/ocornut/imgui/archive/e391fe2e66eb1c96b1624ae8444dc64c23146ef4.tar.gz")
                           (sha256
                            (base32 "0q3qxycyl0z64mxf5j24c0g0yhif3mi7qf183rwan4fg0hgd0px0"))))
                      ("12201149afb3326c56c05bb0a577f54f76ac20deece63aa2f5cd6ff31a4fa4fcb3b7"
                       #$(origin
                                        ; "fontconfig"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/fontconfig-2.14.2.tar.gz")
                           (sha256
                            (base32 "0mcarq6v9k7k9a8is23vq9as0niv0hbagwdabknaq6472n9dv8iv"))))
                      ("N-V-__8AAG3RoQEyRC2Vw7Qoro5SYBf62IHn3HjqtNVY6aWK"
                       #$(origin
                                        ; "libxml2"
                           (method url-fetch)
                           (uri "https://github.com/GNOME/libxml2/archive/refs/tags/v2.11.5.tar.gz")
                           (sha256
                            (base32 "05b2kbccbkb5pkizwx2s170lcqvaj7iqjr5injsl5sry5sg0aa3c"))))
                      ("1220fb3b5586e8be67bc3feb34cbe749cf42a60d628d2953632c2f8141302748c8da"
                       #$(origin
                                        ; "spirv_cross"
                           (method url-fetch)
                           (uri "https://github.com/KhronosGroup/SPIRV-Cross/archive/476f384eb7d9e48613c45179e502a15ab95b6b49.tar.gz")
                           (sha256
                            (base32 "1qspcsx56v0mddarb6f05i748wsl2ln3d8863ydsczsyqk7nyaxm"))))
                      ("N-V-__8AAHjwMQDBXnLq3Q2QhaivE0kE2aD138vtX2Bq1g7c"
                       #$(origin
                                        ; "oniguruma"
                           (method url-fetch)
                           (uri "https://github.com/kkos/oniguruma/archive/refs/tags/v6.9.9.tar.gz")
                           (sha256
                            (base32 "187jk4fxdkzc0wrcx4kdy4v6p1snwmv8r97i1d68yi3q5qha26h0"))))
                      ("12205c83b8311a24b1d5ae6d21640df04f4b0726e314337c043cde1432758cbe165b"
                       #$(origin
                                        ; "highway"
                           (method url-fetch)
                           (uri "https://github.com/google/highway/archive/refs/tags/1.1.0.tar.gz")
                           (sha256
                            (base32 "1jgpcqc3s6z8qjy7ghy4089p9wp3fd188w7ck05yg25m752qnjim"))))
                      ("1220aa013f0c83da3fb64ea6d327f9173fa008d10e28bc9349eac3463457723b1c66"
                       #$(origin
                                        ; "libpng"
                           (method url-fetch)
                           (uri "https://github.com/glennrp/libpng/archive/refs/tags/v1.6.43.tar.gz")
                           (sha256
                            (base32 "0fm0y7543w2gx5sz3zg9i46x1am51c77a554r0zqwpphdjs9bk7y"))))
                      ("1220fed0c74e1019b3ee29edae2051788b080cd96e90d56836eea857b0b966742efb"
                       #$(origin
                                        ; "zlib"
                           (method url-fetch)
                           (uri "https://github.com/madler/zlib/archive/refs/tags/v1.3.1.tar.gz")
                           (sha256
                            (base32 "0p6h2i9ajdp46lckdpibfqy4vz5nh5r22bqq96mp41k0ydiqis0p"))))
                      ("12201278a1a05c0ce0b6eb6026c65cd3e9247aa041b1c260324bf29cee559dd23ba1"
                       #$(origin
                                        ; "glslang"
                           (method url-fetch)
                           (uri "https://github.com/KhronosGroup/glslang/archive/refs/tags/14.2.0.tar.gz")
                           (sha256
                            (base32 "1dcpm70fhxk07vk37f5l0hb9gxfv6pjgbqskk8dfbcwwa2xyv8hl"))))
                      ("N-V-__8AAPlZGwBEa-gxrcypGBZ2R8Bse4JYSfo_ul8i2jlG"
                       #$(origin
                                        ; "sentry"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/sentry-1220446be831adcca918167647c06c7b825849fa3fba5f22da394667974537a9c77e.tar.gz")
                           (sha256
                            (base32 "1pqqqcin8nw398rvn187dfqlab4vikdssiry14qqs6nnr1y4kiia"))))
                      ("N-V-__8AADYiAAB_80AWnH1AxXC0tql9thT-R-DYO1gBqTLc"
                       #$(origin
                                        ; "pixels"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/pixels-12207ff340169c7d40c570b4b6a97db614fe47e0d83b5801a932dcd44917424c8806.tar.gz")
                           (sha256
                            (base32 "06pi3f3lhyxfzczhwrc2b4n0jhhzydbz96qlpw12a24is0b3ps2m"))))
                      ("N-V-__8AAAzZywE3s51XfsLbP9eyEw57ae9swYB9aGB6fCMs"
                       #$(origin
                                        ; "wuffs"
                           (method url-fetch)
                           (uri "https://github.com/google/wuffs/archive/refs/tags/v0.4.0-alpha.9.tar.gz")
                           (sha256
                            (base32 "04qwpr8c4xjla4skwb1fpvkjc0c611qhbhz9xp3c9rlnpq5d4k4y"))))
                      ("ziglyph-0.11.2-AAAAAHPtHwB4Mbzn1KvOV7Wpjo82NYEc_v0WC8oCLrkf"
                       #$(origin
                                        ; "ziglyph"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/ziglyph-b89d43d1e3fb01b6074bc1f7fc980324b04d26a5.tar.gz")
                           (sha256
                            (base32 "1ngkyc81gqqfkgccxx4hj4w4kb3xk0ng7z73bwihbwbdw7rvvivj"))))
                      ("N-V-__8AALIsAwDyo88G5mGJGN2lSVmmFMx4YePfUvp_2o3Y"
                       #$(origin
                                        ; "iterm2_themes"
                           (method url-fetch)
                           (uri "https://github.com/mbadolato/iTerm2-Color-Schemes/releases/download/release-20251124-150533-2b326a8/ghostty-themes.tgz")
                           (sha256
                            (base32 "1cslqpfpn1rrxc9fvhpscwwss8cvaqcm0c123yn4fjkxnxdrfsg6"))))
                      ("122055beff332830a391e9895c044d33b15ea21063779557024b46169fb1984c6e40"
                       #$(origin
                                        ; "zg"
                           (method url-fetch)
                           (uri "https://codeberg.org/atman/zg/archive/v0.13.2.tar.gz")
                           (sha256
                            (base32 "1mnc261y9dc2z69pbv65dx62zr3bnpykkmb2c64x5ayqnr7n27yv"))))
                      ("1220736fa4ba211162c7a0e46cc8fe04d95921927688bff64ab5da7420d098a7272d"
                       #$(origin
                                        ; "glfw"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/glfw/archive/b552c6ec47326b94015feddb36058ea567b87159.tar.gz")
                           (sha256
                            (base32 "0da2qj9jlsnwcarc768s08zyx2fnlkvmrvhwaxm23dr6wh05bq11"))))
                      ("12202adbfecdad671d585c9a5bfcbd5cdf821726779430047742ce1bf94ad67d19cb"
                       #$(origin
                                        ; "xcode_frameworks"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/xcode-frameworks/archive/69801c154c39d7ae6129ea1ba8fe1afe00585fc8.tar.gz")
                           (sha256
                            (base32 "0fnrswx0ahc59cz37qqm9z11021w5h7y3zpxkc4vbrqbrbcwizwq"))))
                      ("122004bfd4c519dadfb8e6281a42fc34fd1aa15aea654ea8a492839046f9894fa2cf"
                       #$(origin
                                        ; "vulkan_headers"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/vulkan-headers/archive/04c8a0389d5a0236a96312988017cd4ce27d8041.tar.gz")
                           (sha256
                            (base32 "0mgqhrvavvrm3nm4yihyi4slr125mma9z16f72j5n730wx3fpv1b"))))
                      ("1220b3164434d2ec9db146a40bf3a30f490590d68fa8529776a3138074f0da2c11ca"
                       #$(origin
                                        ; "wayland_headers"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/wayland-headers/archive/5f991515a29f994d87b908115a2ab0b899474bd1.tar.gz")
                           (sha256
                            (base32 "00jx7w2vz1bdddpx239hkg76jqjjwmflsm8px5nlcam7k0nsan5q"))))
                      ("wayland-0.4.0-dev-lQa1kjfIAQCmhhQu3xF0KH-94-TzeMXOqfnP0-Dg6Wyy"
                       #$(origin
                                        ; "zig_wayland"
                           (method url-fetch)
                           (uri "https://codeberg.org/ifreund/zig-wayland/archive/f3c5d503e540ada8cbcb056420de240af0c094f7.tar.gz")
                           (sha256
                            (base32 "06ajicqccha3ha1csv854kzbvqgicbi9mcsm7gdqcga0brkwdghk"))))
                      ("122089c326186c84aa2fd034b16abc38f3ebf4862d9ae106dc1847ac44f557b36465"
                       #$(origin
                                        ; "x11_headers"
                           (method url-fetch)
                           (uri "https://github.com/mitchellh/x11-headers/archive/2ffbd62d82ff73ec929dd8de802bc95effa0ef88.tar.gz")
                           (sha256
                            (base32 "1rrvyidabdrkvax5s0mz0i122gc0z5fvl12w6wcf7z6qcip7c58j"))))
                      ("gobject-0.3.0-Skun7ET3nQAc0LzvO0NAvTiGGnmkF36cnmbeCAF6MB7Z"
                       #$(origin
                                        ; "gobject"
                           (method url-fetch)
                           (uri "https://github.com/jcollie/ghostty-gobject/releases/download/0.15.1-2025-09-04-48-1/ghostty-gobject-0.15.1-2025-09-04-48-1.tar.zst")
                           (sha256
                            (base32 "1dmy0wmasw8afrgag66lmc7alrkr6zfs07ji9n07v5f6x98qm9l7"))))
                      ("N-V-__8AALw2uwF_03u4JRkZwRLc3Y9hakkYV7NKRR9-RIZJ"
                       #$(origin
                                        ; "breakpad"
                           (method url-fetch)
                           (uri "https://deps.files.ghostty.org/breakpad-b99f444ba5f6b98cac261cbb391d8766b34a5918.tar.gz")
                           (sha256
                            (base32 "1nbadlml3r982bz1wyp17w33hngzkb07f47nrrk0g68s7na9ijkc")))))))))))
    (native-inputs
     (list `(,glib "bin")
           blueprint-compiler
           gettext-minimal ;; msgfmt
           ncurses/tinfo
           pandoc
           pkg-config
           zstd
           gobject-introspection
           libxml2 ;; xmllint
           tar))
    (inputs
     (list bzip2
           expat
           fontconfig
           glslang
           harfbuzz
           libadwaita
           libglvnd
           libpng
           libx11
           libxcursor
           libxi
           libxrandr
           oniguruma
           gtk4-layer-shell
           zlib))
    (native-search-paths
     ;; FIXME: This should only be located in 'ncurses'.  Nonetheless it is
     ;; provided for usability reasons.  See <https://bugs.gnu.org/22138>.
     (list (search-path-specification
             (variable "TERMINFO_DIRS")
             (files '("share/terminfo")))))
    (synopsis "Fast, native, feature-rich terminal emulator pushing modern features")
    (description "Ghostty is a terminal emulator that differentiates itself by
being fast, feature-rich, and native. While there are many excellent terminal
emulators available, they all force you to choose between speed, features, or
native UIs. Ghostty provides all three.")
    (home-page "https://ghostty.org")
    (license license:expat)))

ghostty
