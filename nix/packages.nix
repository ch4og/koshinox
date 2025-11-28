# SPDX-FileCopyrightText: 2025 Nikita Mitasov <me@ch4og.com>
# SPDX-License-Identifier: GPL-3.0-or-later

{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    spotify
    steam-run
    amnezia-vpn
    ayugram-desktop
    aagl.honkers-railway-launcher
  ];
}
