{ config, pkgs, unstable, lib, ... }:


{
  # Configure Git
  programs.git = {
    enable = true;
    userName = "Fabian";
    userEmail = "github@furilofox.dev";

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
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/OqDv8cbzLzx983fHgAupPVy15LKEmVmUR9bOc7GlU";
      };
    };
  };
}
