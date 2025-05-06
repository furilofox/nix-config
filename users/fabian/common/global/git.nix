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
}
