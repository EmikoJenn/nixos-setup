{ pkgs, ... }: {
  enable = true;
  extraCompatPackages = with pkgs; [
    proton-ge-bin
    proton-ge-rtsp-bin
  ];
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
}
