{ pkgs, ... }:
{
  #imports =  [
    #./alvr.nix
  #];
  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    btop.enable = true;
    lazygit.enable = true;
  };
}
