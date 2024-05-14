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
    extraPackages32 = with pkgs; [ driversi686Linux.amdvlk mangohud ];
  };

  # ENV
  environment = {
    sessionVariables.XDG_CURRENT_DESKTOP = "sway";
    systemPackages = with pkgs; [
      sway-contrib.grimshot
      steam-run
      vscode
      git
      wget
      dive
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

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chihuahua";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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



  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  security.polkit.enable = true;

  programs = {
    xfconf.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    thunar.enable = true;
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

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;  

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixO>
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your >
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options>
  system = {
    stateVersion = "23.11";
  };
}
