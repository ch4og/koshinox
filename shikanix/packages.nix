{
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kitty
    spotify
    amnezia-vpn
    ayugram-desktop
    aagl.honkers-railway-launcher
  ];
}
