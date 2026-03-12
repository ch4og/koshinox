;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi home services)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services sound)
  #:use-module (gnu home services xdg)
  #:use-module (shika services home-emacs-daemon)
  #:use-module (koshi home services config environment)
  #:use-module (koshi home services config user-directories))

;;; Right now we don't use username anywhere but let's keep it.
(define-public (make-koshi-home-services username)
  (cons* (service home-dbus-service-type)
         (service home-pipewire-service-type)
         (service home-gpg-agent-service-type
                  (home-gpg-agent-configuration
                    (ssh-support? #t)
                    (pinentry-program
                     (file-append pinentry "/bin/pinentry"))))

         (simple-service 'env-vars-service
                         home-environment-variables-service-type
                         %koshi-home-environment-variables-configuration)

         (service home-xdg-user-directories-service-type
                  %koshi-home-user-directories-configuration)

         (simple-service 'home-xdg-utils
                         home-profile-service-type
                         `(,xdg-utils))

         (simple-service 'setup-nix-hm
                         home-shell-profile-service-type
                         (list (plain-file "hm-vars.sh"
                                           (string-join
                                            '("NIX_HM_ENV=$HOME/.nix-profile"
                                              "if [ -r \"$NIX_HM_ENV/etc/profile.d/hm-session-vars.sh\" ]; then"
                                              ". \"$NIX_HM_ENV/etc/profile.d/hm-session-vars.sh\""
                                              "fi"
                                              "unset NIX_HM_ENV") "\n"))))

         (service home-emacs-daemon-service-type
                  (home-emacs-daemon-configuration
                   (emacs emacs-pgtk)))
         %base-home-services))
