{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    usrConf = nixpkgs.lib.nixosSystem;
    # pkgs = import nixpkgs.legacyPackages.${system}  {
      # inherit system;
      # config.allowUnfree = true;
    # };
    createHome = home-manager.nixosModules.home-manager;
  in
  {
    nixosConfigurations.emikojenn = usrConf {
      inherit system;
      modules = [
	      ./modules/nixos/configuration.nix

				home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.emikojenn = {
            imports = [
              ./modules/home-manager/emikojenn
            ];
          };
				}
      ];
    };
  };
}
