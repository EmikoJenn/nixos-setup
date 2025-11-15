{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";

    sessionVariables = {
      QT_QPA_PLATFORM       = "xcb";
      LD_LIBRARY_PATH       = "${pkgs.vulkan-loader}/lib";
      MOZ_ENABLE_WAYLAND    = "1";
      GDK_BACKEND           = "wayland";
      NIXOS_OZONE_WL        = "1";
    };
  };

  programs.home-manager.enable = true;

  imports = [
    ./programs
    ./packages
    #./containers
    #./theme/gtk.nix
  ];
}
