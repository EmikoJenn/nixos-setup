{ pkgs, ... }:
{
  #imports = [
    #./steam.nix
  #];

  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    nixvim = import ./nixvim.nix { inherit pkgs; };
    #alvr = import ./alvr.nix;
    btop.enable = true;
    yt-dlp.enable = true;
  };
}
