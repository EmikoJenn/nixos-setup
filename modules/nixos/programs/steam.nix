{ pkgs, proton-ge-rtsp-bin, ... }: {
  programs.steam = {
    enable = true;
    extraCompatPackages = [
      pkgs.proton-ge-bin
      proton-ge-rtsp-bin
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
