{ username, osConfig, inputs, ... }:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = osConfig.System.stateVersion;
  };
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.anyrun.homeManagerModules.default
    ./programs
  ];
}
