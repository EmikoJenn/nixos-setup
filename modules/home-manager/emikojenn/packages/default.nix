{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
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
