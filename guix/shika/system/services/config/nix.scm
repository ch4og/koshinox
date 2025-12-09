;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services config nix)
  #:use-module (gnu services nix))

(define-public %shika-nix-configuration
  (nix-configuration
  (extra-config
   (list
    (string-join
     '("allowed-users = @wheel root"
       "auto-optimise-store = true"
       "experimental-features = nix-command flakes"
       "substituters = https://nixos-cache-proxy.cofob.dev https://cache.nixos.org/"
       "trusted-users = @wheel root"
       "warn-dirty = false")
     "\n")))))
