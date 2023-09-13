{ config, pkgs, lib, ... }:

{
  time.timeZone = "Europe/Rome";

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    packages=[ pkgs.terminus_font ];
    font="${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true; # use xkbOptions in tty.
  };
  environment.systemPackages = with pkgs; [
    git
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    dmenu
    dwm
    bspwm
    dunst
    eww
    feh
    flameshot
    flatpak
    gh
    gnumake
    gparted
    kitty
    libverto
    nnn
    picom
    polkit_gnome
    qemu
    rofi
    sxhkd
    stdenv
    terminus-nerdfont
    virt-manager
    xdg-desktop-portal-gtk
    xorg.xinit
  ];

  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  services.picom.enable = true;

  services.xserver.layout = "it";

  services.printing.enable = true;

  virtualisation.libvirtd.enable = true;

  services.flatpak.enable = true;
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    # gtk portal needen to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true; 

  nixpkgs.overlays = [
	(final: prev: {
		dwm = prev.dwm.overrideAttrs (old: { src = /home/aless/github/dwm-titus; });
	})
  ];

  security.polkit.enable = true;
  systemd = {
   user.services.polkit-gnome-authentication-agent-1 = {
     description = "polkit-gnome-authentication-agent-1";
     wantedBy = [ "graphical-session.target" ];
     wants = [ "graphical-session.target" ];
     after = [ "graphical-session.target" ];
     serviceConfig = {
         Type = "simple";
         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
         Restart = "on-failure";
         RestartSec = 1;
         TimeoutStopSec = 10;
     };
   };
   extraConfig = ''
     DefaultTimeoutStopSec=10s
   '';
  };

  networking.firewall.enable = false;
  networking.enableIPv6 = false;

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      (nerdfonts.override { fonts = [ "Meslo" ]; })
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
	      monospace = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
	      serif = [ "Noto Serif" "Source Han Serif" ];
	      sansSerif = [ "Noto Sans" "Source Han Sans" ];
      };
    };
  };

  users.users = {
    aless = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      extraGroups = [ "wheel" "kvm" "input" "disk" "libvirtd" ];
    };
  };
}
