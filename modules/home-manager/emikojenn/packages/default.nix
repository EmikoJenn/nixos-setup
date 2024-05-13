{ pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    neovim
    SDL2
    unzip
    gnumake
    fd
    vulkan-tools
    vulkan-loader
    glfw
    glm
    xorg.libXi
    xorg.libXxf86vm
    syncthing
    clang
    coreutils
    ripgrep
    glib
    raylib
    gcc
    git
    gdb
  ];
}
