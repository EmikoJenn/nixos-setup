{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
    zathura
    steam-tui
    steamcmd
    #(zathura.override { useMupfd = true; })
  ];

  programs.zathura = {
    enable = true;
    #useMupdf = true;
  };
}
