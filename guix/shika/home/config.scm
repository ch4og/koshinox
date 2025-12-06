;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
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
             (guix gexp)
             (guix packages)
             (guix download)
             (nonguix utils)
             (gnu installer utils)
             (nongnu packages nvidia)
             (gnu home services shepherd)
             (koshi lib config-root))

(define (home-dir)
  (getenv "HOME"))

(define (xdg-data-home)
  (or (getenv "XDG_DATA_HOME")
      (string-append home-dir "/.local/share")))

(with-transformation replace-mesa
                     (home-environment
                      (packages (load "packages.scm"))

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
                                                     `(("NIXPKGS_ALLOW_UNFREE" . "1")
					                                             ("EDITOR" . "emacsclient")
					                                             ("FONTCONFIG_PATH" . ,(string-append (home-dir) "/.guix-home/profile/etc/fonts/"))))

                                     (service home-dotfiles-service-type
                                              (home-dotfiles-configuration (directories `
                                                                            (,(string-append config-root "/dotfiles")))
                                                                           (layout 'stow)
                                                                           (packages '
                                                                            ("fastfetch"
                                                                             "dxvk"
                                                                             "ghostty"
                                                                             "mangowc"
                                                                             "emacs"
                                                                             "jujutsu"
                                                                             "git"
                                                                             "protonup"
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
									                                                     (system* "emacs" "-daemon")))
							                                              (stop #~(lambda _
								                                                      (system* "emacsclient" "--eval" "'(kill-emacs)'"))))))
                                     (service home-files-service-type
                                              `((".wakatime/wakatime-cli" ,(file-append
                                                                            (specification->package
                                                                             "wakatime-cli")
                                                                            "/bin/wakatime-cli"))))
                                     (simple-service 'pull-gpg
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp))
                                                         (system
                                                          "gpg --fetch-keys https://codeberg.org/ch4og.gpg")))

                                     (simple-service 'reload-mango
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp))
                                                         (system
                                                          "pgrep mango && mmsg -d reload_config")))

                                     (simple-service 'reload-waybar
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp))
                                                         (system
                                                          "pgrep waybar && killall -SIGUSR2 waybar")))

                                     (simple-service 'home-manager
                                                     home-activation-service-type
                                                     #~(begin
                                                         (use-modules (guix gexp)
                                                                      (koshi lib config-root))
                                                         (system (string-append "nix run "
                                                                                config-root
                                                                                "/nix/hm"
                                                                                " -- switch --flake "
                                                                                config-root
                                                                                "/nix/hm")))))
                               %base-home-services))))
