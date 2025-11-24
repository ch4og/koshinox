{
  description = "Nix home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    aagl,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        (final: prev: {
          aagl = aagl.packages.${system};
        })
      ];
    };
  in {
    homeConfigurations."ch" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        {
          home.username = "ch";
          home.homeDirectory = "/home/ch";
          home.stateVersion = "25.05";
          targets.genericLinux.enable = true;
        }
        ./packages.nix
      ];
    };
    defaultPackage.${system} = pkgs.writeShellScriptBin "home-manager-switch" ''
      exec ${home-manager.packages.${system}.home-manager}/bin/home-manager "$@"
    '';
  };
}
