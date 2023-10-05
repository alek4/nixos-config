{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    #eww
  ];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;

  };
}
