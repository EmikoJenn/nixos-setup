{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  gtk = {
    enable = true;
    theme = {
      #package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
  };
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./programs
    ./packages
    #./containers
    #./theme/gtk.nix
  ];
}
