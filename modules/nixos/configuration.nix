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

  hardware.graphics = {
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
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xorg.xf86videoamdgpu
      vulkan-loader
      vulkan-tools
      clinfo
      radeontop
      ocl-icd
      sway-contrib.grimshot
      vscode
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
      steam-run
      gamescope
      gamemode

      wl-clipboard
      xdg-utils
      vesktop
      discord
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
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
  };
}
