{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./programs
    ./packages

    (import ./modules/home-manager/emikojenn/overlays/proton-ge-rtsp-bin/default.nix)
    #./containers
    #./theme/gtk.nix
  ];
}
