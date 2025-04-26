# Common configuration imported by all hosts
{ lib, ... }:

{
  imports = [
    # Add common host modules here
    ../modules/nixos/default.nix
  ];
}