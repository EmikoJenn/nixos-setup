{ inputs, config, lib, pkgs, ... }:
let
  proton-ge-rtsp-bin = pkgs.callPackage ../home-manager/emikojenn/overlays/proton-ge-rtsp-bin/default.nix {};
  android_SDK = pkgs.androidenv.androidPkgs.androidsdk;
in
{
  system.stateVersion = "23.11";
  imports = [
    ./mountpoints.nix
    ./hardware-configuration.nix
  ];

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      # allowUnfreePredicate = pkg:
      # permittedInsecurePackages = [ "libxml2-2.13.8" ];
      android_sdk.accept_license = true;
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages =  with pkgs; [ mesa rocmPackages.clr.icd ];
    };
  };

  security.pam.services.sddm.kwallet.enable = true;

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    virtualbox.host.enable = true;
  };

  # ENV
  environment = {
    variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      # QT_QPA_PLATFORM         = "wayland";
      LD_LIBRARY_PATH         = "${pkgs.vulkan-loader}/lib";
      DOTNET_ROOT             = "${pkgs.dotnet-sdk_9}/share/dotnet";
      DOTNET_ROOT_X64         = "${pkgs.dotnet-sdk_9}/share/dotnet";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSdk}/libexec/android-sdk/build-tools/28.0.3/aapt2";
      ANDROID_HOME = "${androidSdk}/libexec/android-sdk";
      ANDROID_SDK_ROOT = "${androidSdk}/libexec/android-sdk";
    };
    systemPackages = with pkgs; [
      tmux
      stow

      rar
      zip
      unzip

      wget
      httpie

      qemu
      amdgpu_top
      libva-utils

      xorg.xf86videoamdgpu
      vulkan-loader
      vulkan-tools
      clinfo
      radeontop
      ocl-icd
      sway-contrib.grimshot
      ffmpeg_4-full
      ffmpeg_7-full
      krita

      dive
      podman-compose
      vlc
      libvlc
      SDL2
      gnumake
      fd
      glfw
      glm
      xorg.libXi
      xorg.libXxf86vm
      syncthing
      clang
      coreutils
      ripgrep
      glib
      raylib
      gcc
      gdb

      postgresql
      blender
      brave
      onlyoffice-desktopeditors
      element-desktop

      # Game Engines & Utils
      unityhub
      godot_4
      unstable.godot-mono
      unstable.gdtoolkit_4

      # Steam Related apps
      steam-run
      steamcmd
      gamescope
      gamemode

      # VR Related apps
      envision
      unstable.slimevr

      # Android
      android-studio-full
      android_SDK
      androidenv.androidPkgs.platform-tools

      seahorse
      libsecret

      wl-clipboard
      xdg-utils
      vesktop
      anki-bin
      mpv

      alacritty

      # Code Editors 
      vscode
      neovim
      zed-editor

      # Theme
      spacx-gtk-theme


      ### CLI tools
      # Package Manager & SDKs & Langs
      uv
      dotnet-sdk_9
      jdk21_headless
      kotlin
      gradle

      terraform

      # Firewall libs for ALVR
      iptables
      nftables
    ];
  };

  time.timeZone = "America/Chihuahua";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  security.rtkit.enable = true;




   #  Monado SteamVR alternative
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
  };
  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "1";
    XRT_COMPOSITOR_COMPUTE = "1";
  };
  # END Monado SteamVR alternative



  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      pkgs.proton-ge-bin
      proton-ge-rtsp-bin
    ];
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.steam-hardware.enable = true;
  # END Steam





  # ALVR
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  # END ALVR:with




  services = {
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;

      alsa.support32Bit = true;
      pulse.enable = true;
    };
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "altgr-intl";
        options = "terminate:ctrl_alt_bksp";
      };
      videoDrivers = [ "amdgpu" ];
    };
    libinput.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerd-fonts.jetbrains-mono
  ];

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    xfconf.enable = true;
    appimage.enable = true;
    fish = {
      enable = true;
      shellInit = ''
        set -x PATH $HOME/.dotnet/tools $PATH;
        set -x DOTNET_ROOT ${pkgs.dotnet-sdk_9}/share/dotnet;
        set -x DOTNET_ROOT_X64 ${pkgs.dotnet-sdk_9}/share/dotnet;
      '';
    };
    virt-manager.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 15";
      };
      flake = "/etc/nixos";
    };
    kdeconnect.enable = true;

    #	Library paths for unpacked libraries
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib

      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva

      fontconfig
      freetype
      xorg.libXt
      xorg.libXmu
      libogg
      libvorbis
      SDL
      SDL2_image
      glew110
      libdrm
      libidn
      tbb
      zlib
    ];
  };

  users = {
    extraGroups = {
      docker.members = [ "emikojenn" ];
      vboxusers.members = [ "emikojenn" ];
    };
    groups.libvirtd.members = ["emikojenn"];
    users.emikojenn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" "emikojenn" ];
      packages = with pkgs; [
        firefox
        tmux
        pavucontrol
       	gh
       	yt-dlp
       	openjdk17
       	valgrind
       	xivlauncher
       	delta
       	r2modman
       	sidequest
       	protonup-qt
       	discord
       	google-chrome
     ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  ####################################################	FIREWALL, VPN ###########################################################
  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 25565 /* Palworld port: */ 8211 ];
      allowedUDPPorts = [ 6969 6970 51820 25565 9943 9944 9945 9946 9947 9948 9949 /* Palworld port: */ 8211 ];
    };
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
  };
}
