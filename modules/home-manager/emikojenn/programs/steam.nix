{ pkgs, ... }:
{
  mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      full = true;
      no_display = true;
      cpu_load_change = true;
    };
  };
  package = pkgs.steam.override {
    withPrimus = true;
    extraPkgs = pkgs: [ bumblebee glxinfo ];
  };
}
