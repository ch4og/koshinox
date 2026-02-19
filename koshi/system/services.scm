;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services)
  #:use-module (gnu)
  #:use-module (guix gexp)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages wm)
  #:use-module (gnu services avahi)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu packages games)
  #:use-module (gnu services containers)
  #:use-module (gnu services networking)
  #:use-module (gnu services nix)
  #:use-module (gnu services security-token)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services ssh)
  #:use-module (gnu services sysctl)
  #:use-module (gnu services xorg)
  #:use-module (gnu system accounts)
  #:use-module (shika services guix-gc)
  #:use-module (shika services ntsync)
  #:use-module (shika services polkit-nm)
  #:use-module (shika services udev-fido2)
  #:use-module (koshi config channels)
  #:use-module (koshi config keys)
  #:use-module (koshi config substitutes)
  #:use-module (koshi system services base)
  #:use-module (koshi system services config kmscon)
  #:use-module (koshi system services config network-manager)
  #:use-module (koshi system services config nix)
  #:use-module (koshi system services config openssh)
  #:use-module (koshi system services config screen-locker)
  #:use-module (aagl services hosts)
  #:use-module (shika services btrfs)
  #:use-module (koshi system services endfield-hosts))

(define-public (make-koshi-system-services username)
  (cons* (service wpa-supplicant-service-type)
         (service avahi-service-type)
         (service elogind-service-type)
         (service pcscd-service-type)
         (service bluetooth-service-type)
         (service polkit-service-type)
         (service ntp-service-type)

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty1"))

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty2"))

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty3"))

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty4"))

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty5"))

	 (service kmscon-service-type
                  (generate-koshi-kmscon-configuration "tty6"))

         (service rootless-podman-service-type
                  (rootless-podman-configuration (subgids (list (subid-range (name username))))
                                                 (subuids (list (subid-range (name username))))))

         (service polkit-network-manager-service-type)
         (service udev-fido2-service-type)
         (service ntsync-service-type)

         (service guix-gc-service-type
                  (guix-gc-configuration (delete-system-generations "14d")))

         (service btrfs-scrub-service-type
                  (btrfs-scrub-configuration (schedule "0 0 * * 0")
                                             (filesystems '("/dev/mapper/root"
                                                            "/dev/mapper/home"))))

         (service btrfs-balance-service-type
                  (btrfs-balance-configuration (schedule '(lambda (current-time)
                                                            (+ current-time (* 2 7 24 60 60))))
                                               (filesystems '("/dev/mapper/root"
                                                              "/dev/mapper/home"))))

         (udev-rules-service 'steam steam-devices-udev-rules)
         (service pam-limits-service-type
                  (list (pam-limits-entry "*" 'both 'nofile 524288)))

         (service network-manager-service-type %koshi-network-manager-configuration)
         (service nix-service-type %koshi-nix-configuration)
         (service openssh-service-type %koshi-openssh-configuration)
         (service screen-locker-service-type %koshi-screen-locker-configuration)

         (service aagl-hosts-service-type)
         (service endfield-hosts-service-type)

         %koshi-base-services))
