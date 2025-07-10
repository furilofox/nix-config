# modules/desktop/default.nix
# Entry point for desktop environment modules

{ config, lib, pkgs, ... }:

{
  imports = [
    ./wm/gnome.nix
  ];

  # Enable sound with pipewire
  services.pulseaudio.enable = false;

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

  # Formatting
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  programs.nix-index.enable = true;
  programs.command-not-found.enable = false;

  nixpkgs.config.nix.settings = {
    experimental-features = lib.mkAfter [ "flakes" "nix-command" ];
    formatter = "${pkgs.alejandra}/bin/alejandra";
  };


  # Locale
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


  # Nix
  nix = {
    # Enable flakes and new 'nix' command
    package = pkgs.nixVersions.latest;

    # Optimize store
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
        "ca-derivations"
      ];
      trusted-users = [ "root" "@wheel" ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

}
