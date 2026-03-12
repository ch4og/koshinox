;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home services config environment))

(define (home-append path)
  (let ((home (or (getenv "HOME") (string-append "/home/" username))))
    (string-append home path)))

(define-public %koshi-home-environment-variables-configuration
  (let* ((xdg-config (or (getenv "XDG_CONFIG_HOME") (home-append "/.config")))
         (xdg-cache (or (getenv "XDG_CACHE_HOME") (home-append "/.cache")))
         (xdg-state (or (getenv "XDG_STATE_HOME") (home-append "/.local/state")))
         (xdg-data (or (getenv "XDG_DATA_HOME") (home-append "/.local/share"))))
    `(("TZ" . "Europe/Moscow")
      ("PATH" . "$HOME/.local/bin:$PATH")
      ("NIXPKGS_ALLOW_UNFREE" . "1")
      ("NIXOS_OZONE_WL" . "1")
      ("EDITOR" . "emacsclient")
      ("GUIX_SANDBOX_EXTRA_SHARES" . ,(string-join
                                       (list (home-append "/.config/MangoHud/")
                                             (home-append "/.config/dxvk/")
                                             "/games") ":"))
      ("NPM_CONFIG_USERCONFIG" . ,(string-append xdg-config "/npm/npmrc"))
      ("NPM_CONFIG_CACHE" . ,(string-append xdg-cache "/npm"))
      ("NODE_REPL_HISTORY" . ,(string-append xdg-state "/node_repl_history"))
      ("CARGO_HOME" . ,(string-append xdg-data "/cargo"))
      ("WAKATIME_HOME" . ,(string-append xdg-config "/wakatime"))
      ("FONTCONFIG_PATH" . ,(home-append "/.guix-home/profile/etc/fonts/"))
      ("QT_PLUGIN_PATH" . ,(string-join
                            (list (home-append "/.guix-home/profile/lib/qt6/plugins")
                                  (home-append "/.guix-home/profile/lib/qt5/plugins")) ":")))))
