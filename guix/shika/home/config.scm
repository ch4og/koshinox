;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika home config))

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
             (koshi utils config-root)
             (koshi services home-reload-waybar)
             (shika home packages))

(define (home-dir)
  (getenv "HOME"))

(with-transformation replace-mesa
                     (home-environment
                      (packages %shika-home-packages)

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
					                                             ("FONTCONFIG_PATH" . ,(string-append (home-dir) "/.guix-home/profile/etc/fonts/"))))

                                     (service home-dotfiles-service-type
                                              (home-dotfiles-configuration (directories `
                                                                            (,(string-append config-root "/dotfiles")))
                                                                           (layout 'stow)
                                                                           (packages '
                                                                            ("fastfetch"
                                                                             "btop"
                                                                             "dxvk"
                                                                             "gtk"
                                                                             "ghostty"
                                                                             "mangowc"
                                                                             "waybar"
                                                                             "swappy"
                                                                             "pipewire"
                                                                             "emacs"
                                                                             "jujutsu"
                                                                             "git"
                                                                             "protonup"
                                                                             "mangohud"
                                                                             "tmux"
                                                                             "fish"
                                                                             "rofi"))))
				                             (simple-service 'emacs-server
						                                         home-shepherd-service-type
						                                         (list (shepherd-service
							                                              (documentation
							                                               "Emacs daemon")
							                                              (provision '(emacs-server))
							                                              (start #~(lambda _
									                                                     (system* "emacsclient" "--eval" "'(kill-emacs)'" "||" "true")
															                                         (system* "emacs" "-daemon")))
							                                              (stop #~(lambda _
								                                                      (system* "emacsclient" "--eval" "'(kill-emacs)'"))))))
                                     (service home-files-service-type
                                              `((".wakatime/wakatime-cli" ,(file-append
                                                                            (specification->package
                                                                             "wakatime-cli")
                                                                            "/bin/wakatime-cli"))))
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
                                       (specification->package
                                        "xdg-utils")))
                                     (simple-service 'pull-gpg
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp))
                                                         (system
                                                          "gpg --list-keys ch4og >/dev/null || gpg --fetch-keys https://codeberg.org/ch4og.gpg")))

                                     (simple-service 'reload-mango
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp))
                                                         (system
                                                          "pgrep mango && mmsg -d reload_config")))

                                     (service home-reload-waybar-service-type)

                                     (simple-service 'home-manager
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp)
                                                                      (koshi utils config-root))
                                                         (system (string-append "nix run "
                                                                                config-root
                                                                                "/nix/hm"
                                                                                " -- switch --flake "
                                                                                config-root
                                                                                "/nix/hm")))))
                               %base-home-services))))
