;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home services config environment))

(define-public %koshi-home-environment-variables-configuration
  `(("TZ" . "Europe/Moscow")
    ("PATH" . "$HOME/.local/bin:$PATH")
    ("EDITOR" . "emacsclient")

    ;; Nix
    ("NIXPKGS_ALLOW_UNFREE" . "1")
    ("NIXOS_OZONE_WL" . "1")

    ;; Guix and Nonguix
    ("FONTCONFIG_PATH" . "$HOME/.guix-home/profile/etc/fonts/")
    ("QT_PLUGIN_PATH" . ,(string-join
                          (list "$HOME/.guix-home/profile/lib/qt6/plugins"
                                "$HOME/.guix-home/profile/lib/qt5/plugins") ":"))
    ("GUIX_SANDBOX_EXTRA_SHARES" . ,(string-join
                                     (list "$HOME/.config/MangoHud/"
                                           "$HOME/.config/dxvk/"
                                           "/games") ":"))

    ;; Coding
    ("NPM_CONFIG_USERCONFIG" . "$XDG_CONFIG_HOME/npm/npmrc")
    ("NPM_CONFIG_CACHE" . "$XDG_CACHE_HOME/npm")
    ("NODE_REPL_HISTORY" . "$XDG_STATE_HOME/node_repl_history")
    ("CARGO_HOME" . "$XDG_DATA_HOME/cargo")
    ("GOPATH" . "$XDG_DATA_HOME/go")
    ("WAKATIME_HOME" . "$XDG_CONFIG_HOME/wakatime")

    ;; Fix for NVIDIA
    ("WLR_DRM_NO_ATOMIC" . "1")))
