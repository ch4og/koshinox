;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (shika system services)
  #:use-module (gnu)
  #:use-module (guix gexp)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages wm)
  #:use-module (gnu services avahi)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu services docker)
  #:use-module (gnu packages games)
  #:use-module (gnu services networking)
  #:use-module (gnu services nix)
  #:use-module (gnu services shepherd)
  #:use-module (gnu services security-token)
  #:use-module (gnu services ssh)
  #:use-module (gnu services sysctl)
  #:use-module (gnu services xorg)
  #:use-module (koshi services guix-gc)
  #:use-module (koshi services ntsync)
  #:use-module (koshi services polkit-nm)
  #:use-module (koshi services udev-fido2)
  #:use-module (shika lib channels)
  #:use-module (shika lib keys)
  #:use-module (shika lib substitutes)
  #:use-module (shika system services base)
  #:use-module (shika system services config network-manager)
  #:use-module (shika system services config nix)
  #:use-module (shika system services config openssh)
  #:use-module (shika system services config screen-locker)
  #:use-module (aagl services hosts)
  #:use-module (koshi services runtime-dir)
  #:use-module (koshi services btrfs))

(define-public %shika-system-services
  (cons* (service wpa-supplicant-service-type)
				 (service avahi-service-type)
         (service seatd-service-type)
         (service pcscd-service-type)
         (service bluetooth-service-type)
         (service polkit-service-type)
         (service containerd-service-type)
         (service docker-service-type)
         (service ntp-service-type)

         (service polkit-network-manager-service-type)
         (service runtime-dir-service-type)
         (service guix-gc-service-type)
         (service udev-fido2-service-type)
         (service ntsync-service-type)

         (service btrfs-scrub-service-type
                  (btrfs-scrub-configuration
                   (schedule "0 0 * * 0")
                   (filesystems '("/dev/mapper/root" "/dev/mapper/home"))))

         (service btrfs-balance-service-type
                  (btrfs-balance-configuration
                   (schedule '(lambda (current-time) (+ current-time (* 2 7 24 60 60))))
                   (filesystems '("/dev/mapper/root" "/dev/mapper/home"))))

         (udev-rules-service 'steam steam-devices-udev-rules)
         (service pam-limits-service-type
                  (list (pam-limits-entry "*" 'both 'nofile 524288)))

         (service network-manager-service-type %shika-network-manager-configuration)
         (service nix-service-type %shika-nix-configuration)
         (service openssh-service-type %shika-openssh-configuration)
         (service screen-locker-service-type %shika-screen-locker-configuration)

         (service aagl-hosts-service-type)

         (udev-rules-service 'steam steam-devices-udev-rules)

         %shika-base-services))

