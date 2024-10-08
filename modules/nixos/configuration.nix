
{ inputs, config, lib, pkgs, ... }: {

  imports = [
    ./mountpoints.nix
    ./hardware-configuration.nix
    inputs.hyprland.nixosModules.default
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
      enable32Bit = true;
      extraPackages =  with pkgs; [ 
        amdvlk
        mangohud
        mesa.drivers
        rocmPackages.clr.icd
      ];
      extraPackages32 = with pkgs; [ 
        driversi686Linux.amdvlk
        mangohud 
      ];
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
      NIXOS_OZONE_WL = "1";
      T_QPA_PLATFORM = "wayland";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
    variables = {
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";
    };
    systemPackages = with pkgs; [
      #xdg-desktop-portal-gtk
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
      nodejs
      steam-run
      gamescope
      gamemode

      wl-clipboard
      xdg-utils
      hyprland
      vesktop

      # Theme
      spacx-gtk-theme

      kitty
      kitty-themes
      neovim
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
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
	      variant = "altgr-intl";
	      options = "terminate:ctrl_alt_bksp";
      };
      videoDrivers = [ "amdgpu" ];
      desktopManager = {
        xfce = {
          enable = true;
          thunarPlugins = [ pkgs.xfce.thunar-archive-plugin ];
        };
        xterm.enable = false;
      };
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
    noto-fonts-cjk
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
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
	thunar-volman
      ];
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    appimage.enable = true;
    fish.enable = true;
  };

  users = {
    extraGroups.docker.members = [ "emikojenn" ];
    users.emikojenn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" ];
      packages = with pkgs; [
        firefox
        wezterm
        kitty
        tmux
        pavucontrol
        thunderbird
     ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  system = {
    stateVersion = "23.11";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  home-manager.backupFileExtension = "hm-bak";
}
