{ pkgs, ... }:
{
  programs.home-manager.enable = true;
  git = import ./git.nix;
  nixvim = import ./nixvim;
  btop.enable = true;
  fish.enable = true;
}
