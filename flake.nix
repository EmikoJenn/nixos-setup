{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = { self, nixpkgs, unstable, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    unstablePkgs = import unstable { 
      inherit system;
      config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
      };
    };
    systemConf = nixpkgs.lib.nixosSystem;
    createHome = home-manager.nixosModules.home-manager;
  in
  {
    nixosConfigurations.emikojenn = systemConf {
      inherit system;

      specialArgs = {
        inherit unstablePkgs;
      };

      modules = [
	      ./modules/nixos/configuration.nix
        ./overlays

				home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.emikojenn = import ./modules/home-manager/emikojenn;
				}
      ];
    };
  };
}
