{
  description = "Main Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
    # newHome = home-manager.lib.homeManagerConfiguration;
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

            # Git related config
            programs.git = {
              enable = true;
              lfs.enable = true;
              userName  = "EmikoJenn";
              userEmail = "EmikoJenn@proton.me";
              aliases = {
                cfg = "config --list";
                uncommit = "reset --soft HEAD^";
                logall = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
              };
              extraConfig = {
                pull.rebase = true;
              };
            };
            # END Git related config
          };
				}
      ];
    };
  };
}
