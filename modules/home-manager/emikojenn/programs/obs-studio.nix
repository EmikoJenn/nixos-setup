{
  enable = true;

  # optional Nvidia hardware acceleration
  # package = (
    #pkgs.obs-studio.override {
      #cudaSupport = true;
    #}
  #);

  # plugins = with obs-studio-plugins; [
    # wlrobs
    # obs-backgroundremoval
    # obs-pipewire-audio-capture
    # obs-vaapi #optional AMD hardware acceleration
    # obs-gstreamer
    # obs-vkcapture
  # ];
}
