{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;

    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # ============================================== #
  # User
  # ============================================== #

  users.users.fabian = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
    ];
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  console.keyMap = "de";

  # ============================================== #
  # Window Manager
  # ============================================== #

  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      videoDrivers = ["nvidia"];
      xkb = {
        layout = "de";
        variant = "";
      };
      # Force Wayland
      displayManager.gdm.wayland = true;
    };
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-photos
    gnome-tour
    cheese # webcam tool
    gnome-music
    gedit # text editor
    epiphany # web browser
    geary # email reader
    gnome-characters
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
    yelp # Help view
    gnome-contacts
    gnome-initial-setup
  ];

  # ============================================== #
  # Steam / Gaming
  # ============================================== #

  environment.sessionVariables = {
    # Force Wayland for Chromium based applications
    NIXOS_OZONE_WL = "1";
    # Force Wayland for vscode
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    # Force Wayland for firefox
    MOZ_ENABLE_WAYLAND = 1;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  # ============================================== #
  # Audio (Pipewire)
  # ============================================== #

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # ============================================== #
  # OpenGL
  # ============================================== #

  hardware.graphics = {
    enable = true;
  };

  # ============================================== #
  # NVIDIA
  # ============================================== #

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false; # You can enable this if you wish to experiment, but start with it off for troubleshooting
    powerManagement.finegrained = false; # Requires powerManagement.enable = true
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # ============================================== #
  # Prnting (CUPS)
  # ============================================== #

  services.printing.enable = true;

  # ============================================== #
  # Bootloader
  # ============================================== #

  boot.loader = {
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
    efi.canTouchEfiVariables = true;
  };

  # ============================================== #
  # Other Packages
  # ============================================== #

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    mangohud # Game Hardware stats
    protonup # "protonup" in terminal to download proton-ge
    lutris # great game launcher
    heroic # good for epicgames
    bottles # windows app container
    vesktop # discord + vencord
    _1password-gui # 1Password Desktop
    mission-center # Task / System Monitor
    gnome-extension-manager
    vscode
    brave
    gparted
    easyeffects
    nextcloud-client
    telegram-desktop
    git
    obsidian
    vesktop

    virt-manager
    virt-viewer

    spice
    spice-gtk # Might be needed for client-side rendering in Virt Manager
    libvirt # Ensure libvirt is installed
    qemu # Ensure QEMU is installed

    # prismlauncher
    # (prismlauncher.override {
    #   # Add binary required by some mod
    #   additionalPrograms = [ffmpeg];
# 
    #   # Change Java runtimes available to Prism Launcher
    #   jdks = [
    #     graalvm-ce
    #     zulu8
    #     zulu17
    #     zulu
    #   ];
    # })

    gnome-tweaks

    # solaar # needs sudo to see mouse, idk what the actual buttons are called
    # gnomeExtensions.solaar-extension
  ];

  networking = {
    hostName = "pandora";
    networkmanager = {
      enable = true;
    };
    nameservers = ["1.1.1.1" "8.8.8.8"];
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}