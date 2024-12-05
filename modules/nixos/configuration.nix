
{ inputs, config, lib, pkgs, ... }: {

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

  hardware.pulseaudio.enable = false;

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
  };

  # ENV
  environment = {
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
      MOZ_ENABLE_WAYLAND = "1";
      GDK_BACKEND = "wayland";
    };
    variables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
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

      wl-clipboard
      xdg-utils
      vesktop

      # Theme
      spacx-gtk-theme

      neovim
      alacritty

      ################################# VPN #################################
      wireguard-tools
    ];
  };

  home-manager.users.emikojenn = {
    home.stateVersion = "23.11";
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
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
  ];

  security.polkit.enable = true;

  programs = {
    dconf.enable = true;
    gamemode.enable = true;
    xfconf.enable = true;
    steam = {
      enable = true;
      package = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          corefonts
          vistafonts
        ];
      };
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
      protontricks.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
    appimage.enable = true;
    fish.enable = true;
    nh = {
      enable = true;
      clean = {
        enable = true;
	extraArgs = "--keep 15";
      };
      flake = "/etc/nixos";
    };

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
    extraGroups.docker.members = [ "emikojenn" ];
    users.emikojenn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" ];
      packages = with pkgs; [
        firefox
        tmux
        pavucontrol
	unityhub
	gh
	azure-cli
	yt-dlp
	openjdk17
	valgrind
	xivlauncher
	delta
	steamcmd
	r2modman
	sidequest
     ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  system = {
    stateVersion = "23.11";
  };

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  ####################################################	FIREWALL, VPN ###########################################################
  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 8080 25565];
      allowedTCPPortRanges = [
        { from = 9943; to = 9944; } # ALVR Ports
      ];
      
      allowedUDPPorts = [ 51820 25565 ];
      allowedUDPPortRanges = [
        { from = 9943; to = 9944; } # ALVR Ports
      ];
    };
    nat = {
      enable = true;
      externalInterface = "eth0";
      internalInterfaces = [ "wg0" ];
    };
  };

  home-manager.backupFileExtension = "hm-bak";
}
