{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zathura
    prismlauncher
    thunderbird
    gparted
  ];

  programs.zathura = {
    enable = true;
  };
}
