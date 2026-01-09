# SPDX-FileCopyrightText: 2025-2026 Nikita Mitasov <me@ch4og.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  description = "Bashame (home-manager config)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
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
    formatter.${system} = pkgs.alejandra;
  };
}
