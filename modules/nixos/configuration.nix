{ inputs, config, lib, pkgs, ... }:
let
  proton-ge-rtsp-bin = pkgs.callPackage ../home-manager/emikojenn/overlays/proton-ge-rtsp-bin/default.nix {};
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

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "libxml2-2.13.8" ];

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
      extraPackages =  with pkgs; [ rocmPackages.clr.icd ];
    };
  };

  security.pam.services.sddm.kwallet.enable = true;

  services.pulseaudio.enable = false;

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
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_BACKEND = "wayland";
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      QT_QPA_PLATFORM = "wayland";
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
    };
    systemPackages = with pkgs; [
      amdgpu_top
      glxinfo
      libva-utils

      xorg.xf86videoamdgpu
      vulkan-loader
      vulkan-tools
      clinfo
      radeontop
      ocl-icd
      sway-contrib.grimshot
      vscode
      ffmpeg_4-full
      ffmpeg_7-full
      krita
      git
      wget
      dive
      podman-compose
      vlc
      libvlc
      tmux
      SDL2
      unzip
      rar
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
      steam-run
      gamescope
      gamemode
      unzip
      zip
      postgresql
      httpie
      unityhub
      steam-run
      blender
      brave
      onlyoffice-bin
      pgadmin4
      element-desktop
      godot_4
      dotnet-sdk_10

      qemu

      seahorse
      libsecret

      wl-clipboard
      xdg-utils
      vesktop
      anki-bin
      mpv

      # Python package manager
      uv

      # Theme
      spacx-gtk-theme

      neovim
      alacritty
      zed-editor

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

  services = {
    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    gnome.gnome-keyring.enable = true;

    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
	support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
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

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
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
    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        proton-ge-bin
        proton-ge-rtsp-bin
      ];
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
    appimage.enable = true;
    fish.enable = true;
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
	steamcmd
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

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  ####################################################	FIREWALL, VPN ###########################################################
  networking = {
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 25565];
      allowedUDPPorts = [ 51820 25565 9944 9945 9946 9947 9948 9949 ];
    };
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
  };

  # Configure Home Manager for the local user via our per-user module
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };  # allow passing inputs into imported user module
    users.emikojenn = import ../home-manager/emikojenn/default.nix {
      inherit inputs pkgs;
    };
    backupFileExtension = "hm-bak";
  };
}
