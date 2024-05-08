{ pkgs, ... }:
{
  programs = {
    home-manager.enable = true;
    git = import ./git.nix;
    nixvim = import ./nixvim.nix { inherit pkgs; };
  };
}
