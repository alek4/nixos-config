{ config, lib, pkgs, ... }:

{
  services.polybar = {
        enable = true;
        script = ''                               # Running polybar on startup
          #  Handled by bspwmrc (modules/desktop/bspwm)
        '';                                       # Gets fixed in the bspwmrc file
        config = {
          "bar/main" = {                          # Bar name = Top
            monitor = "HDMI-0";
            width = "100%";
            height = 30;
            background = "#00000000";
            foreground = "#ccffffff";

            offset-y = 2;
            #spacing = "1.5";
            padding-right = 2;

            module-margin-left = 1;
            #module-margin-right = "0.5";

            font-0 = "FiraCode Nerd Font:style=Medium:size=10";     # Icons
            modules-left = "menu bspwm";
	    modules-center = "title";
            modules-right = "backlight pad memory cpu pad sink volume pad battery date"; #wired-network wireless-network bluetooth";

            #override-redirect = "true";
            wm-restack = "bspwm";
          };
	  "module/menu" = {
	    type = "custom/text";
	    content-prefix = "";
	    content-prefix-padding = 1;
	    content = " ";
	    content-foreground = "#999";
            click-left = "rofi -show drun";
	  };
          "module/memory" = {                     # RAM
            type = "internal/memory";
            format = "<label>"; #<bar-used>";
            format-foreground = "#999";
            label = "  %percentage_used%%";
          };
          "module/cpu" = {                        # CPU
            type = "internal/cpu";
            interval = 1;
            format = "<label>"; # <ramp-coreload>";
            format-foreground = "#999";
            label = "  %percentage%%";
          };
          "module/volume" = {                     # Volume
            type = "internal/pulseaudio";
            interval = 2;
            use-ui-max = "false";
            format-volume = "<ramp-volume>  <label-volume>";
            label-muted = "  muted";
            label-muted-foreground = "#66";

            ramp-volume-0 = "";
            ramp-volume-1 = "";
            ramp-volume-2 = "";

            click-right = "${pkgs.pavucontrol}/bin/pavucontrol";  # Right click opens pavucontrol, left click mutes, scroll changes levels
          };
          "module/backlight" = {                  # Keeping for the futur when i have a screen that supports xbacklight
            type = "internal/backlight";          # Now doen with sxhkb shortcuts
            card = "intel_backlight";
            #use-actual-brightness = "false";
            format = "<ramp> <bar>";

            ramp-0 = "";
            ramp-1 = "";
            ramp-2 = "";

            bar-width = 10;
            bar-indicator = "|";
            bar-indicator-font = 3;
            bar-indicator-foreground = "#ff";
            bar-fill = "─";
            bar-fill-font = 3;
            bar-fill-foreground = "ff"; #"#c9665e";
            bar-empty = "─";
            bar-empty-font = 3;
            bar-empty-foreground = "#44";
          };
          #"module/wireless-network" = {           # Show either wired or wireless
            #type = "internal/network";
            #interface = "wlo1";
            #interval = "3.0";
            #ping-interval = 10;
            #
            #format-connected = "<ramp-signal>";
            #format-connected = "<ramp-signal> <label-connected>";
            #label-connected = "%essid%";
            #label-disconnected = "";
            #label-disconnected-foreground = "#66";
            #
            #ramp-signal-0 = "";
            #
            #animation-packetloss-0 = "";
            #animation-packetloss-0-foreground = "#ffa64c";
            #animation-packetloss-1 = ""; #animation-packetloss-1-foreground = "#00000000";
            #animation-packetloss-framerate = 500;
            #};
            #"module/wired-network" = {              # Ditto module above
            #type = "internal/network";
            #interface = "enp0s25";
            #interval = "3.0";
            #
            #label-connected = "  %{T3}%local_ip%%{T-}";
            #label-connected = "";
            #label-disconnected-foreground = "#66";
          #};
          "module/battery" = {                    # Show battery (only when exist), uncomment to show battery and animations
            type = "internal/battery";
            full-at = 98;

            label-full = "%percentage%%";
            label-charging = "%percentage%%";
            label-discharging = "%percentage%%";

            format-charging = "<animation-charging> <label-charging>    ";
            format-discharging = "<ramp-capacity> <label-discharging>    ";
            format-full = "<ramp-capacity> <label-full>    ";

            ramp-capacity-0 = "";
            ramp-capacity-0-foreground = "#f53c3c";
            ramp-capacity-1 = "";
            ramp-capacity-1-foreground = "#ffa900";
            ramp-capacity-2 = "";
            ramp-capacity-3 = "";
            ramp-capacity-4 = "";

            bar-capacity-width = 10;
            bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
            bar-capacity-fill = "█";
            bar-capacity-fill-foreground = "#ddffffff";
            bar-capacity-fill-font = 3;
            bar-capacity-empty = "█";
            bar-capacity-empty-font = 3;
            bar-capacity-empty-foreground = "#44ffffff";

            animation-charging-0 = "";          # Animation when charging
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-3 = "";
            animation-charging-4 = "";
            animation-charging-framerate = 750;
          };
          "module/date" = {                       # Time/Date  Day-Month-Year Hour:Minute
          type = "internal/date";
            #date = "%{A1:notify-send -t 0 \"$(cal -m)\":}  %%{F#999}%d-%m-%Y%%{F-} %%{F#fff}%H:%M%%{F-}%{A}";
            date = "  %%{F#999}%d-%m-%Y%%{F-} %%{F#fff}%H:%M%%{F-}";
          };
          "module/bspwm" = {                      # Workspaces
            type = "internal/bspwm";
            pin-workspace = true;
            #label-monitor = "%name%";

            ws-icon-0 = "1;1";                    # Needs to be the same amount and same name as bswmrc
            ws-icon-1 = "2;2";
            ws-icon-2 = "3;3";
            ws-icon-3 = "4;4";
            ws-icon-4 = "5;5";
            ws-icon-5 = "6;6";
            ws-icon-6 = "7;7";
            ws-icon-7 = "8;8";
            ws-icon-8 = "9;9";
            ws-icon-9 = "10;10";
            #ws-icon-default = "";               # Can have more workspaces availabe but enable default icon

            format = "<label-state> <label-mode>";

            label-dimmed-underline = "#ccffffff"; # Colors in use, active or inactive

            label-focused = "%icon%";
            label-focused-foreground = "#fff";
            label-focused-background = "#773f3f3f";
            label-focused-underline = "#c9665e";
            label-focused-font = 4;
            label-focused-padding = 2;

            label-occupied = "%icon%";
            label-occupied-foreground = "#ddd";
            label-occupied-underline = "#666";
            label-occupied-font = 4;
            label-occupied-padding = 2;

            label-urgent = "%icon%";
            label-urgent-foreground = "#000000";
            label-urgent-background = "#bd2c40";
            label-urgent-underline = "#9b0a20";
            label-urgent-font = 4;
            label-urgent-padding = 2;

            label-empty = "%icon%";
            label-empty-foreground = "#55";
            label-empty-font = 4;
            label-empty-padding = 2;

            label-monocle = "M";
            label-monocle-underline = "#c9665e";
            label-monocle-background = "#33ffffff";
            label-monocle-padding = 2;

            label-locked = "L";
            label-locked-foreground = "#bd2c40";
            label-locked-underline = "#c9665e";
            label-locked-padding = 2;

            label-sticky = "S";
            label-sticky-foreground = "#fba922";
            label-sticky-underline = "#c9665e";
            label-sticky-padding = 2;

            label-private = "P";
            label-private-foreground = "#bd2c40";
            label-private-underline = "#c9665e";
            label-private-padding = 2;
          };
          "module/title" = {                      # Show title of active screen
            type = "internal/xwindow";
            format = "<label>";
            format-background = "#00000000";
            format-foreground = "#ccffffff";
            label = "%title%";
            label-maxlen = 75;
            label-empty = "";
            label-empty-foreground = "#ccffffff";
          };
	};
      };
}
