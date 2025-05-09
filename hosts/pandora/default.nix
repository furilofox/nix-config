# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, unstable, lib, ... }:

{
  imports =
    [
      # Include the results of the hardware scan
      ./hardware-configuration.nix


      # Import modules
      ../common/core
      ../common/desktop
      # ../common/desktop/nvidia.nix
    ];

  # Hostname / Network
  networking.hostName = "pandora";

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = unstable.linuxPackages_latest;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "video=HDMI-1:1920x1080@60"
    "video=DP-1:2560x1440@144"
  ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        unstable.amdvlk
        unstable.rocmPackages.clr.icd
      ];
      extraPackages32 = with pkgs; [
        unstable.driversi686Linux.amdvlk
      ];
    };
  };
  # User
  users.users.fabian = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  virtualisation.docker.enable = true;

  # List packages installed in system profile
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    curl

    bruno
  ];

  # Gaming Stuff
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


  # System version
  system.stateVersion = "24.11";
}
