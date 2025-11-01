{ inputs, pkgs, ... }:
{
  home = {
    username = "emikojenn";
    homeDirectory = "/home/emikojenn";
    stateVersion = "23.11";
  };
  environment.variables = {
    XRT_COMPOSITOR_COMPUTE = 1;
  };
  imports = [
    ./programs
    ./packages

    #./containers
    #./theme/gtk.nix
  ];
}
