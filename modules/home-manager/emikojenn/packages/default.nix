{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
    zathura
    obs-studio
    prismlauncher
    thunderbird
    gparted
    blender
    #(zathura.override { useMupfd = true; })
  ];

  programs.zathura = {
    enable = true;
    #useMupdf = true;
  };
}
