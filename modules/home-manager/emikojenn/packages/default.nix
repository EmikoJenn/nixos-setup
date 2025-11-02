{ pkgs, ... }:
{
  home.packages = with pkgs; [
    prismlauncher
    thunderbird
    gparted
  ];
}
