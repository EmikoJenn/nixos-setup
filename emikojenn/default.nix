{ inputs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./programs
    #./theme/gtk.nix
  ];
}
