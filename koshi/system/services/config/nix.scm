;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services config nix)
  #:use-module (gnu services nix))

(define-public %koshi-nix-subs
  '("https://mirror.yandex.ru/nixos"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://cache.nixos.kz"
    "https://nixos-cache-proxy.cofob.dev"
    "https://cache.nixos.org/"))

(define-public %koshi-nix-configuration
  (nix-configuration
    (extra-config (list (string-join `("allowed-users = @wheel root"
                                       "auto-optimise-store = true"
                                       "experimental-features = nix-command flakes"
                                       ,(string-join `("substituters = " ,@%koshi-nix-subs) " ")
                                       "trusted-users = @wheel root"
                                       "warn-dirty = false")
                                     "\n")))))
