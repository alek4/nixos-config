{ config, pkgs, inputs, ... }: {
  programs.kitty = {
    enable = true;
    font.name = "Fira Code";
    settings = {
      enable_audio_bell = "no";
    };
  };
}
