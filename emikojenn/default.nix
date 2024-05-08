{ username, osConfig, inputs, ... }:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./programs
  ];
}
