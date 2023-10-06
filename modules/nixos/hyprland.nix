{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
    #eww

    # notification
    dunst
    libnotify

    # wallpaper daemon
    swww

    # app launcher
    rofi-wayland
  ];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;

  };
}
