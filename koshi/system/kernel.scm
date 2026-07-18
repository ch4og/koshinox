;;; SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
;;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (koshi system kernel))

(define-public %koshi-kernel-arguments
  '("quiet"
    "module_blacklist=pcspkr,wacom"
    "zswap.enabled=1"
    "zswap.max_pool_percent=20"
    "nvme_core.default_ps_max_latency_us=0"))
