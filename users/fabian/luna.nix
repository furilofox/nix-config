# Configuration for fabian on luna host
{ config, lib, pkgs, ... }:

{
  imports = [
    ./default.nix  # Import common fabian config
  ];


  # Gaming
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
  
  # Host-specific home-manager configuration for fabian
  home-manager.users.fabian = { pkgs, pkgs-unstable, lib, ... }: {
    # Luna-specific packages
    home.packages = with pkgs; [

      # Productivity tools
      libreoffice
      
      # Gaming
      mangohud # Game Hardware stats
      protonup # "protonup" in terminal to download proton-ge
      lutris # Other Game Launcher
      heroic # Epic Games Game Launcher
      bottles # windows app container

      # Unstable Packages
      (lib.custom.pkgsUnstable.pkgs [
        "brave"
        "vesktop" # Discord + Vencord
        "_1password-gui" # 1Password Desktop
        "nextcloud-client"
      ])

      gnome-extension-manager
      gparted
      easyeffects
      
      telegram-desktop
      obsidian
      
      prismlauncher
      (prismlauncher.override {
        # Add binary required by some mod
        additionalPrograms = [ffmpeg];

        # Change Java runtimes available to Prism Launcher
        jdks = [
          graalvm-ce
          zulu8
          zulu17
          zulu
        ];
      })
    ];
    
    # Example: Add Luna-specific git configuration
    programs.git.extraConfig = {
      core.editor = "nvim";
    };
  };
}