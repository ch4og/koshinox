;;; SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system config)
  )
(use-modules (gnu)
             (nongnu system linux-initrd)
             (nongnu services nvidia)
             (nongnu packages nvidia)
             (gnu packages package-management)
             (nonguix utils)
             (shika lib channels)
             (shika lib substitutes)
             (guix gexp))

(use-service-modules networking
                     ssh
                     nix
                     desktop
                     security-token
                     mcron
                     shepherd
                     dbus
                     sysctl)

(with-transformation replace-mesa
                     (operating-system
                       (kernel (specification->package "linux"))
                       (kernel-arguments '("nvidia_drm.modeset=1" "loglevel=4"
                                           "module_blacklist=pcspkr,nouveau"))
                       (initrd microcode-initrd)
                       (host-name "noko")
                       (timezone "Europe/Moscow")
                       (locale "en_US.utf8")
                       (keyboard-layout (keyboard-layout "us" "colemak"))

                       (bootloader (bootloader-configuration
                                     (bootloader grub-efi-bootloader)
                                     (targets '("/boot/efi"))
                                     (keyboard-layout keyboard-layout)))

                       (file-systems (append (list (file-system
                                                     (device (uuid
                                                              "3f026519-10e9-4d92-8253-06558d5d8374"))
                                                     (mount-point "/")
                                                     (type "btrfs")
                                                     (options
                                                      "compress=zstd,subvol=root"))
                                                   (file-system
                                                     (device (uuid
                                                              "3f026519-10e9-4d92-8253-06558d5d8374"))
                                                     (mount-point "/gnu/store")
                                                     (type "btrfs")
                                                     (options
                                                      "compress=zstd,subvol=gnu-store"))
                                                   (file-system
                                                     (device (uuid
                                                              "7c8864a5-1473-4cf2-94f9-9823a5e50ba0"))
                                                     (mount-point "/home")
                                                     (type "btrfs")
                                                     (options
                                                      "compress=zstd,subvol=home"))
                                                   (file-system
                                                     (device (uuid "EE1B-9309"
                                                              'fat))
                                                     (mount-point "/boot/efi")
                                                     (type "vfat")))
                                             %base-file-systems))

                       (users (cons (user-account
                                      (name "ch")
                                      (comment "ch4og")
                                      (group "users")
                                      (shell (file-append (specification->package
                                                           "fish") "/bin/fish"))
                                      (supplementary-groups '("wheel" "seat"
                                                              "audio" "video"
                                                              "netdev"
                                                              "plugdev")))

                                    %base-user-accounts))

                       (packages (append (map specification->package
                                              '("vim" "fish" "openssh" "git"))
                                         %base-packages))
                       (services
                        (append (list (service network-manager-service-type
                                               (network-manager-configuration (dns
                                                                               "dnsmasq")))
                                      (service wpa-supplicant-service-type)
                                      (service seatd-service-type)
                                      (service nvidia-service-type)
                                      (service pcscd-service-type)
                                      (service bluetooth-service-type)
                                      ;; (service polkit-wheel-service)
                                      (service polkit-service-type)

                                      ;; Install our NetworkManager polkit rule.
                                      (extra-special-file
                                       "/etc/polkit-1/rules.d/49-networkmanager.rules"
                                       (plain-file "49-networkmanager.rules"
                                        "polkit.addRule(function(action, subject) {
                                           if (action.id.indexOf('org.freedesktop.NetworkManager.') === 0 &&
                                               subject.user === 'ch') {
                                               return polkit.Result.YES;
                                           }
                                         });"))
                                      (udev-rules-service 'fido2
                                                          (specification->package
                                                           "libfido2")
                                                          #:groups '("plugdev"))
                                      (service nix-service-type
                                               (nix-configuration (extra-config
                                                                   (list (string-join '
                                                                          ("allowed-users = @wheel root"
                                                                           "auto-optimise-store = true"
                                                                           "experimental-features = nix-command flakes"
                                                                           "substituters = https://nixos-cache-proxy.cofob.dev https://cache.nixos.org/"
                                                                           "trusted-users = @wheel root"
                                                                           "warn-dirty = false")
                                                                          "\n")))))
                                      (service openssh-service-type
                                               (openssh-configuration (openssh
                                                                       (specification->package
                                                                        "openssh-sans-x"))
                                                                      (port-number
                                                                       2222)))
                                      (simple-service 'cron-jobs
                                                      mcron-service-type
                                                      (list #~(job "5 0 * * *"
                                                               "guix gc -d 1d -F 1G")))

                                      (simple-service 'add-extra-hosts
                                                      hosts-service-type
                                                      (list (host "0.0.0.0"
                                                             "overseauspider.yuanshen.com"
                                                             '("log-upload-os.hoyoverse.com"
                                                               "log-upload-os.mihoyo.com"
                                                               "dump.gamesafe.qq.com"
                                                               "apm-log-upload-os.hoyoverse.com"
                                                               "zzz-log-upload-os.hoyoverse.com"
                                                               "log-upload.mihoyo.com"
                                                               "devlog-upload.mihoyo.com"
                                                               "uspider.yuanshen.com"
                                                               "sg-public-data-api.hoyoverse.com"
                                                               "hkrpg-log-upload-os.hoyoverse.com"
                                                               "public-data-api.mihoyo.com"
                                                               "prd-lender.cdp.internal.unity3d.com"
                                                               "thind-prd-knob.data.ie.unity3d.com"
                                                               "thind-gke-usc.prd.data.corp.unity3d.com"
                                                               "cdp.cloud.unity3d.com"
                                                               "remote-config-proxy-prd.uca.cloud.unity3d.com"
                                                               "pc.crashsight.wetest.net"))))
                                      (simple-service 'runtime-dir
                                       shepherd-root-service-type
                                       (list (shepherd-service (documentation
                                                                "Create XDG runtime dir")
                                                               (provision '(runtime-dir))
                                                               (requirement '(seatd))
                                                               (start #~(lambda _
                                                                          (let 
                                                                               (
                                                                                (dir
                                                                                 "/run/user/1000"))
                                                                            (unless 
                                                                                    (file-exists?
                                                                                     dir)
                                                                              
                                                                              
                                                                              (mkdir-p
                                                                               dir))
                                                                            (system*
                                                                             "chown"
                                                                             "-R"
                                                                             "1000:1000"
                                                                             dir)
                                                                            (chmod
                                                                             dir
                                                                             #o700))))
                                                               (one-shot? #t)))))
                                (modify-services %base-services
                                  (guix-service-type config =>
                                                     (guix-configuration (inherit
                                                                          config)
                                                                         (channels
                                                                          shika-chs)
                                                                         (guix
                                                                          (guix-for-channels
                                                                           shika-chs))
                                                                         (substitute-urls
                                                                          shika-subs)
                                                                         (authorized-keys
                                                                          (append
                                                                           (list
                                                                            (plain-file
                                                                             "non-guix.pub"
                                                                             "(public-key (ecc
       (curve Ed25519)
          (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                                                                           %default-authorized-guix-keys))))
                                  (sysctl-service-type config =>
                                                       (sysctl-configuration (settings
                                                                              (append '
                                                                               (("vm.max_map_count" . "1048576"))
                                                                               %default-sysctl-settings)))))))
                       (name-service-switch %mdns-host-lookup-nss)))
