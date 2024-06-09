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
    #(zathura.override { useMupfd = true; })
  ];

  programs.zathura = {
    enable = true;
    #useMupdf = true;
  };
}
