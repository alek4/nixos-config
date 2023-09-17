{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    picom
    feh
    arandr
    rofi
    dunst
    sxhkd
    polybar
  ];

  xsession.windowManager.bspwm = {
    enable = true;

    monitors = {
      HDMI-0 = [
        "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"
      ];
    };

    settings = {
      border_width = 0; 
      window_gap = 9;
      pointer_follows_monitor = true;
      focus_follows_pointer = true;
    };

    startupPrograms = [
      #"pgrep -x sxhkd > /dev/null || sxhkd &"
      #"feh --bg-fill ~/Pictures/wall/1.jpg"
      #"~/.config/polybar/launch.sh"
      "polybar main"
    ]; 
  };
}
