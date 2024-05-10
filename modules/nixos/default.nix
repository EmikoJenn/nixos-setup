{ ... }:
{
  modules = [
    ./hardware-configuration.nix

    ./mountpoints.nix

    ./configuration.nix
  ];
}
