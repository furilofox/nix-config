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
        name = "Furilo";
        email = "late.book0382@furilofox.dev";
        signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/OqDv8cbzLzx983fHgAupPVy15LKEmVmUR9bOc7GlU";
      };
    };

    includes = [
      {
        contents = {
          user = {
            name = "Fabian";
            email = "b3-github@fabianweiss.dev";
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl9ziWvbM7DPxSN6CJE9ok3AAoj1S3F3xnwicIZ1tH/";
          };
        };

        condition = "hasconfig:remote.*.url:git@github.com:IF11B-2024-25/*";
      }
    ];
  };
}
