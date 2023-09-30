# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    outputs.homeManagerModules.bspwm

    # Or modules exported from other flakes (such as nix-colors):
    inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ] ++ (import ../modules/home-manager/services);

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "aless";
    homeDirectory = "/home/aless";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    firefox

    neofetch
    nnn # terminal file manager

    # archives
    zip
    unzip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils  # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc  # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    glow # markdown previewer in terminal
    helix
    vscodium

    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  colorScheme = inputs.nix-colors.colorSchemes.ayu-dark;

  programs = {
    # Enable home-manager and git
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "alek4";
      userEmail = "alessandro.bordo41@gmail.com";
    };
    
    kitty = {
      enable = true;
      settings = {
        foreground = "#${config.colorScheme.colors.base07}";
        background = "#${config.colorScheme.colors.base00}";
        #selection_background = "#${config.colorScheme.colors.base05}";
        #selection_foreground = "#${config.colorScheme.colors.base00}";
        #url_color = "#${config.colorScheme.colors.base0C}";
        #cursor = "#${config.colorScheme.colors.base05}";
        #active_border_color = "#${config.colorScheme.colors.base0D}";
        #inactive_border_color = "#${config.colorScheme.colors.base03}";
        #active_tab_background = "#${config.colorScheme.colors.base00}";
        #active_tab_foreground = "#${config.colorScheme.colors.base05}";
	#inactive_tab_background = "#${config.colorScheme.colors.base03}";
	#inactive_tab_foreground = "#${config.colorScheme.colors.base0C}";
	#tab_bar_background = "#${config.colorScheme.colors.base03}";

	# normal
	color0 = "#${config.colorScheme.colors.base00}";
	color1 = "#${config.colorScheme.colors.base01}";
	color2 = "#${config.colorScheme.colors.base02}";
	color3 = "#${config.colorScheme.colors.base03}";
	color4 = "#${config.colorScheme.colors.base04}";
	color5 = "#${config.colorScheme.colors.base05}";
	color6 = "#${config.colorScheme.colors.base06}";
	color7 = "#${config.colorScheme.colors.base07}";

	# bright
	color8 = "#${config.colorScheme.colors.base08}";
	color9 = "#${config.colorScheme.colors.base09}";
	color10 =  "#${config.colorScheme.colors.base0A}";
	color11 =  "#${config.colorScheme.colors.base0B}";
	color12 =  "#${config.colorScheme.colors.base0C}";
	color13 =  "#${config.colorScheme.colors.base0D}";
	color14 =  "#${config.colorScheme.colors.base0E}";
	color15 =  "#${config.colorScheme.colors.base0F}";
      };
    };
  };


  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
