{ pkgs, ... }:
{
  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    nixvim = import ./nixvim.nix { inherit pkgs; };
    steam = import ./steam;
    btop.enable = true;
    yt-dlp.enable = true;
  };
}
