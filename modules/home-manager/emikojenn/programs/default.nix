{ pkgs, ... }:
let
  proton-ge-rtsp-bin = pkgs.callPackage ../overlays/proton-ge-rtsp-bin/default.nix {};
in
{
  home-manager.enable = true;

  programs = {
    steam = {
      enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
          proton-ge-rtsp-bin
        ];
      };
    git = import ./git.nix;
    obs-studio = import ./obs-studio.nix;
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
      };
    };
    lazygit.enable = true;
  };
}
