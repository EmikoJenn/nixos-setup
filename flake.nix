{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    systemConf = nixpkgs.lib.nixosSystem;
    createHome = home-manager.nixosModules.home-manager;
  in
  {
    nixosConfigurations.emikojenn = systemConf {
      inherit system;

      modules = [
	      ./modules/nixos/configuration.nix

				home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.emikojenn = import ./modules/home-manager/emikojenn;
				}
      ];
    };
  };
}
