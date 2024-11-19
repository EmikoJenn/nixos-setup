{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.games.vr;
in
{
  options.games.vr = {
    enable = mkEnableOption "Enable VR";
  };

  config = mkIf cfg.enable {
    programs.alvr = {
      enable = true;
      openFirewall = true;
    };
    # Required for ALVR to be able to launch SteamVR
    # Source: https://discourse.nixos.org/t/alvr-cant-launch-steamvr-steam-desktop-is-not-executable/43845/10
    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      wlr.enable = true;
    };
  };
}
