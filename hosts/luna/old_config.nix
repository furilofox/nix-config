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

  programs.dconf.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
      };
    };
    spiceUSBRedirection.enable = true;
  };
  users.groups.libvirtd.members = ["fabian"];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # enable copy and paste between host and guest

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  
}
