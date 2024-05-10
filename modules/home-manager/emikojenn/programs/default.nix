{ pkgs, ... }:
{
  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    nixvim = import ./nixvim.nix { inherit pkgs; };
    btop.enable = true;
    yt-dlp.enable = true;
  };
}
