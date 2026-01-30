# SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{pkgs, ...}: {
  home.packages = with pkgs; [
    amnezia-vpn
    ayugram-desktop
    spotify
    vscode
  ];
}
