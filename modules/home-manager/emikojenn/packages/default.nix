{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
    zathura
    steam-tui
    steamcmd
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
