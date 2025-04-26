# NixOS service modules
{ ... }:

{
  imports = [
    ./openssh.nix
    # Add more service modules here as you create them
  ];
}