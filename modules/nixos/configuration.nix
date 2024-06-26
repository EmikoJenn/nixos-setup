{ config, lib, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./mountpoints.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;
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
      XDG_CURRENT_DESKTOP = "sway";
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
    };
    variables = {
      LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
    };
    systemPackages = with pkgs; [
      xorg.xf86videoamdgpu
      vulkan-loader
      vulkan-tools
      opencl-info
      radeontop
      ocl-icd
      sway-contrib.grimshot
      vscode
      mangohud
      ffmpeg_5-full
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
    ];
  };

  home-manager.users.emikojenn = {
    home.stateVersion = "23.11";
  };

  nixpkgs.config = {
    packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          gamescope
          mangohud
        ];
      };
    };
    allowUnfree = true;
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
      wireplumber.enable = true;
    };
    displayManager.sddm.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
	variant = "altgr-intl";
	options = "terminate:ctrl_alt_bksp";
      };
      videoDrivers = [ "amdgpu" "nvidia" "modesetting" ];
      desktopManager = {
        xfce.enable = true;
	plasma5.enable = true;
      };
    };
    libinput.enable = true;
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
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
  ];

  security.polkit.enable = true;

  programs = {
    gamemode.enable = true;
    xfconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
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
    fish.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      #plugins = with pkgs.vimUtils.buildVimPlugin; [
        #nvim-tree-lua
        #nvim-treesitter
        #elixir-tools-nvim
        #nvchad-ui
        #catppuccin-nvim
      #];
    };
  };

  users = {
    extraGroups.docker.members = [ "emikojenn" ];
    users.emikojenn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" ];
      packages = with pkgs; [
        neovim
        firefox
        wezterm
        kitty
        tmux
        pavucontrol
        vesktop
        thunderbird
     ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
	xdg-desktop-portal-hyprland
      ];
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  system = {
    stateVersion = "23.11";
  };
}
