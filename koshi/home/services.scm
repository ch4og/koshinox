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
  #:use-module (gnu home services sound)
  #:use-module (gnu home services xdg)
  #:use-module (shika services home-emacs-daemon))


;;; Right now we don't use username anywhere but let's keep it.
(define-public (make-koshi-home-services username)
  (cons*
   (service home-dbus-service-type)
   (service home-pipewire-service-type)
   (service home-gpg-agent-service-type
            (home-gpg-agent-configuration
              (ssh-support? #t)
              (pinentry-program
               (file-append pinentry "/bin/pinentry"))))

   (simple-service
    'env-vars-service
    home-environment-variables-service-type
    (let* ((home       (or (getenv "HOME")             "/home/ch"))
           (xdg-config (or (getenv "XDG_CONFIG_HOME") (string-append home "/.config")))
           (xdg-cache  (or (getenv "XDG_CACHE_HOME")  (string-append home "/.cache")))
           (xdg-state  (or (getenv "XDG_STATE_HOME")  (string-append home "/.local/state")))
           (xdg-data   (or (getenv "XDG_DATA_HOME")   (string-append home "/.local/share"))))
      `(("TZ"                        . "Europe/Moscow")
        ("NIXPKGS_ALLOW_UNFREE"      . "1")
        ("EDITOR"                    . "emacsclient")
        ("GUIX_SANDBOX_EXTRA_SHARES" . "/games")
        ("NIXOS_OZONE_WL"            . "1")
        ("NPM_CONFIG_USERCONFIG"     . ,(string-append xdg-config "/npm/npmrc"))
        ("NPM_CONFIG_CACHE"          . ,(string-append xdg-cache  "/npm"))
        ("NODE_REPL_HISTORY"         . ,(string-append xdg-state  "/node_repl_history"))
        ("CARGO_HOME"                . ,(string-append xdg-data   "/cargo"))
        ("WAKATIME_HOME"             . ,(string-append xdg-config "/wakatime"))
        ("FONTCONFIG_PATH"           . ,(string-append home       "/.guix-home/profile/etc/fonts/")))))


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

   (simple-service 'home-xdg-utils
                   home-profile-service-type
                   `(,xdg-utils))
   (service home-emacs-daemon-service-type
            (home-emacs-daemon-configuration
             (emacs emacs-pgtk)))
   %base-home-services))
