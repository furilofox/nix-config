# User-specific configuration for home-manager

{ config, pkgs, unstable, lib, ... }:

let
  onePassPath = "~/.1password/agent.sock";
in
{
  # Enable and configure the SSH program
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent ${onePassPath}
    '';
  };

  # Configure Git
  programs.git = {
    enable = true;
    userName = "Furilo";
    userEmail = "late.book0382@furilofox.dev";

    extraConfig = {
      core = {
        sshCommand = "ssh -i ~/.ssh/github-personal.pub";
      };
    };

    includes = [
      {
        contents = {
          user = {
            name = "Fabian";
            email = "b3-github@fabianweiss.dev";
          };

          # This conditional sshCommand will be used for repositories
          # matching the condition, potentially overriding the IdentityAgent
          # for those specific operations.
          core = {
            sshCommand = "ssh -i ~/.ssh/github-school.pub";
          };
        };

        condition = "hasconfig:remote.*.url:git@github.com:IF11B-2024-25/*";
      }
    ];
  };

  home.file."ssh-key-link-personal" = {
    target = ".ssh/github-personal.pub";
    source = ./../keys/github-personal.pub;
  };

  home.file."ssh-key-link-school" = {
    target = ".ssh/github-school.pub";
    source = ./../keys/github-school.pub;
  };

  # Other home-manager configurations...
}