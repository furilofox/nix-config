{ config, pkgs, ... }:

{
  home = {
    sessionVariables = {
      EDITOR = "vscode";
      BROWSER = "brave";
      TERMINAL = "kitty";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
