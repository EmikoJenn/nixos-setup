{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  imports = [
    ./programs
    ./packages

    #./containers
    #./theme/gtk.nix
  ];
}
