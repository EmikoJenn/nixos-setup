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
    extraPackages =  with pkgs; [ amdvlk mangohud ];
    extraPackages32 = with pkgs; [ 
      driversi686Linux.amdvlk
      mangohud 
    ];
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enable = true;
    };
  };

  # ENV
  environment = {
    sessionVariables.XDG_CURRENT_DESKTOP = "sway";
    systemPackages = with pkgs; [
      sway-contrib.grimshot
      vscode
      mangohud
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
      vulkan-tools
      vulkan-loader
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
      videoDrivers = [ "amdgpu" ];
    };
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
    thunar.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
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
    extraGroups.docker.members = [ "username-with-access-to-socket" ];
    users.emikojenn = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "docker" ]; # Enable ‘sudo’ f>
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
        xdg-desktop-portal-gtk
      ];
    };
  };

  system = {
    stateVersion = "23.11";
  };
}
