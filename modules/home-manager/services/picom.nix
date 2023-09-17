{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = true;
   
    #shadows
    shadow = true;
    shadowOpacity = 0.8;
    shadowOffsets = [ (-7) (-7) ];

    #fading
    fade = true;
    fadeSteps = [0.03 0.03];
    fadeDelta = 5;

    #opacity
    inactiveOpacity = 0.6;

    #screen tearing fix
    vSync = true;
    backend = "glx";

    #rounded corners

    #other settings
    settings = {
      shadow-radius = 10;
      blur = {
        method = "dual_kawase";
        strength = 7;
      };
    };  
  };
}
