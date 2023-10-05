# Add your reusable home-manager modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.

{
  # List your module files here
  # my-module = import ./my-module.nix;
  bspwm = import ./bspwm.nix;
  services = import ./services/default.nix;
  hyprland = import ./hyprland.nix;
}
