{ config, pkgs, inputs, ... }: {
  
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

    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
    ];

    settings = {
      "plugin:borders-plus-plus" = {
        add_borders = 1; # 0 - 9

        # you can add up to 9 borders
        "col.border_1" = "rgb(ffffff)";
        "col.border_2" = "rgb(2222ff)";

        # -1 means "default" as in the one defined in general:border_size
        border_size_1 = 10;
        border_size_2 = -1;

        # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
        natural_rounding = "yes";
      };
    };

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
