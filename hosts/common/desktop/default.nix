# modules/desktop/default.nix
# Entry point for desktop environment modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./wm/gnome.nix
    ./1password.nix
  ];
  
  # Common desktop packages
  environment.systemPackages = with pkgs; [

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
  
  # Enable printer support
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.hplip ];
  };
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  
}