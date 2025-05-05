# 'nix fmt .' to format files

{ config, lib, pkgs, ... }:

{
    programs._1password.enable = true;
    programs._1password-gui.enable = true;
    programs._1password-gui.polkitPolicyOwners = [ "fabian" ];
}