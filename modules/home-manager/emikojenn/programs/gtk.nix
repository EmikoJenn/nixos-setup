{ pkgs, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["pink"];
        size = "compact";
        tweaks = ["rimless" "black"];
        variant = "mocha";
      };
    };

    cursorTheme = {
      name = "Catppuccin Mocha Pink";
      package = pkgs.catppuccin-cursors.mochaPink;
      size = 16;
    };
  };
  
  imports = [
    ./gtk.nix
  ];
}
