{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable"
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    # nixvim = {
      # url = "github:nix-community/nixvim";
      # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    systemConf = nixpkgs.lib.nixosSystem;
    createHome = home-manager.nixosModules.home-manager;
  in
  {
    nixosConfigurations.emikojenn = systemConf {
      inherit system;

      specialArgs = {
        pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
      };

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
