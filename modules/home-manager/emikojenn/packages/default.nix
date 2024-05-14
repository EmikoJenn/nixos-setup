{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
  ];
}
