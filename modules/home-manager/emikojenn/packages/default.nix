{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zathura
    prismlauncher
    thunderbird
    gparted
    dotnet-sdk_10
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
    DOTNET_ROOT_X64 = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  home.sessionPath = [ "$HOME/.dotnet/tools" ];

  programs.zathura = {
    enable = true;
  };
}
