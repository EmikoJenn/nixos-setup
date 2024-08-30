{ pkgs, ... }:
{
  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    #alvr = import ./alvr.nix;
    btop.enable = true;
    yt-dlp.enable = true;
  };
}
