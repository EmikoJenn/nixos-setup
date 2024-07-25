{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
    zathura
    obs-studio
    prismlauncher
    thunderbird
    gparted
    #(zathura.override { useMupfd = true; })
  ];

  programs.zathura = {
    enable = true;
    #useMupdf = true;
  };
}
