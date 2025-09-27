{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs.legacyPackages.${system}  {
      inherit system;
      config.allowUnfree = true;
    };
    newSystem = nixpkgs.lib.nixosSystem;
    newHome = home-manager.lib.homeManagerConfiguration;
  in
  {
    nixosConfigurations.emikojenn = newSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
	      ./modules/nixos/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.emikojenn = import ./modules/home-manager/emikojenn {
              inherit inputs;
            };
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];
    };
  };
}
