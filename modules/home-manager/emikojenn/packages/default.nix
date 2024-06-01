{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alvr
    zathura
    #(zathura.override { useMupfd = true; })
  ];

  programs.zathura = {
    enable = true;
    #useMupdf = true;
  };
}
