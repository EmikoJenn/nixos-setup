{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, nixpkgs-wayland, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs.legacyPackages.${system}  {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
    nixosConfigurations.emikojenn = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };
  };
}
