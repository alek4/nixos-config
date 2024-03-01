{ config, pkgs, ... }: {
  
  home.packages = with pkgs; [
    waybar
    swww
    rofi-wayland
    dunst
    libnotify
  ];
  
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    xwayland.enable = true;
    extraConfig = ''

      exec-once = swww init &
      exec-once = swww img ../../../wallpapers/bg.png & 
      exec-once = waybar &
      exec-once = dunst

      $mod = SUPER

      input {
        kb_layout=it
      }
      
      bind = $mod, X, exec, kitty
      bind = $mod, Q, killactive
      bind = $mod, S, exec, rofi -show drun -show-icons
    '';
  };
}
