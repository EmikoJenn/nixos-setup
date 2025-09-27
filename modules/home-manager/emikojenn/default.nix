{ inputs, ... }:
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

    ./overlays/proton-ge-rtsp-bin/default.nix
    #./containers
    #./theme/gtk.nix
  ];
}
