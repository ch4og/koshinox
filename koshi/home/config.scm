;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home config))

(use-modules (gnu home)
             (gnu packages)
             (gnu home services)
             (gnu services)
             (gnu home services sound)
             (gnu home services desktop)
             (gnu home services dotfiles)
             (gnu home services gnupg)
             (gnu home services xdg)
             (guix gexp)
             (guix packages)
             (guix download)
             (nonguix utils)
             (gnu installer utils)
             (nongnu packages nvidia)
             (gnu home services shepherd)
             (koshi home packages))

(define %koshi-home
  (home-environment
   (packages %koshi-home-packages)
   (services
    (append (list (service home-dbus-service-type)
                  (service home-pipewire-service-type)
                  (service home-gpg-agent-service-type
                           (home-gpg-agent-configuration
                            (pinentry-program (file-append (specification->package "pinentry")
                                                           "/bin/pinentry"))
                            (ssh-support? #t)))
                  (simple-service 'env-vars-service
                                  home-environment-variables-service-type
                                  `(("TZ" . "Europe/Moscow")
                                    ("NIXPKGS_ALLOW_UNFREE" . "1")
                                    ("EDITOR" . "emacsclient")
                                    ("GUIX_SANDBOX_EXTRA_SHARES" . "/games")
                                    ("NIXOS_OZONE_WL" . "1")
                                    ("NPM_CONFIG_USERCONFIG" . ,(string-append (getenv "XDG_CONFIG_HOME") "/npm/npmrc"))
                                    ("NPM_CONFIG_CACHE" . ,(string-append (getenv "XDG_CACHE_HOME") "/npm"))
                                    ("NODE_REPL_HISTORY" . ,(string-append (getenv "XDG_STATE_HOME") "/node_repl_history"))
                                    ("CARGO_HOME" . ,(string-append (getenv "XDG_DATA_HOME") "/cargo"))
                                    ("WAKATIME_HOME" . ,(string-append (getenv "XDG_CONFIG_HOME") "/wakatime"))
                                    ("FONTCONFIG_PATH" . ,(string-append (getenv "HOME") "/.guix-home/profile/etc/fonts/"))))
                  (simple-service 'emacs-server
                                  home-shepherd-service-type
                                  (list (shepherd-service
                                         (documentation "Emacs daemon")
                                         (provision '(emacs-server))
                                         (start #~(lambda _
                                                    (system* "emacsclient" "--eval" "'(kill-emacs)'" "||" "true")
                                                    (system* "emacs" "-daemon")))
                                         (stop #~(lambda _
                                                   (system* "emacsclient" "--eval" "'(kill-emacs)'"))))))
                  (service home-xdg-user-directories-service-type
                           (home-xdg-user-directories-configuration
                            (desktop     "$HOME")
                            (documents   "$HOME/documents")
                            (download    "$HOME/downloads")
                            (music       "$HOME")
                            (pictures    "$HOME/pictures")
                            (publicshare "$HOME")
                            (templates   "$HOME")
                            (videos      "$HOME/videos")))
                  (simple-service
                   'home-xdg-utils
                   home-profile-service-type
                   (list
                    (specification->package "xdg-utils"))))
            %base-home-services))))

(define %koshi-home-nvidia
  (with-transformation replace-mesa
                       %koshi-home))

%koshi-home-nvidia
