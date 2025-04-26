# NixOS modules directory
{ ... }:

{
  imports = [
    ./system
    ./desktop
    ./services
  ];
}