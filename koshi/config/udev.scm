;;; SPDX-FileCopyrightText: 2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi config udev)
  #:use-module (gnu services base))
;;; Custom udev rules

(define-public %koshi-custom-udev
  (udev-rule "99-koshi.rules"
             "
SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"3151\", ATTRS{idProduct}==\"502f\", MODE=\"0666\"
SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"3151\", ATTRS{idProduct}==\"502f\", MODE=\"0666\"
SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"3151\", ATTRS{idProduct}==\"5026\", MODE=\"0666\"
SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"3151\", ATTRS{idProduct}==\"5026\", MODE=\"0666\""))
