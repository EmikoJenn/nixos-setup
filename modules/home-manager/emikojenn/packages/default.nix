{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    alvr
  ];
}
