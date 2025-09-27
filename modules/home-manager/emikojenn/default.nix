{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  imports = [
    inherit inputs
    inputs.nixvim.homeModules.nixvim
    ./programs
    ./packages

    #./containers
    #./theme/gtk.nix
  ];
}
