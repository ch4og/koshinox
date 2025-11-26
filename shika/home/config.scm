;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika home config)
  )

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
             (gnu home services shepherd))

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
                                               (home-gpg-agent-configuration (pinentry-program
                                                                              (file-append
                                                                               (specification->package
                                                                                "pinentry")
                                                                               "/bin/pinentry"))
                                                                             (ssh-support? #t)))
                                      (simple-service 'env-vars-service
                                       home-environment-variables-service-type
                                       `(("NIXPKGS_ALLOW_UNFREE" . "1")
					 ("EDITOR" . "nvim")
					 ("FONTCONFIG_PATH" . "~/.guix-home/profile/etc/fonts/")))

                                      (service home-dotfiles-service-type
                                               (home-dotfiles-configuration (directories '
                                                                             ("../../dotfiles"))
                                                                            (layout 'stow)
                                                                            (packages '
                                                                             ("fastfetch"
                                                                              "kitty"
                                                                              "mangowc"
                                                                              "neovim"
									      "nix"
                                                                              "jujutsu"
                                                                              "git"
                                                                              "tmux"
                                                                              "fish"
                                                                              "rofi"))))
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

                                      (simple-service 'home-manager
                                       home-activation-service-type
                                       #~(begin
                                           (use-modules (guix gexp)
                                                        (shika lib config-root))
                                           (system (string-append "nix run "
                                                    (dirname (dirname config-root))
                                                    "/nix"
                                                    " -- switch --flake "
                                                    (dirname (dirname config-root))
                                                    "/nix"))))

                                      ) %base-home-services))))

