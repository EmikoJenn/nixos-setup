{ pkgs, ... }:
{
  package = pkgs.steam.override {
    withPrimus = true;
    extraPkgs = pkgs: [ bumblebee glxinfo ];
  };
}
