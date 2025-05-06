{ config, lib, unstable, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    unstable._1password-cli
    unstable._1password-gui
  ];
  
  programs = {
    _1password = {
      enable = true;
    };
    
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "fabian" ];
    };
  };
  security.polkit.enable = true;

  systemd.user.services."1password-gui" = {
    enable = true;
    description = "1Password GUI";
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${unstable._1password-gui}/bin/1password --silent";
      Restart = "on-failure";
      TimeoutStopSec = 10;
    };
  };
}
