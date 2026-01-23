;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system services endfield-hosts)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (ice-9 rdelim)
  #:use-module (srfi srfi-1)
  #:export (endfield-hosts-service-type))

(define %endfield-blocked-domains
  '("data-p.gryphline.com"
    "native-log-collect.gryphline.com"
    "eventlog.gryphline.com"
    "event-log-api-ipv6.gryphline.com"
    "event-log-api-data-platform-data-lake-prod.gryphline.com"))

(define (domains->blocked-hosts domains)
  (if (null? domains)
      '()
      (list
       (host "0.0.0.0"
             (car domains)
             (cdr domains)))))

(define %endfield-hosts
  (domains->blocked-hosts %endfield-blocked-domains))

(define endfield-hosts-service-type
  (service-type
    (name 'endfield-hosts)
    (extensions
     (list (service-extension
            hosts-service-type
            (const %endfield-hosts))))
    (default-value #f)
    (description
     "Add /etc/hosts entries to block Endfield telemetry endpoints.")))
