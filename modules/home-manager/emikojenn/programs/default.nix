{ pkgs, ... }:
{
  # imports =  [
    # ./alvr.nix
  # ];
  programs = {
    home-manager.enable = true;
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
