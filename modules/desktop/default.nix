# modules/desktop/default.nix
# Entry point for desktop environment modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./xserver.nix
    ./fonts.nix
    ./nvidia.nix
  ];
  
  # Common desktop packages
  environment.systemPackages = with pkgs; [
    # Terminal utilities
    alacritty
    kitty
    
    # File managers
    xfce.thunar
    gnome.nautilus
    
    # System tools
    gnome.gnome-system-monitor
    gnome.gnome-control-center
    
    # Media
    mpv
    vlc
    
    # Screenshot
    flameshot
    
    # Clipboard
    xclip
  ];

  # Enable sound with pipewire
  hardware.pulseaudio.enable = false;
  
  # Enable PipeWire as the audio server
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };
  
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;
  
  # Enable printer support
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.hplip ];
  };
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  
  # Enable scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };
}