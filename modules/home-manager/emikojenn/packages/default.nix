{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zathura
    obs-studio
    prismlauncher
    thunderbird
    gparted
  ];

  programs.zathura = {
    enable = true;
  };
}
