{ config, pkgs, unstable, lib, ... }:


{
  # Configure Git
  programs.git = {
    enable = true;

    extraConfig = {
      gpg = {
        format = "ssh";
      };
      "gpg \"ssh\"" = {
        program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
      };
      commit = {
        gpgsign = true;
      };

      user = {
        name = "Fabian";
        email = "github@furilofox.dev";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/OqDv8cbzLzx983fHgAupPVy15LKEmVmUR9bOc7GlU";
      };
    };
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
        Description = "polkit-gnome-authentication-agent-1";
        Wants = [ "graphical-session.target" ];
        After = [ "graphical-session-pre.target" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        KillMode = "mixed";

        RestartSec = 1;
        TimeoutStopSec = 10;
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
